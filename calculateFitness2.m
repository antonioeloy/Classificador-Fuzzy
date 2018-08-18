% ----------------------------------------------------------------------- %
%
%                 Calculate fitness of an individual - GA 2
%
% ----------------------------------------------------------------------- %
function [fitness] = calculateFitness2(data,individual,ruleBase,nRules,clusterCenters,m)
    
    % Obtain the number of database instances.
    nInstances = size(data,1);
    
    % Obtain the classes of database instances.
    classes = data(:,size(data,2));
    
    % Obtain the size of the rule.
    sizeRule = size(ruleBase,2)/nRules;
    
    % Obtain the subset of rules according to the individual.
    subSetRules = obtainSubSetRules(individual,ruleBase,sizeRule);
  
    % Obtain the number of rules of the optimized fuzzy rule base.
    nRulesOptimized = size(subSetRules,2)/sizeRule;

    % Initialize the output of the individual.
    output = zeros(nInstances,1);
    
    % Classify the data using the subset of rules.
    for i=1:nInstances
        output(i) = classicalFuzzyReasoning(data(i,:),nRulesOptimized,subSetRules,clusterCenters,m);
    end
    
    % Calculate fitness of the individual.
    nec = length(nonzeros(classes == output));
    s = nRules;
    qtdr = nRulesOptimized;
    fitness = nec*(s-qtdr);
    
end