% Mon 21 Oct 10:37:03 PST 2019
function obj = set_parameters(obj,d_mm,us)
	% suspension or rouse parameter
	ro = obj.rouse_number(d_mm,us);

	% TODO, reference concentration
	c0 = 1*ones(size(d_mm));

	% ssc = exp(c0 + c1*z')
	% ssc = c0' exp(z')^c1
	% c1 : suspension number
	c1 = ro;

	obj.c = [log(c0); c1];
end % set_parameter

