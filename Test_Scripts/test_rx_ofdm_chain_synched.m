function test_rx_ofdm_chain_synched()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_RX_Synced_R.mat
load ../Mat_Files/Parameters.mat

bits_data = rx_ofdm_chain_synced(rx_signal);
bits_data_30dB = rx_ofdm_chain_synced(rx_signal_30dB);
bits_data_20dB = rx_ofdm_chain_synced(rx_signal_20dB);
bits_data_10dB = rx_ofdm_chain_synced(rx_signal_10dB);
bits_data_7dB = rx_ofdm_chain_synced(rx_signal_7dB);
bits_data_6dB = rx_ofdm_chain_synced(rx_signal_6dB);
bits_data_5dB = rx_ofdm_chain_synced(rx_signal_5dB);

SNR =[5,6,7,10,20,30];
BER = zeros(1,length(SNR));
BER(1) = sum(abs(bits_data_t-bits_data_5dB))/length(bits_data_t);
BER(2) = sum(abs(bits_data_t-bits_data_6dB))/length(bits_data_t);
BER(3) = sum(abs(bits_data_t-bits_data_7dB))/length(bits_data_t);
BER(4) = sum(abs(bits_data_t-bits_data_10dB))/length(bits_data_t);
BER(5) = sum(abs(bits_data_t-bits_data_20dB))/length(bits_data_t);
BER(6) = sum(abs(bits_data_t-bits_data_30dB))/length(bits_data_t);

save ../Results/Result_RX_Chain_Synced.mat bits_data* SNR BER


end