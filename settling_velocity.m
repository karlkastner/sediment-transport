% Tue  9 May 10:25:13 CEST 2017
%% Settling velocity
%% 5.23d in julien-2010
% d given in mm
% function ws = settling_velocity(d)
function ws = settling_velocity(d)
	nu = Constant.viscosity.kinematic.water;
	% mm to m
	d = d*1e-3;
	ds = dimensionless_grain_size(d);
	ws = 8*nu./d.*(sqrt(1 + 0.0139*ds.^3) - 1);
end

