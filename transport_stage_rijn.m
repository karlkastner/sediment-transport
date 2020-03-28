% 2017-05-10 17:20:14.017992792 +0200
% Karl Kastner, Berlin
%% transport stage as defined by van Rijn
% function T = transport_stage_rijn(d50_mm,d90_mm,R,U)
function T    = transport_stage_rijn(d50_mm,d90_mm,R,U,T_C)
	g     = Constant.g;
	rho_w = Constant.density.water;

	% 2 critical shear stress (Fig. 1)
	tau_c = critical_shear_stress(d50_mm,T_C,'rijn');

	% critical shear velocity squared
	usc2  = tau_c/rho_w;

	% 3 q 18 particle chezy coefficient
	rgh   = grain_roughness_rijn(d90_mm,R);
	Ct    = rgh.C;

	% 4 eq 17 particle shear velocity squared
	ust2  = g./Ct.^2.*U.^2;
	% rijn-sl step 3 eq. 2 transport stage parameter
	% rijn-bl step 5 eq  2 transport stage
	% c.f. wu 3.57

	if (1)
		ef = 1;
	else
		% efficient factor introduced in vr 1993
		% C_user : effective roughness height specified by the user
		%ks = z02ks(chezy2z0(C_user));
		ks = 0.01; % rdc
		% efficiency factor
		d90_m = 1e3*d90_mm;
		ef = ( log(12*R./ks) ./ log(4*R./d90_m) ).^2;
	end
	T = (ef*ust2./usc2) - 1;

	% apply limit (this is not explicitely stated by  van Rijn, but necessary)
	fdx    = isfinite(T);
	T(fdx) = max(0,T(fdx));
end

