% rijn, bagnold
% c: volumetric concentration
function f=viscosity_correction(c)
	lambda = 1./((0.74./c).^(1/3) - 1);
	% nu' = f*nu
	f = (1+lambda).*(1 + 0.5*lambda);
end
