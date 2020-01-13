function [M] = LBRforKin(J,robot)

%% Setting up DH-Parameter: Which robot?
a = [0,0,0,0,0.4350,0.435,0];
alp = [90,90,90,90,-90,-90,90].*(pi/180);
theta = zeros(7,1);
if strcmp(robot,'LBR4+') % LBR 4+
    d = [310.4,0,400.1,0,390,0,78];
elseif strcmp(robot,'LBR5') % LBR 5 iiwa
    d = [340,0,400,0,400,0,111];
elseif strcmp(robot, 'LBR7_vrep') % das sind die parameter für den Arm -> für die übung
    a = zeros(7,1);
    alp = [-90, 90, 90, -90, -90, 90, 0].*(pi/180);
    theta = zeros(7,1);
    d = [0.340, 0, 0.400, 0, 0.400, 0, 0.126];
    %% checking wether parameters are in range!
    J = J.*180/pi;
    if abs(J(1)) <= 170 && abs(J(2)) <= 120 && abs(J(3)) <= 170 && abs(J(4)) <= 120 && abs(J(5)) <= 170 && abs(J(6)) <= 120 && abs(J(7)) <= 175 
        % all parameters are fine
        J = J.*pi/180;
    else
        disp('wrong joint parameters')
        M = eye(4);
        return;
    end
else
    disp('wrong robot type')
end
M01 = DHjT(J(1)+theta(1),a(1),alp(1),d(1));
M12 = DHjT(J(2)+theta(2),a(2),alp(2),d(2));
M23 = DHjT(J(3)+theta(3),a(3),alp(3),d(3));
M34 = DHjT(J(4)+theta(4),a(4),alp(4),d(4));
M45 = DHjT(J(5)+theta(5),a(5),alp(5),d(5));
M56 = DHjT(J(6)+theta(6),a(6),alp(6),d(6));
M67 = DHjT(J(7)+theta(7),a(7),alp(7),d(7));
M07 = M01*M12*M23*M34*M45*M56*M67;
M = M07;
