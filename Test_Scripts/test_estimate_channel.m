function test_estimate_channel()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh
% CSAIL, MIT
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_Channel_R.mat
load ../Mat_Files/Parameters.mat

rx_preamble_1=fft(signal(1:num_bins)/sqrt(num_bins),num_bins);
rx_preamble_2=fft(signal(1+num_bins:num_bins*2)/sqrt(num_bins),num_bins);
H = estimate_channel(rx_preamble_1,rx_preamble_2);

save ../Results/Result_Channel_Estimation.mat H

H(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = 0;
ht = ifft(H);
H(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = nan;

h=figure;
subplot(2,1,1);stairs(convert_bin_index_fft_to_normal([1:num_bins],num_bins),abs(H));ylabel('|H|');xlabel('Subcarrier Index');title('Channel in the Frequency Domain');axis([-64 64 min(abs(H))*0.9 max(abs(H))*1.1]);
subplot(2,1,2);stem([0:num_bins/2-1]*1e6/fs,abs(ht(1:num_bins/2)),'.');ylabel('|h|');xlabel('Time (microseconds)');title('Channel Taps in the Time Domain'); axis([-1e6/fs (num_bins/2)*1e6/fs 0 abs(ht(1))*1.1]);
saveas(h,'../Results/Result_Channel.fig','fig');

end