% ----------------------------------------------------------------------- %
%
%                         Standard Mutation - GA 1
%
% ----------------------------------------------------------------------- %
function [newPopulation] = standardMutation1(population,mutProb,nRules,fuzzyDatabaseParameters)

    % Obtain the number of individuals.
    nInd = size(population,1);
    
    % Obtain the size of the individual.
    indSize = size(population,2);
    
    % Obtain the size of the rule.
    sizeRule = indSize/nRules;

    % Initialize the new population.
    newPopulation = zeros(size(population,1),size(population,2));
    
    % Apply elitism.
    newPopulation(1,:) = population(1,:);
    
    % Generate the new population applying standard mutation.
    for i=2:nInd
        for j=1:sizeRule:indSize
            rule = population(i,j:j+sizeRule-1);
            for w=1:size(rule,2)
                if rand <= mutProb
                    if w == size(rule,2)
                        newValue = randi(fuzzyDatabaseParameters(w)); % Class
                        while rule(w) == newValue
                            newValue = randi(fuzzyDatabaseParameters(w)); % Class
                        end
                        rule(w) = newValue;
                    else
                        newValue = randi(fuzzyDatabaseParameters(w)+1) - 1; % Attribute (including don't care)
                        while rule(w) == newValue
                            newValue = randi(fuzzyDatabaseParameters(w)+1) - 1; % Attribute (including don't care)
                        end
                        rule(w) = newValue;
                    end
                end
            end
            newPopulation(i,j:j+sizeRule-1) = rule;
        end
    end

end