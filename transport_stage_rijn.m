% 2017-05-10 17:20:14.017992792 +0200
% Karl Kastner, Berlin
%% transport stage as defined by van Rijn
function T = transport_stage_rijn(d50_mm,d90_mm,R,U)
	g    = Constant.g;
	rhow = Constant.density.water;

	% mm to m
%	d50 = 1e-3*d50;
%	d90 = 1e-3*d90;

	d50_mm   = Expanding_Double(d50_mm);
	d90_mm   = Expanding_Double(d90_mm);
	R        = Expanding_Double(R);
	U        = Expanding_Double(U);

	% 2 critical shear velocity (Fig. 1)
	tau_c = critical_shear_stress(d50_mm);

	% critical shear velocity squared
	usc2  = 1/rhow*tau_c;

	% 3 q 18 particle chezy coefficient
	rgh   = grain_roughness_rijn(d90_mm,R);
	%Ct    = grain_chezy_rijn(R,1e3*d90);
	Ct    = rgh.C;
	% 4 eq 17 particle shear velocity squared
	% ust2  = g./Ct.^2.*U.^2;
	ust2  = g./Ct.^2.*U.^2;
	% rijn-sl step 3 eq. 2 transport stage parameter
	% rijn-bl step 5 eq  2 transport stage
	% c.f. wu 3.57
	T     = (ust2./usc2) - 1;
	% apply limit (this is not explicitely stated by  van Rijn, but necessary)
	T     = max(0,T);
end

