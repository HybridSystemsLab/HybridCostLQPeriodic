function [x_sliced,t_sliced] = plotHarc(t,j,x,jstar,modificator)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Pablo Nanez
%
% Project: Simulation of a hybrid system
%
%
% Name: plotHarc.m
%
% Description: plots a hybrid arc in hybrid time domain
%
% Version: 0.01
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch nargin
    case 3
        iini = j(1);
        ifini = j(end);
        modificator = '';
    case 4
        iini = jstar;
        ifini = jstar;
        modificator = '';        
    case 5
        if isempty(jstar)
            iini = 0;
            ifini = j(end);
        else
            iini = jstar;
            ifini = jstar;
        end        
end
x_sliced{ifini-iini+1} = [];
t_sliced{ifini-iini+1} = [];
for ij=1:ifini-iini+1
    iij = find(j(:)==iini+ij-1,1,'first');
    fij = find(j(:)==iini+ij-1,1,'last');
    x_sliced{ij} = x(iij:fij,:);
    t_sliced{ij} = t(iij:fij);
    plot(t_sliced{ij},x_sliced{ij},modificator)
    hold on;
    if ij>1
        plot(t(iij-1:iij),x(iij-1:iij,:),['--*',modificator]);
    end
end
hold off;