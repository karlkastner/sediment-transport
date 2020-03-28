% 2017-05-20 18:10:42.399224785 +0200
% 2019-05-12 17:28:31.562709808 +0800
%% vertical profile of the suspended sediment according to McLean
% mclean 1992
% form drag influence on sediment concentration profile?
% TODO, take care of sign of u!
% TODO the matrix should actually become 3d with multiple fractions
function [Cn, Cna, a] = vertical_ssc_profile_mclean(chezy,u,h,z,d50_mm,d84_mm,d_mm,p)
	if (isempty(d_mm))
		d_mm = d50_mm;
	end

	a0     = 0.056;
	ad     = 0.12;
	% volume concentration in bed (packing density of spheres)
	Cb     = 0.6;
	gamma0 = 0.004;
	kappa  = 0.41;

	% shear velocity
	us = shear_velocity(u,chezy);

	% eq 2
	% settling velocity for each fraction
	wn = settling_velocity(cvec(d_mm));

	% rouse number
	Ro = cvec(wn)./(kappa*rvec(us));

	% Transport stage and excess shear stress
	% Ts mclean = Ts_vanrijn + 1
	[Ts,S] = transport_stage_mclean(u,h,d50_mm);

	% bed load layer thickness
	% it is unclear, that this is here really d84 and not d50
	% p 5767 
	delta_B_mm = bedload_layer_thickness_mclean(d84_mm,Ts);
	% z0 = max(ad*D84,a0*delta_B);
	% z0 = a0*delta_B;
	z0 = chezy2z0(chezy,h);

	% reference depth
	a = 1e-3*delta_B_mm;

	% multible fractions vs single fractions
	if (length(d_mm)>1)
		% critical shear stress is similar to D50 for all grains if sediment is sand
		% (because grains bounce at each other and a grains in the bed layer move simultaneously)
		% critical shear velocity
		tau_c   = critical_shear_stress(d50_mm);
		usc     = 1./rho_w*sqrt(tau_c);
		Fn      = ones(np,1);
		fdx     = (us < wn);
		Fn(fdx) = (us - usc)./(wn(fdx) - usc);

		% weigh fraction (itn in mclean)
		itn = Fn.*p/sum(Fn*p)
	else
		itn = 1;
	end

	% eq 31 reference concentration
	Cna = itn*(gamma0*Cb*S)./(1 + gamma0*S);
	Cna(:,S<0) = 0;

	% eq 15 concentration along vertical for each fraction
	% Cn = Cna*(a/z*(h-z)/(h-a)).^Ro;
	%Cn = bsxfun(@power,bsxfun(@times,Cna,(a./z.*((h-z)./(h-a)))),Ro);
	Cn = Cna.*((rvec(a)./z).*(rvec(h)-z)./(rvec(h)-rvec(a))).^rvec(Ro);

	% total concentration along z
	%C = sum(Cn,2);

	% mean grain diameter along z
	%d_bar = 1./C*(Cn*d);
end % vertical_ssc_profile_mclean

