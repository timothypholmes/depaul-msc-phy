import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def problem_3():
    df = pd.read_csv('ssm.txt', delimiter = '\s+')#, delimiter = '\t')
    print(df)
    df['Y'] = 1 - df['X']

    plt.plot(df['X'], df['R/Rsun'])
    plt.plot(df['Y'], df['R/Rsun'])
    plt.xlabel(r'$X/Y$')
    plt.ylabel(r'$R/R_{\odot}$')
    plt.show()

    plt.plot(df['T'], df['R/Rsun'])
    plt.xlabel(r'$T$')
    plt.ylabel(r'$R/R_{\odot}$')
    plt.show()

    plt.plot(df['L/Lsun'], df['R/Rsun'])
    plt.plot(df['M/Msun'], df['R/Rsun'])
    plt.xlabel(r'$X/Y$')
    plt.ylabel(r'$R/R_{\odot}$')
    plt.show()

def problem_4():
    
    M_0 = 1.99 * 10 ** 30 # m_star
    t = np.linspace(0, 1.5 * 10 ** 6, 10000)
    #L = 3.85 * 10 ** 26 # L_star
    L = 10000 * 3.828 * 10 ** 26
    R = 10000 * 10 ** 16 # R_star

    M = np.sqrt(M_0 ** 2 - (8 * 10 ** (-13) * L * R * t))
    
    plt.plot(t, M)
    #plt.plot(t, M/(1.99 * 10 ** 30))
    plt.show()

if __name__ == '__main__':
    problem_3()
    #problem_4()

