% Sun Nov 23 16:16:05 CET 2014
% Karl Kastner, Berlin

% group samples based on curvature
function obj = group_curvature(obj)
	snrel = obj.snrel;
	cugroup = obj.cugroup();
	% case idx==1 is actually useless (ident)
	vdx = obj.valid();
	for idx=1:cugroup.n
		m = idx; %cugroup.M(idx);
		q = [0,quantile(abs(obj.Rc(vdx)),(1:m)/m)];
		cugroup(idx).q = q;
		for jdx=1:m
			fdx =  (abs(obj.Rc(vdx)) >= q(jdx)) ...
                             & (abs(obj.Rc(vdx)) <= q(jdx+1)) ...
                             & isfinite(snrel(vdx));
			cugroup(idx).g(jdx).id = fdx;
			% quantiles of normalised n coordinate (spanwise)
			qj = [-inf,2*(1:m-1)/m-1,inf];
			cugroup(idx).g(jdx).q = qj;
			for kdx=1:length(q)-1;
				gdx = (obj.snrel(vdx) > qj(kdx)) ...
                                    & (obj.snrel(vdx) < qj(kdx+1));
				cugroup(idx).g(jdx).g(kdx).id = fdx & gdx;
			end
		end
	end
	obj.cugroup = cugroup;
end % function group_curvature

