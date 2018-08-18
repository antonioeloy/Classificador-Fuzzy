% ----------------------------------------------------------------------- %
%
%                   Generate initial individual - GA 2
%
% ----------------------------------------------------------------------- %
function [individual] = generateIndividual2(nRules)

    % Initialize the individual.
    individual = ones(1,nRules);
    
    % Generate the individual ramdonly with '0s' and '1s'.
    n = randi(nRules-1);
    indexes = randperm(nRules,n);
    individual(1,indexes) = 0;

end

