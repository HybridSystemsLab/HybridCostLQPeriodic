function [t x j] = HyEQsolver( f,g,C,D,x0,TSPAN,JSPAN,rule,options,maxStepCoefficient)
% Code developed by Torstein Ingebrigtsen BÃ
%
% HyEQsolver solves hybrid equations
%   [t x j] = HyEQsolver( f,g,C,D,x0,TSPAN,JSPAN) will integrate
%   x'=f(x) and jump by the rule x = g(x). x is a vector with the same
%   length as x0. Both must return a vector with the
%   equal length as x0.
%
%   inside = C(x) returns 0 if outside of C and 1 inside of C
%
%   inside = D(x) returns 0 if outside of D and 1 inside of D
%
%   TSPAN = [TSTART TFINAL] is the time interval. JSPAN = [JSTART JSTOP] is
%       the interval for discrete jumps. The algorithm stop when the first stop
%       condition is reached.
%
%   rule for jumps
%       rule = 1 (default) -> priority for jumps
%       rule = 2 -> priority for flows
%
%   options - options for the solver see odeset f.ex.
%       options = odeset('RelTol',1e-6);
%
%   maxStepCoefficient - set the maximum step length. At each run of the
%       integrator the option 'MaxStep' is set to (time length of last
%       integration)*maxStepCoefficient.
%       Default value = 0.1


if ~exist('rule','var')
    rule = 1;
end

if ~exist('options','var')
    options = odeset();
end

if ~exist('maxStepCoefficient','var')
    maxStepCoefficient = .1;
end

% simulation horizon
tstart = TSPAN(1);
tfinal = TSPAN(end);

% simulate
options = odeset(options,'Events',@(t,x) zeroevents(x,C,D,rule));
tout = tstart;
xout = x0.';
jout = JSPAN(1);
j = jout(end);

% Jump if jump is prioritized:
if rule == 1
    while (j<JSPAN(end))
        % Check if value it is possible to jump current position
        insideD = D(xout(end,:).');
        if insideD == 1
            [j tout xout jout] = jump(g,j,tout,xout,jout);
        else
            break;
        end
    end
end
fprintf('Completed: %3.0f%%',0);
while (j < JSPAN(end) && tout(end) < TSPAN(end))
    % Check if it is possible to flow from current position
    insideC = C(xout(end,:).');
    if insideC == 1
        [t,x] = ode45(@(t,x) f(x),[tout(end) tfinal],xout(end,:).', options);
        nt = length(t);
        tout = [tout; t];
        xout = [xout; x];
        jout = [jout; j*ones(1,nt)'];
        % A good guess of a valid first time step is the length of
        % the last valid time step, so use it for faster computation.
        options = odeset(options,'InitialStep',t(end)-t(nt-1),...
            'MaxStep',(t(end)-t(1))*maxStepCoefficient);
    end
    
    %Check if it is possible to jump
    insideD = D(xout(end,:).');
    if insideD == 0
        break;
    else
        if rule == 1
            while (j<JSPAN(end))
                % Check if it is possible to jump from current position
                insideD = D(xout(end,:).');
                if insideD == 1
                    [j tout xout jout] = jump(g,j,tout,xout,jout);
                else
                    break;
                end
            end
        else
            [j tout xout jout] = jump(g,j,tout,xout,jout);
        end
    end
    fprintf('\b\b\b\b%3.0f%%',100*tout(end)/TSPAN(end));
end
t = tout;
x = xout;
j = jout;
fprintf('\nDone\n');
end

function [value,isterminal,direction] = zeroevents(x,C,D,rule )
isterminal = 1;
direction = -1;
insideC = C(x);
if insideC == 0
    % Outside of C
    value = 0;
elseif (rule == 1)
    % If priority for jump, stop if inside D
    insideD = D(x);
    if insideD == 1
        % Inside D, inside C
        value = 0;
    else
        % outside D, inside C
        value = 1;
    end
else
    % If inside C and not priority for jump or priority of jump and outside 
    % of D
    value = 1;
end
end

function [j tout xout jout] = jump(g,j,tout,xout,jout)
% Jump
j = j+1;
y = g(xout(end,:).');
% Save results
tout = [tout; tout(end)];
xout = [xout; y.'];
jout = [jout; j];
end
