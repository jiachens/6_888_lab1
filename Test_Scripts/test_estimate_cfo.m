function test_estimate_cfo()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh
% CSAIL, MIT
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_CFO_R.mat
load ../Mat_Files/Parameters.mat

cfo_values = zeros(1,size(rx_signal,1));

for m = 1:1:size(rx_signal,1)
    cfo_values(m) = estimate_cfo(rx_signal(m,1:num_bins),rx_signal(m,1+num_bins:num_bins*2));
end

save ../Results/Result_CFO_estimation.mat cfo_values

end