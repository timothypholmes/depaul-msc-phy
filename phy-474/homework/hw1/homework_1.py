import numpy as np

G = 6.67 * 10 ** (-11) # gravitational constant (N m^2 kg^-2)
M_solar = 1.99 * 10 ** 30 # solar mass (kg)
R_solar = 6.96 * 10 ** 8 # solar radius (m)
m_p = 1.67 * 10 ** (-27) # (kg)
k_B = 1.38 * 10 ** (-23) # Boltsmanns (J/K)

e   = 1.602 * 10 ** (-19) # electron charge (C)
m_e = 9.109 * 10 ** (-31) # electron mass (kg)
c   = 3.00 * 10 ** 8 # speed of light (m/s)
epsilon = 8.85 * 10 ** (-12) # permittivity (F m^-1)

sigma_T = (8 * np.pi)/3 * ((e ** 2)/(4 * np.pi * epsilon * m_e * (c ** 2))) ** 2
print('Value of sigma_T: {}'.format(sigma_T))

n_e = 1

l = 1/(n_e * sigma_T)
t_s = l/c
print('Value of t_s: {}'.format(t_s))









