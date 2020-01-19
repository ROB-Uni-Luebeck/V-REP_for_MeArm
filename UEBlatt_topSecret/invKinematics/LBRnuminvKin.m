function q = LBRnuminvKin(M, q_start, robot)

if (exist('jacobianKuka','file')~=2)
    % erzeugt eine Funktion, die die Jacobi-Matrix berechnet
    createJacobianKuka(robot)
    %disp('Bitte führen sie ''run.m'' nochmals aus um die inkrementelle Rückwärtsrechnung durchzuführen!')
    q = LBRnuminvKin_codeSnippet(M, q_start, robot);
else
    % inkrementelle Rückwärtsrechnung für den sphärischen Roboter
    q = LBRnuminvKin_codeSnippet(M, q_start, robot);
end