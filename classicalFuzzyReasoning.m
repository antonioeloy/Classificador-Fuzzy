% ----------------------------------------------------------------------- %
%
%                         Classical Fuzzy Reasoning
%
% ----------------------------------------------------------------------- %
function [output] = classicalFuzzyReasoning(instance,nRules,individual,clusterCenters,m)
    
    % Initialize the compatibilities array.
    compatibilities = zeros(1,nRules);

    % Find the rule with highest compatibility with the instance.
    sizeRule = size(individual,2)/nRules;
    for i=1:nRules
        rule = individual(1+(i-1)*sizeRule:i*sizeRule);
        compatibilities(i) = calculateCompatibilityDegree(rule,instance,clusterCenters,m);
    end
    [~,ind] = max(compatibilities);
    ruleHighestCompatibility = individual(1+(ind-1)*sizeRule:ind*sizeRule);
    
    % Get the output of the rule.
    output = ruleHighestCompatibility(sizeRule);

end