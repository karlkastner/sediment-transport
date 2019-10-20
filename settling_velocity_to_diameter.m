% Fri 19 May 13:37:09 CEST 2017
%% invert settling velocity to diameter
function d = settling_velocity_to_diameter(w,mode)
	if (nargin()<2)
		mode = '';
	end
	rhow = 1000;
	rhos = 2650;
	g    = 9.81;
	nu   = Constant.viscosity.kinematic.water;
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

