% Wed 17 May 13:48:37 CEST 2017
% Karl Kastner, Berlin
%% fit the suspended sediment concentration profile
% function [c clog obj] = fit(obj,ssc,z,H,mask)
function [c, s2c, clog, obj] = fit(obj,ssc,z,H,mask,ensmask)
	if (isvector(ssc))
		ssc = cvec(ssc);
	end
	if (isvector(z))
		z = cvec(z);
	end
	if (nargin() < 5)
		mask = [];
	end
	if (nargin()<6)
		ensmask = 1:size(ssc,2);
	end
	if (islogical(ensmask))
		ensmask = find(ensmask);
	end
	nwin = floor(obj.nwin/2);

	n = size(ssc);
	
	if (isempty(obj.c))
		% allocate memory
		obj.c    = NaN(2,n(2));
		obj.s2c  = NaN(2,n(2));
		obj.serr = NaN(1,n(2));
%	else
%		c   = obj.c;
%		s2c = obj.s2c;
%		serr = obj.serr;
	end

%	end
	% convert to double for fit
	if (obj.nlfit)
		ssc = double(ssc);
		H   = double(H);
		z   = double(z);
	end

	% relative vertical position above bed
	s   = bsxfun(@times,z,1./rvec(H));

	%zi = z(:,1);
	%Hi = H(1);
	% fit each profile individually
	for idx=rvec(ensmask) %1:n(2)
		% fetch ensembles within window
		ssc_  = flat(ssc(:,max(1,idx-nwin):min(idx+nwin,n(2))));
		s_    = flat(s(:,max(1,idx-nwin):min(idx+nwin,n(2))));
		mask_ = flat(mask(:,max(1,idx-nwin):min(idx+nwin,n(2))));
		% H_    = H(max(1,idx-nwin):min(idx+nwin,nens));

		% rescale from s to z
		z_ = H(idx)*s_;

		fdx = isfinite(ssc_) & mask_;
%		if (~isempty(mask))
%			fdx = fdx & mask(:,idx);
%		end
		% fit by linearisation
		ns = sum(fdx);
		if (ns>=2)
			%if (~isvector(z))
			%	zi = z(:,idx);
			zi = z_;
			%end %iv z
			%if (isvector(H))
			Hi = H(idx);
			%end%iv H

			% regression matrix
			A = obj.regmtx(zi(fdx),Hi,obj.z_ref);

			% regression parameters of linearised profile
			log_ssc = log(ssc_(fdx));
			clog    = A \ log_ssc;

			% non-linear regression, use result of linear regression as start value
			if (~obj.nlfit)
				c   = clog; %(:,idx);
				res = A*c - log_ssc;
			else
				try 
					% normalize (for absolute tolerance)
					w = 1/mean(ssc_(fdx));
					f = @(c) w*(exp(A*c) - ssc_(fdx));
					c = lsqnonlin(f, clog(:,idx));
					% linearized regression matrix
					A   = bsxfun(@times,A,exp(A*c));

					% regression residual
					res        = A*c - ssc_(fdx);

					% error of parameters
					if (0)
						% determine sensitivity
						C = inv(A'*A);
						s1 = diag(A*C*A');
						diag(C)
						C = inv(A'*A);
						diag(C)
						% determine leverage
						s=diag(A*C*A')
						head([s1/sum(s1) s/sum(s)],10)
						pause
					end
				catch e
					disp(e);
				end
			end % if nlfit

			serr2 = sum(res.^2)/(ns-2);

			obj.c(:,idx)   = c;
			obj.serr(idx)  = sqrt(serr2);
			obj.s2c(:,idx) = serr2*diag(inv(A'*A));
			%s2c(:,idx) = ns/(ns-2)*rms(res)^2*diag(inv(A'*A));
		end % if sum(fdx)>2
	end % idx
%	if (~obj.nlfit)
%		obj.c = c;
%	else
%	obj.c = c;
%	obj.serr = serr;
%	obj.s2c = s2c;
%	end	
end % fit

