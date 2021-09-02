% Wed 10 May 09:42:56 CEST 2017
% Karl Kastner, Berlin
%% suspended load transport according to van Rijn
% sd : geometric standard deviation
% function [Qs qs Phi] = suspended_transport_rijn(C,d50,d90,sd,U,d,b,T_C,dune_height)
%
% TODO : account for effect of cohesisve sediment on critical shear stress
% TODO : account for effect of slope on critical shear stress
%
function [Qs_m, qs_m, Phi] = suspended_transport_rijn(C,d50_mm,d90_mm,sd,U,d,b,T_C,dune_height)
	g     = Constant.gravity;
	kappa = Constant.Karman;
	rho_s  = Constant.density.quartz;
	rho_w  = Constant.density.water;
	s     = rho_s/rho_w;

	d50_m   = 1e-3*d50_mm;

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
	T = transport_stage_rijn(d50_mm,d90_mm,R,U,T_C);

	%  4. eq.  37 refrence level
	if (nargin() < 9 || isempty(dune_height))
		dune_height = bedform_dimension_rijn(d,d50_mm,T);
	end
	
	% eq 36
	a = reference_height_rijn(dune_height,d);

	%  5. eq. 38 reference concentration
	%ca    = 0.015*d50./a.*T.^1.5.*ds.^-0.3;
	ca = reference_concentration_rijn(d50_mm,a,T,T_C);

	%  6. eq.  39 particle size of suspended sediment
	d_sus_mm = suspended_grain_size_rijn(d50_mm,sd,T);

	%  7. eq.  11,12,13 fall velocity of suspended sediment
	% TODO implement van rijn method
	ws = settling_velocity(d_sus_mm,T_C,'rijn');

	%  8. eq.  - overall bed shear velocity (swapped with step 9)
	us = sqrt(g)./C.*U;

	zt = suspension_parameter(ws,us,ca,'rijn');

	% 12. eq. 44 F-factor
	% note, series expansion for zt->0 as proposed by
	% van rijn seems not necessary
	F = reference_to_flux_averaged_concentration_rijn(a./d,zt);

	% 13. eq. 43 volumetric suspended load transport per unit width
	% p.7.71 in Rijn 1993
	qs_v = F.*U.*d.*ca;

	% transport capacity / normalized transport
	scale = sediment_transport_scale(d50_mm);
	% sqrt(g*(s-1.0)*d50_m.^3);
	Phi   = qs_v./scale;

	% mass tranport per unit width
	qs_m = rho_s.*qs_v;

	% total mass transport
	Qs_m = qs_m.*b;

	Qs_m(d<=0) = 0;
end % suspended_transport_rijn

