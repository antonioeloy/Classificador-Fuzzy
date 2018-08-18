% ----------------------------------------------------------------------- %
%
%            Divide the data set in Training and Test parts
%
% ----------------------------------------------------------------------- %
function [TrainingDataSet,TestDataSet] = divideDataSet(DataSet,TrainingPercentage,TestPercentage)

    % Obtain the number of instances (N).
    N = length(DataSet);

    % Initialize training and test data sets.
    TrainingDataSet = [];
    TestDataSet = [];
    
    % Obtain the number of training and test instances according to
    % training and test percentages.
    TrainingInstancesNumber = int8(TrainingPercentage*N);
    TestInstancesNumber = int8(TestPercentage*N);
    
    % Select instances that will become part of training data set.
    TrainingInstances = sort(randperm(N,TrainingInstancesNumber));
    for i=TrainingInstances
        TrainingDataSet = vertcat(TrainingDataSet,DataSet(i,:));
    end
    
    % Select instances that will become part of test data set.
    for i=1:N
        if(ismember(i,TrainingInstances)==0)
            TestDataSet = vertcat(TestDataSet,DataSet(i,:));
        end
    end
    
end