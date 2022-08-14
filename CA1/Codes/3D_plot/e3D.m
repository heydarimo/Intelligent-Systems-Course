
X1 = -15:0.1:15;
X2 = -15:0.1:15;
[x1,x2] = meshgrid(X1,X2);                                
f_a = 3*x1.^2 +12*x1+8*x2.^2+8*x2+6*x1*x2;
%fa1 = gradient(f_a, 0.2, 0.2);                  % Derivative
%zv = contour(x1,x2,fa1, [0; 0]);                % Critical Points
figure(3)
surf(x1,x2,f_a)
xlabel('x1'); ylabel('x2'); zlabel('z');
%hold on
%plot3(zv(1,2:end), zv(2,2:end), zeros(1,size(zv,2)-1), 'r', 'LineWidth',2)
%hold off