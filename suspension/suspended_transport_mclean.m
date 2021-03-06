% 2019-05-12 17:28:31.562709808 +0800
%% vertical profile of the suspended sediment according to McLean
% mclean 1992
% form drag influence on sediment concentration profile?
% Ts mclean = Ts_vanrijn + 1
% TODO, take care of sign of u!
% TODO use we by dietrich
% TODO use tau_c by wieberg 
function [Qs, Cs, z, u_z, us_f, us_T, z0_f, z0_T, scale] = suspended_transport_mclean( ...
				chezy,u,h,width,d50_mm,d84_mm,T_C,varargin)
	rho_s = 2650;
	%order  = 6;
	order  = 6;
	kappa = Constant.Karman;
	if (nargin()<8)
		d_mm = d50_mm;
	end


	% baricentric coordinates and weights for numerical integration
	if (0)
		[w_int, b] = int_1d_gauss(order);
	else
		n = 10;
		b = (1:n)'/(n+1);
		b = [b,1-b];
		w_int = (1/n)*ones(n,1);
	end

	a = zeros(size(h));	
	% vertical coordinate for numerical integration
	z = (b(:,1)*rvec(a) + b(:,2)*rvec(h));


	% detph-averaged velocity
	%ubar = log_profile_ubar(us,H,z0);
	%ubar = us/kappa*(log(h/z0)-1);
	ubar = u;

	% sediment concentration profile
	[Cs, Ca, a, u_z, us_f, us_T, z0_f, z0_T, scale] = vertical_ssc_profile_mclean(chezy,u,h,z,w_int,d50_mm,d84_mm,T_C,varargin{:});
	%[C,Ca] = sediment_concentration_profile_mclean();
%	if (isempty(chezy))
%		chezy = z02chezy(z0,h);
%	end

	%us = shear_velocity(u,chezy);

	% logarithmic velocity profile : eq 5
	%% u := us/kappa*log(z/z0);
	%z0  = chezy2z0(chezy,h)
	%u_z = (rvec(us)/kappa).*log(z./rvec(z0));

	% einstein integral over depth
	%% I = 1/(int_a^h c dz int_a^h u dz) int_a^h c u dz
	% I = 1/h*int_a^h u/ubar Cs/Ca dz
	%I = 1./((c*w).*(u*w)).*((c.*u)*w);
	I = (rvec(h)./(rvec(ubar).*rvec(Ca))).*((Cs.*u_z).'*w_int).';

	% eq 1
	% specific transport per unit width
	% mass
	qs     = rho_s*Ca.*ubar.*h.*I;

	% total transport across section
	Qs     = width*qs;

	% total transport
%	z0  = h/(exp(kappa*C/sqrt(g) + 1);
%	u   = us/kappa*log(z./z0);
%	qsz = u.*C;
%	qs  = sum(qz);
end

function Ifub(a,z0,h,p)
	a_ = max(a,z0);
	n  = 1e2;
	z  = linspace(a_,h,n);
	dz = (h-a_)/(n-1); 
	% normalized velocity
	u  = log(z/z0)/(log(h/z0)-1);
	% normalized concentration
	c  = (a./z.*(h-z)./(h-a)).^p;
	I = dz*sum(u.*c);
end

