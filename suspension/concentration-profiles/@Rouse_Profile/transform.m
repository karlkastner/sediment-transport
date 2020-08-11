% 2017-05-19 18:31:14.292885009 +0200
%% transform the vertical coordinate
function [zt obj] = transform(obj,z,H,z_ref)
	if (nargin()<4)
		z_ref = obj.z_ref;
	end
	%zt = (H-z).*zref./((H-zref).*z);
	zt = z./(H-z).*(H-z_ref)./z_ref;
	%(H-z).*zref./((H-zref).*z);
end
