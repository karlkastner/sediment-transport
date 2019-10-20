% Wed 17 May 13:56:42 CEST 2017
%% predict suspended sediment concentration
function [ssc, dssc_dz, obj] = predict(obj,z,H,c)
	if (nargin() < 4)
		c = obj.c;
	end
	if (nargin() < 5)
		zref = obj.z_ref;
	end
	if (isvector(z))
		z=cvec(z);
	end
	% scale
	s = bsxfun(@times,z,1./rvec(H));

	for idx=1:length(H)
		[ssc, dssc_ds] = hp2_predict(0,1,c(:,idx),z);
		%[ssc, dssc_ds] = hp2_predict(1/obj.nz,1-1/obj.nz,c(:,idx),z);
	end
	% scale
	dssc_dz = bsxfun(@times,dssc_ds,1./rvec(H));
%	ssc = exp(log_ssc);
end

