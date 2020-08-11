% Wed 10 May 09:42:56 CEST 2017
%% grain size of the suspended sediment according to van rijn, empirical
% eq 11.81 in Delft3D-Flow manual 2014
% TODO there is a limit for T<1 as 0.64 D50
function ds = suspended_grain_size_rijn(d50_mm,sd,T)
	if (isempty(sd))
		sd = 2.5;
	end
	d50_m = 1e-3*d50_mm;
	% Fig 16, ds increases with T
	ds    = (1 + 0.011*(sd-1).*(T-25)).*d50_m;
	% Note: D3D has: factored sd in :
%	ds    = (1 + 0.015*(T-25)).*d50_m
	%ds(T>25) = d50_m;
	% do not allow for coarsening beyond d50
	ds = min(ds,d50_m);
	%ds = max(ds,d50_m);
	ds    = 1e3*ds;
	df(~isfinite(T)) = NaN;
end

