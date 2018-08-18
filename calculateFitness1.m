% ----------------------------------------------------------------------- %
%
%                 Calculate fitness of an individual - GA 1
%
% ----------------------------------------------------------------------- %
function [fitness] = calculateFitness1(data,individual,nRules,clusterCenters,m)
    
    % Obtain the number of database instances.
    nInstances = size(data,1);
    
    % Obtain the classes of database instances.
    classes = data(:,size(data,2));

    % Initialize the output of the individual.
    output = zeros(nInstances,1);
    
    % Calculate fitness of an individual.
    for i=1:nInstances
        output(i) = classicalFuzzyReasoning(data(i,:),nRules,individual,clusterCenters,m);
    end
    fitness = length(nonzeros(classes == output));
    
end