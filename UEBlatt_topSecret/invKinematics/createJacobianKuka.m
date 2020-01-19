function createJacobianKuka(robot)
syms theta_1 theta_2 theta_3 theta_4 theta_5 theta_6 theta_7

J = [];
q = [theta_1; theta_2; theta_3; theta_4; theta_5; theta_6; theta_7];

if strcmp(robot, 'LBR7_vrep')
    a = zeros(7,1);
    alp = [-90; 90; 90; -90; -90; 90; 0].*(pi/180);
    theta = zeros(7,1);
    d = [0.340; 0; 0.400; 0; 0.400; 0; 0.126];
end

dhP = [a alp d q];

BKS_A_7 = poseSym(dhP,1,7);
BKS_A_7 = simplify(BKS_A_7);

diary('jacobianKuka.txt')
diary on
for i = 1:4
    J = [J; jacobian(BKS_A_7(1:3,i), q)];
end
J
diary off

matlabFunction(J, 'file', 'jacobianKuka')
end