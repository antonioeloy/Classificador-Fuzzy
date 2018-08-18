% ----------------------------------------------------------------------- %
%
%                       Calculate cluster centers
%
% ----------------------------------------------------------------------- %
function [clusterCenters] = calculateClusterCenters(data,U,n,a,nc,m)

    % Initialize cluster centers.
    clusterCenters = zeros(nc,a);
    
    % Calculate cluster centers.
    for j=1:nc
        num = 0;
        den = 0;
        for i=1:n
            num = num + (U(i,j)^m)*data(i,:);
            den = den + (U(i,j)^m);
        end
        clusterCenters(j,:) = num/den;
    end

end

