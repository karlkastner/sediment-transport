% Ts = tau./tau_c
function [Hd,Ld] = dune_dimension_yalin(h,Ts)
	Hd = 1/6*(1 - 1./Ts);
	Ld = 5*h;
end


