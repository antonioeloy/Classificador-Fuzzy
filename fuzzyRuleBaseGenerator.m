
% ----------------------------------------------------------------------- %
%
%        Automatic Generation of Fuzzy Rules using Genetic Algorithm
%
% ----------------------------------------------------------------------- %


clear;


% ----------------------------------------------------------------------- %
%                           Loading Data Set
% ----------------------------------------------------------------------- %
dataSet = load ('datasets/iris.txt');


% ----------------------------------------------------------------------- %
%                      Define Fuzzy Database parameters
% ----------------------------------------------------------------------- %
nSetsAttr1 = 3;
nSetsAttr2 = 3;
nSetsAttr3 = 3;
nSetsAttr4 = 3;
nClasses = 3;
fuzzyDatabaseParameters = [nSetsAttr1 nSetsAttr2 nSetsAttr3 nSetsAttr4 nClasses];


% ----------------------------------------------------------------------- %
%                      Define GA 1 and GA 2 parameters
% ----------------------------------------------------------------------- %
nPop = 150;
nGer = 1000;
crossProb = 0.7;
mutProb = 0.015;


% ----------------------------------------------------------------------- %
%                      Define the number of executions
% ----------------------------------------------------------------------- %
N = 5;


% ----------------------------------------------------------------------- %
%                     Execute the algorithm 'N' times
% ----------------------------------------------------------------------- %
numberExecutions = 0;
bestFitnessTest = [];
bestRuleBase = [];

while numberExecutions < N

    
    % ----------------------------------------------------------------------- %
    %               Divide the Data Set (70% Training, 30% Test)
    % ----------------------------------------------------------------------- %
    pTraining = 0.70;
    pTest = 0.30;
    [trainingDataSet,testDataSet] = divideDataSet(dataSet,pTraining,pTest);

    
    % ----------------------------------------------------------------------- %
    %                  Define fuzzy sets using FCM (FC MEANS)
    % ----------------------------------------------------------------------- %
    m = 2;
    e = 0.001;
    clusterCenters = [];
    for i=1:size(fuzzyDatabaseParameters,2)
        if i ~= size(fuzzyDatabaseParameters,2)
            [UAttr,clusterCentersAttr] = fcmeans(trainingDataSet(:,i),fuzzyDatabaseParameters(i),m,e);
            clusterCenters = vertcat(clusterCenters,clusterCentersAttr');
        end
    end
    
    % ----------------------------------------------------------------------- %
    %                  Define initial number of fuzzy rules
    % ----------------------------------------------------------------------- %
    nRules = 100;
    

    % ----------------------------------------------------------------------- %
    %      Execute Genetic Algorithm 1 (GA 1) - Fuzzy Rule Base Generation
    % ----------------------------------------------------------------------- % 
    [bestIndividualGA1,fitnessBestIndividualGA1] = ga1(trainingDataSet,fuzzyDatabaseParameters,nRules,clusterCenters,m,nPop,nGer,crossProb,mutProb);
    
    
    % ----------------------------------------------------------------------- %
    %    Execute Genetic Algorithm 2 (GA 2) - Fuzzy Rule Base Optimization
    % ----------------------------------------------------------------------- % 
    [bestIndividualGA2,fitnessBestIndividualGA2] = ga2(trainingDataSet,bestIndividualGA1,nRules,clusterCenters,m,nPop,nGer,crossProb,mutProb);

    
    % ----------------------------------------------------------------------- %
    %                  Obtain the optimized fuzzy rule base
    % ----------------------------------------------------------------------- %
    optimizedFuzzyRuleBase = obtainSubSetRules(bestIndividualGA2,bestIndividualGA1,size(dataSet,2));
    bestRuleBase = vertcat(bestRuleBase,optimizedFuzzyRuleBase);
    
    
    % ----------------------------------------------------------------------- %
    %        Classify the Test Data using the Optimized Fuzzy Rule Base
    % ----------------------------------------------------------------------- % 
    nRulesOptimized = size(optimizedFuzzyRuleBase,2)/size(dataSet,2);
    fitnessTest = calculateFitness1(testDataSet,optimizedFuzzyRuleBase,nRulesOptimized,clusterCenters,m);
    bestFitnessTest = vertcat(bestFitnessTest,fitnessTest);
    
    
    % ----------------------------------------------------------------------- %
    %                    Increment the number of executions
    % ----------------------------------------------------------------------- % 
    numberExecutions = numberExecutions + 1;
    
    
end


% ----------------------------------------------------------------------- %
%                           Calculate accuracy
% ----------------------------------------------------------------------- % 
accuracyTest = mean(bestFitnessTest) / size(testDataSet,1);

