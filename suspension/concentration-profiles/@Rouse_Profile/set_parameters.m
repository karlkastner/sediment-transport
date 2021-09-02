% Mon 21 Oct 10:37:03 PST 2019
%function obj = set_parameters(obj,d_mm,us)
function obj = set_parameters(obj,d_mm,us,d50_mm,p,varargin)
	if (nargin()<4||isempty(d50_mm))
		d50_mm = d_mm;
	end
	if (nargin()<5)
		p = 1;
	end

	% suspension or rouse parameter
	ro = obj.rouse_number(d_mm,us,varargin{:})

	% TODO, reference concentration
	if (0)
		c0     = 1*ones(size(d_mm));
	else
		% TODO make reference level for each profile different
		[Ts,S] = transport_stage_mclean(us,d50_mm,varargin{:});%$T_C)
		%z_ref = 2*d50_mm*1e-3;
		z_ref = reference_height_mclean(1.5*d50_mm,Ts);
                for idx=1:length(d_mm)
		    c0(idx)     = p(idx).*reference_concentration_mclean(d_mm(idx),d50_mm,S,varargin{:}); %T_C)
                end
	end

	% ssc = exp(c0 + c1*z')
	% ssc = c0' exp(z')^c1
	% c1 : suspension number
	c1 = ro;

	obj.z_ref = z_ref;
	obj.c = [log(c0); c1];
end % set_parameter

