function inside = D(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Torstein Ingebrigtsen B??
%
% Description: Jump set
% Return 0 if outside of D, and 1 if inside D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1 = x(1);
x2 = x(2);
x=[x1;x2];

global M;

if (x'*M*x<=0)
    inside = 1;
else
    inside = 0;
end
end