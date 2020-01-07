% Add path for the API scripts
addpath('../API')

%%
vrep=remApi('remoteApi');      % Creates remote API object which is called vrep
vrep.simxFinish(-1);           % Closes any currently open connections
 
clientID = vrep.simxStart('127.0.0.1',19999,true,true,5000,5);   % Creates a connection
 
if (clientID>-1)
    disp('Connected')
    
    % Define number of joints
    n_joints = 7;
    
    % Get object handles
    jointHandles = zeros(n_joints,1);
    for i=1:1:n_joints
        stringJoint = sprintf('LBR_iiwa_7_R800_joint%i',i);
        [returnCode,jointHandles(i)] = vrep.simxGetObjectHandle(clientID,stringJoint,vrep.simx_opmode_blocking);
        if returnCode < 0
            error('Can not find all joint handles!');
        end
    end
    [~,endEffector] = vrep.simxGetObjectHandle(clientID,'BaxterGripper',vrep.simx_opmode_blocking);
    
    % Get joint positions
    jointPositions = zeros(n_joints,3);
    for i=1:1:n_joints
        [returnCode,jointPositions(i,:)] = vrep.simxGetObjectPosition(clientID,jointHandles(i),-1,vrep.simx_opmode_blocking);
        if returnCode < 0
            error('Can not find all joint positions!');
        end
    end
    [returnCode,endEffectorPosition] = vrep.simxGetObjectPosition(clientID,endEffector,-1,vrep.simx_opmode_blocking);
    
    % Get Initial Euler angles
    jointEulerAngles = zeros(n_joints,3);
    for i=1:1:n_joints
        [returnCode,jointEulerAngles(i,:)] = vrep.simxGetObjectOrientation(clientID,jointHandles(i),-1,vrep.simx_opmode_blocking);
        if returnCode < 0
            error('Can not find all joint Euler Angles!');
        end
    end
    
    % Calculate axis of rotations for the joints
    jointAxisOfRotation = zeros(n_joints,3);
    for i=1:1:n_joints
        jointAxisOfRotation(i,:) = vrepEulerRotation(jointEulerAngles(i,:))*[0; 0; 1];
    end
    
    % Calculate length vector
    jointLengthVector = zeros(n_joints,3);
    for i=2:1:n_joints
        jointLengthVector(i-1,:) = jointPositions(i,:) - jointPositions(i-1,:);
    end
    jointLengthVector(end,:) = endEffectorPosition - jointPositions(end,:);
    
    % Save data
    axisOfRotationMy = jointAxisOfRotation;
    lengthVectorsMy = jointLengthVector;
    originJoint1My = jointPositions(1,:);
    save('KUKA_LBR_iiwa_7_R800My','axisOfRotationMy','lengthVectorsMy','originJoint1My');
    disp('done');

    vrep.simxFinish(-1); 
end
%vrep.delete();