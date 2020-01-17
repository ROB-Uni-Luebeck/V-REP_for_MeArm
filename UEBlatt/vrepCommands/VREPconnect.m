% connect to V-REP (get clientID and jointHandles)
addpath('../API');
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
vrepDATA.clientID = vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (vrepDATA.clientID>-1)
    disp('V-REP connect');
    for i = 1:1:7
        vrepDATA.stringJoint = sprintf('LBR_iiwa_7_R800_joint%i',i);
        [vrepDATA.returnCode,vrepDATA.jointHandles(i)] = vrep.simxGetObjectHandle(vrepDATA.clientID,vrepDATA.stringJoint,vrep.simx_opmode_blocking);
    end
    % add gripper + cuboid
    [vrepDATA.returnCode,vrepDATA.gripper] = vrep.simxGetObjectHandle(vrepDATA.clientID,'BaxterGripper',vrep.simx_opmode_blocking);
    [vrepDATA.returnCode,vrepDATA.cuboid] = vrep.simxGetObjectHandle(vrepDATA.clientID,'Cuboid',vrep.simx_opmode_blocking);
end