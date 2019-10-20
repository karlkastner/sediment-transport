% 2016-03-16 14:08:29.842728937 +0100
%% dynamic shear stress
function tau_bf = dynamic_shear_stress(d50,S)
	beta   = 1220;
	m      = 0.53;
	ds     = dimensionless_grain_size(d50)
	tau_bf = beta / ds * S^m;
end


