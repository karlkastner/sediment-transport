% Wed 24 May 14:04:50 CEST 2017
% Karl Kastner, Berlin
%% bed load transport according to Wu
% TODO unfinished
% function [Qb_m] = bed_load_transport_wu()
function [Qb_m] = bed_load_transport_wu()
	
	[phkn, pek] = hiding_exposure_wu(d,p);

	% 3.45 inception of motion
	tau_ck = critical_shear_stress_wu();

	nt = 1/20*d50^(1/6);
	% transport rate
	Phi = 5.3e-3*((nt/n).^(1.5)*taub/tauck-1).^2.2;
	% volumetric transport
	qb_v  = pbk*sqrt((rhos/rhow-1)*g*d.^3);
	% mass transport
	qb_m  = rhos*qb_v;
	% mass transport integrated across width
	Qb_m  = w*qb_m;
end

