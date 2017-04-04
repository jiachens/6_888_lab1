function [ rx_signal_no_cfo ] = correct_cfo(rx_signal,cfo)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
load ../Mat_Files/Parameters.mat

%  ... add your code here ... %
for m=1:1:size(rx_signal,2)
    rx_signal_no_cfo(m)=rx_signal(m)*exp(1i*cfo*m);
end

end