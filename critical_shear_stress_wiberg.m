	alpha = 1.5;


	% f is calculated from (10),
	% but it is not clear how zb should be determined

	% no bed slope
	beta = 0;

	% tau_b and Ax cancel
	tab_b  = 1;
	Ax     = 1;
	c_L    = 0.2;
	c_D    = 0.15; % for turbulent flow Re>2 10^5
	F_D    = 1./2*c_D*tau_b*f_0^2*Ax;
	F_L    = 1./2*c_L*tau_b*(f_T.^2 - f_B.^2)*Ax;
	ks      = D_m; % (p 1473, fig 3 and text)
	% eq 11
	zs     = -0.02;
	phi0   = acos( (D/ks+zs)/(D/ks+1)); 

	tau_cr = 2./(c_D*alpha)*1./(f_0.^2)*(tan(phi0)*cos(beta)-sin(beta))./(1+(F_L/F_D).*tan(phi0));

