function xdot = f(x)

    
% state
x1 = x(1);
x2 = x(2);
x3= x(3);
J= x(4);
x=[x1;x2];
global Ac Qc;
xd=Ac*x;
taud=1;
J=x'*Qc*x;
% differential equations
xdot=[xd;taud;J];
end