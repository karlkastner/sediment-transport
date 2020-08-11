% Tue 31 Mar 12:20:14 +08 2020
function beta = stratification_parameter_rijn(ws,us)
	%  9. eq.  22 beta-factor, inverse of Prandtl-Schmidt-Number
	% note : was implemented as min 2, beta
	% note in eq the limit ws = us -> beta = 3 is given
	% but on page 1634, ws=1/2 us -> beta = 1.5 is given
	beta = min(1.5, 1 + 2*(ws./us).^2);
end

