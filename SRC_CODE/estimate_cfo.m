function [ cfo ] = estimate_cfo(rx_sym1,rx_sym2)
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh 
% CSAIL, MIT 
% September 11, 2013
%
load ../Mat_Files/Parameters.mat

z=0;
rx_sym2_conj=conj(rx_sym2);

for m=1:1:num_bins
    z=z+rx_sym2_conj(m)*rx_sym1(m);
end
z_angle=angle(z);
cfo=z_angle/num_bins;
%  ... add your code here ... %

end