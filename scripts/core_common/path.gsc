// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace path;

/*
	Name: function_a760f3bf
	Namespace: path
	Checksum: 0xD075E23D
	Offset: 0x68
	Size: 0x158
	Parameters: 5
	Flags: Private
*/
private function function_a760f3bf(path, var_bc114662, point_color, line_color, var_80bf7c44)
{
	/#
		/#
			assert(isdefined(path));
		#/
		for(i = 0; i < path.size; i++)
		{
			if(isdefined(path[i + 1]))
			{
				direction = vectornormalize(path[i + 1] - path[i]);
				radius = distance(path[i], path[i + 1]) / 2;
				center = path[i] + vectorscale(direction, radius);
				[[var_bc114662]](path[i], path[i + 1], center, radius, point_color, line_color, var_80bf7c44);
			}
		}
	#/
}

/*
	Name: function_d88e0349
	Namespace: path
	Checksum: 0xAB03D072
	Offset: 0x1C8
	Size: 0xB4
	Parameters: 7
	Flags: Private
*/
private function function_d88e0349(var_ac3ff0b7, var_3e109452, center, radius, point_color, line_color, var_80bf7c44)
{
	/#
		recordline(var_ac3ff0b7, var_3e109452, line_color, "");
		recordsphere(var_ac3ff0b7, 2, point_color, "");
		recordcircle(center, radius, var_80bf7c44, "");
	#/
}

/*
	Name: function_bb43c529
	Namespace: path
	Checksum: 0xC30B229A
	Offset: 0x288
	Size: 0xB4
	Parameters: 7
	Flags: Private
*/
private function function_bb43c529(var_ac3ff0b7, var_3e109452, center, radius, point_color, line_color, var_80bf7c44)
{
	/#
		line(var_ac3ff0b7, var_3e109452, point_color, 1, 1);
		sphere(var_ac3ff0b7, 5, line_color, 1, 1);
		circle(center, radius, var_80bf7c44, 0, 1, 1);
	#/
}

/*
	Name: function_3c367117
	Namespace: path
	Checksum: 0xCBF83F44
	Offset: 0x348
	Size: 0x8C
	Parameters: 4
	Flags: None
*/
function function_3c367117(path_points, point_color, line_color, var_80bf7c44)
{
	/#
		if(!isdefined(point_color))
		{
			point_color = (0, 0, 1);
		}
		if(!isdefined(line_color))
		{
			line_color = (0, 1, 0);
		}
		if(!isdefined(var_80bf7c44))
		{
			var_80bf7c44 = (1, 0.5, 0);
		}
		function_a760f3bf(path_points, &function_d88e0349, point_color, line_color, var_80bf7c44);
	#/
}

/*
	Name: function_aa9bfd9d
	Namespace: path
	Checksum: 0x378DE650
	Offset: 0x3E0
	Size: 0x8C
	Parameters: 4
	Flags: None
*/
function function_aa9bfd9d(path_points, point_color, line_color, var_80bf7c44)
{
	/#
		if(!isdefined(point_color))
		{
			point_color = (0, 0, 1);
		}
		if(!isdefined(line_color))
		{
			line_color = (0, 1, 0);
		}
		if(!isdefined(var_80bf7c44))
		{
			var_80bf7c44 = (1, 0.5, 0);
		}
		function_a760f3bf(path_points, &function_bb43c529, point_color, line_color, var_80bf7c44);
	#/
}

