% Tue 31 Mar 11:20:24 +08 2020
%
% can be coupled with stage-discharge_parker to predict from slope and unknown roughness
%
function [Qs] = suspended_transport_wright_parker(Chezy,u,h,W,d50_mm,d90_mm,sd_2,d_mm,T_C)
	if (isempty(d_mm))
		d_mm = d50_mm;
	end
	if (isempty(sd_2))
		% note: norminv(0.9)-norminv(0.5) = norminv(0.9)-0
		sd_2 = (log2(d90_mm)-log2(d50_mm))./norminv(0.9);
	end
	rho_s = Constant.density.quartz;
	rho_w = Constant.density.water;
	g     = Constant.gravity;
	d90_m = 1e-3*d90_mm;

	ws    = settling_velocity(d_mm,T_C);

	% skin friction
	ks      = nikuradse_roughness_length(d90_mm,'parker');

	% shear velocity
	us_t    = shear_velocity(u,Chezy);

	% TODO, this equation differs, when the power law is used
	S = us_t.^2/(g*h);

	tau_t   = rho_w*us_t.^2;
	tau_rat = total2skin_stress_ratio(tau_t,[],u,h,'wright-parker-2003');
	tau_s   = tau_t.*tau_rat;
	us_k    = us_t.*sqrt(tau_rat);   	

	% roughness parameter for the velocity profile
	kc = ks.*(tau_t./tau_s).^4;

	% (5) Km : eddy viscosity
	% (2) du_dz =  1./Km*us.^2*(1-eta)	
	% Km    = us*h*a*k*eta*(1-eta); 
	% Km    = us*a*kappa*z*(1-z./h);
	% (3) Ks : eddy diffusity
	% dc_dz = -1./Ks*nu*c;

	c5 = reference_concentration_wright_parker(us_k,ws,S,d_mm,d50_mm,sd_2,T_C);

	a  = stratification_parameter_wright_parker(c5,S);

	Ro = suspension_parameter(us_t,ws,a,'rouse');

	I  = integration_factor_wright_parker(Ro);

	% (1, 15) q = int_d^h u C dz
	if (0)
		qs = 9.70*us.*h./a.*c5.*(h./kc).^(1/6).*I;
	else
		qs = u.*h.*c5.*I;
	end	

	% mass concentration
	qs_m = rho_s*qs;

	% integrated across section
	Qs = W*qs_m;

	Qs(h<=0) = 0;
end

