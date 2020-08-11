% Thu 25 Jul 19:07:15 CEST 2019
function [theta_t,Ct,Dt] = total_2_skin_friction_eh(theta,C,D)
	% skin shields stress
	% EH 4.2.4
	theta_t = 0.06 + 0.4*theta.^2;

	% EH 4.2.5
	% for high stresses
	fdx     = (theta>0.15)
	theta_t(fdx) = 0.4*theta(fdx).^2;

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
	f = 2*g/C^2;

	% to scin friction
	% f = ft + a*H^2/(D*L)
	ft = f*theta_t./theta;

	% transform back
	% C = sqrt(2g/f)  => c = sqrt(2/f)
	Ct=sqrt(2*g/ft);
	end

	if (nargin() > 2)
		% p 55
		% height of boundary layer
		Dt = (theta_t./theta)*D;
	end	
end

