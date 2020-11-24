%% Author : Krishna Satish D S
function dataout = Normalization(datain)
    [minval,maxval] =  Min_Max_Finder(datain);
    temp = (datain - minval);
    dataout = temp/(maxval-minval);
end
