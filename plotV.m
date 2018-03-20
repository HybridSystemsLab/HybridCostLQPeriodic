function [EE]=plotV(P,x,j,t)

LL=max(size(x));
V=zeros(1,1);
E=V;
for i=1:LL
   V(i)=x(i,:)*P*x(i,:)';
 end
 
grid on;
 
plotflows(t,j,V,'-',2,[0 0 0]);
ylabel('$$V$$','Interpreter','latex','FontSize',15)
figure;
plotjumps(t,j,V);
ylabel('$$V$$','Interpreter','latex','FontSize',15)
EE=V;
end
