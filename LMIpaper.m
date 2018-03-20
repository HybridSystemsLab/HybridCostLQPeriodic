clear all;

Ac=[0 1;
   -1 0] ; 
% Ad=[0.8 0; 
%     0.8 0];
Ac2=[-1 1;
   -1 -1];
Ad=expm(Ac2);
%%%%%%%%%%%
np=max(size(Ac));

Qc=eye(np);
M=[-1, 0.5;0.5 0];
%%%%%%%%%%%
tau1=sdpvar(1,1,'full');
tau2=sdpvar(1,1,'full');
lambda=sdpvar(1,1,'full');
P=sdpvar(np,np,'symmetric');

flow=[Ac'*P+P*Ac+Qc+tau1*M<=0, P>=eye(np)*1e-8];
jump=[Ad'*P*Ad-P+Qc-tau2*M<=0];
problem=flow+jump+[tau1>=0,tau2>=0, P-lambda*eye(np)<=0];
options=sdpsettings('solver','mosek','verbose',2);
solution=solvesdp(problem,lambda,options);
P=double(P);


