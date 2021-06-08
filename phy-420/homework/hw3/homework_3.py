import numpy as np
import matplotlib.pyplot as plt
import scipy.special as sp


def I_nu(x, nu):
    I = ((1j) ** (-nu)) * sp.jv(nu, 1j * x)  
    
    return I


def K_nu(x, nu):
    hv = sp.jv(nu, 1j * x) + 1j * sp.yv(nu, 1j * x)
    K = (np.pi/2) * (1j) ** (nu + 1) * hv
    
    return K


x  = np.linspace(0, 5, 1000)
nu = [0, 1, 2, 3]
I = []
K = []
if __name__ == "__main__":
    for i in range(0, len(nu)):
        I.append(I_nu(x, nu[i]))  
        K.append(K_nu(x, nu[i]))


for i in range(0, len(nu)):
    plt.plot(x, I[i], label=r'$I_{}(x)$'.format(i))

plt.title(r'modified Bessel function of the first kind $I_{\nu}(x)$')
plt.xlabel(r'$x$')
plt.ylabel(r'$I_{\nu}(x)$')
plt.legend(loc='best')
plt.show()


for i in range(0, len(nu)):
    plt.plot(x, K[i], label=r'$K_{}(x)$'.format(i))
 
plt.title(r'modified Bessel function of the second kind $K_{\nu}(x)$')
plt.xlabel(r'$x$')
plt.ylabel(r'$K_{\nu}(x)$')
plt.legend(loc='best')
plt.ylim((0, 15)) 
plt.show()
