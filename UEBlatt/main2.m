clear all; close all; clc;

%% actual code
VREPconnect;
posA = [0.425; 0; 0.1]; % start pos of element
rotation = rotz(90)*rotx(180);
M_1 = [[rotation;[0 0 0]] [posA;1]];
posB = [ -0.425; 0; 0.05]; % todo: choose position
M_1 = [0 1.0000 0 0.4250;
        1.0000 0 0 0;
        0 0 -1.0000 0.1000;
        0 0 0 1.0000]
M_2 = [-0.4924 -0.6428 0.5868 0.4289;
        -0.4132 0.7660 0.4924 0.3599;
        -0.7660 -0.0000 -0.6428 0.5835;
         0 0 0 1.0000];
M_3 = [[eye(3);[0 0 0]] [posA;1]]
%% homogenius matrices
M_pickUp = [0.2140 0.9272 -0.3073 0.0839;
            0.9671 -0.2454 -0.0668 -0.0282;
            -0.1373 -0.2829 -0.9493 0.1582;
            0 0 0 1.0000];

%%
% starting at:
openGripper;
q = zeros(7,1); % current joint values
VREPtransfer;
pause(1);
q = [30 45 -35 -160 90 22 10].*pi/180;
M_pickUp = LBRforKin(q,'LBR7_med')
%q = LBRinvKin(M_pickUp, [-1 -1 -1 0], 'LBR7_med').*pi/180;
VREPtransfer;
pause()
%M = LBRforKin(q,'LBR7_med') 
%M = LBRforKin(q,'LBR7_med') 
%VREPtransfer;

% while true
     closeGripper;
     pause();
     q = zeros(7,1);
%     q = input('q= \n')
    VREPtransfer;
% end

VREPdisconnect; % trennt die Verbindung -> nur einmal am Ende aufrufen


%%  0.0000   48.3844    0.0000  113.2619 -180.0000  115.1225  -90.0000

% q0 = zeros(7,1);
% q1 = [30 45 -35 -160 90 20 10].*pi/180;