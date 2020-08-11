% Sat 20 May 16:22:42 CEST 2017
%% transport stage according to McLean
% this is the excess shear stress
% notation unified, as defined in mclean is Ts - 1
function [Ts,S,us_f] = transport_stage_mclean(us_f,d50_mm,T_C)
%function [Ts,S,us_f] = transport_stage_mclean(U,H,z0_f,d50_mm,T_C)
	rho_w = Constant.density.water;
	kappa = Constant.Karman;

	% mm to m
	d50_m = 1e-3*d50_mm;

	% nicuradse roughness height
	% z0  = (1/30)*d50_m

	tau_f = rho_w*us_f.^2;

	%  critical shear stress
	tau_c = critical_shear_stress(d50_mm,T_C);

%tau_f = 2.39;
%tau_c = 0.146; % N/m^2
%pause

	% Transport stage
	Ts    = tau_f./tau_c;

	% excess shear stress
	S     = max(Ts - 1,0);
end

