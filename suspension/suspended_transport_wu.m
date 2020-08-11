% widthed 24 May 14:11:35 CEST 2017
% Karl Kastner, Berlin
%% suspended sediment transport according to widthu
function [Qs,Phi_sk] = suspended_transport_wu(C,d_mm,U,width,T_C)
	ws   = settling_velocity(d_mm,T_C);
	d_m   = 1e-3*d_mm;
	rho_s = 2650;
	rho_w = 1000;
	g     = 9.81;

	pbk  = 1; 

	us  = shear_velocity(U,C);
	tau = rho_w.*us.^2;

	tau_ck  = critical_shear_stress(d_mm,T_C,'wu');

	% 3.102 
	% non-dimensional transport
	Phi_sk = 2.62e-5*(max(tau./tau_ck-1,0).*U./ws).^1.74;

	% volumetric transport per unit width
	%scale = sqrt(g*(rho_s/rho_w-1)*d_m.^3)
	scale = sediment_transport_scale(d_mm);
	qs_v = pbk.*scale.*Phi_sk;

	% mass transport
	qs_m = rho_s*qs_v;

	% total mass transport
	Qs = width*qs_m;
end
	
