% 2016-03-16 14:05:54.243257026 +0100
%% critical shear Stress
%function tau_c = critical_shear_stress(d50_mm,varargin)
function tau_c = critical_shear_stress(d50_mm,T_C,varargin)
	if (issym(d50_mm))
	syms rho_w rho_s g
	else
	rho_w = Constant.density.water;
	rho_s = Constant.density.quartz;
	g     = Constant.gravity;
	end

	% critical shields parameter
	theta_c = critical_shear_stress_ratio(d50_mm,T_C,varargin{:});

	% m to mm
	d50_m = 1e-3*d50_mm;
	tau_c = g*(rho_s-rho_w).*d50_m.*theta_c;
% mud fraction, according to d3d:
%	tau_c = tau_c.*(1 + p_mud).^betam;
%
end

