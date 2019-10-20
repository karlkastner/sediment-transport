% Wed 10 May 09:42:56 CEST 2017
% Karl Kastner, Berlin
%% suspended load transport according to van Rijn
% sd : geometric standard deviation
% function [Qs qs Phi] = suspended_transport_rijn(C,d50,d90,sd,U,d,b,dune_height)
%
function [Qs_m, qs_m, Phi] = suspended_transport_rijn(C,d50,d90,sd,U,d,b,dune_height)
	g     = Constant.gravity;
	kappa = Constant.Karman;
	rhos  = Constant.density.quartz;
	rhow  = Constant.density.water;
	s     = rhos/rhow;


	% implicit use of bsxfun
	C   = Expanding_Double(C);
	d50 = Expanding_Double(d50);
	d90 = Expanding_Double(d90);
	U   = Expanding_Double(U);
	d   = Expanding_Double(d);
	b   = Expanding_Double(b);
	
	d50   = 1e-3*d50;
	d90   = 1e-3*d90;

	%  1. eq.   1 particle diameter
	ds    = dimensionless_grain_size(d50);

	% hydraulic radius according to Vanoni-Brooks
	R     = (b.*d)./(b+2*d);
	R     = max(R,0);

	%  3. eq.   2 transport stage parameter
	%  uses 2. eq.   - critical bed-shear velocity according to Shields	
	T = transport_stage_rijn(1e3*d50,1e3*d90,R,U);

	%  4. eq.  37 refrence level
	if (nargin() < 8 || isempty(dune_height))
		dune_height = bedform_dimension_rijn(d,1e3*d50,T);
	end
	dune_height = Expanding_Double(dune_height);
	
	a     = 0.5*dune_height;

	%  5. eq. 38 reference concentration
	%ca    = 0.015*d50./a.*T.^1.5.*ds.^-0.3;
	ca    = 0.015*d50./a.*ds.^-0.3.*T.^1.5;
	ca(0 == a) = 0;

	%  6. eq.  39 particle size of suspended sediment
	d_suspended = suspended_grain_size_rijn(d50,sd,T);
	%  7. eq.  11,12,13 fall velocity of suspended sediment
	ws = settling_velocity(1e3*d_suspended);
	%  8. eq.  - overall bed shear velocity (swapped with step 9)
	us = sqrt(g)./C.*U;
	%  9. eq.  22 beta-factor, inverse of Prandtl-Schmidt-Number
	beta = min(2, 1 + 2*(ws./us).^2);
	% packing density of spheres (maximum concentration)
	c0 = Constant.packing_density.Spheres;
	% 10. eq. 34 stratification correction
	phi = 2.5*abs(ws./us).^0.8.*(ca./c0).^0.4;
	% 11. eq. 3 and 33 suspension parameter, aka rouse number
	z  = ws./(beta.*kappa.*abs(us)); 
	zt = z + phi;
	% 12. eq. 44 F-factor
	F = ((a./d).^zt - (a./d).^1.2)./((1-a./d).^zt.*(1.2 - zt));

	% 13. eq. 43 volumetric suspended load transport per unit width
	% p.7.71 in Rijn 1993
	qs_v = F.*U.*d.*ca;

	% transport capacity / normalized transport
	Phi = qs_v./sqrt(g*(s-1.0)*d50.^3);

	% mass tranport per unit width
	qs_m = rhos*qs_v;

	% total mass transport
	Qs_m = qs_m.*b;
end % suspended_transport_rijn

