function test_packet_detection()
% 6.888 Wireless Communications Systems
%
% Dina Katabi / Haitham Hassnaieh
% CSAIL, MIT
% September 11, 2013
%
addpath ../SRC_CODE
load ../Mat_Files/Test_Packets_R.mat
load ../Mat_Files/Parameters.mat

[num_sigs len_sigs] = size(signals);

packets_start_index = zeros(1,num_sigs);

for m=1:1:num_sigs
    packets_start_index(m) = packet_detection(signals(m,1:len_sigs));
end

save ../Results/Result_Pkt_Start.mat packets_start_index

end