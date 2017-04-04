function [ signal ] = tx_ofdm_chain(bits_data)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%

load ../Mat_Files/Parameters.mat
load ../Mat_Files/Test_TX.mat
signal = zeros(1,num_samples);

signal_preamble=[];
signal_data=[];

bits_preamble_mapping=bits_preamble;
bits_preamble_mapping(bits_preamble_mapping==1)=-1;
bits_preamble_mapping(bits_preamble_mapping==0)=1;

bits_data_mapping=bits_data;
bits_data_mapping(bits_data_mapping==1)=-1;
bits_data_mapping(bits_data_mapping==0)=1;

bits_pilots_mapping=bits_pilots;
bits_pilots_mapping(bits_pilots_mapping==1)=-1;
bits_pilots_mapping(bits_pilots_mapping==0)=1;

% Use this variable to create each symbol in the frequency domain before
% taking the fft
symbol_freq = zeros(1,num_bins);
% Use this variable to help you set the data subcarriers from pilot
% subcarriers from unused subcarriers


subcarrier_config = ones(1,num_bins);%normal symbol
subcarrier_config(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = 0;
subcarrier_config(convert_bin_index_normal_to_fft(pilots,num_bins)) = 3;

fft_pilots_index=convert_bin_index_normal_to_fft(pilots,num_bins);
fft_preamble_index=find(subcarrier_config~=0);
fft_data_index=find(subcarrier_config==1);

container_preamble=zeros(1,num_bins);
container_data=zeros(1,num_bins);


%% ADD PREAMBLE SYMBOLS
for m = 1:1:num_syms_preamble    
    %  ... add your code here ... %
    container_preamble(fft_preamble_index)=bits_preamble_mapping;
    signal_preamble=[signal_preamble,ifft(container_preamble,num_bins)];
end
    signal_preamble=[signal_preamble,signal_preamble(1:51)]*sqrt(num_bins);
    %  ... add your code here ... %
%% ADD DATA SYMBOLS
for m = 1:1:num_syms_data
%  ... add your code here ... %
    container_data(fft_data_index)=bits_data_mapping((1+(m-1)*92:m*92));
    container_data(fft_pilots_index)=bits_pilots_mapping;
    temp=ifft(container_data,num_bins)*sqrt(num_bins);
    signal_data=[signal_data,temp,temp(1:51)];
end
    signal=[signal_preamble,signal_data];
end