% 2017-05-10 14:51:17.695439960 +0200
%% grain roughness (skin friction) according to van Rijn
% function rgh = grain_roughness_rijn(d90,R)
function rgh = grain_roughness_rijn(d90_mm,R_m)
	% mm to m
	d90_m = 1e-3*d90_mm;

%	d90 = Expanding_Double(d90);
%	R   = Expanding_Double(R);

	rgh.ks    = 3*d90_m;
	% rgh.z0    = rgh.ks/30;
	rgh.z0    = ks2z0(rgh.ks);

	if (nargin()>1)
		g     = Constant.gravity;
		%kappa = Constant.Karman;
		% original equation by van rijn:
		% Ct  = 18.0*log10(4*R./d90);
		% sqrt(g)/kappa*log(10) ~ 18
		% R/(e z0) = 30 R/(e ks) = 10/e R/d90 ~ 4 
		% rgh.C  = sqrt(g)/kappa*(log(R./rgh.z0) - 1);
		%rgh.C = double(z02chezy(rgh.z0,R_m));
		rgh.C  = z02chezy(rgh.z0,R_m);
		rgh.cd = g*rgh.C.^(-2);
		rgh.n  = chezy2manning(rgh.C,R_m);
	end
end

