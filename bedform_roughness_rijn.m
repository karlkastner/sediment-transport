% Do 14. Mai 11:43:31 CEST 2015
%% form drag according to van Rijn
% function [rgh] = bedform_roughness_rijn(h,l,R)
% h : dune height
% l : dune length
% R : hydraulic radius
function [rgh] = bedform_roughness_rijn(hd,ld,R)
	rgh.ks  = 1.1*hd.*(1-exp(-25*hd./ld));
	rgh.z0  = rgh.ks/30;
	if (nargin()>2)
		if (~issym(hd))
			g = Constant.gravity;
			kappa = Constant.Karman;
		else
			syms g kappa 
		end
		%rgh.C = sqrt(g)/kappa*(log(R./rgh.z0) - 1);
		rgh.C = double(z02chezy(rgh.z0,R));
		rgh.cd = g*rgh.C.^(-2);
		rgh.n  = chezy2manning(rgh.C,R);
	end
end

