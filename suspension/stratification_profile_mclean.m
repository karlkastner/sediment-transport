% 2020-11-15 13:43:21.748005372 +0800
% note : this requires values to be sorted in ascending order (!)
% integration by the midpoint rule
% TODO, part between 0 and a has to be excluded (!)
% TODO, initial value ?
function [Cs_z, u_z] = stratification_profile_mclean(z,h,us,Ca,ws,z0)
	%ws_n  = ws;
	eta   = (z-z0)./h;
	kappa = 0.41;

	% TODO no magic number
	maxiter = 10;
	abstol = 1e-3;
	k = 1;
	% TODO this is better done in an ode fashion where only step i
	% is iterated instead of the entire integration
	Cs_z = 0;
	dz = z(2)-z(1);
	u_z = 0;
	while (k<maxiter)
		k = k+1;

		[Km, Ks, Kn] = eddy_viscosity_mclean(eta,h,us,ws,Cs_z);

		% 4 (4 in 1992)
		% u = int_eta0^eta us^2/km(1-eta)deta
		uold = u_z;
		% TODO, the integration constant is not corrected for sediment (!)
		u_z = dz*cumsum([0;mid(us.^2.*(1-eta)./Km)]) + us/kappa*log(eta(1)*h/z0);
		%u_z_ = dz*cumsum(us.^2./(Kn.*(1-eta)));

		% 6 (14 in 1992) 
		% Cs_ = Cs./(1-Cs)
		%Cs_ = Ca./(1-Ca)*exp(int_a^z w_n/Ks dz)
		Cs_ = Ca./(1-Ca)*exp(dz*cumsum(ws./Ks));
		
		% solve for Cs
		Cs_z = Cs_./(1 + Cs_);
		
		if (max(abs(u_z-uold)) <abstol)
			break
		end
	end
end % stratification profile mc lean


