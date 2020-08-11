% Fri 27 Dec 14:04:21 +08 2019
% scales non-dimensional transport to transport
% per unit width
function scale = sediment_transport_scale(d_mm)
	if (~issym(d_mm))
		g     = Constant.gravity;
		rho_s = Constant.density.quartz;
		rho_w = Constant.density.water;
	else
		syms g rho_s rho_w
	end
	d_m   = 1e-3*d_mm;
	scale = sqrt(g*(rho_s/rho_w-1).*d_m.^3);
end

