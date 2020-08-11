% Mon 30 Mar 12:40:04 +08 2020
% TODO: mclean 1986, nelson 1989, Warner 2006
% TODO merge skin_2_total_friction_eh
function tau_rat = skin2total_stress_ratio(tau_s,d50_mm,dune_h,dune_l,z_f,u,h,method,flag)
	kappa = 0.41;

	if (nargin()<7)
		method = 'smith-1977';
	end

	switch (method)
	case {'engelund-hansen-1967'}
		g     = 9.81;
		d50_m = 1e-3*d50_mm; 
		rho_s = 2650;
		rho_w = 1e3;
		if (~flag)
			theta_s = tau_s./(g*(rho_s-rho_w).*d50_m);
		else
			% in and output are already theta_s
			theta_s = tau_s;
		end
		if (~issym(theta_s))
			theta_t = sqrt(2.5*max(theta_s - 0.06,0));
		else
			theta_t = sqrt(2.5*(theta_s - 0.06));
		end
		tau_rat = theta_t./theta_s;
	case {'wright-parker-2003'} % c.f. chaudhry
		g       = 9.81;
		Fr      = u./sqrt(g*h);
		tau_t   = ((tau_s-0.05)./(0.7*Fr.^0.7)).^1.25;
		tau_rat = tau_t./tau_s;
	case {'smith-1977'}
		% c.f. nelson 1993
		c_D = 0.21;
		a1  = 0.1;
		% eq 38, p 5765
		% mclean explicitely writes ln, so this is indeed the natural logarithm matlab "log"
		% it is unclear in the paper, if (lamdab/zf).^0.8 is in the log
		f         = (1/kappa*log(a1.*(dune_l./z_f).^0.8));
		% note in 1986, eq 26, p 306, it reads log a1 lambda.^(4/5)/z0		
		% which seems to be a typo, as in mclean 1992, it is again outside
		tau_rat = 1 + 1/2*c_D.*dune_h./dune_l.*f.^2;
	case {'nelson-wolfe-1993'}
		c_D = 0.25;
		f         = 1/kappa*log(z_m./z_f);
		tau_rat = 1 + 1/2*c_D*dune_h/L*f^2;
	case {'wiberg-nelson-1992'}
		c_D       = 0.23; % page 12,753 
		% note that sqrt(tau_0/rho) f gives a reference velocity
		f         = 1/kappa*(log(dune_h/z0_s)-1);
		tau_rat = 1 + 1/2*CD*dune_h/L*f^2;
	end
end

