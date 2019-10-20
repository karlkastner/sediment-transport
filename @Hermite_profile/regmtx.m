% Wed 17 May 13:57:42 CEST 2017
%% regression matrix
function [A obj] = regmtx(obj,z,H,varargin)

	zt = obj.transform(z,H,varargin{:});
	A = [ones(size(z,1),1), -log( zt ) ];
	%A = [ones(size(z,1),1) log( (H-z).*zref./((H-zref).*z)) ];
	%z./(z-H).*(z-zref)./zref)];
	%A = [ones(size(z,1),1) log(z./(z-H).*(z-zref)./zref)];
end

