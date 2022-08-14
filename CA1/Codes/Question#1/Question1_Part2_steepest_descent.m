[xopt,fopt,niter,gnorm,dx,xnew_collect] = gradient_descent1();
xopt
fopt
niter
dx
function [Target_xvalue,yvalue_optimal,iterations_Num,gnorm,dx] = gradient_descent1()
x0 = [1 ; 1];
tolerance = 1e-6;
max_iterations = 1000;
dxmin = 1e-6;
alpha = 0.01;
gnorm = inf;
x = x0; 
iterations_Num = 0; 
dx = inf;
f = @(x1,x2) 3*x1.^2 + 12*x1 + 8*x2.^2 + 8*x2 + 6*x1.*x2;
figure(1); 
clf; 
fcontour(f,[-15 15 -15 15]); 
axis equal; 
hold on
f2 = @(x) f(x(1),x(2));
while (gnorm>=tolerance || (iterations_Num <= max_iterations && dx >= dxmin))
    g = [6*x(1) + 6*x(2)+12 ; 6*x(1) + 16*x(2)+8];
    gnorm = norm(g);
    direction=-g;
    xnew = x + alpha*direction;  
    plot([x(1) xnew(1)],[x(2) xnew(2)],'ko-')
    refresh
    iterations_Num = iterations_Num + 1;
    dx = norm(xnew-x);
    x = xnew; 
end
Target_xvalue = x;
yvalue_optimal = f2(Target_xvalue);
iterations_Num = iterations_Num - 1;
end