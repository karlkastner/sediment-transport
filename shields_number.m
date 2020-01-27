% 2018-03-09 12:43:01.261859520 +0100
%% normalized shear stress, shear stress ratio
% 	theta = shields_number(C,U,d_mm,rho_s,rho_w)
function theta = shields_number(C,U,d_mm,rho_s,rho_w)
	if (nargin()<4)
		if (~issym(C))
			rho_s = Constant.density.quartz;
		else
			syms rho_s positive
		end
	end
	if (nargin()<5)
		if (~issym(C))
			rho_w = Constant.density.water;
		else
			syms rho_w positive
		end
	end
	if (~issym(C))
		g    = Constant.gravity;
	else
		syms g positive
	end
	d_m  = 1e-3*d_mm;

	tau    = rho_w*g./C.^2.*U.^2;
	theta  = tau./(g*(rho_s-rho_w).*d_m);
end

