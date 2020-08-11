% Tue 31 Mar 11:59:12 +08 2020
function I = integration_factor_wright_parker(Ro)
	% I = int^1 eta^(1/6)*( (1-eta)./eta*eta_a./(1-eta_a)).^Ro;
	I     = 0.679*exp(-2.23*Ro);
	fdx   = Ro>1;
	I(fdx) = 0.073.*Ro(fdx).^(-1.44); 
end

