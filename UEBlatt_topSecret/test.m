clear all; close all; clc;
robot = 'LBR7_vrep';
%% script what robot does
% connect to vrep
VREPconnect;

q = zeros(7,1);
VREPtransfer;
pause(2)

q = [0 0 0 90 0 0 0]*pi/180;
VREPtransfer;
pause(2)

q = zeros(7,1);
VREPtransfer;
pause(2)

% trennt die Verbindung -> nur einmal am Ende aufrufen
VREPdisconnect;