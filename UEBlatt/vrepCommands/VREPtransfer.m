% transfer angleparameter to V-REP
if (vrepDATA.clientID>-1)
    disp('V-REP transfer');
    for i = 1:1:7
        vrep.simxSetJointTargetPosition(vrepDATA.clientID,vrepDATA.jointHandles(i),q(i),vrep.simx_opmode_blocking);
    end
end