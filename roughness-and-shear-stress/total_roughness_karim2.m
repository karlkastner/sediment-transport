% 2020-04-17 01:29:14.710998234 +0800
function [C,n] = total_roughness_karim2(H_d,h,d50_mm)
	d50_m    = 1e-3*d50_mm;
	ks0      = 2.5*d50_m;
	z0_0     = ks2z0(ks0);
	C0       = z02chezy(z0_0,h);
	f0       = chezy2f(C0);
	f        = f0.*(1.20 + 8.92*(H_d./h));
	n        = 0.037*d50_m.^(0.126).*(f./f0).^(0.465);
	C        = manning2chezy(n,h);
end

