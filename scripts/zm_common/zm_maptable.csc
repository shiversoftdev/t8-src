// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace zm_maptable;

/*
	Name: function_10672567
	Namespace: zm_maptable
	Checksum: 0x6E3E443D
	Offset: 0x70
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function function_10672567()
{
	if(!isdefined(level.maptableentry))
	{
		mapname = util::get_map_name();
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
		level.maptableentry = fields;
	}
	return level.maptableentry;
}

/*
	Name: get_cast
	Namespace: zm_maptable
	Checksum: 0x1AC6ABE3
	Offset: 0x1C8
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function get_cast()
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
	Name: get_story
	Namespace: zm_maptable
	Checksum: 0x34DAAB84
	Offset: 0x230
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function get_story()
{
	var_26ea2807 = get_cast();
	if(var_26ea2807 === #"story1")
	{
		return 1;
	}
	return 2;
}

