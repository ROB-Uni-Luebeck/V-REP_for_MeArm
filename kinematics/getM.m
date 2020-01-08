function [ M ] = getM( x , y, z , tx, ty, tz)


    Rx = [ 1 0 0 ; 0 cos(x) -sin(x) ; 0 sin(x) cos(x) ];
    Ry = [ cos(y) 0 sin(y) ; 0 1 0 ; -sin(y) 0 cos(x)];
    Rz = [ cos(z) -sin(z) 0 ; sin(z) cos(z) 0 ; 0 0 1 ];
    
    R = Rz*Ry*Rx;
    T = [tx;ty;tz];
    
    M = [R, T; 0,0,0,1];

end

