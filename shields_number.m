% 2018-03-09 12:43:01.261859520 +0100
%% normalized shear stress, shear stress ratio
function theta = shields_number(C,U,d_mm,rhos,rhow)
	if (nargin()<4)
		rhos=Constant.density.quartz;
	end
	if (nargin()<5)
		rhow = Constant.density.water;
	end
	if (~issym(C))
		g    = Constant.gravity;
	else
		syms g
	end
	d_m  = 1e-3*d_mm;

	tau    = rhow*g./C.^2.*U.^2;
	theta  = tau./(g*(rhos-rhow).*d_m);
end

