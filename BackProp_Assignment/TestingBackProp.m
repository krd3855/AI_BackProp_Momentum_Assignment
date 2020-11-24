%% Author : Krishna Satish D S

function TestingBackProp()
%% Loading The Weights
load('Weights.mat');    %% Loading Weights
%% Training Dataset
Out_Classes = ["Class1","Class2","Class3"];
Test_DataSet = [Class_1_Data' Class_2_Data' Class_3_Data']';
count = 0;
%% Testing 
for i=1:length(Test_DataSet)
    temp = Test_DataSet(i,2:end);
    Test_Hidden_In = temp*Weight_Input_Hidden;
    Test_Out = sigmoid(Test_Hidden_In+Weight_Bias_Hidden');
    Out_Sigmoid_Input = Test_Out * Weight_Hidden;
    Out = sigmoid(Out_Sigmoid_Input+ Weight_Bias_Output');
    [~,Idx] = max(Out);
    if (Test_DataSet(i,1) == 1)
        if (strcmp(Out_Classes(Idx),"Class1"))
            %disp('Correcly classified class 1');
        else
            count = count + 1;
        end
    elseif (Test_DataSet(i,1) == 2)
        if (strcmp(Out_Classes(Idx),"Class2"))
            %disp('Correcly classified  class 2');
        else
            count = count + 1;
        end
    else
        if (strcmp(Out_Classes(Idx),"Class3"))
            %disp('Correcly classified  class 3');
        else
            count = count + 1;
        end
      
    end
 
end
    X = sprintf('Number of misclassified data is: %d',count);
    disp(X);  
end

