function [ H ] = estimate_channel(rx_sym1,rx_sym2)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%

load ../Mat_Files/Parameters.mat 

%  ... add your code here ... %
bits_preamble_mapping=bits_preamble;
bits_preamble_mapping(bits_preamble_mapping==1)=-1;
bits_preamble_mapping(bits_preamble_mapping==0)=1;

subcarrier_config = ones(1,num_bins);%normal symbol
subcarrier_config(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = 0;
subcarrier_config(convert_bin_index_normal_to_fft(pilots,num_bins)) = 3;

fft_preamble_index=find(subcarrier_config~=0);

container_preamble=zeros(1,num_bins);
container_preamble(fft_preamble_index)=bits_preamble_mapping;

received_sym = (rx_sym1 + rx_sym2)/2;
memory_sym = container_preamble;

H=received_sym./memory_sym;
H(subcarrier_config==0)=inf;

end