function q = LBRnuminvKin_codeSnippet(M, q_start, robot)
%q_start in rad pls

% Berechnung der homogenen Matrizen für die Start- und Zielstellung
A_start = LBRforKin(q_start,robot);
A_ziel = M;

% Initialisierung der Inkrementellen Rückwärtsrechnung
q = q_start;
A = A_start;

% maximale Abweichung in den Einträgen der initialen Stellungsmatrix von der
% Zielstellung
Delta_pose = max(abs(A_ziel(:)-A(:)));

i=0;
while Delta_pose > 0.01
    %% LSG
%     i=i+1;
%     J = jacobianKuka(q(1),q(2),q(3),q(4),q(5),q(6),q(7));
%     A_diff = A_ziel-A;
%     % Extraktion der nichttrivialen Einträge in der Differenz der
%     % Stellungsmatrizen
%     A_diff = A_diff(1:3, :);
%     % Umsortieren der Abweichung von der Stellungsmatrix zu einem
%     % Spaltenvektor
%     A_diff = A_diff(:);
%     % Lösen des überbestimmten Gleichungssystems zur Bestimmung der
%     % Änderung in den Gelenkwinkeln
%     dq = J \ A_diff;
    
    %% CODESNIPPET
    % TODO: implementieren sie die inkrementelle inverse Kinematik. Lassen
    % sie sich von Aufgabenblatt 7 Inspirieren.
    
    %%
    % Berechnung der neuen Gelenkwinkel
    q = wrapToPi(q + dq);
    
    % Bestimmung der maximalen Abweichung in der Pose-Matrix von der
    % Zielstellung
    A =  LBRforKin(q,robot);
    Delta_pose = abs(max(A_ziel(:)-A(:)));
    if sum(abs(dq)) < 0.0000001 && Delta_pose > 0.01
        q = rand(7,1)*2*pi - pi;
    end
end
end

