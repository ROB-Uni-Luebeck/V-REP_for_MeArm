function R = RodRotForM(k,theta)
% RodRotFor -> Rodrigues' rotation formula
% M -> Matrix
% k is a unit vector describing an axis of rotation

%{
if abs(norm(k,2) - 1) > 10^-6
    disp('axis of rotation k is hardly an unit vector')
end
%}
K = [0,-k(3),k(2);k(3),0,-k(1);-k(2),k(1),0];
R = eye(3) + sin(theta)*K + (1 - cos(theta))*K^2;
end