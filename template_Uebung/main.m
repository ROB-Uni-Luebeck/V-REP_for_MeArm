%% dieses skript gibt eine einfuehrung in alle Befehle die benutzt werden koennen
% Anleitung:    - installiere und oeffne vrep und Matlab
%               - lade diesen Ordner runter: oeffne dieses skript in matlab und die
%               szene in vrep (achte darauf, dass alles im gleichen ordner ist)
%               - starte die Simmulation in vrep, dann fuehre das skript
%               aus
%               - viel spass
%
%% DONT TOUCH HERE
% angaben muessen in rad gemacht werden, also *pi/180
% dieses script ist fuer ownRobot1
% Clear everything and close everything
clear all; close all; clc;
portNumber = 19999;
numberOfJoints = 4;
jointName = 'joint%i';
%% FEEL FREE TO TOUCH
%verbindet zum ROboterarm
VREPconnect;

% q ist ein 1x4 vektor, der in rad die Grad zahlen der einzelnen Gelenke
% angibt -> q = [joint1 joint2 joint3 joint4]
% VREPtransfer sendet die Gelenkparameter an VREP
q = zeros(1,4);
VREPtransfer;

pause();
% close gripper command
VREPcloseGripper;
    
pause();
% open gripper
VREPopenGripper;
    
pause();
% move joints in rad
q = input('bitte Gelenkwinkel angeben \n >_ ');
VREPtransfer;
    
pause();
% trennt die Verbindung
VREPdisconnect;
       
        

