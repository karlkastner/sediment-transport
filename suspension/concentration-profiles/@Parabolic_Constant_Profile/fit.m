% Wed 17 May 13:48:37 CEST 2017
% Karl Kastner, Berlin
%% fit the suspended sediment concentration profile
% function [c clog obj] = fit(obj,ssc,z,H,msk)
function [c clog obj] = fit(obj,ssc,z,H,msk)
	if (isvector(ssc))
		ssc = cvec(ssc);
	end
	if (isvector(z))
		z = cvec(z);
	end
	if (nargin() < 5)
		msk = [];
	end
	n = size(ssc);
	% allocate memory
	clog = NaN(2,n(2));
	if (obj.nlflag)
		c = NaN(2,n(2));
	end
	ssc = double(ssc);
	H = double(H);
	z = double(z);
	zi = z(:,1);
	Hi = H(1);
	% fit each profile individually
	for idx=1:n(2)
%		idx/n(2)
		fdx = isfinite(ssc(:,idx));
		if (~isempty(msk))
			fdx = fdx & msk(:,idx);
		end
		% fit by linearisation
		if (sum(fdx)>=2)
			if (~isvector(z))
				zi = z(:,idx);
			end %iv z
			if (isvector(H))
				Hi = H(idx);
			end%iv H

			% regression matrix
			A = obj.regmtx(zi(fdx),Hi,obj.z_ref);

			% regression parameters of linearised profile
			clog(:,idx) = A \ log(ssc(fdx,idx));

			% non-linear regression, use result of linear regression as start value
			if (obj.nlflag)
				try 
					c(:,idx) = lsqnonlin(@(c) exp(A*c) - ssc(fdx,idx), clog(:,idx));
				catch
				end
			end % if nlflag
		end % if sum(fdx)>2
	end % idx
	if (~obj.nlflag)
		c = clog;
		obj.c = c;
	else
		obj.c = c;
	end	
end % fit

