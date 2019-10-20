% Wed 10 May 11:14:33 CEST 2017
%% bed load transport according to engelund and fredsoe
% c.f wu
% function [Qb, qb, Phi_b] = bed_load_engelund_fredsoe(C,d,U,H,W)
function [Qb, qb, Phi_b] = bed_load_engelund_fredsoe(C,d_mm,U,H,W)
	g    = Constant.gravity;
	rhow = Constant.density.water;
	rhos = Constant.density.quartz;
	s    = rhos/rhow;
	theta_c = critical_shear_stress_ratio(d_mm);
	% mm to m
	d = 1e-3*d_mm;
	% shear stress
	tau   = rhow*g./C.^2.*U.^2;
	% shear stress ratio
	theta = tau./(g*(rhos-rhow).*d);
	% transport capacity
	Phi_b = 11.6*sign(U).*max(0,theta - theta_c).*max(0,sqrt(theta)-0.7*sqrt(theta_c));
	% volumentric transport per unit  width
	qb_v   = sqrt(g*(s-1).*d.^3).*Phi_b;
	% mass transport
	qb     = rhos*qb_v;
	% tranport through cross section
	Qb     = qb.*W;
end

