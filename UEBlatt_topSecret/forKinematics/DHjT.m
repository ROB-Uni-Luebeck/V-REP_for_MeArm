% Calculation of joint transformation matrix DH-convention
function [ T ] = DHjT( teta, a, alpha, d )
%% LSG
% T = [cos(teta), -sin(teta)*cos(alpha), sin(teta)*sin(alpha), a*cos(teta); ...
%         sin(teta), cos(teta)*cos(alpha), -cos(teta)*sin(alpha), a*sin(teta) ; ...
%         0           , sin(alpha)             , cos(alpha)              , d              ; ...
%         0           , 0                       , 0                        , 1                 ];

%% CODESNIPPET
% TODO: erstelle die homogene Transformationsmatrix T aus den DH-Parametern
T = [1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
end

