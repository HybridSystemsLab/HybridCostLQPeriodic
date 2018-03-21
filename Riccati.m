%This script provides the solution to the Lyapunov equaiton in Example 1 

clear all;

Ac=[1 1;
    0 0];

Ad=[1 0; -2 0];

Qc=eye(2);

Qd=eye(2);

T=1;

global Ac Ad Qd Qc T;

n=max(size(Ac));

H=[Ac, zeros(n,n); 
   -Qc, -Ac.'];

Psi_0=expm(-H*T);

psi_0_2_1=Psi_0(n+1:2*n,1:n);

%Solve the Lyapunov DT equation
%X-Ad'*expm(Ac'*T)*X*expm(Ac'*T)*Ad=Ad'*psi_0(2,1)*expm(Ac*T)*Ad+Qd

Alyap=(Ad'*expm(Ac'*T));

Qlyap=(Ad'*psi_0_2_1*expm(Ac*T)*Ad+Qd);

X=dlyap(Alyap,Qlyap);

P_0=(psi_0_2_1+expm(Ac'*T)*X)*expm(Ac*T);



