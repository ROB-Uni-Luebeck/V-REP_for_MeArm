%% DONT TOUCH HERE
% Clear everything and close everything
clear all; close all; clc;

global vrep; 
global vrepDATA;
global numberOfJoints; 
portNumber = 19999; % FOR KUKA: 19999
%% FEEL FREE TO TOUCH
% parameter abhaengig vom Roboter
numberOfJoints = 7; %FOR KUKA 7
jointName = 'LBR_iiwa_7_R800_joint%i'; % FOR KUKA: 'LBR_iiwa_7_R800_joint%i' 'MTB_axis%i'
%verbindet zum ROboterarm
VREPconnect(portNumber, jointName, 1);

% hier kann man die gelenkparameter einstellen
param1 = 0 * pi/180;
while 1
param1 = param1 + 10*pi/180
q = [param1 0 0 0 0 0 0]; 
%fahr Parameter an
VREPtransfer(q);
pause()
end
% trennt die Verbindung
VREPdisconnect;