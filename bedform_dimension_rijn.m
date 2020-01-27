% Wed 10 May 17:06:04 CEST 2017
%
%% bed form dimensions
%% cf. rijn 1984 iii
%
% function [Delta, lambda] = bedform_dimension_rijn(h,d50,T)
%
% statinary flow (no flood waves or tidal waves)
% TODO only for dunes, this function does not check riffle limits
%
function [Delta, lambda] = bedform_dimension_rijn(h,d50,T)
	% 5.2.12 in v. Rijn, principles of sediment transport
	% mm to m
	d50 = 1e-3*d50;

	% dune height according to yalin
	% dune_height = 1/6*d;

	% TODO what if T > 25? antidunes?
	% eq 5.2.12 in "principles of sediment transport 1993"
	% eq 15 sediment transpor iii 1984
	% Rijn (1982
	Delta  = 0.11*h.*(d50./h).^0.3.*(1-exp(-T/2)).*max(0, 25 - T);
	lambda = 7.3*h;
end % bed_form_dimensions

