alpha=5;
x=[0 ;0];
[alpha_armijo_vector,xvector,fvector] = alfa_armijo_finder(alpha,x,20)




function [xnew,alpha_armijo,f] = armijo(alpha,x)  
Beta = 0.5;
Epsilon = 1e-4;
f_z = @(x1,x2) x1.^2 -10.*x2*cos(0.2.*pi.*x1)+x2.^2-15.*x1.*cos(0.4.*pi.*x2);
f0 = @(x) f_z(x(1),x(2));
g=[2*x(1) + 2*pi*x(2)*sin(0.2*pi*x(1))-15*cos(0.4*pi*x(2)) ; 2*x(2)- 10*cos(0.2*pi*x(1))+ 6*pi*x(1)*sin(0.4*pi*x(2))];
d=-g;
loop= 1;
while (loop>0)
x_new = x+alpha.*d;
if (f0(x_new)<=f0(x)+Epsilon*alpha*g'*d)
loop = 0;
alpha_armijo = alpha;
else
alpha = alpha*Beta;
end 
end
f=f0(x_new);
xnew=x_new;
end

function [alpha_armijo_vector,xvector,fvector] = alfa_armijo_finder(alpha,x,n_iteration)  
xvector=zeros(2,n_iteration);
for i=1:1:n_iteration
[xnew,alpha_armijo,f] = armijo(alpha,x);   
vector1(i)= alpha_armijo; 
vector2(:,i)=x;
vector3(i)=f;
x=xnew;
end
alpha_armijo_vector=vector1;
xvector=vector2;
fvector=vector3;
end

