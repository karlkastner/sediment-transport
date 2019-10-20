% Wed 10 May 09:42:56 CEST 2017
%% grain size of the suspended sediment according to van rijn, empirical
function ds = suspended_grain_size_rijn(d50,sd,T)
	if (isempty(sd))
		sd = 2.5;
	end
	% TODO what if T>25? or sd < 1?
	ds = (1 + 0.011*(sd-1).*(T-25)).*d50;
end

