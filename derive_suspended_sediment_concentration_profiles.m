% 2020-05-02 22:12:43.358903739 +0800

syms kappa z c(z) ws c0 us h positive;
%syms kappa us z0 ws ca  za positive 

mode = {'constant','linear','quadratic'}

%ws = 1
%kappa = 1
%us = 1
for idx=1:length(mode)

% all normalized to \bar e = 1/6*kappa*h*us
switch (mode{idx})
case {'constant'}
	e  = 1/6*kappa*h*us
case {'linear'}
	e  = 1/3*kappa*z*us
case {'quadratic'}
	%e = kappa*z*(1-z/h)*us
	e = z*(1-z/h)*us
end

%eq=-ws*diff(c(z),z) + diff(e*diff(c(z),z),z);
eq=-ws*c(z) + e*diff(c(z),z);
%eq=-ws*diff(c,z) + e*diff(diff(c(z),z),z);
C = dsolve(eq,z)
%C = simplify(C)
 simplify(expand(rewrite(C,'exp'))) 
end

%	eq = ws*diff(c,z) + diff(e*diff(c(z),z),z);
%	c_ = dsolve(eq,c(0)==c0,c(inf)==0,z)
%	limit(c_,z,inf)
%	c_ = subs(c_,'C1',0)
%	subs(c_,e,k/6*us*h)
%pause
%	eq = ws*diff(cs,z) + diff(e*diff(cs,z),z)
%	cs = dsolve(eq,cs(za)==ca,z)
%	cs_inf = limit(cs,z,Inf);
%	C1 = solve(cs_inf==0,C1);
%	cs = subs(cs,'C1',C1)
	%c(0)==c0,z)

