import numpy as np
import matplotlib.pyplot as plt
from matplotlib.offsetbox import AnchoredText

def problem_3():

    rho = 10 ** 3 # kg m^-3
    X = 0.7
    X_CNO = 0.02
    T_6 = np.linspace(5, 40, 1000) # K

    epsilon_pp_chain = (1.08 * 10 ** (-12)) * rho * (X ** 2) * (T_6 ** 4) 
    epsilon_CNO_cycle = (8.24 * 10 ** (-31)) * rho * X * X_CNO * (T_6 ** 20)
    
    log_epsilon_pp_chain = np.log10(epsilon_pp_chain) 
    log_epsilon_CNO_cycle = np.log10(epsilon_CNO_cycle)
    log_T_6 = np.log10(T_6)
    
    plt.plot(log_T_6, log_epsilon_pp_chain)
    plt.plot(log_T_6, log_epsilon_CNO_cycle)
    plt.ylabel(r'$log_{10}(\epsilon)$')
    plt.xlabel(r'$log_{10}(T_{6})$')
    idx = np.argwhere(np.diff(np.sign(log_epsilon_pp_chain - log_epsilon_CNO_cycle))).flatten()
    plt.plot(log_T_6[idx], log_epsilon_CNO_cycle[idx], 'go')
    plt.show()

    plt.plot(T_6, log_epsilon_pp_chain)
    plt.plot(T_6, log_epsilon_CNO_cycle)
    plt.ylabel(r'$log_{10}(\epsilon$)')
    plt.xlabel(r'$T_{6}$')
    idx = np.argwhere(np.diff(np.sign(log_epsilon_pp_chain - log_epsilon_CNO_cycle))).flatten()
    plt.plot(T_6[idx], log_epsilon_CNO_cycle[idx], 'go')
    plt.annotate(f'$({T_6[idx]} \; K)$',
                 (T_6[idx], log_epsilon_CNO_cycle[idx]),
                 textcoords="offset points",
                 xytext=(40, -15),
                 ha='center')
    plt.show()


def problem_4():

    T_s     = np.linspace(2400, 2800, 1000)
    M       = (1.98 * 10 ** 30) / 2 # kg
    M_solar = 1.98 * 10 ** 30 # kg
    L_solar = 3.85 * 10 ** 26 # W

    L_s = 0.03 * ((M / M_solar) ** (-7)) * ((T_s / 2400) ** (-40)) * L_solar

    log_L_s = np.log10(L_s) 
    log_T_s = np.log10(T_s)

    an1 = plt.annotate(r'$0.5 \; M_{\odot}$', xy=(3.485, 27.15), xycoords="data",
        va="center", ha="center", color='red',
        bbox=dict(boxstyle="round", fc="w"))
    
    plt.plot(log_T_s, log_L_s)
    plt.xlabel(r'$log_{10}(T_{s})$')
    plt.ylabel(r'$log_{10}(L_{s})$')
    plt.xlim(3.5, 3.3)
    plt.show()


if __name__ == "__main__":
    #problem_3()
    problem_4()
