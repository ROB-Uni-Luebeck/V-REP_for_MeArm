function J = jacNum(q, deltaStep, currentPos, iiwaDATA)
% numeric Jacobian
J = zeros(3,7);
for i = 1:1:7
    % numeric first-order partial derivate of the fwKin of q(i)
    deltaQ = q;
    deltaQ(i) = q(i) + deltaStep;
    deltaPos = fwKinHRM(deltaQ,iiwaDATA);
    J(:,i) = (deltaPos - currentPos)/deltaStep;
end
end