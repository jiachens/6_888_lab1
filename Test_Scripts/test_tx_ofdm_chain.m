function test_tx_ofdm_chain()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_TX_R.mat
load ../Mat_Files/Parameters.mat

tx_signal = tx_ofdm_chain(bits_data);

save ../Results/Result_TX_Chain.mat tx_signal

tm = 0:1:length(tx_signal)-1;
tm = tm*1e6/fs;

h=figure;
subplot(2,1,1);plot(tm,real(tx_signal));ylabel('Real');xlabel('Time (microseconds)');title('OFDM Time Signal');
subplot(2,1,2);plot(tm,imag(tx_signal));ylabel('Imag');xlabel('Time (microseconds)');
saveas(h,'../Results/Result_TX_Chain.fig','fig');

end