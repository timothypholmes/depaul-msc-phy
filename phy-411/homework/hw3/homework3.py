import numpy as np
import pandas as pd 
import matplotlib.pyplot as plt
import matplotlib.ticker as tck

n       = 1
n_prime = 1.5
i       = np.linspace(0, np.pi/2, 10000)

T_parallel = ((2 * n * n_prime * np.cos(i)) / \
             ((n_prime**2 * np.cos(i)) + (n * np.sqrt(n_prime**2 - n**2 * np.sin(i)**2))))**2 \
             * (np.sqrt(n_prime ** 2 - n ** 2 * np.sin(i) ** 2)/(n * np.cos(i)))

R_parallel = ((n_prime**2 * np.cos(i) - n * np.sqrt(n_prime**2 - n**2 * np.sin(i)**2))/ \
              (n_prime**2 * np.cos(i) + n * np.sqrt(n_prime**2 - n**2 * np.sin(i)**2)))**2 \
              * (n_prime/n)
T_max = T_parallel.argmax()
R_min = R_parallel.argmin()

f,ax=plt.subplots(figsize=(8,5))
ax.plot(i, T_parallel, 'r', label=r'$T_{\parallel}$ Transmission')
ax.plot(i[T_max], T_parallel[T_max],'o')
ax.plot(i, R_parallel, 'b', label=r'$R_{\parallel}$ Reflection')
ax.axvline(x=i[T_max], ymin=0, ymax=1, linestyle='--', color='g')
ax.plot(i[R_min], R_parallel[R_min],'o')
plt.xlabel(r'Angle of Incidence $(Rad)$')
plt.ylabel(r'$R$, $T$ Coefficient')
ax.xaxis.set_major_formatter(tck.FormatStrFormatter('%g $\pi$'))
ax.xaxis.set_major_locator(tck.MultipleLocator(base=0.2))
ax.annotate(r'$T_{\parallel}$ = 1', xy=(0.98, 1),  xycoords='data',
            xytext=(0.5, 0.7), textcoords='axes fraction',
            arrowprops=dict(arrowstyle="->", facecolor='black'),
            horizontalalignment='right', verticalalignment='top',
            )
ax.annotate(r'$R_{\parallel} = 0$', xy=(0.98, 0),  xycoords='data',
            xytext=(0.5, 0.3), textcoords='axes fraction',
            arrowprops=dict(arrowstyle="->", facecolor='black'),
            horizontalalignment='right', verticalalignment='top',
            )
ax.legend(loc='center left')
plt.show()