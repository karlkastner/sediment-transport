% Tue 28 Apr 20:25:43 +08 2020
function Qb = bedload_transport_bagnold_1973(C,U,H,W,d_mm,T_C)
	rhos = 2650;
	rhow = 1000;
	g = 9.81;
	us  = shear_velocity(U,C);
	tau = rhow*us.^2;
	d_m = 1e-3*d_mm;
	ws  = settling_velocity(d_mm,T_C);
	uc  = critical_shear_velocity(d_mm,T_C);
	% 19
	% qb = a*tau*u./tan_a*(1 - (5.75*log(y/(n*d_m))+ur)./uy);
	% bagnold 1973, above eq 17
	n = 1.4*(us./uc).^0.6;
	tan_a = 0.63;
	% omega = rho*g*Q*S/w;
	% omega = rho*g*H*S/w;
	omega = tau.*U;
	uc = 0;
	qb    = 1./g*(rhos./(rhos-rhow)).*max(0,us-uc)./us.*omega./tan_a ...
		 .*max(0,1 - (5.75*abs(us).*log(0.37*H./(n.*d_mm))+ws)./abs(U));
	Qb    = W.*qb;
end

