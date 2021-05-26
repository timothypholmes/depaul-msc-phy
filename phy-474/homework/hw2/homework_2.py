import numpy as np
import matplotlib.pyplot as plt


R = 10
r = np.linspace(0, R, 1000)
x = r/R

G = 6.67 * 10 ** (-11) # Gravitational constant N m^2 kg^-2
M = 2.0 * 10 ** (30)   # Mass of the sun kg

P = ((5/(4 * np.pi)) * ((G * (M ** 2))/ (R ** 4)) *  
     (1 - (24/5) * (x ** 2) + (28/5) * (x ** 3) - (9/5) * (x ** 4)))


plt.plot(x, P)
plt.xlabel(r'$x$')
plt.ylabel(r'$P$')
plt.show()
