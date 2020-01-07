function endEffectorPos = fwKinHRM(q,iiwaDATA)
% fwKinHRM calculates the forward kinematics of the
% KUKA LBR_iiwa_7_R800

% HRM -> homogene-rotations-matrix

% q -> jointAngeles
% iiwaDATA.axisOfRot -> axes of Rotation in starting/initial position
% iiwaDATA.lengthV -> vectors between successive joints
% iiwaDATA.originJoint1 -> vector between origin/base and first joint

H = eye(4);
H_Rot = eye(4);
H_Rot(1:3,1:3) = RodRotForM(iiwaDATA.axisOfRot(:,1), q(1));
H_Rot(1:3,4) = iiwaDATA.originJoint1;

for i = 2:1:7
    H(1:3,1:3) = RodRotForM(iiwaDATA.axisOfRot(:,i), q(i));
    H(1:3,4) = iiwaDATA.lengthV(:,i-1);
    H_Rot = H_Rot * H;
end

H = eye(4);
H(1:3,4) = iiwaDATA.lengthV(:,7);
H_Rot = H_Rot * H;

endEffectorPos = H_Rot(1:3,4);
end