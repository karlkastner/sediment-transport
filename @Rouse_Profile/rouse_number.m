% 2018-07-07 14:39:22.873696444 +0200
%
%% rouse number (suspension number) for given grain siye and shear velocity
% function [ro, obj] = rouse_number(D,us)
%
function [ro, obj] = rouse_number(obj,d_mm,us)
	% prandtl schmidt number
	beta = 1;
	ws = obj.fun.settling_velocity(d_mm);
	ro = ws./(Constant.Karman*beta*us);
end

