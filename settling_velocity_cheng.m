% 2017-05-17 17:53:45.763056219 +0200
%% settling velocity according to cheng
% c.f. sassi
function w = settling_velocity_cheng(d)
	% mm to m
	d = 1e-3*d;
	nu = Constant.viscosity.kinematic.water;
	a = 32;
	B = 1;
	M = 1.5;
	d_s = dimensionless_grain_size(d);
	w = nu./d.*(sqrt(1/4*(a/B).^(2/M) + (4/3*d_s.^3./B).^(1/M)) - 1/2*(a/B).^(1/M)).^M;
end
