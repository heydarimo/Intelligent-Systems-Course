clc;
clear;
close all;

% Generate a contour plot
% Start location
x_start = [10, 7];

% Design variables at mesh points
i1 = -1.0:0.01:1.0;
i2 = -1.0:0.01:1.0;
[x1m, x2m] = meshgrid(i1, i2);
fm=x1m.^2 -10*x2m.*cos(0.2*pi*x1m)+x2m.^2-15*x1m.*cos(0.4*pi*x2m);

% Contour Plot
fig = figure(1);
[C,h] = contour(x1m,x2m,fm);
clabel(C,h,'Labelspacing',250);
title('Simulated Annealing');
xlabel('x1');
ylabel('x2');
hold on;

% Simulated Annealing

% Number of cycles
n = 50;
% Number of trials per cycle
m = 50;
% Number of accepted solutions
na = 0.0;
% Probability of accepting worse solution at the start
p1 = 0.7;
% Probability of accepting worse solution at the end
p50 = 0.001;
% Initial temperature
t1 = -1.0/log(p1);
% Final temperature
t50 = -1.0/log(p50);
% Fractional reduction every cycle
frac = (t50/t1)^(1.0/(n-1.0));
%frac=0.5;
% Initialize x
x = zeros(n+1,2);
x(1,:) = x_start;
xi = x_start;
na = na + 1.0;
% Current best results so far
% xc = x(1,:);                          
fc = f(xi);
fs = zeros(n+1,1);
fs(1,:) = fc;
% Current temperature
t = t1;
% DeltaE Average
DeltaE_avg = 0.0;
for i=1:n
    disp(['Cycle: ',num2str(i),' with Temperature: ',num2str(t)])
    xc(1) = x(i,1);                        
    xc(2) = x(i,2);                        
    for j=1:m
        % Generate new trial points
        xi(1) = xc(1) + rand() - 0.5;
        xi(2) = xc(2) + rand() - 0.5;
        % Clip to upper and lower bounds
        xi(1) = max(min(xi(1),15.0),-15.0);
        xi(2) = max(min(xi(2),15.0),-15.0);
        DeltaE = abs(f(xi)-fc);
        if (f(xi)>fc)
            % Initialize DeltaE_avg if a worse solution was found
            %   on the first iteration
            if (i==1 && j==1)
                DeltaE_avg = DeltaE;
            end
            % objective function is worse
            % generate probability of acceptance
            p = exp(-DeltaE/(DeltaE_avg * t));
            %             % determine whether to accept worse point
            if (rand()<p)
                % accept the worse solution
                accept = true;
            else
                % don't accept the worse solution
                accept = false;
            end
        else
            % objective function is lower, automatically accept
            accept = true;
        end

        % accept                            
        if (accept==true)
            % update currently accepted solution
            xc(1) = xi(1);
            xc(2) = xi(2);
            fc = f(xc);

            xa(j,1) = xc(1);                
            xa(j,2) = xc(2);                
            fa(j) = f(xc);                  
            % increment number of accepted solutions
            na = na + 1.0;
            % update DeltaE_avg
            DeltaE_avg = (DeltaE_avg * (na-1.0) +  DeltaE) / na;
        else
            fa(j) = 0.0;                    
        end
    end
    % cycle)
    fa_Min_Index = find(nonzeros(fa) == min(nonzeros(fa)));

    if isempty(fa_Min_Index) == 0          
        x(i+1,1) = xa(fa_Min_Index,1);  
        x(i+1,2) = xa(fa_Min_Index,2);  
        fs(i+1)  = fa(fa_Min_Index);    
    else                                    
        x(i+1,1) = x(i,1);                  
        x(i+1,2) = x(i,2);                  
        fs(i+1)  = fs(i);                  
    end                                    
    % Lower the temperature for next cycle
    t = frac * t;
    fa = 0.0;                              
end
% print solution
disp(['Best candidate: ',num2str(xc)])
disp(['Best solution: ',num2str(fc)])
plot(x(:,1),x(:,2),'r-o')
saveas(fig,'contour','png')

fig = figure(2);
subplot(2,1,1)
plot(fs,'r.-')
legend('Objective')
subplot(2,1,2)
hold on
plot(x(:,1),'b.-')
plot(x(:,2),'g.-')
legend('x_1','x_2')

% Save the figure as a PNG
saveas(fig,'iterations','png')