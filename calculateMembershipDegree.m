% ----------------------------------------------------------------------- %
%
%                       Calculate membership degree
%
% ----------------------------------------------------------------------- %
function [membershipDegree] = calculateMembershipDegree(instance,clusterCenters,nc,m)

    % Initialize the membership degree.
    membershipDegree = zeros(1,nc);
    
    % Calculate membership degree.
    for j=1:nc
        sum = 0;
        for w=1:nc
            exp = 2/(m-1);
            num = norm(instance - clusterCenters(j));
            den = norm(instance - clusterCenters(w));
            frac = (num^2/den^2)^(exp);
            sum = sum + frac;
        end
        membershipDegree(1,j) = (1/sum);
    end


end