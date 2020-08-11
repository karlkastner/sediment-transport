% Thu 30 Apr 14:29:06 +08 2020
function d50_mm = grain_size_from_shear_stress(tau)
	rho_s = Constant.density.quartz;
	rho_w = Constant.density.water;
	g     = Constant.gravity;
	%c = [0.0470, -0.7368];
	% c = [0.3128, -0.3254];
	c = [0.0017, -0.7811];
	d = (tau./(c(1)*g*(rho_s-rho_w))).^(1./(1+c(2)));
	d50_mm = 1e3*d;
end

