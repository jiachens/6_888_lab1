function test_rx_ofdm_chain()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh
% CSAIL, MIT
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_RX_Chain_R.mat
load ../Mat_Files/Parameters.mat

bits_data = zeros(size(rx_signal,1),num_bins_data*num_syms_data);

for m = 1:1:size(rx_signal,1)
    bits_data(m,:) = rx_ofdm_chain(rx_signal(m,:));
end


save ../Results/Result_RX_Chain.mat bits_data


end