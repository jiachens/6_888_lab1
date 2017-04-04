function [ rx_sym_no_channel ] = correct_channel(rx_sym,H)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%

load ../Mat_Files/Parameters.mat 

%  ... add your code here ... %

rx_sym_no_channel=rx_sym./H;

end
