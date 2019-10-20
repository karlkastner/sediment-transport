% 2017-05-24 20:24:01.780068893 +0800
% hiding and exposure correction according to wu
% note : ph + p1 = 1, ph=pk=1/2 for uniform sediment
function [phk pek] = hiding_exposure_wu(d,p)
	d = cvec(d);
	nd = length(d);
	% hiding coefficient
	phk = zeros(size(p));
	% exposure coefficient
	pek = zeros(size(p));
	% for each size class
	for idx=1:nd
		% 3.42
		phk = phk + btimes(p(idx,:),d(idx)./(d(idx) + d));
		% 3.43
		%pek = pek + p(idx,:).*p./(d(idx)+d);
	end % for idx
	pek = 1-phk;
end

