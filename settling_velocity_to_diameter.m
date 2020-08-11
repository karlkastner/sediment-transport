% Fri 19 May 13:37:09 CEST 2017
%% invert settling velocity to diameter
function d = settling_velocity_to_diameter(w,T_C,mode)
	if (nargin()<3)
		mode = '';
	end
	rhow = Constant.density.water;
	rhos = Constant.density.quartz;
	g    = Constant.gravity;
	nu   = Constant.viscosity_kinematic_water(T_C);
	s    = rhos/rhow;
	a    = 8*nu;
	b    = 0.0139*(g*(s-1)./nu.^2);
	d    = (w.^2 + sqrt(w.*(8*b.*a.^3 + w.^3)))./(2*a.^2.*b);

	% m to mm
	d = d*1e3

	switch (mode)
		case {'cheng'}
		d = fzero(@(d) settling_velocity_cheng(d) - w,d);
	end
end

