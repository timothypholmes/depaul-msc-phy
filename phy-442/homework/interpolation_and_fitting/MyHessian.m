function [a] = MyHessian(a,h)
% MyHessian Computes hessian matrix using eqs. 2.74 and 2.75 from text
% Note: code is not complete but should give you enough to make progress
% Inputs: a, starting values of parameters
%         h, starting stepsize to change parameters
% .
% .
% .
% LSE contains the infomration about the data's functional form
m = length (a);

for i = 1:m
    for j = 1:m
        if i==j
            for k = 1:m
                ap(k) = a(k);
                am(k) = a(k);
            end
                ap(i) = a(i) + h(i);
                am(i) = a(i) - h(i);
                hessian(i,i) =(LSE(ap) -2*LSE(a)+LSE(am))/(h(i) *h(i));
        else
            for k = 1:m
                app(k) = a(k);
                apm(k) = a(k);
                amp(k) = a(k);
                amm(k) = a(k);
            end
            app(i) = a(i) + h(i);
            app(j) = a(j) + h(j);
            % amp and amm work similarly
            hessian(i,j) = ((LSE(app) - LSE(apm))/(2*h(j))-...
                (LSE(amp)-LSE(amm))/(2*h(j)))/(2*h(i));
            hessian(j,i) = hessian(i,j);
        end
    end
end
% .
% .
% .
           
                   
end

