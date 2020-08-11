% Thu 12 Jul 12:40:31 CEST 2018
%
%% convert known rous number (suspension parameter) to grain size diameter
% function [ro, obj] = rouse_number(ro,us)
%
function [D, ws, obj] = rouse_number_to_grain_diameter(ro,us)
	% prandtl schmidth number
	beta = 1;
%	ws = settling_velocity(D);
%	ro = ws/
	ws = ro*(Constant.Karman*beta*us);
	D = settling_velocity_to_diameter(ws);
end

