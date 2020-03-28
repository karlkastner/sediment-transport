% Fri 27 Mar 15:15:45 +08 2020
function nt = grain_rougness_wu(d50_mm)
	d50_m = 1e-3*d50_mm;
	% below eq 3.80
	nt = 1/20*d50_m.^(1/6);
end
