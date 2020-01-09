%% DONT TOUCH HERE
clear all; close all; clc;

VREPconnect;
posA = [0.425; 0; 0.05]; % start pos of element
rotation = rotz(90)*rotx(180);
M_1 = [[rotation;[0 0 0]] [posA;1]];
posB = [ -0.425; 0; 0.05]; % todo: choose position


% starting at:
q = zeros(7,1); % current joint values
q = [40 10 0 -90 0 30 0].*pi/180;
%% FEEL FREE TO TOUCH
VREPtransfer;
%q = LBRinvKin(M_1, [1 1 1 1], 'LBR7');
M = LBRforKin(q,'LBR7') % -0.1 in x richtung

disp('result')
q

VREPtransfer;

VREPdisconnect; % trennt die Verbindung -> nur einmal am Ende aufrufen
