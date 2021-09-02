% Fri 17 Apr 17:24:33 +08 2020
% c.f. Ji-Sung KIM 2010
function [ks_m,n,C] = grain_roughness_nikuradse(d_mm,R,method)
	if (nargin()<3)
		method = 'default';
	end
	% strickler-type equations
	switch (method)
	case {'strickler'}
		d50_m = 1e-3*d_mm;
		n    = 0.047*d50_m.^(1/6);
		ks_m = manning2kc(n,R);
		C    = manning2chezy(n,R);
	case {'mpm'}
		n    = 0.038*d90_m.^(1/6);
		ks_m = manning2kc(n);
		C    = manning2chezy(n,R);
	case {'keulegan-1938'}
		n    = 0.039*d50_m.^(1/6);
		ks_m = manning2kc(n);
		C    = manning2chezy(n,R);
	case {'bray-1979-d50'}
		n    = 0.0593*d50_m.^(0.179);
		ks_m = manning2kc(n);
		C    = manning2chezy(n,R);
	case {'bray-1979-d90'}
		n    = 0.0495*d50_m.^(0.16);
		ks_m = manning2kc(n);
		C    = manning2chezy(n,R);
	case {'default'}
		% log-law, d = d50
		d_m   = 1e-3*d_mm;
		ks_m  = 2.5*d_m;
		z0    = ks2z0(ks_m);
		C     = z02chezy(z0,R);
		n     = chezy2manning(C,R);
	end % switch
end % end

