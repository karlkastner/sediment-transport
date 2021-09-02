% Sun Nov 23 10:46:48 CET 2014
% Karl Kastner, Berlin
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.

% TODO make histogram a class
classdef GrainSizeDistribution < handle
    properties
        % size class separation    
        edge     = struct('lin', [], 'log', []);
        centre;
	binwidth;
        n_group  = 5;

	% object of class Histogram
	histogram

        % histogram group
        hgroup = struct('n',5 ... % maximum number of histogram groups
                       );

	% downstream S-coordinate (the original S-coordinate has a random direction)
	channel = struct('name',[],'id',[],'group',[]);

	% curvature group
	cugroup = struct('n', 3);

	% bimodality index
	bimode

	% water depth at sample location
	depth
	
	% cross section area at sample location
	area

        %
        % matrix quantities [nsample x nbin]
        %

	% fraction of gravel
	gravel

        % entropy per bin
        Ebin
        % ???
        nn

        %
        % vector quantities [nsample x 1]
        %
        
        %
        % spatial data
        %

        % UTM Easting
        X
        % UTM Northing
        Y
        % running sample number as collected in the field
        index
        % time sample was taken
        time
        % streamwise coordinate
        S
	S_sanggau;
        % spanwise coordinate
        N
        % midriver radius of curvature at sample location
        Rc
        % width of river at sample location
        width
        % relative position of sample in a bend (- is inner)
        snrel
	% index of histogram group
	%hid
        % index of the tidal channel the sample was collected in
        %cid
%	Sds

        %
        % histogram information
        % 

        % hist mean
        mu
        % hist std
        std
	% hist skewness
	skew
	% hist kurtosis
	kurt
        % hist max
        mo
        % hist standard error of the mean
        serr
	% effective number of bins
	dof_reduction
        % quanitles
        d16
	% median
        me %d50
        d84
        % total entropy of the sample histogram
        entropy

	valid;
    end
    methods
        % constructor
        function obj = GrainSizeDistribution(id,h,edge)
	    % extract index
	    obj.index  = id;

            % size class edges and centres
	    edge.lin = edge;

            % extrapolate bondary
            centre.lin            = 0.5*(edge.lin(1:end-1)+edge.lin(2:end));
            edge.log              = log(edge.lin)/log(2);
	    % the log centre is the log of the lin centre, not the mean of the log edges
            centre.log            = log(centre.lin)/log(2);

	    obj.edge   = edge;      
            obj.centre = centre;
 
	    hist = Histogram(h,edge.log);

	    % sort out gravel
	    % TODO, this is a custom fix
	    obj.gravel   = hist.h(:,1);
	    hist.h(:,1)  = 0;
	    hist.normalize();

	    % TODO this is a manual fix to different sieves used for individual samples
	    % spread from left to right
	    fdx = (obj.index > 0 & obj.index < 186);
            gdx=[9 11 13 15];
	    for idx=gdx
		hist.h(fdx,idx:idx+1) = 0.5*hist.h(fdx,idx+1)*[1 1];
	    end

	    obj.valid = hist.valid();

            % compute cdf
            %obj.H = hist.cdf();
            
            % statistical properties within samples
	    % TODO compute this on demand
            % mean, median, mode
            obj.mu   = hist.mean(); %h,obj.centre.log);
            obj.mo   = hist.mode(); %h,obj.centre.log);
            % standard deviation
            obj.std  = hist.std(); %h,obj.centre.log);
	    % skewness
	    obj.skew = hist.skewness(); %h,obj.centre.log);
	    % kurtosis
	    obj.kurt = hist.kurtosis();

            % important quantiles
            obj.me   = hist.median(); %h,obj.centre.log);
            obj.d84  = hist.quantile(normcdf(+1));
            obj.d16  = hist.quantile(normcdf(-1));
            %obj.s   = 0.5*(obj.d84 - obj.d16);
            %0.5*(hist.quantile(h,obj.centre.log,normcdf(+1)) - hist.quantile(h,obj.centre.log,normcdf(-1)));
            
            % reduction of discretisation standard error of mean estimate
            dof_reduction = sqrt(sum(h.^2,2));
            % bin width (assumed to be constant)
            w        = median(diff(obj.edge.log));
            % standard error of the mean
            serr     = dof_reduction*sqrt(1/12)*w;
            
            obj.dof_reduction = dof_reduction;
            obj.binwidth = w;
            obj.serr     = serr;
            
            % compute entropy
            [obj.entropy obj.Ebin] = hist.entropy(); %obj.h,obj.edge.log);

	    % write back
	    obj.histogram = hist;

        end % load gsd
	% function that indicates valid samples
	% (invalid samples may not yet have been sieved for example)
%	function flag = valid(obj)
%		flag = isfinite(obj.mu);
%	end
    end % methods
end % classdef GrainSizeDistribution

