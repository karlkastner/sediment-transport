% Thu 25 Jul 11:21:11 CEST 2019
%% critical aspect ratio of a bifurcation
%% c.f. redolfi and pittaluga
function [beta_c,a_c,a_0,C,Ct,Phi] = bifurcation_critical_aspect_ratio(Q,w,h,d_mm)

	% baar 2018 - odd reference, should come from earlier sources (as used in 2003)
	r = 0.5;
	g     = Constant.gravity;
	rho_w = Constant.density.water;
	rho_s = Constant.density.quartz;

	Delta  = (rho_s-rho_w)/rho_w;
	d_m    = 1e-3*d_mm;
	U      = Q./(w.*h);
	beta_0 = w./h;

	[C,Ct] = total_roughness_engelund_fredsoe(d_mm,h,Q/(w*h));

	h0 = h;
	% note that c_D = C_D, as it is a ratio
	[C_D] = h0./C.*grad(@(h_) total_roughness_engelund_fredsoe(d_mm,h_,Q/(w*h0)),h0)
	c_D = C_D;	

	% skin friction
	%[Ct, C_D] = chezy_roughness_engelund_fredsoe(d_mm,h);
	%u_s     = U.*sqrt(g)./Ct;
	%tau_b   = rho_w*u_s.^2;

	S       = (U.^2./(C.^2.*h));
	theta   = S.*h./(Delta.*d_m);

	% total friction
	%[theta,C,h_] = skin_2_total_friction_eh(theta_t,Ct,h);
	
	% normalize
	c   = 1/sqrt(g)*C;
	%c_D = 1/sqrt(g)*dC_dh_rel;
	
	% B5 in Redolfi 2019
	%[Phi, Phi_D, Phi_T] = sediment_transport_engelund_hansen_2(d_mm,h,theta);
	[Phi, Phi_D, Phi_T] = sediment_transport_engelund_hansen_2(C,C_D,h,d_mm,theta)

	% eq 14 in Redolfi 2019
	% resonand aspect ratio
	beta_r = pi/sqrt(8)*c.*sqrt(r)./theta.^0.25.*1./sqrt(Phi_D+Phi_T-(3/2+c_D));

	% eq. 12 in Redolfi 2019
	% beta_c = r*a/sqrt(theta_0)*4/(phi_d + phi_T - (3/2 + c_D))
	beta_c = beta_r;
	a_c = beta_c./(r./sqrt(theta).*4./(Phi_D + Phi_T - (3/2 + c_D)));
	a_0 = beta_0./(r./sqrt(theta).*4./(Phi_D + Phi_T - (3/2 + c_D)));
end

