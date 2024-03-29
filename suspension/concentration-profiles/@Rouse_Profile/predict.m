% Wed 17 May 13:56:42 CEST 2017
%
%% predict the suspended sediment concentration
% ssc = predict(z,H,c,zref)
%
function [ssc, log_ssc, obj] = predict(obj,z,H,c,zref)
	if (nargin() < 4||isempty(c))
		c = obj.c;
	end
	if (nargin() < 5)
		zref = obj.z_ref;
	end
	if (isvector(z))
%		z=rvec(z);
	end
	if (isscalar(H) && size(c,2) > 1)
		H = repmat(H,1,size(c,2));
		z = repmat(cvec(z),1,size(c,2));
	end
	for idx=1:length(H)
		A   = obj.regmtx(z(:,idx),H(idx),zref);
		log_ssc(:,idx) = A*c(:,idx);
	end
	ssc = exp(log_ssc);
end

