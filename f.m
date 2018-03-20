function xdot = f(x)

    
% state
x1 = x(1);
x2 = x(2);
J= x(3);
x=[x1;x2];
global Ac Qc;
xd=Ac*x;
J=x'*Qc*x;
% differential equations
xdot=[xd; J];
end