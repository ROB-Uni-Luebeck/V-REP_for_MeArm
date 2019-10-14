% connect to V-REP (get clientID and jointHandles)
%addpath('API');
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
% ip, port, wait for connect, dont reconnect, timeout in ms, commthread cycle
vrepDATA.clientID = vrep.simxStart('127.0.0.1',portNumber,true,true,5000,5); 
if (vrepDATA.clientID>-1)
    disp('V-REP connect');
    for i = 1:1:numberOfJoints
        vrepDATA.stringJoint = sprintf(jointName,i);
        [vrepDATA.returnCode,vrepDATA.jointHandles(i)] = vrep.simxGetObjectHandle(vrepDATA.clientID,vrepDATA.stringJoint,vrep.simx_opmode_blocking);
    end
end
vrep.simxAddStatusbarMessage(vrepDATA.clientID,'Hello V-REP!',vrep.simx_opmode_oneshot);
