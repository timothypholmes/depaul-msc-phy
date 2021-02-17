import numpy as np
import matplotlib.pyplot as plt


N = 1
a = 1
k = np.linspace(-10, 10, 10000)
x = np.linspace(-10, 10, 10000)
k_0 = 0

A_k_sq = ((2 * N ** 2) / np.pi) * (np.sin(a * (k - k_0))**2)/(k - k_0) ** 2

u_x_sq = np.piecewise(x,             # variable    (x)
                     [abs(x/a) < 1,  # condition 1 (abs(x/a) < 1)
                      abs(x/a) > 1], # condition 2 (abs(x/a) > 1)
                     [lambda x: 1,   # function 1 
                      lambda x: 0])  # function 2
                
plt.figure(1)
plt.plot(k, A_k_sq)
plt.xlabel(r'$k$')
plt.ylabel(r'$|A(k)|^{2}$')
plt.show()

plt.figure(2)
plt.plot(x, u_x_sq, 'r')
plt.xlabel(r'$\frac{x}{a}$')
plt.ylabel(r'$|u(x, 0)|^{2}$')
plt.show()