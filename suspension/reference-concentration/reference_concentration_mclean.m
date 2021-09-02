% 2017-05-20 18:10:42.399224785 +0200
function Cna = reference_concentration_mclean(d_mm,p,d50_mm,S,T_C,us,ws,flag)
	% volume concentration in bed (packing density of spheres)
	Cb     = 0.6;
	gamma0 = 0.004;
	rho_w  = Constant.density.water;

        if(nargin()<8)
		flag = 1;
	end

	% multible fractions vs single fractions
	nc = length(d_mm);
	if (nc>1)
		% critical shear stress is similar to D50 for all grains if sediment is sand
		% (because grains bounce at each other and a grains in the bed layer move simultaneously)
		% critical shear velocity
		tau_c   = critical_shear_stress(d50_mm,T_C);
		usc     = 1./rho_w*sqrt(tau_c);
		if (0)
		Fn      = ones(length(S),nc);
		fdx     = (cvec(us) < rvec(ws));
		Fn(fdx) = (us - usc)./(ws(fdx) - usc);
		else
			Fn = 1;
		end

		% weigh fraction (itn in mclean)
		itn = Fn.*p./sum(Fn.*p,2);
	else
		itn = 1;
	end

	% eq 31 reference concentration
	Cna = itn.*(gamma0*Cb*S)./(1 + flag*gamma0*S);
	if (2==flag)
		Cna = itn*(gamma0*Cb*S).*(1 - gamma0*S);
%		Cna = itn*(Cb).*(1 - 1./(gamma0*S));
	end
	Cna(:,S<0) = 0;
end % reference_concentration_mclean

