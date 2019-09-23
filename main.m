%% DONT TOUCH HERE
% Clear everything and close everything
clear all; close all; clc;

global vrep; 
global vrepDATA;
global numberOfJoints; 
portNumber = 20000; % FOR KUKA: 19999
%% FEEL FREE TO TOUCH
% parameter abhaengig vom Roboter
numberOfJoints = 3;
jointName = 'uarm_motor%i'; % FOR KUKA: 'LBR_iiwa_7_R800_joint%i'
%verbindet zum ROboterarm
VREPconnect(portNumber, jointName, 1);

% hier kann man die gelenkparameter einstellen
q = ones(numberOfJoints,1)*20;
%fahr Parameter an
VREPtransfer(q);
        
% trennt die Verbindung
VREPdisconnect;