% Tue 28 Apr 21:58:49 +08 2020
% THIS IS FOR WIND (!)
% c.f. state of the cost of sand diego
function Qs = bedload_transport_bagnold_1941(C,U,W,H,d_mm)
	rho_w = 1000;
	g = 9.81;
	us = shear_velocity(U,C);
	tau = rho_w.*us.^2;
	omega = tau.^2.*U;
	% note that C scales with the std of the gsd	
	C = 1.8;
	d_um = 1e3*d_mm;
	K = C.*sqrt(d_um/250);
	j = 1/g.*K.*omega;
	c0 = 0.65;
	qs_m = j*c0;
	%qs_v = qs_m/rho_s;
	Qs = W.*j;
	Qs = Qs/rho_w;
end
