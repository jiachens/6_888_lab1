function [ bits_data ] = rx_ofdm_chain(rx_signal)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
clc
load ../Mat_Files/Parameters.mat

bits_data = [];
container=[];

% Use this variable to help you set the data subcarriers from pilot
% subcarriers from unused subcarriers
subcarrier_config = ones(1,num_bins);
subcarrier_config(convert_bin_index_normal_to_fft(gaurd_bins,num_bins)) = 0;
subcarrier_config(convert_bin_index_normal_to_fft(pilots,num_bins)) = 3; 

% Use this variable to keep track at which sample you are  in packet
fft_data_index=find(subcarrier_config==1);
current_index = 1;


%% PACKET DETECTION
start_index=packet_detection(rx_signal);
current_index=start_index;
%  ... add your code here ... %
for m = 1:1:num_syms_preamble-2
    preamble_bits(m,:)=fft(rx_signal(current_index:current_index+num_bins-1)/sqrt(num_bins),num_bins);
    current_index=current_index+num_bins;
end

%% CFO ESTIMATION AND CORRECTION

[cfo]=estimate_cfo(preamble_bits(5,:),preamble_bits(6,:));
[rx_signal_no_cfo]=correct_cfo(rx_signal,cfo);

%  ... add your code here ... %

%% CHANNEL ESTIMATION

for m = num_syms_preamble-1:1:num_syms_preamble
    preamble_bits(m,:)=fft(rx_signal_no_cfo(current_index:current_index+num_bins-1)/sqrt(num_bins),num_bins);
    current_index=current_index+num_bins;
end

H=estimate_channel(preamble_bits(7,:),preamble_bits(8,:));
current_index=current_index+cp;

%  ... add your code here ... %
for m = 1:1:num_syms_data
    data_bits(m,:)=fft(rx_signal_no_cfo(current_index:current_index+num_bins-1)/sqrt(num_bins),num_bins);
    current_index=current_index+num_bins+cp;
end
h=H;
for m= 1:1:num_syms_data
    
    [r_cfo,r_sfo]=estimate_residual_cfo_sfo(data_bits(m,:),h);
    [h]=correct_residual_cfo_sfo(h,r_cfo,r_sfo);
    [rx_sym_no_channel]=correct_channel(data_bits(m,:),h);
    rx_sym_no_channel_abs(m,:)=abs(rx_sym_no_channel);
    rx_sym_no_channel_angle(m,:)=angle(rx_sym_no_channel);
end

%% DECODING
for m = 1:1:num_syms_data
    container=rx_sym_no_channel_angle(m,:);
    container(container<pi/2 & container>-pi/2)=0;
    container(container<-pi/2 | container>pi/2)=1;
    bits_data=[bits_data,container(fft_data_index)];
    %  ... add your code here ... %
    
end
    
end