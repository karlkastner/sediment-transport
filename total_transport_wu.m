% widthed 24 May 14:11:35 CEST 2017
% Karl Kastner, Berlin
%% total sediment transport according to wu 2000b
function [Q_tot] = total_transport_wu(C,d_mm,U,H,width,T_C)
	Q_sus    = suspended_transport_wu(C,d_mm,U,width,T_C);
	Q_bed    = bed_load_transport_wu(C,d_mm,U,H,width,T_C);
	Q_tot    = Q_sus + Q_bed;
end

