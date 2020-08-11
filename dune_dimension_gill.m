
function dune_dimension_gill(h,Fr,Ts)
	eta  = 3;
	beta = 1/2;
	H = h*max(0,1-Fr^2)/(2*eta*beta)*(1-1./Ts);
end


