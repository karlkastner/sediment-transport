% Tue 31 Mar 10:42:42 +08 2020
function tau_rat = total2skin_stress_ratio(tau_t,d50_mm,u,h,method)
	switch (method)
	case {'engelund-hansen-1967'}
		% EH 4.2.4
		% critical shear stress
		% identity theta/theta_t = tau/tau_t
		%g     = Constant.gravity;
		%rho_s = Constant.density.quartz;
		%rho_w = Constant.density.water;
		%d50_m   = 1e-3*d50_mm; 
		theta_t = shear2shields(tau_t,d50_mm);
		% tau_t./(g*(rho_s-rho_w).*d50_m);
		theta_s = 0.06 + 0.4*theta_t.^2;
		tau_rat = theta_s./theta_t;
	case {'wright-parker-2003'}
		g       = Constant.gravity;
		Fr      = u./sqrt(g*h);
		tau_s   = 0.05 + 0.7*(tau_t.*Fr.^0.7).^0.8;
		tau_rat = tau_s./tau_t;
	otherwise
		error('here');
	end
end

