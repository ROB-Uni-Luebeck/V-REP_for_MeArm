function VREPconnect(portNumber, jointName, oneRobot)
% connect to V-REP (get clientID and jointHandles)
global vrep;
global vrepDATA;
global numberOfJoints;
%addpath('API');
vrep=remApi('remoteApi');
if oneRobot
    vrep.simxFinish(-1);
end
% ip, port, wait for connect, dont reconnect, timeout in ms, commthread cycle
vrepDATA.clientID = vrep.simxStart('127.0.0.1',portNumber,true,true,5000,5); 
vrepDATA.clientID
if (vrepDATA.clientID>-1)
    disp('V-REP connect');
    for i = 1:1:numberOfJoints
        vrepDATA.stringJoint = sprintf(jointName,i);
        [vrepDATA.returnCode,vrepDATA.jointHandles(i)] = vrep.simxGetObjectHandle(vrepDATA.clientID,vrepDATA.stringJoint,vrep.simx_opmode_blocking);
        vrepDATA.returnCode
    end
end
vrep.simxAddStatusbarMessage(vrepDATA.clientID,'Hello V-REP!',vrep.simx_opmode_oneshot);
end