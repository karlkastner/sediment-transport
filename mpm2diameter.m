% Wed  1 Jan 19:26:27 +08 2020
%function d = mpm2diameter(Qb,Q,W,n,S)
% Note that this function is invalid for when the original transport is
% computed with multiple fractions, when for any tau < tau_c
function d_mm = mpm2diameter(Qb,Q,W,n,S)
	g    = 9.81;
	rho_s = 2650;
	rho_w = 1000;
	tc = 0.047;
	
	U = normal_flow_velocity(Q,W,n,S,true);
	H = normal_flow_depth(Q,W,n,S,true);
	C = manning2chezy(n,H);
	%us   = normal_shear_velocity(Q,W,n,S,true);

	%d = 1/tc*( us.^2./(g*(rho_s/rho_w-1)) - (Qb./(8*W*rho_s*(g*(rho_s/rho_w-1))^(1/2))).^(2/3))
	d_m = 1/tc*( (U./C).^2/(rho_s/rho_w - 1) - ( Qb./(8*rho_s*W*sqrt(g*(rho_s/rho_w - 1))) ).^(2/3)  ); 
	d_mm = 1e3*d_m;
end

