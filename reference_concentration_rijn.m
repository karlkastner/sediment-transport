% Wed 10 May 09:42:56 CEST 2017
% function ca = reference_concentration_rijn(d50_mm,a,T,T_C)
function ca = reference_concentration_rijn(d50_mm,a,T,T_C)
	%  1. eq.   1 particle diameter
	ds    = dimensionless_grain_size(d50_mm,T_C);
	d50_m = 1e-3*d50_mm;
	ca    = 0.015*d50_m./a.*ds.^-0.3.*T.^1.5;
end


