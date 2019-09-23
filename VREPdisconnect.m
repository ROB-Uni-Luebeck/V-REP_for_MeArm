function VREPdisconnect()
global vrep;
global vrepDATA;
% disconnect V-REP (delete remoteAPI clear vrepDATA)
if (vrepDATA.clientID>-1)
    vrep.simxFinish(-1); 
end
vrep.delete();
clear vrepDATA;
disp('VREP disconnect');