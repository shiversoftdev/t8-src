// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace namespace_cb7fdaf1;

/*
	Name: function_755c26d1
	Namespace: namespace_cb7fdaf1
	Checksum: 0x12B2F9EF
	Offset: 0x90
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function function_755c26d1()
{
	level.var_1a7a3f05 = spawnstruct();
	i = 0;
	level.var_1a7a3f05.var_23e0aef1 = [];
	while(isdefined(var_23e0aef1) && isarray(var_23e0aef1) && var_23e0aef1.size > 0)
	{
		level.var_1a7a3f05.var_23e0aef1[i] = var_23e0aef1;
		waitframe(1);
		i++;
		var_23e0aef1 = getentarray("vol_tregion_lane_" + i, "targetname");
	}
	level.var_1a7a3f05.var_7c70464e = i;
}

/*
	Name: function_9fe18733
	Namespace: namespace_cb7fdaf1
	Checksum: 0x65867A6A
	Offset: 0x1A8
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_9fe18733()
{
	if(!isdefined(level.var_1a7a3f05) || !isdefined(level.var_1a7a3f05.var_7c70464e))
	{
		return 0;
	}
	return level.var_1a7a3f05.var_7c70464e;
}

/*
	Name: function_a129ecda
	Namespace: namespace_cb7fdaf1
	Checksum: 0x78CD96C8
	Offset: 0x1F8
	Size: 0x82
	Parameters: 3
	Flags: None
*/
function function_a129ecda(startpos, endpos, var_d108dac6)
{
	function_871ecf05();
	volumes = function_8373f930(var_d108dac6);
	function_c5b9e623(volumes, 0.2);
	return function_e86822f4(startpos, endpos);
}

/*
	Name: function_b0f112ca
	Namespace: namespace_cb7fdaf1
	Checksum: 0xA21148AA
	Offset: 0x288
	Size: 0x82
	Parameters: 3
	Flags: None
*/
function function_b0f112ca(var_55e8adf1, var_d3547bb1, var_d108dac6)
{
	function_871ecf05();
	volumes = function_8373f930(var_d108dac6);
	function_c5b9e623(volumes, 0.2);
	return function_afd64b51(var_55e8adf1, var_d3547bb1);
}

/*
	Name: function_871ecf05
	Namespace: namespace_cb7fdaf1
	Checksum: 0x6A3E2F3E
	Offset: 0x318
	Size: 0x6E
	Parameters: 0
	Flags: Private
*/
private function function_871ecf05()
{
	for(i = 1; i < 128; i++)
	{
		info = function_b507a336(i);
		if(!isdefined(info))
		{
			break;
		}
		function_e563d6b7(i, 1);
	}
}

/*
	Name: function_8373f930
	Namespace: namespace_cb7fdaf1
	Checksum: 0xF81ADC8B
	Offset: 0x390
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
private function function_8373f930(var_d108dac6)
{
	return level.var_1a7a3f05.var_23e0aef1[var_d108dac6];
}

/*
	Name: function_c5b9e623
	Namespace: namespace_cb7fdaf1
	Checksum: 0xA5BBA723
	Offset: 0x3C0
	Size: 0x13E
	Parameters: 2
	Flags: Private
*/
private function function_c5b9e623(volumes, score)
{
	if(!isarray(volumes))
	{
		return;
	}
	for(i = 1; i < 128; i++)
	{
		info = function_b507a336(i);
		if(!isdefined(info))
		{
			break;
		}
		desired = 0;
		foreach(volume in volumes)
		{
			if(volume istouching(info.origin))
			{
				desired = 1;
				break;
			}
		}
		if(desired)
		{
			function_e563d6b7(i, score);
		}
	}
}

