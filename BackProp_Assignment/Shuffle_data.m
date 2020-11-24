%% Author : Krishna Satish D S
function [Shuffled_Data,Class_1_Data,Class_2_Data,Class_3_Data] = Shuffle_data(datain)
    Shuffled_Data = [];
    Class_1_Data = [];
    Class_2_Data = [];
    Class_3_Data = [];
    
    for iterator=1:length(datain)
        if (datain(iterator) == 1)
            Class_1_Data = [Class_1_Data; datain(iterator,:)];
        elseif (datain(iterator) == 2)
             Class_2_Data = [Class_2_Data; datain(iterator,:)];
        else
            Class_3_Data = [Class_3_Data; datain(iterator,:)];
        end
    end
    for iterator=1:40
         training_data_buffer = [Class_1_Data(iterator,:);Class_2_Data(iterator,:);Class_3_Data(iterator,:)]';
         Shuffled_Data = [Shuffled_Data training_data_buffer];
    end
    
end
