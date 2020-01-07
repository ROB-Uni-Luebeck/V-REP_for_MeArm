function [q,currentPos,e,error] = newtonInKin(epsilon,eta,deltaStep,q,desPos,iiwaDATA)

% epsilon -> acceptable error
% eta -> stepsize eta
% deltaStep -> jacobian numerical derive deltaStep
% q -> starting parameters (current joint values)
% desPos -> destination position

% q
% currentPos
% e -> errorVector
% error -> distance between desPos and currentPos

%{
% log every jointparameter over timestep
q_log_newton = q;
%}

% LOOP
setEta = [true,true];
currentPos = fwKinHRM(q,iiwaDATA);
e = desPos - currentPos;
error = norm(e,2);
while error > epsilon
    J = jacNum(q,deltaStep,currentPos,iiwaDATA); % numericJacobian
    invJ = pinv(J);
    
    % calculations for next itaration
    q = q + eta * invJ * e;
    
    % sollte ohne funktionieren, die inverse ist viel zu grob,
    % winkel mit 10^+4 ist murks!!!
    for i = 1:1:7
        while q(i) > pi
            q(i) = q(i) - 2*pi;
        end
        while q(i) < -pi
            q(i) = q(i) + 2*pi;
        end
    end
    
    currentPos = fwKinHRM(q,iiwaDATA);
    e = desPos(:,1) - currentPos;
    error = norm(e,2)
    
    % kleinerer fehler, kleieres eta - zwei mal
    if error < 0.1 & setEta(1)
        eta = eta * 0.1;
        setEta(1) = false;
    end
    if error < 0.01 & setEta(2)
        eta = eta * 0.1;
        setEta(2) = false;
    end
    %    q_log_newton = cat(2,q_log_newton,q);
end