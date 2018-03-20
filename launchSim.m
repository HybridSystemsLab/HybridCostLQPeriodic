%close all;
clc;
Out=runF();
x=Out(:,1:6);
xplant=x(:,1:2);
tau=x(:,3);
cost=x(:,4);
t=Out(:,6);
j=Out(:,5);
figure(1);

%% Plot
plot(xplant(:,1), xplant(:,2),'-b');
grid on;
% 
% subplot(2,1,1)
% plotflows(t,j,x(:,1),'-k',1,[0,0,0]+0.7);
% hold on;
% plotflows(t,j,x(:,2),'-k',1,[0,0,0]);
% grid on;
