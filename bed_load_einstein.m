% Wed 10 May 12:06:22 CEST 2017
% Karl Kastner, Berlin
%% bed load transport according to einstein jr.
% function [Qb, qb, Phi_b] = bed_load_transport_einstein(C,d_mm,U,H,W,varargin)
function [Qb, qb, Phi_b] = bed_load_transport_einstein(C,d_mm,U,H,W,varargin)
	g    = Constant.gravity;
	rhow = 1000;
	rhos = 2650;
	s     = rhos/rhow;
	% mm to m
	d = 1e-3*d_mm;
	% shear stress
	%tau   = rhow*g./C.^2.*U.^2;
	% shear stress ratio
	%theta = nondimensional_shear_stress(d_mm,tau);
	%theta = tau./(g*(rhos-rhow).*d)
	theta = shields_number(C,U,d_mm,varargin{:});
	% transport capacity
	Phi_b = 8*sign(U).*max(0,theta - 0.047).^(3/2);
	% volumetric transport
	qb_v  = sqrt(g*(s-1).*d.^3).*Phi_b;
	% mass transport per unit width
	qb    = rhos.*qb_v;
	% mass transport through cross section
	Qb    = W*qb;
end

