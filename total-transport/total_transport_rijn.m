% 2017-05-10 15:07:45.668630272 +0200
%% total sediment transport according to van rijn
% function [Qt, qt, Phi] = total_transport_rijn(C,d50,d90,sd,U,d,b,T_C,varargin)
function [Qt, qt, Phi] = total_transport_rijn(C,d50,d90,sd,U,d,b,T_C,varargin)
	[Qb, qb, Phib] = bedload_transport_rijn(C,d50,d90,U,d,b,T_C);
	[Qs, qs, Phis] = suspended_transport_rijn(C,d50,d90,sd,U,d,b,T_C,varargin{:});
	Qt = Qb + Qs;
	qt = qb + qs;
	% this is not quite true, as grain size in suspension and bed material differ
	Phi = Phib + Phis;
end

