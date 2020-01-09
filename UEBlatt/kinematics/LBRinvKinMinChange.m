function [J,arm,elbow,flip] = LBRinvKinMinChange(M,J,delta,robot)

possible_configs = 2^3;
joints = size(J,2);

J_new = zeros(possible_configs,joints);
J_arm     = zeros(possible_configs,1);
J_elbow   = zeros(possible_configs,1);
J_flip    = zeros(possible_configs,1);

% calculate for each config posibility
i=1;
for arm = [-1,1]
    for elbow = [-1,1]
        for flip = [-1,1]
            
            J_arm(i) = arm;
            J_elbow(i) = elbow;
            J_flip(i) = flip;
            
            arg = [J_arm(i),J_elbow(i),J_flip(i),delta];
            try
                J_new(i,:) = LBRinvKin(M,arg,robot);
            catch
                % config is not valid dectemten to write 
                % at same position again
                i = i - 1;
            end
            
            i = i + 1 ;
        end
    end
end

% cut unused space
J_new = J_new(1:i-1,:);

% get the minimum change index
J_changes = sum((J_new - repmat(J,possible_configs,1)).^2,2);
[~,index] = min(J_changes);

% set return values
J = J_new(index,:);
arm = J_arm(index);
elbow = J_elbow(index);
flip = J_flip(index);
    
    