% Wed 17 May 13:57:42 CEST 2017
%% regression matrix
function [A obj] = regmtx(obj,z,H,varargin)

	zt  = obj.transform(z,H,varargin{:});
	fdx = z < 0.5*H;
	zt_  = obj.transform(0.5*H,H,varargin{:});
	A    = [ones(size(z,1),1), fdx.*(-log(zt))  + (~fdx).*( -log( zt_) - 4*(z/H-0.5)) ];
end

