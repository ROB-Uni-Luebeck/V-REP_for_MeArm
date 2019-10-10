function VREPtransfer (q)
global vrep;
global vrepDATA;
global numberOfJoints;
% transfer angleparameter to V-REP
% q: Gelenkparameter
if (vrepDATA.clientID>-1)
    disp('V-REP transfer');
    for i = 1:1:numberOfJoints
        vrep.simxSetJointTargetPosition(vrepDATA.clientID,vrepDATA.jointHandles(i),q(i),vrep.simx_opmode_blocking);
        vrep.simxAddStatusbarMessage(vrepDATA.clientID,['joint' num2str(i) ' set to ' num2str(q(i))],vrep.simx_opmode_oneshot);
    end
end
end