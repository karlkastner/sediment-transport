% Wed 29 Apr 20:55:05 +08 2020
function d_m = derive_critical_grain_size()
	syms Q n S d50_mm T_C tau
	
	tau_c = critical_shear_stress(d50_mm,T_C,'mpm')
%	0.47 = rhow g h S/((rhos - rho) g D)
%	0.47 = rhow h S/((rhos - rhow) D)
%	h    = normal_flow_depth(Q,1,n,S,1)
	d_mm = solve(tau_c-tau,d50_mm)
	d_m = d_mm*1e-3;
end

