% 2020-04-23 12:57:27.602492251 +0800
% formative discharge for Engelund-Hansen Transport relation
% function Q = formative_discharge(Qmin,Qmax,mode)
function Q = formative_discharge(Qmin,Qmax,mode)
	if (nargin()<3)
		mode = 'chezy';
	end
	switch (lower(mode))
	case {'manning'} % manning
		Q = sign(Qmax)*sqrt((3*Qmax^2)/8 + (Qmax*Qmin)/4 + (3*Qmin^2)/8);
	case {'chezy'}
		Q = sign(Qmax)*(quad(@(t) (abs(Qmin) + 1/2*(abs(Qmax)-abs(Qmin))*(1 - cos(2*pi*t))).^(5/3),0,1))^(3/5);
	otherwise
		error('here');
	end
% syms Q h; h=Q.^(2/3); u=h.^(1/2); Qs = u.^5, syms h; h = solve(Q-h^(3/2+1/6),h); h=h(1); u = h.^(1/2+1/6);Qs=u.^5
end

