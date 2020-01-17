vrep.simxSetIntegerSignal(vrepDATA.clientID, 'BaxterGripper_close', 1, vrep.simx_opmode_oneshot);
%vrep.simxSetObjectParent(vrepDATA.cuboid, vrepDATA.gripper, false, false, vrep.simx_opmode_oneshot);