% note : this requires values to be sorted in ascending order (!)
% integration by the midpoint rule
% TODO, part between 0 and a has to be excluded (!)
% TODO, initial value ?
function [Cs_z, u_z] = stratification_profile_mclean(z,H,us,Ca,ws)
	gamma  = 5.4;
	sigma  = 1;
	beta   = 0.25*gamma^2; % 7.3
	kappa  = 0.41;
	g      = 9.81;
	rhow   = 1e3;
	rhos   = 2650;

	ws_n  = ws;

	eta   = z./H;
	
	f_eta = eta.*(1-eta);

	% 30 in 1992
	Kn = kappa.*us.*h.*f_eta;

	maxiter = 10;
	k = 1;
	% TODO this is better done in an ode fashion where only step i
	% is iterated instead of the entire integration
	while (k<maxiter)
		k = k+1;
	
		% 29 in 1992
		Cn  = Cs_z;
		chi = g*kappa*(rhos-rhow)/rhow*(ws_n*Cn*(1-Cs_z)).*h.*f_eta./(us.^3*(1-eta).^2);

		% 13 a, (25 1992)
		Km = Kn./(1+gamma*chi);		
		
		% 13 b (26 in 1992)
		Ks = Kn./(sigma + beta*chi);
		
		% 4 (4 in 1992)
		% u = int_eta0^eta us^2/km(1-eta)deta
		u_z = dz*cumsum(us.^2./(Km.*(1-eta)));

		% 6 (14 in 1992) 
		% Cs_ = Cs./(1-Cs)
		%Cs_ = Ca./(1-Ca)*exp(int_a^z w_n/Ks dz)
		Cs_ = Ca./(1-Ca)*exp(dz*cumsum(ws_n./Ks));
		
		% solve for Cs
		Cs_z = Cs_./(1 + Cs_);
	end
end % stratification profile mc lean


