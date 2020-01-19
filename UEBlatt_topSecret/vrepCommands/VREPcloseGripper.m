if (vrepDATA.clientID>-1)
    vrep.simxSetIntegerSignal(vrepDATA.clientID, 'BaxterGripper_close', 1, vrep.simx_opmode_oneshot);
    disp('V-REP close gripper');
end