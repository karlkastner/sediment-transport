% Sat 20 May 16:22:42 CEST 2017
%% transport stage according to McLean
% this is the excess shear stress
% notation unified, as defined in mclean is Ts - 1
function [Ts] = transport_stage_mclean(d50,H,U)
	rhow = Constant.density.water;

	% mm to m
	d50 = 1e3*d50;

	% nicuradse roughness height
	z0  = 1/30*d50;

	% shear velocity associated with skin friction
	us_f  = U./(log(H./z0)-1);
	tau_f = rhow*us_f.^2;

	%  critical shear stress
	tau_c = critical_shear_stress(1e3*d50);

	% excess shear stress
	Ts = tau_f./tau_c - 1;
end

