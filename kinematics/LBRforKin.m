function [M] = LBRforKin(J,robot)

%% Setting up DH-Parameter: Which robot?
a = [0,0,0,0,0,0,0];
alp = [-90,90,-90,90,-90,90,0].*(pi/180);

if strcmp(robot,'LBR4+') % LBR 4+ 
    d = [310.4,0,400.1,0,390,0,78]; 
end
if strcmp(robot,'LBR5') % LBR 5 iiwa
    d = [340,0,400,0,400,0,111];
end
M01 = DHjT(J(1),a(1),alp(1),d(1));
M12 = DHjT(J(2),a(2),alp(2),d(2));
M23 = DHjT(J(3),a(3),alp(3),d(3));
M34 = DHjT(J(4),a(4),alp(4),d(4));
M56 = DHjT(J(5),a(5),alp(5),d(5));
M67 = DHjT(J(6),a(6),alp(6),d(6));
M78 = DHjT(J(7),a(7),alp(7),d(7));
M08 = M01*M12*M23*M34*M56*M67*M78;
M = M08;
