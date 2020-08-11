% Tue 31 Mar 12:16:57 +08 2020
% prandtl-schmidt number
% TODO this fails for very high concentrations
function a = stratification_parameter_wright_parker(c5,S)
	% (6) stratification adjustment parameter
	a   = 1 - 0.06*(c5./S).^0.77;
	fdx = c5 > 10*S;
	a   = 0.67 - 0.0025*(c5./S);
end

