%x1=0;
%x2=0;
x1=1.2220;
x2=0.8147;
g1=2*x1 + 2*pi*x2*sin(0.2*pi*x1)-15*cos(0.4*pi*x2) ;
g2=2*x2- 10*cos(0.2*pi*x1)+ 6*pi*x1*sin(0.4*pi*x2) ;
v1=-g1;
v2=-g2;
vnorm=norm([v1,v2]);
f=x1.^2 -10*x2.*cos(0.2*pi*x1)+x2.^2-15*x1.*cos(0.4*pi*x2);
count=0;
for i=0:0.1:10  
fun=@(a) 2*((x1+v1*a).^2 -10*(x2+v2.*a).*cos(0.2*pi.*(x1+v1.*a))+ (x2+v2*a).^2 - 15*(x1+v1*a).*cos(0.4*pi.*(x2+a.*v2))-f)+(((v1^2+v2^2)*a));   
roots = fzero(fun,i);
if(roots>0)
count=count+1;
collect_root(count)=roots;
end
end


collect_root;
x1_new=x1+(v1*collect_root(1)) ;
x2_new=x2+(v2*collect_root(1)) ;



