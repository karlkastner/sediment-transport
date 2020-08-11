% 2018-03-09 12:43:01.261859520 +0100
function theta = shear2shields(tau,d_mm,rho_s)
	if (~issym(tau))
		if (nargin()<3||isempty(rho_s))
		rho_s = Constant.density.quartz;
		end
		rho_w = Constant.density.water;
		g    = Constant.gravity;
	else
		syms rho_s positive
		syms rho_w positive
		syms g positive
	end
	d_m  = 1e-3*d_mm;
	
	theta =	tau./(g*(rho_s-rho_w).*d_m);
end

