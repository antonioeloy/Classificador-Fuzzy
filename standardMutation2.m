% ----------------------------------------------------------------------- %
%
%                         Standard Mutation - GA 2
%
% ----------------------------------------------------------------------- %
function [newPopulation] = standardMutation2(population,mutProb)

    % Obtain the number of individuals.
    nInd = size(population,1);
    
    % Obtain the size of individuals.
    indSize = size(population,2);

    % Initialize the new population.
    newPopulation = zeros(nInd,indSize);
    
    % Apply elitism.
    newPopulation(1,:) = population(1,:);
    
    % Generate the new population applying standard mutation.
    for i=2:nInd
        for j=1:indSize
            if rand <= mutProb
                if population(i,j) == 0
                    newPopulation(i,j) = 1;
                elseif population(i,j) == 1
                        if length(nonzeros(population(i,:))) > 1
                            newPopulation(i,j) = 0;
                        end
                end
            else
                newPopulation(i,j) = population(i,j);
            end
        end
    end

end