%% Author : Krishna Satish D S

function BackPropAlgorithm()
    %% Desired Outputs
    class_1 = [1 0 0]';
    class_2 = [0 1 0]';
    class_3 = [0 0 1]';
    %% Read and Normalizing Data
    data = load('WineDataSet.txt');
    class             =       data(:,1);
    Alcohol           =       Normalization(data(:,2));
    M_acid            =       Normalization(data(:,3));
    Ash               =       Normalization(data(:,4));
    Alcalinity_ash    =       Normalization(data(:,5));
    Magnesium         =       Normalization(data(:,6));
    T_phenols         =       Normalization(data(:,7));
    Flavanoids        =       Normalization(data(:,8));
    NF_phenols        =       Normalization(data(:,9));
    Proanthocyanins   =       Normalization(data(:,10));
    Color_intensity   =       Normalization(data(:,11));
    Hue               =       Normalization(data(:,12));
    Diluted_wines     =       Normalization(data(:,13));
    Proline           =       Normalization(data(:,14));
    n_data            =       [class Alcohol M_acid Ash Alcalinity_ash Magnesium T_phenols ...
                               Flavanoids NF_phenols Proanthocyanins Color_intensity Hue Diluted_wines Proline];
    %% Network parameters
    Number_Input = 13;
    Number_Of_Hidden_Nodes = 4;
    Number_Of_Outputs = 3;
    Learning_Rate = 0.7;
    Iteration=100;
    Alpha = 0.8;
    Weight_Input_Hidden =         rand(Number_Input,Number_Of_Hidden_Nodes);
    Prev_Weight_Input_Hidden =    Weight_Input_Hidden;
    Weight_Bias_Hidden =          rand(Number_Of_Hidden_Nodes,1);
    Prev_Weight_Bias_Hidden =     Weight_Bias_Hidden;
    Weight_Bias_Output =          rand(Number_Of_Outputs,1);
    Prev_Weight_Bias_Output =     Weight_Bias_Output;
    Weight_Hidden =               rand(Number_Of_Hidden_Nodes,Number_Of_Outputs);
    Prev_Weight_Hidden =          Weight_Hidden;
    error=                        zeros(Number_Of_Outputs,Iteration);
    %% Delta for Momentum Calculations
    Delta_Prev_Weight_Hidden =    (zeros(Number_Of_Hidden_Nodes,1));
    Delta_Prev_Weight_Input_Hidden = (zeros(Number_Input,Number_Of_Hidden_Nodes));
    Delta_Prev_Weight_Bias_Output  = (zeros(Number_Of_Outputs,1));
    Delta_Prev_Weight_Bias_Hidden  = zeros(Number_Of_Hidden_Nodes,1);
    %% Shuffling Training Data 
    [Shuffled_Data,Class_1_Data,Class_2_Data,Class_3_Data] = Shuffle_data(n_data);
    %% OutPut Value Prep
    Desired_out_temp = [class_1 class_2 class_3];
    Desired_out=repmat(Desired_out_temp,[1 45]);
    %% Training 
    h = waitbar(0,'Training...');
    for iterator_i = 1:Iteration
        for iterator_j = 1:size(Shuffled_Data,2)
            Input_Layer_Weight = Shuffled_Data(2:end,iterator_j)'*Weight_Input_Hidden;  %% Wx --> Input layer to first hidden layer
            Input_Layer_Weight_Bias = Input_Layer_Weight + Weight_Bias_Hidden';  %% Wx + b
            Hidden_Layer_Input = sigmoid(Input_Layer_Weight_Bias);   %% Sigmoid Activation Function
            Hidden_Layer_temp = (Hidden_Layer_Input *  Weight_Hidden) + Weight_Bias_Output';  %% Hidden Layer Inputs multiplied with Hidden Layer Weights
            Final_Output = sigmoid(Hidden_Layer_temp);
            %% Finding Error
            Err = Desired_out(:,iterator_j)'-Final_Output;   %% Difference b/w output and labelled output
            Delta = (Final_Output.*(1-Final_Output)).* Err;   %% Finding out the Partial derivative 
            %% Updading Weights
            Weight_Hidden=Weight_Hidden+(Learning_Rate*Hidden_Layer_Input'*Delta) + (Alpha.*Delta_Prev_Weight_Hidden);  %% Updating Hidden Layer Weights
            Weight_Bias_Output = Weight_Bias_Output + (2*Delta') + (Alpha*(Delta_Prev_Weight_Bias_Output));                 %% Updading Biases
            %% Updating Input Layer Weights
            Delta_Hidden = Hidden_Layer_Input'.*(1-Hidden_Layer_Input)'.*(Weight_Hidden*Delta');
            Weight_Input_Hidden=Weight_Input_Hidden+Learning_Rate*(Shuffled_Data(2:end,iterator_j)*Delta_Hidden') + (Alpha.*Delta_Prev_Weight_Input_Hidden);
            Weight_Bias_Hidden = Weight_Bias_Hidden + (2*Delta_Hidden) + (Alpha*Delta_Prev_Weight_Bias_Hidden);
            %% Delta For Momentum
            Delta_Prev_Weight_Hidden = Weight_Hidden - Prev_Weight_Hidden;
            Delta_Prev_Weight_Input_Hidden = Weight_Input_Hidden - Prev_Weight_Input_Hidden;
            Delta_Prev_Weight_Bias_Output  = Weight_Bias_Output - Prev_Weight_Bias_Output;
            Delta_Prev_Weight_Bias_Hidden  = Weight_Bias_Hidden - Prev_Weight_Bias_Hidden;
            Prev_Weight_Hidden = Weight_Hidden;
            Prev_Weight_Input_Hidden = Weight_Input_Hidden;
            Prev_Weight_Bias_Output = Weight_Bias_Output;
            Prev_Weight_Bias_Hidden = Weight_Bias_Hidden;
        end
            error(:,iterator_i)=Err;
            waitbar(iterator_i / Iteration)
    end
    close(h)
    %% Error Plots
    sqe=sum((error(:,1:iterator_i).^2),1);
    X = sprintf('Error is %f ',sqe(length(sqe)));
    disp(X);
    plot(sqe);
    title('Error Plot-Training');
    xlabel('Number Of Iterations');
    ylabel('Error^2');
    %% Saving Weights
    save('Weights','Weight_Bias_Hidden','Weight_Hidden','Weight_Input_Hidden','Weight_Bias_Output','n_data',...
          'Class_1_Data','Class_2_Data','Class_3_Data');
    TestingBackProp();
end




