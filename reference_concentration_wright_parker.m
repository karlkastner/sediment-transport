% Tue 31 Mar 11:52:05 +08 2020
function c5 = reference_concentration_wright_parker(us_k,ws,S,d_mm,d50_mm,sd,T_C)
	rho_s  = Constant.density.quartz;
	rho_w  = Constant.density.water;
	g      = Constant.gravity;
	nu     = Constant.viscosity_kinematic_water(T_C);
	d_m    = 1e-3*d_mm;
	Rep    = sqrt((rho_s./rho_w-1)*g*d_m).*d_m./nu;
%	ds    =       (g*(s-1)./nu.^2 ).^(1/3).*d_m;
	F      = 1; % fraction
	p      = (d_mm<d50_mm);
	b      = (p*0.2 + (1-p)*0.6).*(d_mm./d50_mm);
	B      = 5.7e-7;
	lambda = 1-0.28*sd;
	X      = (us_k ./ ws.*Rep.^0.6).*S.^0.07.*(d_mm./d50_mm).^b;
	E      = B*(lambda.*X).^5./(1 + B./0.3*(lambda.*X).^5);
	c5     = E.*F;
end

