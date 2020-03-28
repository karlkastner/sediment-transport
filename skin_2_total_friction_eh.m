% Thu 25 Jul 18:54:34 CEST 2019
%% skin friction to total friction conversion according to engelund and hansen
%% function [theta,C] = skin_2_total_friction_eh(theta_t,Ct)
function [theta,C] = skin_2_total_friction_eh(theta_t,Ct)
	if (issym(theta_t))
		syms g positive
	else
		g = Constant.gravity;
	end
	% skin shields stress
	% EH 4.2.4
	% critical shear stress
	if (~issym(theta_t))
		theta = sqrt(2.5*max(theta_t - 0.06,0));
	else
		theta = sqrt(2.5*(theta_t - 0.06));
	end

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
	ft = chezy2f(Ct);

	% to skin friction (4.1.15)
	% page 43 top f = f' theta'/theta
	% f = ft + a*H^2/(D*L)
	% in the equation we furthermore must have f_total >= t', so
	if (~issym(ft))
		f = ft.*max(theta./theta_t,1);
	else
		f = ft.*(theta./theta_t);
	end

	% transform back
	% C = sqrt(2g/f)  => c = sqrt(2/f)
	C = f2chezy(f);
	end
end


