% Fri 20 Mar 19:02:02 +08 2020
function psi = mobility_parameter_rijn(u,d50_mm)
	rho_s = 2650;
	rho_w = 1000;
	g = 9.81;
	s = rho_s/rho_w;
	d50_m = 1e-3*d50_mm;
	psi = u.^2./((s-1).*g.*d50_m);
end

