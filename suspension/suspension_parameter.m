% Wed 10 May 09:42:56 CEST 2017
% Tue 31 Mar 12:20:14 +08 2020
% corrected rouse number
function ret = suspension_parameter(ws,us,ca,method)
	kappa = Constant.Karman;

	switch (method)
	case {'rouse'}
		if (isempty(ca))
			a = 1;
		else
			a = ca;
		end
		Ro = ws./(a.*kappa.*us);
		%zt = ws./(kappa*us);
		ret = Ro;
	case {'rijn'}
		% packing density of spheres (maximum concentration)
		c0 = Constant.packing_density.spheres;

		% TODO this should be a
		beta = stratification_parameter_rijn(ws,us);
	
		% 10. eq. 34 stratification correction
		phi = 2.5*abs(ws./us).^0.8.*(ca./c0).^0.4;
	
		% 11. eq. 3 and 33 suspension parameter, aka rouse number
		z  = ws./(beta.*kappa.*abs(us));
		zt = z + phi;

		% same limitation as in d3d
		zt = min(20,zt);
		ret = zt;
	otherwise
		error('here');
	end
end

