function [outF]= runF()

% initial conditions
x1_0 = 2;
x2_0 = 6;
x0 = [x1_0;x2_0;0];
% simulation horizon
TSPAN=[0  50];
JSPAN = [0 400];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',0.01);

maxStepCoefficient = .1;  % set the maximum step length. At each run of the
                   % integrator the option 'MaxStep' is set to 
                   % (time length of last integration)*maxStepCoefficient.
                   %  Default value = 0.1

% simulate
[t x j] = HyEQsolver(@f,@g,@C,@D,x0,TSPAN,JSPAN,rule,options,maxStepCoefficient);
% plot solution
% position


    
% hold on
% plotflows(t,j,x(:,1)-x(:,3));
% grid on
% plotflows(t,j,x(:,2)-x(:,4));

outF=[x,j,t];

end
