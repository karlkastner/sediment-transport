% 2019-05-12 17:28:31.562709808 +0800
% inomplete
function suspended_sediment_transport_mclean()
	% 1
	qs = Ca*ubar*h*I;
	% 2
	% I = 1/h*int_a^h u/ubar Cs/Ca dz

	gamma0 = 0.004;
	cb = 0.6;
	Ca = gamma0*cb*S/(1+gamma0*S);
end
