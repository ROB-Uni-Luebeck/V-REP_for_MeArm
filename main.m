%% DONT TOUCH HERE
% Clear everything and close everything
clear all; close all; clc;

global vrep; 
global vrepDATA;
global numberOfJoints; 
portNumber = 20000; % FOR KUKA: 19999
%% FEEL FREE TO TOUCH
% parameter abhaengig vom Roboter
numberOfJoints = 4; %FOR KUKA 7
jointName = 'MTB_axis%i'; % FOR KUKA: 'LBR_iiwa_7_R800_joint%i' 'MTB_axis%i'
%verbindet zum ROboterarm
VREPconnect(portNumber, jointName, 1);

% hier kann man die gelenkparameter einstellen
q = [100 100 0 0]; %ones(numberOfJoints,1)*20;
%fahr Parameter an
VREPtransfer(q);
        
% trennt die Verbindung
VREPdisconnect;