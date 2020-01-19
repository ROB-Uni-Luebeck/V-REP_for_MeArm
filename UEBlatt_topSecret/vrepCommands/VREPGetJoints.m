% transfer angleparameter to V-REP
if (vrepDATA.clientID>-1)
    disp('V-REP get joints');
    for i = 1:1:7
        [returnCode q(i)] =  vrep.simxGetJointPosition(vrepDATA.clientID,vrepDATA.jointHandles(i),vrep.simx_opmode_blocking);
    end
end
