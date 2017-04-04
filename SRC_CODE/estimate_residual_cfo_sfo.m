function [ r_cfo, r_sfo ] = estimate_residual_cfo_sfo(rx_sym, h)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
load ../Mat_Files/Parameters.mat

bits_pilots_mapping=bits_pilots;
bits_pilots_mapping(bits_pilots_mapping==1)=-1;
bits_pilots_mapping(bits_pilots_mapping==0)=1;

%  ... add your code here ... %
fft_to_normal_subcarrier=convert_bin_index_fft_to_normal([1:128],num_bins);

for m=1:1:size(pilots,2)
    normal_subcarrier_pilot_index(m)=find(fft_to_normal_subcarrier==pilots(m));
end

% ... channel correct ...%
[rx_sym_no_channel]=correct_channel(rx_sym,h);
rx_sym_no_channel_abs=abs(rx_sym_no_channel);
rx_sym_no_channel_angle=angle(rx_sym_no_channel);
%........................%
Theata=angle(rx_sym_no_channel(normal_subcarrier_pilot_index)./bits_pilots_mapping);
pilot=[ones(1,8);pilots];

b=regress(Theata',pilot');

r_cfo=b(1);
r_sfo=b(2);
end