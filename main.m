% Clear everything and close everything
clear all
close all
clc

% Add path for the API scripts
addpath('API')

% verbindet mit dem roboterarm -> Simmulation muss laufen
VREPconnect;

% hier kann man die gelenkparameter einstellen -> transfer lässt anfahren
q = ones(7,1)*20;
VREPtransfer;
    
pause();
        
% trennt die Verbindung
VREPdisconnect;