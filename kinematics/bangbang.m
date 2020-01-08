function [s,sd,sdd] = bangbang(q0, q1, t)

    t0 = t;
    if isscalar(t)
        t = (0:t-1)';
    else
        t = t(:);
    end

    tf = max(t(:));

    V = (q1-q0)/tf * 1.5;

    % already on target
    if q0 == q1
        s = ones(size(t)) * q0;
        sd = zeros(size(t));
        sdd = zeros(size(t));
        return
    end

    tb = t(ceil(length(t)/2)); % time intervals
    a = V/tb;

    p = zeros(length(t), 1);
    pd = p;
    pdd = p;
    
    for i = 1:length(t)
        tt = t(i);

        if tt <= tb
            % initial blend
            p(i) = q0 + a/2*tt^2;
            pd(i) = a*tt;
            pdd(i) = a;
        else
            % final blend
            p(i) = q1 - a/2*tf^2 + a*tf*tt - a/2*tt^2;
            pd(i) = a*tf - a*tt;
            pdd(i) = -a;
        end
    end

    switch nargout
        case 0
            if isscalar(t0)
                % for scalar time steps, axis is labeled 1 .. M
                xt = t+1;
            else
                % for vector time steps, axis is labeled by vector M
                xt = t;
            end

            clf
            subplot(311)
            % highlight the accel, coast, decel phases with different
            % colored markers
            hold on
            k = t<= tb;
            plot(xt(k), p(k), 'r-o');
            k = (t>=tb) & (t<= (tf-tb));
            plot(xt(k), p(k), 'b-o');
            k = t>= (tf-tb);
            plot(xt(k), p(k), 'g-o');
            grid; ylabel('s');
            hold off

            subplot(312)
            plot(xt, pd); grid; ylabel('sd');
            
            subplot(313)
            plot(xt, pdd); grid; ylabel('sdd');
            if ~isscalar(t0)
                xlabel('time')
            else
                for c=get(gcf, 'Children');
                    set(c, 'XLim', [1 t0]);
                end
            end
            shg
        case 1
            s = p;
        case 2
            s = p;
            sd = pd;
        case 3
            s = p;
            sd = pd;
            sdd = pdd;
    end
