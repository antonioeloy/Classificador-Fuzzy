% ----------------------------------------------------------------------- %
%
%            GA 2 - Genetic Algorithm 2 - Optimize Fuzzy Rule Base
%
% ----------------------------------------------------------------------- %
function [bestIndividual,fitnessBestIndividual] = ga2(data,ruleBase,nRules,clusterCenters,m,nPop,nGer,crossProb,mutProb)
 
    % Initialize the generation number.
    generation = 0;

    % Define the initial population.
    population = zeros(nPop,nRules);
    for i=1:nPop
        if i == 1
            population(i,:) = ones(1,nRules);
        else
            population(i,:) = generateIndividual2(nRules);
        end
    end

    % Calcute fitness of each individual of the initial population.
    fitness = zeros(nPop,1);
    for i=1:nPop
        fitness(i,:) = calculateFitness2(data,population(i,:),ruleBase,nRules,clusterCenters,m);
    end
    
    % Find the best individual of the initial population.
    [fitness,index] = sort(fitness,'descend');
    population = population(index,:);
    bestIndividual = population(1,:);
    fitnessBestIndividual = fitness(1)
    
    % Repeat while the total number of generations is not reached.
    while (generation < nGer)
        
        % Update the generation number.
        generation = generation + 1;
        
        % Selection.
        population = stochasticUniversalSampling(population,fitness);

        % Crossover.
        population = onePointCrossover(population,crossProb);

        % Mutation.
        population = standardMutation2(population,mutProb);

        % Calcute fitness of each individual of current generation.
        for i=1:nPop
            fitness(i,:) = calculateFitness2(data,population(i,:),ruleBase,nRules,clusterCenters,m);
        end
        
        % Find the best individual of current generation.
        [fitness,index] = sort(fitness,'descend');
        population = population(index,:);
        bestGenerationIndividual = population(1,:);
        fitnessGenerationBestIndividual = fitness(1)
   
        % Update the best individual (solution).
        if (fitnessGenerationBestIndividual > fitnessBestIndividual)
            bestIndividual = bestGenerationIndividual;
            fitnessBestIndividual = fitnessGenerationBestIndividual;
        end  
        
    end
    
end
