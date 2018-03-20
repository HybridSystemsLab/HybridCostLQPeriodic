%close all;
clc;
Out=runF();
x=Out(:,1:5);
xplant=x(:,1:2);
cost=x(:,3);
t=Out(:,5);
j=Out(:,4);
figure(1);
%plotV(P1,P2,epsilon,e,tau,t,j,'k',1,sigma);
%% Plot
plot(xplant(:,1), xplant(:,2),'-b');
grid on;
% 
% subplot(2,1,1)
% plotflows(t,j,x(:,1),'-k',1,[0,0,0]+0.7);
% hold on;
% plotflows(t,j,x(:,2),'-k',1,[0,0,0]);
% grid on;
