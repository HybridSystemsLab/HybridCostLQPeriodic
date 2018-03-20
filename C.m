function [value discrete] = C(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Torstein Ingebrigtsen B??
%
% Description: Flow set
% Return C if outside of D, and 1 if inside C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = x(1);
x2 = x(2);
x=[x1;x2];
global M;

if (x'*M*x>=0)
   
    value = 1;
else
    value = 0;
end
end