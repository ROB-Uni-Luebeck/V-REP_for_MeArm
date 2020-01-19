if (vrepDATA.clientID>-1)
    vrep.simxSetIntegerSignal(vrepDATA.clientID, 'BaxterGripper_close', 0, vrep.simx_opmode_oneshot);
    disp('V-REP open gripper');
end