% ----------------------------------------------------------------------- %
%
%                           One Point Crossover
%
% ----------------------------------------------------------------------- %
function [newPopulation] = onePointCrossover(population,crossProb)

    % Obtain the number of individuals.
    nInd = size(population,1);
    
    % Obtain the size of the individual.
    indSize = size(population,2);
    
    % Initialize the new population.
    newPopulation = zeros(size(population,1),size(population,2));
    
    % Apply elitism.
    newPopulation(1,:) = population(1,:);
    
    % Generate the new population applying one point crossover.
    for i=2:2:nInd-2
        if rand <= crossProb
            crossPoint = randi(indSize-1); % Obtain the crossover point.
            pai1 = population(i,1:crossPoint);
            pai2 = population(i,crossPoint+1:indSize);
            mae1 = population(i+1,1:crossPoint);
            mae2 = population(i+1,crossPoint+1:indSize);
            if size(nonzeros(horzcat(pai1,mae2)),1) > 0 && size(nonzeros(horzcat(mae1,pai2)),1) > 0
                newPopulation(i,:) = horzcat(pai1,mae2);
                newPopulation(i+1,:) = horzcat(mae1,pai2);
            else
                newPopulation(i,:) = population(i,:);
                newPopulation(i+1,:) = population(i+1,:);
            end
        else
            newPopulation(i,:) = population(i,:);
            newPopulation(i+1,:) = population(i+1,:);
        end
    end
    
    % Complete the new population.
    if mod(nInd,2) == 0
        newPopulation(nInd,:) = population(nInd,:);
    else
        newPopulation(nInd-1,:) = population(nInd-1,:);
        newPopulation(nInd,:) = population(nInd,:);
    end

end