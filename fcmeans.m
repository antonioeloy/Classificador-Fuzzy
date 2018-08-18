% ----------------------------------------------------------------------- %
%                                                                         %
%                   FC MEANS fuzzy clustering algorithm                   %
%                                                                         %
% ----------------------------------------------------------------------- %
% INPUT                                                                   %
%                                                                         %
% 1) data -> data set                                                     %
% 2) nc -> number of clusters                                             %
% 3) m ->  fuzzy partition matrix exponent                                %
% 4) e -> termination criterion between 0 and 1                           %
% ----------------------------------------------------------------------- %
% OUTPUT                                                                  %
%                                                                         %
% 1) U -> fuzzy partition matrix                                          %
% 2) clusterCenters -> final cluster centers                              %
% ----------------------------------------------------------------------- %
function [U,clusterCenters] = fcmeans(data,nc,m,e)

    % Obtain the number of samples (n).
    n = size(data,1);
    
    % Obtain the number of atributes (a).
    a = size(data,2);
    
    % Initialize membership matrix (U).
    U = zeros(n,nc);
    for i=1:n
        r = rand(1,nc);
        r = r/sum(r);
        U(i,:) = r;
    end
    
    while true
        
        % Calculate the cluster centers.
        clusterCenters = calculateClusterCenters(data,U,n,a,nc,m);
    
        % Update membership matrix (U).
        Unew = updateMembershipMatrix(data,clusterCenters,n,nc,m);
        
        % Verify if ||Unew - U|| improves by less than a specified minimum threshold
        % (e).
        if (norm(Unew - U)) < e
            break;
        else
            U = Unew;
        end
             
    end
    
end

