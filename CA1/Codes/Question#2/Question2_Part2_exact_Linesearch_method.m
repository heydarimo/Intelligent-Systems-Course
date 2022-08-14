x1=10;
x2=7;
[alpha_optimum_vector,xvector,fvector] = alfa_finder(x1,x2,20)


function [x1_new,x2_new,alpha_optimum,f] = diff(x1,x2)
v1=2*x1 + 2*pi*x2*sin(0.2*pi*x1)-15*cos(0.4*pi*x2) ;
v2=2*x2- 10*cos(0.2*pi*x1)+ 6*pi*x1*sin(0.4*pi*x2) ;
v1=-v1;
v2=-v2;
f=x1.^2 -10*x2.*cos(0.2*pi*x1)+x2.^2-15*x1.*cos(0.4*pi*x2);
collect_minn=zeros(2,5000);
count=0;
for i=0:0.1:500  
fun=@(a) (x1+v1*a).^2 -10*(x2+v2.*a).*cos(0.2*pi.*(x1+v1.*a))+ (x2+v2*a).^2 - 15*(x1+v1*a).*cos(0.4*pi.*(x2+a.*v2));
val=fminsearch(fun,i);
minn=fun(val);
if(val>0)
count=count+1;
collect_minn(1,count)=val;
collect_minn(2,count)=minn;
end
end
vector=collect_minn(2,:);
[M,I]=min(vector);
alpha_optimum=collect_minn(1,I);
x1_new=x1+(v1*alpha_optimum) ;
x2_new=x2+(v2*alpha_optimum) ;
end

function [alpha_optimum_vector,xvector,fvector] = alfa_finder(x1,x2,n_iteration)
xvector=zeros(2,n_iteration);
for i=1:1:n_iteration
[x1_new,x2_new,alpha_optimum,f] = diff(x1,x2);   
vector1(i)= alpha_optimum; 
vector2(:,i)=[x1;x2];
vector3(i)=f;
x1=x1_new;
x2=x2_new;
end
alpha_optimum_vector=vector1;
xvector=vector2;
fvector=vector3;
end
