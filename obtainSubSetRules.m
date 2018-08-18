% ----------------------------------------------------------------------- %
%
%                         Obtain subset of rules
%
% ----------------------------------------------------------------------- %
function [subSetRules] = obtainSubSetRules(individual,ruleBase,sizeRule)

    % Obtain the subset of rules according to the individual.
    subSetRules = [];
    for i=1:size(individual,2)
        if individual(i) == 1
            rule = ruleBase(sizeRule*(i-1) + 1:sizeRule*(i));
            subSetRules = horzcat(subSetRules,rule);
        end
    end

end