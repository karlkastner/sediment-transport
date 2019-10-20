% 2018-07-07 14:39:22.873696444 +0200
%
%% rouse number
% function [ro, obj] = rouse_number(D,us)
%
function [ro, obj] = rouse_number(D,us)
	% prandtl schmidth number
	beta = 1;
	ws = settling_velocity(D);
	ro = ws/(Constant.Karman*beta*us);
end

