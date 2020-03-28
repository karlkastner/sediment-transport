% Sat 20 May 16:22:42 CEST 2017
%% transport stage according to McLean
% this is the excess shear stress
% notation unified, as defined in mclean is Ts - 1
function [Ts,S,us_f] = transport_stage_mclean(U,H,d50_mm)
	rho_w = Constant.density.water;
	kappa = 0.41;

	% mm to m
	d50_m = 1e-3*d50_mm;

	% nicuradse roughness height
	z0  = (1/30)*d50_m;

	% shear velocity associated with skin friction
	%us_f  = U./(log(H./z0)-1);
	us_f  = kappa*U./((log(H./z0)-1));
	tau_f = rho_w*us_f.^2;

	%  critical shear stress
	tau_c = critical_shear_stress(d50_mm);

	% Transport stage
	Ts    = tau_f/tau_c;

	% excess shear stress
	S     = Ts - 1;
end

