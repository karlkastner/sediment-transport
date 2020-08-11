% Wed  8 Jan 19:05:56 +08 2020
% TODO, this is a sloppy implementation
function [cbar,ubar] = mean_concentration(obj,H,us,z0)
	n     = 100;
	kappa = 0.41;
	z     = (1:n)'/(n+1)*H;
	c     = obj.predict(z,H); %,c,zref)
	u     = us/kappa*log(z/z0);
	ubar  = us/kappa*(log(H/z0)-1);
	cbar  = sum(c.*u)./sum(u);
end

