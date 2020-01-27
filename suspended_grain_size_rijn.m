% Wed 10 May 09:42:56 CEST 2017
%% grain size of the suspended sediment according to van rijn, empirical
function ds = suspended_grain_size_rijn(d50_mm,sd,T)
	if (isempty(sd))
		sd = 2.5;
	end
	d50_m = 1e-3*d50_mm;
	ds    = (1 + 0.011*(sd-1).*(T-25)).*d50_m;
	%ds(T>25) = d50_m;
	ds = min(ds,d50_m);
	ds    = 1e3*ds;
	df(~isfinite(T)) = NaN;
end

