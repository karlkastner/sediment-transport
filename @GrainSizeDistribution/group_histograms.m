% 2014-09-18 13:50:51 +0200
% Karl Kastner, Berlin

function obj = group_histograms(obj)
	group = obj.hgroup;
        bh    = obj.histogram.h(obj.valid,:);
	% cluster the histograms
	for idx=1:group.n
		% the K-means algorithm uses random seeds, so here start group centres are chosen
		n = size(bh,2);
		S = zeros(idx,n);
		for jdx=1:idx
			s = normpdf([0:n-1]+0.5,jdx*n/(idx+1),n/idx);
			s = s/sum(s);
			S(jdx,:) = s;
		end
		id = kmeans(bh,idx,'Start',S);
		% sort groups by mean
		mu = [];
		for jdx=1:idx
			fdx = find(id == jdx);
			mu(jdx) = Histogram.meanS(mean(bh(fdx,:)),obj.histogram.edge);
		end
		[mu sdx] = sort(mu);
		%group(idx).id = zeros(size(id));
		id = -id;
		for jdx=1:idx
			id(id == -jdx) = sdx(jdx);
			%group(idx).id = group(idx).id + jdx*(sdx(jdx) == id);
		end
		group(idx).id = id;
		% group histograms
		h = zeros(idx,size(obj.histogram.h,2));
		for jdx=1:idx
			fdx = find(group(idx).id == jdx);
			h(jdx,:) = mean(bh(fdx,:));
			h_(fdx,:) = repmat(h(jdx,:),length(fdx),1);
		end
		% moments and quantiles
		group(idx).mu = mu;
		%group(idx).mu  = Histogram.mean(h,obj.histogram.edge);
		group(idx).me  = Histogram.medianS(h,obj.histogram.edge);
		group(idx).mo  = Histogram.modeS(h,obj.histogram.edge);
		group(idx).q16 = Histogram.quantileS(h,obj.histogram.edge,normcdf(-1));
		group(idx).q84 = Histogram.quantileS(h,obj.histogram.edge,normcdf(+1));
		group(idx).std = Histogram.stdS(h,obj.histogram.edge);
		group(idx).h = h;
		%n    = length(bh(:));
		mse  = mean((bh(:) - mean(obj.histogram.h(:))).^2);
		mse_ = mean((bh(:) - h_(:)).^2);
		group(idx).R2 = 1 - mse_./mse;
	end % for idx
	obj.hgroup = group;
end

