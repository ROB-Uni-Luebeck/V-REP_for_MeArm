function [J] = LBRinvKin(M,args,robot)

%% Setting up DH-Parameter: Which robot?
a = [0,0,0,0,0,0,0];
alp = [-90,90,-90,90,-90,90,0].*(pi/180);

if strcmp(robot,'LBR4+') % LBR 4+ 
    d = [310.4,0,400.1,0,390,0,78]; 
end
if strcmp(robot,'LBR5') % LBR 5 iiwa
    d = [340,0,400,0,400,0,111];
end

%Parameter
ARM = -args(1);
ELBOW = -args(2);
FLIP = -args(3);
if (ELBOW == -1)
    delta = args(4)+pi;
else
    delta = args(4);
end

%Erstellen von M06
R67 = DHjT(0,a(7),alp(7),d(7));
M06 = M*pinv(R67);

%Verdrehung der Ellipse um die z-Achse des BKS
phi = atan2(M06(2,4),M06(1,4));

%Berechnung der gew�nschten Ellenbogenposition in BKS-Koordinaten
Rsw = getRotMat([0;0;d(1)],rotz(-phi)*M06(1:3,4));
S = [Rsw,[0;0;d(1)];[0 0 0 1]];
W = [Rsw,rotz(-phi)*M06(1:3,4);[0 0 0 1]];
dsw = sqrt((W(1,4)-S(1,4))^2+(W(2,4)-S(2,4))^2+(W(3,4)-S(3,4))^2);
alpha = acos((d(5)^2-d(3)^2-dsw^2)/(-2*d(3)*dsw));
E0 = S*[eye(3),[sin(alpha)*d(3);0;cos(alpha)*d(3)];[0 0 0 1]];
Ed = S*[rotz(delta),[0;0;0];[0 0 0 1]]*pinv([Rsw,[0;0;0];[0 0 0 1]])*[eye(3),E0(1:3,4)-S(1:3,4);[0 0 0 1]];

% Joint 1
Ed_phi = rotz(phi)*Ed(1:3,4);
J(1) = atan2(ARM*Ed_phi(2),ARM*Ed_phi(1));
M01 = DHjT(J(1),a(1),alp(1),d(1));
% Joint 2
J(2) = atan2(ARM*sqrt((Ed(1,4))^2+(Ed(2,4))^2),Ed(3,4)-S(3,4));
% Joint 4
J(4) = ARM*ELBOW*(pi-acos((dsw^2-d(5)^2-d(3)^2)/(-2*d(5)*d(3))));

%% Singularit�t vorhanden?
if (d(3)+d(5))-dsw < 1E-10
    % Joint 3
    J(3) = delta;
else
    %% Keine Singularit�t
    % Joint 3
    M16 = pinv(M01)*M06;
    s3 = M16(3,4)/(sin(J(4))*d(5));
    
    %Floating point Fehler von Matlab
    if 1-abs(s3) < 1E-10 
        c3 = 0;
    else
        c3 = sqrt(1-s3^2);
    end
    %Parametrisierung der Ellipse
    E90 = S*[rotz(pi/2),[0;0;0];[0 0 0 1]]*pinv([Rsw,[0;0;0];[0 0 0 1]])*[eye(3),E0(1:3,4)-S(1:3,4);[0 0 0 1]];
    a_ell = E90(2,4);
    b_ell = E0(1,4)-E90(1,4);
    
    if abs(b_ell)< 1E-10 % Spezialfall: Schulter und Handgelenk auf einer H�he -> Ellipse wird zur Linie
        J(3) = atan2(s3,ELBOW*((Ed(3,4)-S(3,4))/abs(Ed(3,4)-S(3,4)))*c3);
    else
        if abs((-W(1,4)/2)) > abs(b_ell) %normaler Fall: Schulter au�erhalb Ellipse  %NOTE: corrected from orig: (-W(1,4)/2) < b
            x1 = -a_ell*sqrt(-b_ell^2+(-W(1,4)/2)^2)/(-W(1,4)/2); % x0=0 gek�rzt
            if abs(Ed(2,4))>abs(x1) || abs(Ed(1,4))>abs(-W(1,4)/2) % Tangentenschnittpunkt �berschrittten?
                J(3) = atan2(s3,ELBOW*(b_ell/abs(b_ell))*c3);
            else
                J(3) = atan2(s3,-ELBOW*(b_ell/abs(b_ell))*c3); 
            end
        else %Schulter liegt innerhalb oder auf Ellipse -> keine Tangente m�glich
            J(3) = atan2(s3,ELBOW*(b_ell/abs(b_ell))*c3);
        end
    end
end

%% Joint 5, 6 und 7
M12 = DHjT(J(2),a(2),alp(2),d(2));
M23 = DHjT(J(3),a(3),alp(3),d(3));
M34 = DHjT(J(4),a(4),alp(4),d(4));
M04 = M01*M12*M23*M34;
M47 = pinv(M04)*M;

th = 1E-10;
if abs(abs(M47(3,3))-1) <  th
    J(6) = 0;
else
    J(6) = atan2(FLIP*sqrt(1-M47(3,3)^2),M47(3,3));
end

if abs(M47(2,3)) < th && abs(M47(1,3)) < th
    J(5) = 0;
else
    J(5) = atan2(FLIP*M47(2,3),FLIP*M47(1,3));
end

if abs(M47(3,2)) < th && abs(M47(3,1)) <th
    J(7) = 0;
else
    J(7) = atan2(FLIP*M47(3,2),FLIP*-M47(3,1));
end

%% From rad to deg
J = J.*(180/pi);
