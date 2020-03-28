% Fri 20 Mar 18:08:35 +08 2020
%
% this gives essentially the same result as the 1984 equation
% (this is a piecewise linear apprpximation of vr 1984)
%
function rgh = bedform_roughness_rijn_2007(d50_mm,psi,R)
	d_sand_mm = 0.062;
	f_fs      = (d50_mm./(1.5*d_sand_mm));
	f_fs(d50_mm>1.5*d_sand_mm) = 1;

	ks_cd =   (   0.0004*f_fs.*psi.*R.*(psi < 100) ...
		    + (psi>100 & psi<600).*(0.048 - 0.00008*psi).*f_fs.*R );
	% zero for psi > 600

	% TODO ripples and megaripples are missing
	ks_mr = 0;

	rgh.ks = ks_cd + ks_mr;

	rgh.z0  = rgh.ks/30;
	if (nargin()>2)
		if (~issym(psi))
			g = Constant.gravity;
			kappa = Constant.Karman;
		else
			syms g kappa 
		end
		%rgh.C = sqrt(g)/kappa*(log(R./rgh.z0) - 1);
		rgh.C = double(z02chezy(rgh.z0,R));
		rgh.cd = g*rgh.C.^(-2);
		rgh.n  = chezy2manning(rgh.C,R);
	end
end

