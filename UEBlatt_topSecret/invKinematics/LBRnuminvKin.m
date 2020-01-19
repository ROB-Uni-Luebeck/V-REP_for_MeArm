function q = LBRnuminvKin(M, q_start, robot)

if (exist('jacobianKuka','file')~=2)
    % erzeugt eine Funktion, die die Jacobi-Matrix berechnet
    createJacobianKuka(robot)
    %disp('Bitte f�hren sie ''run.m'' nochmals aus um die inkrementelle R�ckw�rtsrechnung durchzuf�hren!')
    q = LBRnuminvKin_codeSnippet(M, q_start, robot);
else
    % inkrementelle R�ckw�rtsrechnung f�r den sph�rischen Roboter
    q = LBRnuminvKin_codeSnippet(M, q_start, robot);
end