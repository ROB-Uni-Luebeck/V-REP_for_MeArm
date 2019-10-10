%% DONT TOUCH HERE
% angaben muessen in rad gemacht werden, also *pi/180
% dieses script ist fuer ownRobot1
% Clear everything and close everything
clear all; close all; clc;

global vrep; 
global vrepDATA;
global numberOfJoints; 
portNumber = 19999;
%% FEEL FREE TO TOUCH
% parameter abhaengig vom Roboter
numberOfJoints = 4; %FOR KUKA 7
jointName = 'joint%i'; % FOR KUKA: 'LBR_iiwa_7_R800_joint%i' 'MTB_axis%i'
%verbindet zum ROboterarm
VREPconnect(portNumber, jointName, 1);
VREPtransfer([0 0 0 0])

while 1
    q = input('bitte Gelenkwinkel angeben \n >_ ');
    %fahr Parameter an
    VREPtransfer(q);
end
% trennt die Verbindung
VREPdisconnect;

%% forward kinematics -> fragen nach code
% parameter
% a alpha d theta
DHtabelle = [0.0000 -90.0 0.3450 90.0;
            0.0000 90.0 -0.2500 -90.0;
            0.0 0.2500 0.0000 -90.0
            0.3271 0.0 0.0 1.3];
        
        

