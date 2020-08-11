% 2017-05-20 18:10:42.399224785 +0200
% 2019-05-12 17:28:31.562709808 +0800
% note that there is a circular dependence in McLean,
% as z0_f depend on delta_B and delta_B via transport stage z0_f
% z0_f = a_0 (= 0.056) delta_B (17, p 5761)
% which he resolves by introducing the alternative roughness height of
% z0_f = a_D (=0.12) D_84 on p 5766
function z0_f = roughness_height_mclean(d84_mm,U,H,d50_mm,T_C)
	maxiter = 10;

	a0      = 0.056;
	a_D84   = 0.12;
if (1)
	% z0 ~ d50_mm / 30
	d84_m = 1e-3*d84_mm;
	z0_f = d84_m/10;
else

	% initial value
	d84_m   = 1e-3*d84_mm;
	z0_f    = a_D84*d84_m
	z0_f_   = z0_f;
	k       = 1;
	while (k < maxiter)
		k  = k+1;
		Ts = transport_stage_mclean(U,H,z0_f,d50_mm,T_C);
		% 
		%dB_mm = bedload_layer_thickness_mclean(d84_mm,Ts);
		dB_mm = bedload_layer_thickness_mclean(d84_mm,Ts);
		z0_f  = a0*1e-3*dB_mm;
	end
	z0_f
	z0_f = max(z0_f,z0_f_);
tau_f = 2.39;
tau_c = 0.146; % N/m^2
pause
end
end

