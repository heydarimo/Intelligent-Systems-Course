function [xopt,fopt,niter,gnorm,dx,xnew_collect] = grad_descent2(varargin)

if nargin==0
    % define starting point
    x0 = [5 5]';
elseif nargin==1
    % if a single input argument is provided, it is a user-defined starting
    % point.
    x0 = varargin{1};
else
    error('Incorrect number of input arguments.')
end

% termination tolerance
tol = 1e-6;

% maximum number of allowed iterations
maxiter = 1000;

% minimum allowed perturbation
dxmin = 1e-6;

% step size ( 0.33 causes instability, 0.2 quite accurate)
alpha = 0.005;

% initialize gradient norm, optimization vector, iteration counter, perturbation
gnorm = inf; x = x0; niter = 0; dx = inf;

% define the objective function:
f = @(x1,x2) x1.^2 -10.*x2*cos(0.2.*pi.*x1)+x2.^2-15.*x1.*cos(0.4.*pi.*x2);

% plot objective function contours for visualization:
figure(1); clf; fcontour(f,[-5 5 -5 5]); axis equal; hold on

% redefine objective function syntax for use with optimization:
f2 = @(x) f(x(1),x(2));

% gradient descent algorithm:
count=0;
xnew_collect=zeros(2,1000);
xnew_collect(1:2,1)=x0;
while and(gnorm>=tol, and(niter <= maxiter, dx >= dxmin))
    % calculate gradient:
    g = grad(x);
    gnorm = norm(g);
    % take step:
    xnew = x - alpha*g;
    count=count+1;
    xnew_collect(1:2,count+1)=xnew;
    % check step
    if ~isfinite(xnew)
        display(['Number of iterations: ' num2str(niter)])
        error('x is inf or NaN')
    end
    % plot current point
    plot([x(1) xnew(1)],[x(2) xnew(2)],'ko-')
    refresh
    % update termination metrics
    niter = niter + 1;
    dx = norm(xnew-x);
    x = xnew;
    
end
xopt = x;
fopt = f2(xopt);
niter = niter - 1;

% define the gradient of the objective

function g = grad(x)
    
    g = [2*x(1) + 2*pi*x(2)*sin(0.2*pi*x(1))-15*cos(0.4*pi*x(2)) ; 2*x(2)- 10*cos(0.2*pi*x(1))+ 6*pi*x(1)*sin(0.4*pi*x(2))];

