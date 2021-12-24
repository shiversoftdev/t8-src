// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scene_shared.gsc;

#namespace namespace_3be0b7ad;

/*
	Name: function_9b62d333
	Namespace: namespace_3be0b7ad
	Checksum: 0x4D7FB0B0
	Offset: 0x90
	Size: 0x238
	Parameters: 2
	Flags: Linked
*/
function function_9b62d333(n_hour, n_minute)
{
	var_f6197f53 = 0;
	switch(n_minute)
	{
		case 15:
		{
			var_f6197f53 = 1;
			break;
		}
		case 30:
		{
			var_f6197f53 = 2;
			break;
		}
		case 45:
		{
			var_f6197f53 = 3;
			break;
		}
	}
	if(!isdefined(self.n_hour))
	{
		self.n_hour = 0;
	}
	if(!isdefined(self.var_f6197f53))
	{
		self.var_f6197f53 = 0;
	}
	if(self.n_hour == n_hour && self.var_f6197f53 == var_f6197f53)
	{
		return;
	}
	if(self.n_hour == n_hour && self.var_f6197f53 <= var_f6197f53)
	{
		while(self.var_f6197f53 != var_f6197f53)
		{
			function_783891ed();
		}
		return;
	}
	if(self.var_f6197f53 <= var_f6197f53)
	{
		while(self.n_hour != n_hour)
		{
			function_64c53556();
		}
		while(self.var_f6197f53 != var_f6197f53)
		{
			function_783891ed();
		}
		return;
	}
	var_c6781a1b = self.n_hour + 1;
	if(var_c6781a1b == 12)
	{
		var_c6781a1b = 0;
	}
	while(var_c6781a1b != n_hour)
	{
		function_64c53556();
		var_c6781a1b = self.n_hour + 1;
		if(var_c6781a1b == 12)
		{
			var_c6781a1b = 0;
		}
	}
	while(self.var_f6197f53 != var_f6197f53)
	{
		function_783891ed();
	}
}

/*
	Name: function_64c53556
	Namespace: namespace_3be0b7ad
	Checksum: 0x68E2EE62
	Offset: 0x2D8
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_64c53556()
{
	for(i = 0; i < 4; i++)
	{
		function_783891ed();
	}
}

/*
	Name: function_fba6efd4
	Namespace: namespace_3be0b7ad
	Checksum: 0x3FC02614
	Offset: 0x320
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_fba6efd4()
{
	function_9e6251db("slow");
}

/*
	Name: function_783891ed
	Namespace: namespace_3be0b7ad
	Checksum: 0x809A18CB
	Offset: 0x348
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_783891ed()
{
	function_9e6251db("fast");
}

/*
	Name: function_9e6251db
	Namespace: namespace_3be0b7ad
	Checksum: 0xE90EF784
	Offset: 0x370
	Size: 0x1E6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e6251db(var_c03fe9e3)
{
	if(!isdefined(self.n_hour))
	{
		self.n_hour = 0;
	}
	if(!isdefined(self.var_f6197f53))
	{
		self.var_f6197f53 = 0;
	}
	var_cb3d2b85 = self.hour_hand.angles;
	var_86c6b8df = var_cb3d2b85[0] - 7.5;
	var_f6197f53 = self.var_f6197f53;
	var_e51ab168 = var_f6197f53 + 1;
	self.var_f6197f53++;
	var_64807aea = (((("pos_" + var_f6197f53) + "_to_") + var_e51ab168) + "_") + var_c03fe9e3;
	var_c74251a4 = scene::function_8582657c(self.scriptbundlename, var_64807aea);
	if(var_c74251a4 <= 0)
	{
		if(var_c03fe9e3 == "fast")
		{
			var_c74251a4 = 0.166;
		}
		else
		{
			var_c74251a4 = 0.333;
		}
	}
	self.hour_hand rotatepitch(-7.5, var_c74251a4);
	self scene::play(var_64807aea);
	self.hour_hand.angles = (var_86c6b8df, var_cb3d2b85[1], var_cb3d2b85[2]);
	if(self.var_f6197f53 == 4)
	{
		self.var_f6197f53 = 0;
		self.n_hour++;
		if(self.n_hour == 12)
		{
			self.n_hour = 0;
		}
	}
}

