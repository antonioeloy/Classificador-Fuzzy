% ----------------------------------------------------------------------- %
%
%                       Update membership matrix
%
% ----------------------------------------------------------------------- %
function [U] = updateMembershipMatrix(data,clusterCenters,n,nc,m)

    % Initialize membership matrix (U).
    U = zeros(n,nc);
    
    % Update membership matrix (U).
    for i=1:n
        for j=1:nc
            sum = 0;
            for w=1:nc
                exp = 2/(m-1);
                num = norm(data(i,:) - clusterCenters(j,:));
                den = norm(data(i,:) - clusterCenters(w,:));
                frac = (num^2/den^2)^(exp);
                sum = sum + frac;
            end
            U(i,j) = (1/sum);
        end
    end

end

