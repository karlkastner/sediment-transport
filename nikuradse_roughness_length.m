% Wed 29 Apr 11:01:44 +08 2020
function ks = nikuradse_roughness_length(d_mm,method)
	switch (method)
	case {'parker'}
		d90_m = 1e-3*d_mm;
		ks    = 3*d90_m;
	otherwise
		error('here');
	end
end
