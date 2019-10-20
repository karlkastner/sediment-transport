% Thu 25 Jul 18:54:34 CEST 2019
%% skin friction to total friction conversion according to engelund and hansen
function [theta,C,D] = skin_2_total_friction_eh(theta_t,Ct,Dt)
	g = 9.81;
	% skin shields stress
	% EH 4.2.4
	% critical shear stress
	theta = sqrt(2.5*max(theta_t - 0.06,0));

	% EH 4.2.5
	% for high stresses
	% note : not necessary, this is only asymptotic
	%if (~issym(theta))
	%	fdx = (theta_t > 0.4*0.15.^2);
	%	theta(fdx) = sqrt(2.5*theta_t(fdx));
	%end

	if (nargin() > 1)
	%k  = 2.5*d_m;
	%ft = 0.6 + 2.5*log(Dt./k);
	
	% dune height (Fig 8 in EF 1982)
	% H = 0.2*D;
	% from vr
	% L = 7*D;
	% eh 1967 4.1.5

	% transform c to f (p.45)
	% f = 2/c.^2;
	ft = 2*g./Ct.^2;

	% to scin friction
	% f = ft + a*H^2/(D*L)
	% in the equation we furthermore must have f_total >= t', so
	f = ft.*max(theta./theta_t,1);

	% transform back
	% C = sqrt(2g/f)  => c = sqrt(2/f)
	C=sqrt(2*g./f);
	end

	if (nargin() > 2)
		% p 55
		% height of boundary layer
		D = max(theta./theta_t,1).*Dt;
	end
end


