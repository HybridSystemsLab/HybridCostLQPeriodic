function xplus = g(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file               Author: Torstein Ingebrigtsen B??
%
% Project: Simulation of a hybrid system (bouncing ball)
%
% Description: Jump map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% state
x1 = x(1);
x2 = x(2);
J= x(3);
x=[x1;x2];
global Ad Qc;
xplus=[Ad*x; J+x'*Qc*x];
end