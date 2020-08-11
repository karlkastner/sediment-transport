% Do 14. Mai 11:43:31 CEST 2015
%% total roughness according to van rijn
% function [rgh rgh_from rgh_skin] = total_roughness_rijn(hd,ld,d90,varargin)
% varagin can be R 
function [rgh rgh_form rgh_skin] = total_roughness_rijn(hd,ld,d90,varargin)
	rgh_form = bedform_roughness_rijn(hd,ld,varargin{:});
	rgh_skin = grain_roughness_rijn(d90,varargin{:});

	rgh.ks = rgh_form.ks + rgh_skin.ks;
	rgh.z0 = rgh.ks/30;

	if (nargin()>3)
		g     = Constant.gravity;
		R      = varargin{1};
		rgh.C = double(z02chezy(rgh.z0,R));
		rgh.cd = g./rgh.C.^2; 
		rgh.n  = chezy2manning(rgh.C,R);
	end
end

