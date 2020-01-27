% Mon  6 Jan 19:50:13 +08 2020
function n = grain_roughness_mpm(d90_mm)
	d90_m = 1e-3*d90_mm;
	n = d90_m.^(1/6)/26;
end
