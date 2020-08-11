% Wed  1 Apr 17:34:18 +08 2020
% karim 1998
function Qs = total_transport_karim(C,u,h,w,d50_mm,T_C)
	d_mm = d50_mm;
	d50_m = 1e-3*d50_mm;

	rho_s = 2650;
	rho_w = 1000;
	g    = 9.81;
	s = (rho_s./rho_w-1);

	di   = 1e-3*d_mm;
	if (0)
		pai = (pi./di)./(sum(pi./di));
	else
		pi_  = 1;
		pai = 1;
		wsi = settling_velocity(1e3*di,T_C);
	end
	
	us = shear_velocity(u,C);

	c1  = 1.15*(wsi./us);
	c2  = 0.60*(wsi./us);
	eta = c1.*(di./d50_m).^c2;
	phii = pai.*eta;
	Phii_ = 0.00139*(u./sqrt(g*(s-1).*di)).^2.97.*(us./wsi).^1.47.*phii;

	qsi = sqrt(g.*(s-1).*di.^3).*Phii_;
	qs_m = rho_s.*qsi;
	Qs   = w.*qs_m;

	Qs(h<=0) = 0;
end

