% Sat 20 May 16:22:42 CEST 2017
%% transport stage according to McLean
% this is the excess shear stress
% notation unified, as defined in mclean is Ts - 1
function [Ts,S] = transport_stage_mclean(U,H,d50_mm)
	rhow = Constant.density.water;

	% mm to m
	d50_m = 1e-3*d50_mm;

	% nicuradse roughness height
	z0  = 1/30*d50_m;

	% shear velocity associated with skin friction
	us_f  = U./(log(H./z0)-1);
	tau_f = rhow*us_f.^2;

	%  critical shear stress
	tau_c = critical_shear_stress(d50_mm);

	Ts = tau_f/tau_c;

	% excess shear stress
	S = tau_f./tau_c - 1;
end

