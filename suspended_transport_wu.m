% Wed 24 May 14:11:35 CEST 2017
% Karl Kastner, Berlin
%% suspended sediment transport according to Wu
function [Qs] = suspended_transport_wu()
	% 3.102 
	Phi_sk = 2.62e-5*((tau/tauck-1).*U/wsk).^1.74;
	% 
	qs_v = pbk*sqrt( g*(gammas/gamma-1)*d.^3 );
	%
	qs_m = rhos*qs_v;
	% 
	Qs = W*qs_m;
end
	
