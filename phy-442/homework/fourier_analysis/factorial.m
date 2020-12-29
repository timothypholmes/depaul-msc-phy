function x = factorial(n)

x = n;

if n == 0 
    x = 1;
    
else
    x = x * factorial(n - 1);
    
end

display(x)

end