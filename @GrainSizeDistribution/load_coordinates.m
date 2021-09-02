% Mo 22. Sep 16:34:15 CEST 2014
% Karl Kastner, Berlin

function obj = load_coordinates(obj, filename, centre, zone)

	gpx   = read_gpx(filename,zone);
	index = cellfun(@str2num,strrep(gpx.name(:),'B',''));

	% extract data and sort
	[index, sdx] = sort(index);
	time  = gpx.time(sdx);
	X     = cvec(gpx.utm.X(sdx));
	Y     = cvec(gpx.utm.Y(sdx));
	
	% remove duplicate samples
	% last occurance is successful sample
	kdx  = 1;
	jdx  = 1;
	K(1) = 1;
	for idx=2:length(index)
		if (index(idx) ~= index(idx-1))
			% push back current sample
			kdx      = kdx+1;
			K(kdx,1) = idx;
			% proceed to next sample
			jdx      = idx;
		else
			if (time(idx) > time(K(kdx)))
				% newer position of current sample found
				K(kdx,1) = idx;
			end
		end
	end
	index            = index(K);
	X                = X(K);
	Y                = Y(K);

	id = obj.index;
	for idx=1:length(id)
		fdx = find(id(idx) == index);
		if (~isempty(fdx))
		obj.time(idx)  = time(fdx);
		obj.X(idx)     = X(fdx);
		obj.Y(idx)     = Y(fdx);
		else
			warning(['coordinates of ' num2str(id(idx)) ' are missing'])
		end
	end
	
	% transform to XY to SN coordinates
	[obj.S, obj.N, obj.nn] = centre.xy2sn(cvec(obj.X), cvec(obj.Y));
	
	% interpolate width and Rc
%	[obj.width] = centre.get(obj.S,'width');
%	[obj.Rc]    = centre.curvature(obj.S);
	
	% normalise N coordinate
	% corrected left and right turns
	% negative n indicates inner bend
%	obj.snrel = 2*sign(obj.Rc).*obj.N./obj.width;

	% distance from Sanggau
	obj.S_sanggau = zeros(1,length(obj.index));

	% TODO, pass as arguments
	[x0, y0] = sanggau_coordinates();
	yoffset = 0;
	for idx=1:length(obj.index)
		obj.S_sanggau(idx) = centre.distance(obj.X(idx),obj.Y(idx)-yoffset,x0,y0-yoffset);
	end

	% extract channel properties
	%for idx=1:length(obj.index)
	%	obj.width = width(obj.nn);
	%	obj.Rc    = Rc(obj.nn);
	%end
end % load_coordinates

