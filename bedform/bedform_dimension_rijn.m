% Wed 10 May 17:06:04 CEST 2017
%
%% bed form dimensions
%% cf. rijn 1984 iii
%
% function [h_dune, l_dune] = bedform_dimension_rijn(h,d50_mm,T)
%
% statinary flow (no flood waves or tidal waves)
% TODO only for dunes, this function does not check riffle limits
%
function [h_dune, l_dune] = bedform_dimension_rijn(h,d50_mm,T)
	% 5.2.12 in v. Rijn, principles of sediment transport
	% mm to m
	d50_m = 1e-3*d50_mm;

	% dune height according to yalin
	% dune_height = 1/6*d;

	% Note, antidunes only emerge in subcritical flow (Fr>1), T>>25
	% eq 5.2.12 in "principles of sediment transport 1993"
	% eq 14 sediment transpor iii 1984
	% Rijn (1982)
	h_dune = 0.11*h.*(d50_m./h).^0.3.*max(1-exp(-0.5*T),0).*max(0, 25 - T);
	l_dune = 7.3*h;
end % bed_form_dimensions

