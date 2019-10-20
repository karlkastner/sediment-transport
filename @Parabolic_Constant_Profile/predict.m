% Wed 17 May 13:56:42 CEST 2017
%% predict suspended sediment concentration
function [ssc, obj] = predict(obj,z,H,c,zref)
	if (nargin() < 4)
		c = obj.c;
	end
	if (nargin() < 5)
		zref = obj.z_ref;
	end
	if (isvector(z))
		z=cvec(z);
	end
	for idx=1:length(H)
		A   = obj.regmtx(z(:,idx),H(idx),zref);
		log_ssc(:,idx) = A*c(:,idx);
	end
	ssc = exp(log_ssc);
end

