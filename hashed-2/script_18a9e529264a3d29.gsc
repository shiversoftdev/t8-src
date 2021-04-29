// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace namespace_cb7cafc3;

/*
	Name: function_10672567
	Namespace: namespace_cb7cafc3
	Checksum: 0x6E3E443D
	Offset: 0x70
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function function_10672567()
{
	if(!isdefined(level.var_4ada4f1f))
	{
		mapname = util::function_53bbf9d2();
		fields = getmapfields();
		if(!isdefined(fields))
		{
			fields = getmapfields(mapname, 0);
		}
		if(!isdefined(fields))
		{
			fields = getmapfields(mapname, 1);
		}
		if(!isdefined(fields))
		{
			fields = getmapfields(mapname, 2);
		}
		if(!isdefined(fields))
		{
			fields = getmapfields(mapname, 3);
		}
		if(!isdefined(fields))
		{
			fields = getmapfields(mapname, 4);
		}
		/#
			if(!isdefined(fields))
			{
				fields = getmapfields(mapname, "");
			}
		#/
		level.var_4ada4f1f = fields;
	}
	return level.var_4ada4f1f;
}

/*
	Name: function_90500af5
	Namespace: namespace_cb7cafc3
	Checksum: 0x1AC6ABE3
	Offset: 0x1C8
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_90500af5()
{
	cast = #"other";
	fields = function_10672567();
	if(isdefined(fields))
	{
		cast = fields.cast;
	}
	return cast;
}

/*
	Name: function_166646a6
	Namespace: namespace_cb7cafc3
	Checksum: 0x34DAAB84
	Offset: 0x230
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_166646a6()
{
	var_26ea2807 = function_90500af5();
	if(var_26ea2807 === #"hash_517389c0ae1875f9")
	{
		return 1;
	}
	return 2;
}

