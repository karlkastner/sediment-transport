% 2018-03-09 12:43:01.261859520 +0100
%% normalized shear stress, shear stress ratio
% 	theta = shields_number(C,U,d_mm,rho_s,rho_w)
function theta = shields_number(C,U,d_mm,rho_s)
	if (~issym(C))
		g    = Constant.gravity;
		rho_w = Constant.density.water;
	else
		syms g rho_w positive 
	end
	if (nargin()<4)
		rho_s = [];
	end

	tau    = rho_w*g./C.^2.*U.^2;
	theta  = shear2shields(tau,d_mm,rho_s);
end

