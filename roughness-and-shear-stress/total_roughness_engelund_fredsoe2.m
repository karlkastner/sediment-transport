% Fri 17 Apr 17:26:19 +08 2020
function [C,C_s] = total_roughness_engelund_hansen(u,S,h,d50_mm)
	rho_w   = Constant.density.quartz;
	g       = Constant.gravity;

	us      = sqrt(g*h.*S);

	tau_t   = rho_w*us.^2;
	tau_rat = total2skin_stress_ratio(tau_t,d50_mm,u,h,'engelund-hansen-1967');
	tau_rat = min(1,tau_rat);

	tau_s   = tau_rat.*tau_t;

	k_s     = grain_roughness_nikuradse(d50_mm);
	z0_s    = ks2z0(k_s);
	h_s     = boundary_layer_height(u,h,S,z0_s);
	C_s     = chezy_roughness_engelund_fredsoe(d50_mm,h_s);
	f_s     = chezy2f(C_s);
	f       = f_s.*tau_t./tau_s;
	C       = f2chezy(f);
end

