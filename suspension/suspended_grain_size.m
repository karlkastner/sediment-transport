% Tue 16 May 16:36:46 CEST 2017
%% suspended grain size distribution based on bed material grain size distribution
%% 
%% assumes that probability of suspension is inverse proportional to grain diameter
%% as in Engelund-Hansen transport relation
%% - no hiding effects considered
%% - no threshold for large grains applied
%% - no flocking considered
%% note: actual distribution varies with the depth
%%
%% d     : [1xnd]  grain size in arbitrary units (on linear, not on log scale)
%% h_bed : [nsxnd] fractions of sediment of size d
function h = suspended_grain_size_distribution(d_mm,h_bed)
	d_m = 1e-3*d_mm;
	% first inverse moment
	h = bsxfun(@times,(1./d)',h_bed);
	% normalise
	h = bsxfun(@times,h,1./sum(h,2));
end

