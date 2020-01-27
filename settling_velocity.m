% Tue  9 May 10:25:13 CEST 2017
%% Settling velocity
%% 5.23d in julien-2010
% d given in mm
% function ws = settling_velocity(d)
function ws = settling_velocity(d_mm)
	nu = Constant.viscosity.kinematic.water;
	ds = dimensionless_grain_size(d_mm);
	% mm to m
	d_m = 1e-3*d_mm;
	ws = 8*nu./d_m.*(sqrt(1 + 0.0139*ds.^3) - 1);
end

