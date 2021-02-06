import numpy as np


def problem_3():

    k         = 1.38*10**(-23)                                       # Boltzmann_Const. (J/K )
    T         = [296.9, 296.9, 296.9, 296.9]                         # temperature (K)
    P         = [1.02*10**5, 57.50*10**5, 221.6*10**5, 1011.6*10**5] # Pressure (Pa)
    V         = [1.180, 66.04, 236.1, 578.0]                         # Density (kg m^(-3))
    epsilon_r = [1.00052, 1.03109, 1.11413, 1.29633]                 # Dielectric constant 

    y_mol = np.zeros(len(T))
    for i in range(0, len(T)):
        y_mol[i] = ((3 * k * T[i])/(P[i])) * ((epsilon_r[i] - 1)/(epsilon_r[i] + 2))
        print('Data set {}: $y_{{mol}} = {}$\\\\'.format((i + 1), y_mol[i]))

def problem_4():
    
    NZ         = 1.5 * 10 ** 12    # electron density (m^-3)
    m          = 9.109 * 10**(-31) # mass of an electron (kg)
    e          = 1.602 * 10**(-19) # Electron charge (c)
    epsilon_0  = 8.85 * 10**(-12)  # F/m
    omega_p_sq = (NZ * (e ** 2))/(epsilon_0 * m) 

    omega_p = np.sqrt(omega_p_sq)/(2 * np.pi) # Hz

    print(omega_p)


if __name__ == '__main__':
    problem_3()
    problem_4()