function test_correct_channel()
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

ss=[];
sc=[];
for m=1:1:(length(signal)/num_bins)
    sym_freq =(1/sqrt(num_bins))*fft(signal(1+num_bins*(m-1):num_bins*m));
    ss = [ss;sym_freq];
    sym_freq_no_channel = correct_channel(sym_freq,H);
    sc = [sc;sym_freq_no_channel];
end

h=figure;
subplot(1,2,1);plot(ss,'.');ylabel('Imag');xlabel('Real');title('Constellation Before Channel Correction'); axis([-3 3 -3 3])
subplot(1,2,2);plot(sc,'.');ylabel('Imag');xlabel('Real');title('Constellation After Channel Correction'); axis([-2 2 -2 2])
saveas(h,'../Results/Result_Cons_Channel_Corr.fig','fig');

end