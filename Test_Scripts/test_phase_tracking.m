function test_phase_tracking()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh
% CSAIL, MIT
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_Phase_Tracking_R.mat
load ../Mat_Files/Parameters.mat

cfo_r = zeros(1,num_syms_data);
sfo_r = zeros(1,num_syms_data);

k=figure;
subplot(1,2,1);ylabel('Imag');xlabel('Real');title('Constellation Without Phase Tracking ');
subplot(1,2,2);ylabel('Imag');xlabel('Real');title('Constellation With Phase Tracking');

for m=1:1:num_syms_data
pause(0.25);
sym = 1/sqrt(num_bins)*fft(signal(1+(num_bins+cp)*(m-1):num_bins*m+cp*(m-1)));

[cfo_r(m) sfo_r(m)] = estimate_residual_cfo_sfo(sym,h);
h = correct_residual_cfo_sfo(h,cfo_r(m),sfo_r(m));

subplot(1,2,1);hold on;plot(sym./h_f,'.b');
subplot(1,2,2);hold on;plot(sym./h,'.r');
end

saveas(k,'../Results/Result_Phase_Tracking.fig','fig');
save ../Results/Result_Phase_Tracking.mat sfo_r cfo_r


end
