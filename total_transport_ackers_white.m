% Fri 27 Mar 21:01:29 +08 2020
function Qs = total_transport_aw(C,d_mm,U,H,W,T_C)
	if (~issym(C))
		g     = Constant.gravity;
		rho_s = Constant.density.quartz;
		rho_w = Constant.density.water;
		nu = Constant.viscosity_kinematic_water(T_C);
	else
		syms g rho_s rho_w nu positive
	end
	d_m   = 1e-3*d_mm;
	%ds    = d_m.*((rho_s/rho_w - 1 )*g./nu.^2).^(1./3)
	ds    = dimensionless_grain_size(d_mm,T_C,rho_s);
	us    = shear_velocity(U,C);

	if (ds > 60)
		n  = 0;
		Ac = 0.17;
		m  = 1.5;
		lambda = 0.025;
	else
		n  = 1.0 - 0.56*log10(ds);
		Ac = 0.23*ds.^(-1/2) + 0.14;
		m  = 9.66./ds + 1.34;
		lambda = exp10(-3.53 + 2.86*log10(ds) - log10(ds).^2);
	end

	Fgr = us.^n./sqrt((rho_s./rho_w-1)*g*d_m).*(  U ./ (sqrt(32).*log10(10*H./d_m) ) ).^(1-n);
	Ggr = lambda.*max(0,Fgr./Ac - 1).^m;
	Ct  = rho_w*Ggr.*d_m.*(rho_s./rho_w)./H.*(U./us).^n;
	Qs  = Ct.*U.*H.*W;

	Qs(H<=0) = 0;
end

