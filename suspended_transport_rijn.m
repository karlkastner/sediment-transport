% Wed 10 May 09:42:56 CEST 2017
% Karl Kastner, Berlin
%% suspended load transport according to van Rijn
% sd : geometric standard deviation
% function [Qs qs Phi] = suspended_transport_rijn(C,d50,d90,sd,U,d,b,dune_height)
%
function [Qs_m, qs_m, Phi] = suspended_transport_rijn(C,d50_mm,d90_mm,sd,U,d,b,dune_height)
	g     = Constant.gravity;
	kappa = Constant.Karman;
	rho_s  = Constant.density.quartz;
	rho_w  = Constant.density.water;
	s     = rho_s/rho_w;


	% implicit use of bsxfun
%	C   = Expanding_Double(C);
%	d50 = Expanding_Double(d50);
%	d90 = Expanding_Double(d90);
%	U   = Expanding_Double(U);
%	d   = Expanding_Double(d);
%	b   = Expanding_Double(b);
	
	d50_m   = 1e-3*d50_mm;
	%d90   = d90;

	% hydraulic radius according to Vanoni-Brooks
	if (isempty(b))
		R = d;
		b = 1;
	else
		R = hydraulic_radius(d,b);
	end
	R     = max(R,0);

	%  3. eq.   2 transport stage parameter
	%  uses 2. eq.   - critical bed-shear velocity according to Shields	
	T = transport_stage_rijn(d50_mm,d90_mm,R,U);

	%  4. eq.  37 refrence level
	if (nargin() < 8 || isempty(dune_height))
		dune_height = bedform_dimension_rijn(d,d50_mm,T);
	end
	dune_height = Expanding_Double(dune_height);
	
	% eq 36
	a     = 0.5*dune_height;
	a     = max(a,0.01*d);

	%  5. eq. 38 reference concentration
	%ca    = 0.015*d50./a.*T.^1.5.*ds.^-0.3;
	ca = reference_concentration_rijn(d50_mm,a,T);

%function f_factor_rijn(C,d50_mm,sd,U,T,ca)

	%  6. eq.  39 particle size of suspended sediment
	d_sus_mm = suspended_grain_size_rijn(d50_mm,sd,T);

	%  7. eq.  11,12,13 fall velocity of suspended sediment
	% TODO implement van rijn method
	ws = settling_velocity(d_sus_mm);

	%  8. eq.  - overall bed shear velocity (swapped with step 9)
	us = sqrt(g)./C.*U;

	%  9. eq.  22 beta-factor, inverse of Prandtl-Schmidt-Number
	beta = min(2, 1 + 2*(ws./us).^2);
	% packing density of spheres (maximum concentration)
	c0 = Constant.packing_density.spheres;

	% 10. eq. 34 stratification correction
	phi = 2.5*abs(ws./us).^0.8.*(ca./c0).^0.4;

	% 11. eq. 3 and 33 suspension parameter, aka rouse number
	z  = ws./(beta.*kappa.*abs(us));
	zt = z + phi;
	% same limitation as in d3d
	zt = min(20,zt);

	% 12. eq. 44 F-factor
	F = ((a./d).^zt - (a./d).^1.2)./((1-a./d).^zt.*(1.2 - zt));

	% 13. eq. 43 volumetric suspended load transport per unit width
	% p.7.71 in Rijn 1993
	qs_v = F.*U.*d.*ca;

	% transport capacity / normalized transport
	scale = sediment_transport_scale(d50_mm);
	% sqrt(g*(s-1.0)*d50_m.^3);
	Phi   = qs_v./scale;

	% mass tranport per unit width
	qs_m = rho_s*qs_v;

	% total mass transport
	Qs_m = qs_m.*b;
end % suspended_transport_rijn

