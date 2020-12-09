curl -vv --proxy http://localhost:42200 'http://localhost:42201/cgi-bin/echo?argument' \
        -H 'X-ExtraHeader: Value' --data-binary 'Raw POST data'
