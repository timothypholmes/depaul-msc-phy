#!/usr/bin/env julia
using SpecialFunctions
using PyPlot

x = range(0, stop=5, length=100)
for nu in range(0, stop=5, length=6)
	I_nu = besseli.(nu , x)
	plot(x, I_nu, label="\$I_{$nu}(x)\$")
end
title(L"modified Bessel function of the first kind $I_{\nu}(x)$")
xlabel(L"$x$")
ylabel(L"$I_{\nu}(x)$")
legend(loc="best")
show()
#PyPlot.svg(true)

for nu in range(0, stop=5, length=6)
	K_nu = besselk.(nu , x)
	plot(x, K_nu, label="\$K_{$nu}(x)\$")
end
title(L"modified Bessel function of the second kind $K_{\nu}(x)$")
xlabel(L"$x$")
ylabel(L"$K_{\nu}(x)$")
legend(loc="best")
ylim((0, 15)) 
show()
#PyPlot.svg(true)
