% Mon 30 Mar 21:46:23 +08 2020
% from 25b in 1977, z0 ~ za
function z0 = roughness_height_mclean_1972(d50_mm,d84_mm,us,T_C)
	rhos=2650;
	rhow=1000;
	g=9.81;
	

	tau_f = rhow*us.^2;
	tau_c = critical_shear_stress(d50_mm,T_C);

	% owen 1964, 1972, eq 6b
	%z_N = d84_mm/10;
	% this is according to soulsby 1997
	% c.f. parker garcia 1991, they use z_a = z_0
	z_N = 1e-3*d50_mm/12;
	%z_N     = 1e-3*3*d84_mm/10;
	%z_N = 1e-3*d84_mm/30
	if (1)
		a0_1977 = 26.3; % tauc included
		z0 = a0_1977*(tau_f-tau_c)./((rhos-rhow)*g) + z_N;
	else
		a0_1964 = 22.8 % for tauc = 0
		z0 = a0_1964*(tau_f)./((rhos-rhow)*g) + z_N;
	end
end

