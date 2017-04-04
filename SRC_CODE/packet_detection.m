function [ packet_start_index ] = packet_detection(rx_signal)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%

load ../Mat_Files/Parameters.mat 

% Dc removal filter
alpha = 0.975; 
rx_signal = filter([1 -1], [1 -alpha], rx_signal);

threshold=3.75;

for m=num_bins:1:(size(rx_signal,2)-num_bins)
    A_m=sum(abs(rx_signal(m-num_bins+1:m)).*abs(rx_signal(m-num_bins+1:m)));
    B_m=sum(abs(rx_signal(m+1:m+num_bins)).*abs(rx_signal(m+1:m+num_bins)));
    if  B_m/A_m > threshold
        break;
    end
end
for m=m:1:m+num_bins
    A_m=sum(abs(rx_signal(m-num_bins+1:m)).*abs(rx_signal(m-num_bins+1:m)));
    B_m=sum(abs(rx_signal(m+1:m+num_bins)).*abs(rx_signal(m+1:m+num_bins)));
    peak_finder(m)=B_m/A_m;
end
packet_start_index=find(peak_finder==max(peak_finder))+1;% means that removes two preambles
%  ... add your code here ... %

end