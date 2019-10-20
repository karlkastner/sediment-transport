% Do 14. Mai 11:43:31 CEST 2015
%% total roughness according to van rijn
% function [rgh rgh_from rgh_skin] = total_roughness_rijn(h,l,d90,varargin)
function [rgh rgh_form rgh_skin] = total_roughness_rijn(hd,ld,d90,varargin)
	rgh_form = bedform_roughness_rijn(hd,ld,varargin{:});
	rgh_skin = grain_roughness_rijn(d90,varargin{:});

	rgh.ks = rgh_form.ks + rgh_skin.ks;
	rgh.z0 = rgh.ks/30;

	if (nargin()>3)
		g     = 9.81;
		kappa = 0.41;
		R = varargin{1};
		rgh.C  = sqrt(g)/kappa*(log(R./rgh.z0) - 1);
		rgh.cd = g./rgh.C.^2; 
	end
end

