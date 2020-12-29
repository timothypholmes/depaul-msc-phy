function in_class()

fun1 = @(x) (x.^2);
fun_int_1 = integral(fun1, 0, 1);
fprintf('%f\n', fun_int_1)

fun2 = @(x, c) (c*x.^2);
fun_int_2 = integral(@(x)fun2(x,5), 0, 1);
fprintf('%f\n', fun_int_2)

fun3 = @(x, a, b) (a*x.^2 + b);
fun_int_3 = integral(@(x)fun3(x, 5, 4), 0, 1);
fprintf('%f\n', fun_int_3)

w = 1;
f_t = @(t, a) ((a * (1 - a * abs(t))) * exp(-1*i * w * t));
g_w = 1/(sqrt(2*pi)) * integral(@(t)f_t(t, 10), -Inf, Inf);
g_w

end