function [u] = MyHeatEq(N, maxiter, u0t, u0x, uft, ufx)

    sqrt_alpha = sqrt(4 - (2*cos(pi/N))^2);
    alpha      = (4/(2 + sqrt_alpha)) - 1;

    tol      = 5.e-5;      
    u        = zeros(2,N); 
    u(1,1:N) = u0t;
    u(1:N,1) = u0x;
    u(N,1:N) = uft;  
    u(1:N,N) = ufx; 
    count    = 0; 
    done     = false; 
    while ~done 
        done  = true;                
        count = count + 1; 
        if (count >= maxiter), error( 'Too many iterations!'); end 
        for i = 2: N-1 
            for j = 2: N-1 
                uu = .25*(u(i+1,j) + u(i-1,j)+u(i,j+1)+u(i,j-1)); 
                if(abs((uu-u(i,j))/uu) > tol), done = false; end 
                u(i,j) = uu + alpha *(uu -u(i,j));  
            end 
        end 
    end 
end
