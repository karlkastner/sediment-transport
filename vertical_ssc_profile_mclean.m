% 2017-05-20 18:10:42.399224785 +0200
%% vertical profile of the suspended sediment according to McLean
% Ts mclean = Ts_vanrijn + 1
function [C, dmu, Cn] = vertical_profile(C,p,d,W,H,U,z)
	
	% volume concentration in bed (packing density of spheres)
	Cb     = 0.6
	gamma0 = 0.004
	ad     = 0.12;
	a0     = 0.056;

	% shear velocity
	us = sqrt(g)/C*U;

	% settling velocity
	wn = settling_velocity(d);

	% excess shear stress
	S  = transport_stage_mclean(d50,H,U);

	% bed layer thickness
	delta_B = bed_layer_thickness(d84,Ts);
	
	% z0 = max(ad*D84,a0*delta_B);

	% critical shear stress is similar to D50 for all grains if sediment is sand
	% (because grains bounce at each other and a grains in the bed layer move simultaneously)
	% critical shear velocity
	us   = critical_shear_stress(d50);
	Fn   = ones(np,1);
	fdx  = (us < wn);
	Fn(fdx)   = (us - usc)./(wn(fdx) - usc);
	
	% weigh fraction (itn in mclean)
	ptn = Fn.*p/sum(Fn*p)

	% eq 31 reference concentration
	Cna = itn*(gamma0*Cb*S)./(1 + gamma0*S);

	% rouse number
	Ro = wn./(0.4*us);

	% reference depth
	a = delta_B;

	% concentration along depth (eq 15)
	% Cn = Cna*(a/z*(h-z)/(h-a)).^Ro;
	Cn = bsxfun(@power,bsxfun(@times,Cna,(a./z.*(h-z)./(h-a))),Ro);

	% total concentration along z
	C = sum(Cn,2);
	% mean grain diameter along z
	d = 1./C*(Cn*d);

	% total transport
	% u = log(z/z0)
	z0  = H/(exp(kappa*C/sqrt(g) + 1);
	u   = us/kappa*log(z./z0);
	qsz = u.*C;
	qs  = sum(qz);

	% TODO load averaging
end % vertical_profile_mclean

