function [ h_new ] = correct_residual_cfo_sfo(h_prev, r_cfo , r_sfo)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
load ../Mat_Files/Parameters.mat

%  ... add your code here ... %
h_prev_angle=angle(h_prev);
h_prev_abs=abs(h_prev);

h_new_abs=h_prev_abs;

for m=-64:1:63
    fft_index=convert_bin_index_normal_to_fft(m,num_bins);
    h_new_angle(fft_index)=h_prev_angle(fft_index)+r_sfo*m+r_cfo;
end

h_new=h_new_abs.*exp(1i.*h_new_angle);
end