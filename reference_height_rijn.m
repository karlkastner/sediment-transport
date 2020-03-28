% Wed 10 May 09:42:56 CEST 2017
function a = reference_height_rijn(dune_height,d)
	a     = 0.5*dune_height;
	a     = max(a,0.01*d);
	% 11.25 in d3d manual
	a     = min(a,0.2*d);
end

