% Wed Nov 19 15:54:25 CET 2014
% Karl Kastner, Berlin

function obj = bimodality(obj)
	fdx = find(rvec(obj.valid));
	t = tic();
	for idx=fdx
		if (toc(t) > 10)
			fprintf('Progress %d\n',round(100*idx/length(fdx)));
			t = tic();
		end
		par(idx,:)   = binormfit(obj.edge.log,obj.h(idx,:));
		mode(idx,1).id = bimodes(obj.h(idx,:));
	end
	D = binorm_separation_coefficient(par);

	obj.bimode.mode = mode;
	obj.bimode.par = par;
	obj.bimode.D   = D;
end % bimodality
