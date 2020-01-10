function R = getRotMat(v1,v2)

% x-vektor
x = v1-v2;
x = x/norm(x);

%überprüfe vektor
th = 0.00000001;
ind = find(abs(x)>th);



if length(ind)==3 %% normaler Fall, alles ok
    %u-vektor
    u = [x(3);0;0];
    u(2) = (-(x(1)*u(1))-(x(3)*u(3)))/x(2);
    u = u/norm(u);
    %v-Vektor
    v = cross(x,u);
    
    ct1 = cos(-pi/2);
    st1 = sin(-pi/2);
    ct2 = cos(pi);
    st2 = sin(pi);
    R = [x,u,v]*[ct1 0 st1;0 1 0;-st1 0 ct1]*[ct2 -st2 0;st2 ct2 0;0 0 1];
    
elseif length(ind)==2 %% Falls ein Wert Null, reagiere
    %unterscheide fälle
    if abs(x(1))<th
        %u-vektor
        u = [x(3);0;0];
        u(2) = (-(x(1)*u(1))-(x(3)*u(3)))/x(2);
        u = u/norm(u);
        %v-Vektor
        v = cross(x,u);
        ct1 = cos(-pi/2);
        st1 = sin(-pi/2);
        ct2 = cos(pi);
        st2 = sin(pi);
        R = [x,u,v]*[ct1 0 st1;0 1 0;-st1 0 ct1]*[ct2 -st2 0;st2 ct2 0;0 0 1];
    elseif abs(x(2))<th
        %u-vektor
        u = [0;abs(x(3));0];
        u(1) = (-(x(2)*u(2))-(x(3)*u(3)))/x(1);
        u = u/norm(u);
        %v-Vektor
        v = cross(x,u);
        ct1 = cos(-pi/2);
        st1 = sin(-pi/2);
        ct2 = cos(pi);
        st2 = sin(pi);
        R = [x,u,v]*[ct1 0 st1;0 1 0;-st1 0 ct1]*[ct2 -st2 0;st2 ct2 0;0 0 1];
    elseif abs(x(3))<th
        %u-vektor
        u = [0;0;x(2)];
        u(2) = (-(x(3)*u(3))-(x(2)*u(2)))/x(1);
        u = u/norm(u);
        %v-Vektor
        v = cross(x,u);
        ct1 = cos(-pi/2);
        st1 = sin(-pi/2);
        ct2 = cos(-pi/2);
        st2 = sin(-pi/2);
        R = [x,u,v]*[ct1 0 st1;0 1 0;-st1 0 ct1]*[ct2 -st2 0;st2 ct2 0;0 0 1];
    end
    
    
elseif length(ind)==1 %% falls nur ein wert > 0  spezialfälle
    if ind == 1
        gamma = pi;
        beta = pi/2;
        if x(1)<0
            beta = -pi/2;
        end
        ct1 = cos(beta);
        st1 = sin(beta);
        ct2 = cos(gamma);
        st2 = sin(gamma);
        R = [ct2 -st2 0;st2 ct2 0;0 0 1]*[ct1 0 st1;0 1 0;-st1 0 ct1];
    elseif ind == 2
        beta = pi/2;
        gamma = -pi/2;
        if x(2)<0
            gamma = pi/2;
        end
        ct1 = cos(beta);
        st1 = sin(beta);
        ct2 = cos(gamma);
        st2 = sin(gamma);
        R = [ct2 -st2 0;st2 ct2 0;0 0 1]*[ct1 0 st1;0 1 0;-st1 0 ct1];
    elseif ind == 3
        beta = pi;
        if x(3)<0
            beta = -pi/2;
        end
%         ct1 = cos(beta);
%         st1 = sin(beta);
%         R = [ct1 0 st1;0 1 0;-st1 0 ct1];
        ct2 = cos(pi);
        st2 = sin(pi);
        R = [ct2 -st2 0;st2 ct2 0;0 0 1];
    end
else
    % Fuck off state
    disp('fuck of state')
end