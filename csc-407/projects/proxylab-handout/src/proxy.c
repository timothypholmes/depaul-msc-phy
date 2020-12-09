#include <stdio.h>
#include <csapp.h>
#include <sbuf.h>
#include <dict.h>
#include "proxy.h"
#include "cache.h"

sbuf_t sbuf;

static void usage(const char *progname);
int server_connect(char *hostname, int port);
int create_header(char *header, char *request_type, char *hostname, char *path, \
                  int port, rio_t *rio);
void payload(char *payload_data, int len, int serverfd, rio_t *rio);
void proxy(int connfd);


static void usage(const char *progname) {
  fprintf(stderr, "usage: %s PORT\n", progname);
  exit (1);
}

static void *thread(void *vargp) {
  Pthread_detach(pthread_self());
  while (1) {
    int connfd = sbuf_remove(&sbuf); 
    proxy(connfd);
    close(connfd);
  }
  return NULL;
}

int server_connect(char *hostname, int port) {
  char server_port[MAXLINE];
  sprintf(server_port, "%d", port);
  return open_clientfd(hostname, server_port);
}

int create_header(char *header, char *request_type, char *hostname, char *path, \
                  int port, rio_t *rio) {
                     
  char buf[MAXLINE];

  int len = rio_readlineb(rio, buf, MAXLINE);
  int pos = 0;

  pos += sprintf(&header[pos], "%s %s HTTP/1.0\r\n", request_type, path);
  while (strcmp (buf, "\r\n")) {
    char *pos2 = strchr (buf, ':');

    if (len > 2 && pos2 != NULL) {
      pos2[0] = 0;
      buf[len - 2] = 0; 
      pos2++;

      while (pos2[0] == ' ') {
        pos2++;
      }
      
      if (!strncasecmp(buf, "User-Agent", strlen("User-Agent"))) {
        pos += sprintf(&header[pos], "%s: %s\r\n", buf, USER_AGENT);
      }
      else if (!strncasecmp(buf, "Proxy-Connection", strlen("Proxy-Connection"))) {
        pos += sprintf(&header[pos], "%s: %s\r\n", buf, PROXY_CONN);
      }
      else if (!strncasecmp(buf, "Connection", strlen("Connection"))) {
        pos += sprintf(&header[pos], "%s: %s\r\n", buf, CONNECTION);
      }
      else {
        pos += sprintf(&header[pos], "%s: %s\r\n", buf, pos2);
      }
      len = rio_readlineb (rio, buf, MAXLINE);
    }
    else
	return 1;
  }

  const char *pos1 = strstr(header, "Connection");
  char connection[MAXLINE];
  if (pos1 && sscanf(pos1, "%*s %9s", connection) == 1) {
    strcat(header, "Connection: close\r\n");
  } 
  else {
    strcat(header, "Connection: close\r\n");
  }
  strcat(header, "\r\n");
  return 0;
}

void payload(char *payload_data, int len, int serverfd, rio_t *rio) {
  char buf[MAXLINE];

  int pos = 0;

  while (len > 0) {
    int readlen = rio_readnb(rio, buf, MAXLINE < len ? MAXLINE : len);
    pos += sprintf(&payload_data[pos], "%s", buf);
    if (readlen == 0)
      break;
    len -= readlen;
    if (rio_writen(serverfd, buf, readlen) < 0) {
      close(serverfd);
      wait(NULL);
      return;
    }
  } 
}

void proxy(int connfd) {

  char buf[MAXLINE], request_type[MAXLINE], url[MAXLINE], protocol_version[MAXLINE], \
  protocol[MAXLINE], hostname[MAXLINE], path[MAXLINE], response[MAXLINE];
  rio_t rio, server_rio;

  rio_readinitb(&rio, connfd);
  if (!rio_readlineb (&rio, buf, MAXLINE)) {
    close (connfd);
    return;
  }
  sscanf(buf, "%s %s %s", request_type, url, protocol_version);

  if (strcasecmp(request_type, "GET") != 0 &&
      strcasecmp(request_type, "POST") != 0) {
    close(connfd);
    return;
  }
  /*
  strtok (protocol_version, "/");
  strcat(protocol_version, "/");

  if (strcasecmp(protocol_version, "HTTP/") != 0) {
    close(connfd);
    return;
  }
  */
  int port = 80;
  if (sscanf(url, "%99[^:]://%99[^:]:%i/%199[^\n]", protocol, hostname, &port, path) == 4) {}
  else if (sscanf(url, "%99[^:]://%99[^/]/%199[^\n]", protocol ,hostname, path) == 3) {}  
  //else {return;}

  char fpath[MAXLINE] = "\0";
  strcat(fpath, "/");
  strcat(fpath, path);

  if (strcasecmp(protocol, "http") != 0) {
    close(connfd);
    return;
  }
  
  char header[MAXLINE];
  if (create_header(header, request_type, hostname, fpath, port, &rio) != 0) {
	close (connfd);
	return;
  }
	
  int serverfd = server_connect(hostname, port);
  
  rio_readinitb(&server_rio, serverfd);
  rio_writen(serverfd, header, strlen(header));

  if (strcasecmp (request_type, "GET")) {
    // READ PAYLOAD
    const char *pos = strstr(header, "Content-Length:");
    char content_length[MAXLINE];
    if (pos && sscanf(pos, "%*s %9s", content_length) == 1) {} 
    else {
      printf("Could not find content length\n");
      return;
    }

    int str_len = strlen(content_length);
    while (str_len > 0 && isspace(content_length[str_len - 1]))
      str_len--;     
    if (str_len > 0) {
      for (int i = 0; i < str_len; i++) {
        if (!isdigit(content_length[i])) {
          close(connfd);
          return;
        }
      }
    }

    int len = atoi(content_length);

    if (len < 0) {
      close(connfd);
      return;
    }

    char payload_data[MAXLINE];
    payload(payload_data, len, serverfd, &rio);
    rio_writen(serverfd, payload_data, strlen(payload_data));
  }

  size_t n;
  while ((n = rio_readlineb(&server_rio, response, MAXLINE)) != 0) {
    rio_writen(connfd, response, n);
  }
  close(serverfd);
}

int main(int argc, char **argv) {

  int listenfd, connfd;
  socklen_t clientlen;
  struct sockaddr_storage clientaddr; 
  char client_hostname[MAXLINE], client_port[MAXLINE];

  if (argc != 2) {
    usage (argv[0]);
  }

  sigset_t mask;
  sigemptyset(&mask);
  sigaddset(&mask, SIGPIPE);
  sigprocmask(SIG_BLOCK, &mask, NULL);

  listenfd = open_listenfd (argv[1]);
  sbuf_init(&sbuf, SBUFSIZE);
  pthread_t tid;
  for (int i = 0; i < NTHREADS; i++)
    Pthread_create(&tid, NULL, thread, NULL);

  while (1) {
    clientlen = sizeof (clientaddr);
    connfd = accept(listenfd, (SA *) &clientaddr, &clientlen);
    getnameinfo((SA *) &clientaddr, clientlen, client_hostname, MAXLINE,
                  client_port, MAXLINE, 0);
    printf ("Accepted connection from (%s, %s)\n", client_hostname, client_port);
    sbuf_insert (&sbuf, connfd);
  }
  exit(0);
}
