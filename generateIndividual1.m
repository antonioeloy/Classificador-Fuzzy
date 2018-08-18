% ----------------------------------------------------------------------- %
%
%                 Generate initial individual (optmized)
%
% ----------------------------------------------------------------------- %
function [individual] = generateIndividual1(data,fuzzyDatabaseParameters,clusterCenters,m,nRules)

    % Obtain the total number of examples.
    n = size(data,1);
    
    % Obtain the size of the rule.
    sizeRule = size(data,2);
    
    % Obtain the number of clusters.
    nc = size(clusterCenters(1,:),2);
    
    % Define parameters of GA 1 initial population optimized generation.
    pt = 0.7;
    pdc = 0.015;
    
    % Select ramdonly 't' examples from data according to 'pt'.
    t = min(int64(pt*n),nRules);
    indexExamples = sort(randperm(n,t));
    examples = data(indexExamples,:);
    
    % For each selected example. build 1 fuzzy rule with highest
    % compatibility with the example, obtaining 't' fuzzy rules.
    individual = [];
    for i=1:t
        example = examples(i,:);
        rule = zeros(1,sizeRule);
        for j=1:(sizeRule-1)
            membershipDegree = calculateMembershipDegree(example(j),clusterCenters(j,:),nc,m);
            [~,rule(j)] = max(membershipDegree); % Attribute
            % According to a pre specified probability 'pdc', substitute the antecedents
            % of the rule by 'dont care'.
            if rand <= pdc
                rule(j) = 0;
            end
        end
        rule(sizeRule) = example(sizeRule);
        individual = horzcat(individual,rule);
    end
    
    % Obtain the other 'nRules - t' fuzzy rules.
    for i=(t+1):nRules
        rule = zeros(1,size(fuzzyDatabaseParameters,2));
        for j=1:size(rule,2)
            if j == size(rule,2)             
                rule(j) = randi(fuzzyDatabaseParameters(j));
            else
                rule(j) = randi(fuzzyDatabaseParameters(j)+1) - 1;
            end
        end
        individual = horzcat(individual,rule);
    end

end