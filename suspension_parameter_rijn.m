% Wed 10 May 09:42:56 CEST 2017
% corrected rouse number
function zt = suspension_parameter_rijn(ws,us,ca)
	kappa = Constant.Karman;

	%  9. eq.  22 beta-factor, inverse of Prandtl-Schmidt-Number
	% note : was implemented as min 2, beta
	% note in eq the limit ws = us -> beta = 3 is given
	% but on page 1634, ws=1/2 us -> beta = 1.5 is given
	beta = min(1.5, 1 + 2*(ws./us).^2);

	% packing density of spheres (maximum concentration)
	c0 = Constant.packing_density.spheres;

	% 10. eq. 34 stratification correction
	phi = 2.5*abs(ws./us).^0.8.*(ca./c0).^0.4;

	% 11. eq. 3 and 33 suspension parameter, aka rouse number
	z  = ws./(beta.*kappa.*abs(us));
	zt = z + phi;
	% same limitation as in d3d
	zt = min(20,zt);
end
