% Wed 24 May 14:04:50 CEST 2017
% Karl Kastner, Berlin
%% bed load transport according to Wu
% function [Qb_m] = bed_load_transport_wu()
function [Qb_m,Phi] = bed_load_transport_wu(C,d_mm,U,H,width,T_C)

	rho_w = 1000;	
	rho_s = 2650;

	if (0)
		[phkn, pek] = hiding_exposure_wu(d,p);
	else
		pbk = 1;
	end

	n  = chezy2manning(C,H);

	% d50 here even for multiple fractions
	nt = grain_roughness_wu(d_mm);
	Ct = manning2chezy(nt,H);
	
	% shear stress due to grains
	% read text carefully: (nt/n)^(3/2) corrects for the total to grain stress conversion
	%us    = shear_velocity(U,Ct);
	us    = shear_velocity(U,C);
	tau_b = rho_w.*us.^2;

	% 3.45 inception of motion
	tau_ck = critical_shear_stress(d_mm,T_C,'wu');

	% transport rate
	Phi = 5.3e-3*max((nt./n).^(1.5).*tau_b./tau_ck-1,0).^2.2;

	% volumetric transport
	scale = sediment_transport_scale(d_mm);

	qb_v  = pbk.*scale.*Phi;

	% mass transport
	qb_m  = rho_s*qb_v;

	% mass transport integrated across width
	Qb_m  = width*qb_m;
end

