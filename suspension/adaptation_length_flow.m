% Fri  9 Mar 11:27:17 CET 2018
%% adaption length of the flow
% struiksma 1985
function lw = adaptation_length_flow(C,H)
	if (~issym(C))
		g = Constant.gravity;
	else
		syms g
	end
	lw = C^2/(2*g)*H;	
end

