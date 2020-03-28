% Fr 10. Apr 14:27:06 CEST 2015
% Karl Kastner, Berlin

function obj = export_csv(obj,fid)
	if (nargin < 2)
		fid = 1;
	end
	local = isstr(fid);
	if (local)
		fid = fopen(fid,'w');	
	end
	timeV = str2num(datestr(obj.time,'yyyymmddHHMM'));
	% bend distinction (two-split)
	% actually they are mutually exclusive, but here different bits are used for simplicty
	% TODO put this into the grouping
	if (~isempty(obj.cugroup) && isfield(obj.cugroup,'g'))
		cuid(obj.cugroup(2).g(1).g(1).id) = {'inner'};
		cuid(obj.cugroup(2).g(1).g(2).id) = {'outer'};
		cuid(obj.cugroup(2).g(2).id)      = {'straight'};
	end
	% make exportable
	%[obj.channel(:).name] = {obj.group.name{obj.channel.id(:)};
	%c=cell(length(obj.channel),1); [obj.channel(1:length(obj.channel)).name] = deal(c{:});
%	for idx=1:length(obj.channel(1).id) obj.channel().name = obj.channel.group(obj.channel(1).id(idx)).name; end
%	obj.channel.name = cell(length(obj.channel.id),1);
%	for idx=1:length(obj.channel.id);
%		obj.channel.name{idx} = obj.channel.group(obj.channel.id(idx)).name;
%	end
	fields = {
		'X',            'X';
		'Y',            'Y';
		'time',		'time';
		'index',        'index';
		'channel_id',   'channel.id';
		'channel_name', 'channel.name';
%		'hist_group',  'obj.hgroup(3).id ...  
%		'time',        'timeV';
%		'S',           'S';
%		'N',           'N';
%		'Rc',          'Rc';
%		'width',       'width';
%		'S_downstream', 'channel.S';
%		'snrel',       'snrel';
		'mean',        'mu';
		'std',         'std';
		'skew',        'skew';
		'kurt',        'kurt';
		'mode',        'mo';
%		'serr_mu',     'serr';
		'd16',         'd16';
		'd50',         'me';
		'd84',         'd84';
		'entropy',     'entropy';
%		'bimodality',  'bimode.D';
%		'depth',       'depth';
%		'area',	       'area';
		cellfun(@num2str,num2cell(obj.centre.lin),'UniformOutput',false), 'histogram.h'
	}
	% print header
	for jdx=1:size(fields,1)
		if (~iscell(fields{jdx,1}))
			fprintf(fid,'%s; ',fields{jdx,1});
		else
			fprintf(fid,'%s; ',fields{jdx,1}{:});
		end
	end
	fprintf(fid,'\n');
	fdx = find(obj.valid);
	% print values for each sample
	for idx=rvec(fdx)
	    % for each field
            for jdx=1:size(fields,1)
		% test if field exists
                if (isfield_deep(obj,fields{jdx,2}))
                    f = getfield_deep(obj,fields{jdx,2});
		    % make a column vector
		    if (isvector(f))
			f = cvec(f);
		    end
                    if (idx > size(f,1))
                        fprintf(fid,'NaN;');
                    else
		    if (strcmp(fields{jdx,2},'time'))
                        f = cellfun(@datestr,num2cell(f),'UniformOutput',false);
		    end
                    if (iscell(f))
                        if (isstr(f{idx}))
                            fprintf(fid,'"%s"; ',f{idx});
                        else
                            fprintf(fid,'%f; ',f{idx});
                        end
                    else
                        fprintf(fid,'%f; ',f(idx,:));
                    end
                end
                else
                    fprintf(fid,'NaN;');
                end
            end
            fprintf(fid,'\n');
	end
	if (local)
		fclose(fid);
	end
end % export_csv

