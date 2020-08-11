function shear_velocity_mclean(U,H,z0_f)
	kappa = 0.41;
	% shear velocity associated with skin friction
	%us_f  = U./(log(H./z0)-1);
	us_f  = kappa*U./((log(H./z0_f)-1));
	%us_f = shear_velocity(U,C)

