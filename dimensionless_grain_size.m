% Tue  9 May 10:24:48 CEST 2017
% Sat Feb 14 15:48:00 CET 2015
% 2016-03-16 14:07:04.353216640 +0100
%% dimensionless grain size
% Karl Kastner, Berlin
% c.f. Julien 5.23e (dimensionless particle diameter)
% c.f. eq 1 in van Rijn
function ds = dimensionless_grain_size(d_mm,rho_s)
	g   = Constant.g;
	if (nargin() < 2 || isempty(rho_s))
		rho_s = Constant.density.quartz;
	end
	rho_w = Constant.density.water;
	nu    = Constant.viscosity.kinematic.water;
	s     = rho_s/rho_w;
	d_m   = 1e-3*d_mm;
	ds    = (g*(s-1)./nu.^2 ).^(1/3).*d_m;
end % dimensionless_grain_size

