% 2016-03-16 14:05:54.243257026 +0100
%% critical shear Stress
function tau_c = critical_shear_stress(d50_mm,varargin)
	rho_w = Constant.density.water;
	rho_s = Constant.density.quartz;
	g     = Constant.gravity;
	% critical shields parameter
	theta_c = critical_shear_stress_ratio(d50_mm,varargin{:});
	% m to mm
	d50 = 1e-3*d50_mm;
	tau_c = g*(rho_s-rho_w).*d50.*theta_c;
end

