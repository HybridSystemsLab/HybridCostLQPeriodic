%This script allows one to reproduce Example 1 in Ferrante Sanfelice CDC
%2018

%Definition of the data

Ac=[1 1;
    0 0];

Ad=[1 0; -2 0];

Qc=eye(2);

Qd=eye(2);

T=1;

global Ac Ad Qd Qc T;

n=max(size(Ac));

%Solution to the DT Lyapunov equation
%X-Ad'*expm(Ac'*T)*X*expm(Ac'*T)*Ad=Ad'*psi_0(2,1)*expm(Ac*T)*Ad+Qd

H=[Ac, zeros(n,n); 
   -Qc, -Ac.'];

Psi_0=expm(-H*T);

psi_0_2_1=Psi_0(n+1:2*n,1:n);

Alyap=(Ad'*expm(Ac'*T));

Qlyap=(Ad'*psi_0_2_1*expm(Ac*T)*Ad+Qd);

X=dlyap(Alyap,Qlyap);

P_0=(psi_0_2_1+expm(Ac'*T)*X)*expm(Ac*T); 

%% Simulation of the hybrid system including computation of the cost along the solution

%initial condition
xp0=[1,1];
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
x0=[xp0';0;0];

[t, x, j] = HyEQsolver(@f,@g,@C,@D,x0,TSPAN,JSPAN,rule,options,maxStepCoefficient);

xp=x(:,1:2);
tau=x(:,3);
cost=x(:,4);
%% Plot
figure(1);
plotHarc(xp(:,1),j,xp(:,2));
grid on;
figure(2);
plotHarcColor(t,j,cost);
hold on
plot(t,t*0+xp0*P_0*xp0','--', 'linewidth',2);
grid on;