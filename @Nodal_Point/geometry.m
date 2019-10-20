% Wed  7 Mar 18:38:57 CET 2018
%% cross section geometry of branches
function [h,w,R] = geometry(obj, A)
	if (obj.wfixed)
		w = obj.w;
		if (~issym(A))
			h = bsxfun(@times,A,1./w);
		else
			h = A./w;
		end
	else
		hg = obj.hg;
		h = (hg.aw/hg.ah*A.^(hg.pw)).^(1/(hg.pw+hg.ph));
		w = A./h;
	end
	if (obj.widechannel)
		R = h;
	else
		%A = bsxfun(@times,h,w);
		P = bsxfun(@plus,w,2*h);
		R = A./P;
	end
end % geometry

