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
jointName = 'uarm_motor%i'; % FOR KUKA: 'LBR_iiwa_7_R800_joint%i' 'MTB_axis%i'
%verbindet zum ROboterarm
VREPconnect(portNumber, jointName, 1);

% hier kann man die gelenkparameter einstellen
while true
    %q = zeros(4,1)%rand(4,1) * 60
    % erster wert drehen in xy ebene
    % zweiter wert 
    q = input('bitte Gelenkwinkel angeben \n >_ ')
    %fahr Parameter an
    VREPtransfer(q);
end
% trennt die Verbindung
VREPdisconnect;