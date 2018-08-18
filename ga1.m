% ----------------------------------------------------------------------- %
%
%            GA 1 - Genetic Algorithm 1 - Generate Fuzzy Rule Base
%
% ----------------------------------------------------------------------- %
function [bestIndividual,fitnessBestIndividual] = ga1(data,fuzzyDatabaseParameters,nRules,clusterCenters,m,nPop,nGer,crossProb,mutProb)
 
    % Define self-adapting parameters.
    Vmax = 0.8;
    Vmin = 0.3;
    Csup = 0.9;
    Cinf = 0.1;
    Msup = 0.25;
    Minf = 0.01;
    v = 1.3;

    % Initialize the generation number.
    generation = 0;

    % Define the initial population.
    population = zeros(nPop,nRules*size(data,2));
    for i=1:nPop
        population(i,:) = generateIndividual1(data,fuzzyDatabaseParameters,clusterCenters,m,nRules);
    end
    
    % Calcute fitness of each individual of the initial population.
    fitness = zeros(nPop,1);
    for i=1:nPop
        fitness(i,:) = calculateFitness1(data,population(i,:),nRules,clusterCenters,m);
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
        
        % Calculate genetic diversity (dg).
        if generation <= nGer/2
            if mod(generation,5) == 0
                dg = mean(fitness)/fitnessBestIndividual;
                % Dynamic change of parameters values.
                if dg >= Vmax
                    mutProb = min(mutProb*v,Msup);
                    crossProb = max(crossProb/v,Cinf);
                elseif dg <= Vmin
                    mutProb = max(mutProb/v,Minf);
                    crossProb = min(crossProb*v,Csup);
                end
            end
        end
        
        % Selection.
        population = stochasticUniversalSampling(population,fitness);

        % Crossover.
        population = onePointCrossover(population,crossProb);
        
        % Mutation.
        population = standardMutation1(population,mutProb,nRules,fuzzyDatabaseParameters);

        % Calcute fitness of each individual of current generation.
        for i=1:nPop
            fitness(i,:) = calculateFitness1(data,population(i,:),nRules,clusterCenters,m);
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
