% ----------------------------------------------------------------------- %
%
%                     Calculate compatibility degree
%
% ----------------------------------------------------------------------- %
function [compatibilityDegree] = calculateCompatibilityDegree(rule,instance,clusterCenters,m)

    % Initialize compatibility degree.
    compatibilityDegree = 1;
    
    % Calculate compatibility degree.
    for i=1:(size(rule,2)-1)
        set = rule(i);
        if set ~= 0
            nc = size(clusterCenters(i,:),2);
            degreeMembership = calculateMembershipDegree(instance(i),clusterCenters(i,:),nc,m);
            compatibilityDegree = compatibilityDegree * degreeMembership(set);
        end

    end

end