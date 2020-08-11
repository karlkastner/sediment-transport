% Wed 17 May 13:48:37 CEST 2017
% Karl Kastner, Berlin
%% fit suspended sediment profile
% function [c clog obj] = fit(obj,val,z,H,msk)
function [c, s2c, obj] = fit(obj,val,z,H,msk,nwin)
	if (isvector(val))
		val = cvec(val);
	end
	if (isvector(z))
		z = cvec(z);
	end
	if (nargin() < 5)
		msk = [];
	end
	if (nargin() < 6)
		nwin = 0;
	end
	nwin = floor(nwin/2);

	n = size(val);
	% allocate memory
%	clog = NaN(2,n(2));
%	if (obj.nlflag)
	c   = NaN(obj.nz+1,n(2));
%	s2c = NaN(2,n(2));
%	end
	val = double(val);
	H   = double(H);
	z   = double(z);
	s   = bsxfun(@times,z,1./rvec(H));

	%zi = z(:,1);
	%Hi = H(1);
	% fit each profile individually
	for idx=1:n(2)
		fdx = msk(:,idx) & isfinite(val(:,idx));
		if (sum(fdx)>obj.nz)
			c(:,idx) = hp2_fit(0,1,obj.nz,s(fdx,idx),val(fdx,idx));
			%c(:,idx) = hp2_fit(1/obj.nz,1-1/obj.nz,obj.nz,s(fdx,idx),val(fdx,idx));
		end
	end
	% TODO s2c
	obj.c = c;
end % fit

