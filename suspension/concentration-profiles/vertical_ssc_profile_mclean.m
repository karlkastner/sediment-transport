% 2017-05-20 18:10:42.399224785 +0200
% 2019-05-12 17:28:31.562709808 +0800
%% vertical profile of the suspended sediment according to McLean
% mclean 1992
% form drag influence on sediment concentration profile?
% TODO, take care of sign of u!
% TODO the matrix should actually become 3d with multiple fractions
function [Cn, Cna, a_m, u_z, us_f, us_T, z0_f, z0_T, scale] = vertical_ssc_profile_mclean(chezy,u,h,z,w_int,d50_mm,d84_mm,T_C,h_d,l_d,d_mm,p)
	if (nargin()<9)
		l_d  = [];
	end
	if (nargin()<11 || isempty(d_mm))
		d_mm = d50_mm;
	end

	kappa  = Constant.Karman;

	% allocate memory
	u_z = zeros(size(z));
	Cn  = zeros(size(z));

	% roughness height associated with skin friction by grains
	z0_f = roughness_height_mclean(d84_mm,u,h,d50_mm,T_C);

	% roughness height, for skin+form drag
%	if(isempty(chezy))
%		z0_T = z0_f;
%		chezy = z02chezy(z0_T,h);
%	else
%		z0 = chezy2z0(chezy,h);
%	end
	chezy_f = z02chezy(z0_f,h);

	% shear velocity
	%us   = shear_velocity(u,chezy);
	us_f = shear_velocity(u,chezy_f);

	if (~isempty(l_d))
		z_m  = matching_level_mclean(l_d,z0_f); 
		us_T = us_f.*sqrt(shear_stress_ratio_mclean(h_d,l_d,z0_f))
		z0_T = total_roughness_length_mclean(h_d,l_d,z0_f,z_m)
	else
		z_m  = h;
		z0_T = z0_f;
		us_T = us_f;
	end

	% scale, so that the depth averaged velocity is matched
	fdx    = z<z_m; 
	tdx    = ~(fdx);
	u_z(fdx) = us_f./kappa*log(z(fdx)./z0_f); 
	u_z(tdx) = us_T./kappa*log(z(tdx)./z0_T);

mean(u_z)
	u_     = sum(u_z.*w_int);
	scale  = u./u_
%	scale = 1;
pause
%scale = 1;
	us_f   = us_f.*scale;
	us_T   = us_T.*scale;
%pause

	% eq 2
	% settling velocity for each fraction
	wn = settling_velocity(cvec(d_mm),T_C,'dietrich');

	% rouse number
	%Ro   = cvec(wn)./(kappa*rvec(us));
	Ro_f = cvec(wn)./(kappa*rvec(us_f));
	Ro_T = cvec(wn)./(kappa*rvec(us_T));

	% Transport stage and excess shear stress
	% Ts mclean = Ts_vanrijn + 1
	% TODO has u to be scaled here?
	[Ts,S] = transport_stage_mclean(u.*scale.^0,h,z0_f,d50_mm,T_C);

	a_m = reference_level_mclean(d84_mm,Ts);

	Cna = reference_concentration_mclean(d_mm,d50_mm,S,T_C);

	% eq 15 concentration along vertical for each fraction
	% Cn = Cna*(a/z*(h-z)/(h-a)).^Ro;
	%Cn = bsxfun(@power,bsxfun(@times,Cna,(a./z.*((h-z)./(h-a)))),Ro);

	% upper layer, z > z_m
	% lower layer, z < z_m
	Cn(fdx) = Cna.*((rvec(a_m)./z(fdx)).*(rvec(h)-z(fdx))./(rvec(h)-rvec(a_m))).^rvec(Ro_f);

	% the upper layer has a = zm and ca = c(zm)
	a_   = z_m;
	Cna_ = Cna.*((rvec(a_m)./a_).*(rvec(h)-a_)./(rvec(h)-a_)).^rvec(Ro_f)

	% upper layer, z > z_m
	Cn(tdx)  = Cna_.*((rvec(a_)./z(tdx)).*(rvec(h)-z(tdx))./(rvec(h)-rvec(a_))).^rvec(Ro_T);

	% total concentration along z
	%C = sum(Cn,2);

	% mean grain diameter along z
	%d_bar = 1./C*(Cn*d);
end % vertical_ssc_profile_mclean

