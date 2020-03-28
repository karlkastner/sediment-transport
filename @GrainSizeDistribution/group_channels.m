% Sun Nov 23 11:51:03 CET 2014
% Karl Kastner, Berlin

function obj = group_channels(obj)
	% group samples into channels
	[S sdx] = sort(obj.S);
	kdx=1
	gdx = 0;
	group = struct();
	for idx=2:length(S)-1
		if (S(idx) > S(idx-1)+10000)
			% new group
			gdx = gdx+1;
			group(gdx).id = [sdx(kdx:idx-1)];
			kdx=idx;
		end
	end
	% last group
	gdx = gdx+1;
	group(gdx).id = [sdx(kdx:end)];

	Sds = obj.S;

	% manually concat group 6 with 3
%	Sds(group(6).id) = Sds(group(3).id(end)) - Sds(group(6).id) + Sds(group(6).id(end)) + 2.5;
%	group(3).id = [group(3).id; group(6).id];
%	group(6) = [];

	% manually correct flow direction
	% TODO no magic numbers
	Sds(group(3).id) = -Sds(group(3).id);
	Sds(group(4).id) = -Sds(group(4).id);

	% TODO, this should be part of the centre-line
	% TODO mendawat is missing
	C  = {323529     9987966      'K. Kecil';
	      317762     9969346      'K. Besar';
	      308243     9952717      'Kubu' };

	% build reverse index
	id = NaN(size(obj.X));
	for idx=1:length(group)
		id(group(idx).id) = idx;
	end

%	name             = {'Sanggau', 'K. Kecil','K. Besar','Kubu','',''}
	name = cell(length(group),1);
	for idx=1:size(C,1)
		dmin = [];
		for jdx=1:length(group)
			dx = obj.X(group(jdx).id) - C{idx,1};
			dy = obj.Y(group(jdx).id) - C{idx,2};
			d2 = dx.*dx + dy.*dy;
			dmin(jdx) = min(d2);
		end
		[void mdx] = min(dmin);
		group(mdx).name = C{idx,3};
	end
%	name{1} = 'Sanggau';
%	name{2} = 'K. Kecil';
%	name{3} = 'K. Besar';
%	name{4} = 'Kubu';
	%obj.channel.name = name{group};
	obj.channel.S    = Sds;
	obj.channel.id   = id;
%	obj.channel.name = {};
%	obj.channel.name(1:length(id),1) = {''};
%	for idx=1:length(name)
%		obj.channel.name(idx==id)  = group(idx).name;
%	end
%	group.name(1:length(group)) = name;
%	[group(:).name] = deal(name{:});
	obj.channel.group = group;
end % goup_channels

