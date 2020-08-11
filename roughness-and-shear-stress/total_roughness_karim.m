% Wed  1 Apr 18:11:30 +08 2020
function [C,H_d,n,f] = total_rouhness_karim(u,h,d50_mm,T_C)
	reltol   = 1e-2;
	maxiter  = 100;

	d50_m    = 1e-3*d50_mm;
	ks0      = 2.5*d50_m;
	z0_0     = ks2z0(ks0);
	C0       = z02chezy(z0_0,h);
	f0       = chezy2f(C0);
	
	% initial value
	%C = 2*C0;
	% f = 1.2*f0*
	H_d = 0.2*h;
	% relaxation
	p = 0.5;
	k = 0;
	while (1)
		k     = k+1;
		H_old = H_d;
		f    = f0*(1.20 + 8.92*(H_d./h));
		n     = 0.037*d50_m.^(0.126).*(f./f0).^(0.465);
		C     = manning2chezy(n,h);
		H_d   = dune_height_karim(C,u,h,d50_mm,T_C);
		H_d   = p*H_d + (1-p)*H_d;
		rms_  = rms(H_d - Hold);
		if (rms_ < p*reltol*rms(f) || isnan(rms_))
			break;
		end
		if (k > maxiter)
			break;
		end
	end
end % total_roughness_karim

