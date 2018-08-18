% ----------------------------------------------------------------------- %
%
%                      Stochastic Universal Sampling
%
% ----------------------------------------------------------------------- %
function [newPopulation] = stochasticUniversalSampling(population,fitness)

    % Obtain cumulative fitness.
    normalizedFitness = fitness/sum(fitness);
    cumulativeFitness = cumsum(normalizedFitness);
    
    % Initialize the new population.
    newPopulation = zeros(size(population,1),size(population,2));
    
    % Apply elitism.
    newPopulation(1,:) = population(1,:);
    
    % Complete the new population.
    ind = 0:1:size(population,1)-2;
    ind = ind/(size(population,1)-1);
    for i=1:size(ind,2)
        for j=1:size(cumulativeFitness,1)
            if ind(i) <= cumulativeFitness(j)
                newPopulation(i+1,:) = population(j,:);
                break;
            end
        end
    end
    
end