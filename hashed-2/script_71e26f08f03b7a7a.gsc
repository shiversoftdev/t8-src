// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6de2f7255a97ab00;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_3d2704b3;

/*
	Name: function_89f2df9
	Namespace: namespace_3d2704b3
	Checksum: 0xF01AB1AC
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_280fe2667ed2d300", &__init__, undefined, #"hash_c70352f852fda84");
}

/*
	Name: __init__
	Namespace: namespace_3d2704b3
	Checksum: 0x118AC00C
	Offset: 0xD8
	Size: 0x6E
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	level.var_2ead97d1 = [];
	level.var_ef5dbc90 = [];
}

/*
	Name: function_2d47ee1e
	Namespace: namespace_3d2704b3
	Checksum: 0x3AB48519
	Offset: 0x150
	Size: 0x15E
	Parameters: 6
	Flags: Linked, Private
*/
private function function_2d47ee1e(var_6ed927a6, var_caba78c2, waittime, var_ef5e1b44, var_d6388d1 = 0, vehicletype = undefined)
{
	if(isdefined(var_d6388d1) && var_d6388d1 && !isdefined(vehicletype))
	{
		return;
	}
	wait(randomfloatrange(var_caba78c2, waittime));
	if(isdefined(var_6ed927a6) && !var_d6388d1)
	{
		level callback::callback(#"hash_258e15865427fb62", var_6ed927a6);
		if(isdefined(level.var_ef5dbc90[var_6ed927a6]))
		{
			var_6ed927a6 = level.var_ef5dbc90[var_6ed927a6];
		}
	}
	var_58ca2822 = !var_ef5e1b44.var_7f40d76c;
	var_ef5e1b44.var_7f40d76c = 1;
	level thread namespace_8f74625a::function_418e26fe(var_6ed927a6, var_d6388d1, var_58ca2822, var_ef5e1b44.heightoffset, var_d6388d1, vehicletype);
	var_ef5e1b44.heightoffset = var_ef5e1b44.heightoffset + 600;
}

/*
	Name: function_f0297225
	Namespace: namespace_3d2704b3
	Checksum: 0xE1D3E740
	Offset: 0x2B8
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function function_f0297225(var_2ab9d3bd, var_f532cd9f, var_3afaa57b)
{
	if(!function_7a600918(var_2ab9d3bd) || !isint(var_f532cd9f) || !isint(var_3afaa57b))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(var_3afaa57b <= 0)
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(level.var_2ead97d1[var_3afaa57b]))
	{
		level.var_2ead97d1[var_3afaa57b] = [];
	}
	var_37d0690b = level.var_2ead97d1[var_3afaa57b].size;
	level.var_2ead97d1[var_3afaa57b][var_37d0690b] = {#count:var_f532cd9f, #replacement:var_2ab9d3bd};
}

/*
	Name: function_d0178153
	Namespace: namespace_3d2704b3
	Checksum: 0xB62AA31A
	Offset: 0x3F0
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_d0178153(var_2ab9d3bd)
{
	level.var_ef5dbc90[var_2ab9d3bd] = #"hash_696141fcc5f2e372";
}

/*
	Name: start
	Namespace: namespace_3d2704b3
	Checksum: 0xDF33B052
	Offset: 0x428
	Size: 0x836
	Parameters: 3
	Flags: Linked
*/
function start(var_b76aef06 = 1, minwaittime = 20, var_fe6b2eab = 20)
{
	if(isint(var_b76aef06) && var_b76aef06 < 1)
	{
		return;
	}
	level flagsys::wait_till(#"hash_405e46788e83af41");
	if(isarray(minwaittime))
	{
		foreach(key, value in minwaittime)
		{
			minwaittime[key] = minwaittime[key] * level.var_8d8322b4;
		}
	}
	else
	{
		minwaittime = minwaittime * level.var_8d8322b4;
	}
	if(isarray(var_fe6b2eab))
	{
		foreach(key, value in var_fe6b2eab)
		{
			var_fe6b2eab[key] = var_fe6b2eab[key] * level.var_8d8322b4;
		}
	}
	else
	{
		var_fe6b2eab = var_fe6b2eab / level.var_8d8322b4;
	}
	var_b2003e21 = 0;
	if(!isarray(var_b76aef06))
	{
		var_b2003e21 = var_b76aef06;
		var_b76aef06 = [];
		for(index = 0; index < var_b2003e21; index++)
		{
			var_b76aef06[index] = 1;
		}
	}
	else
	{
		for(index = 0; index < var_b76aef06.size; index++)
		{
			var_b2003e21 = var_b2003e21 + var_b76aef06[index];
		}
	}
	var_7003bde7 = [];
	var_68f65b5a = getarraykeys(level.var_2ead97d1);
	for(index = var_68f65b5a.size - 1; index >= 0; index--)
	{
		var_3afaa57b = var_68f65b5a[index];
		var_64f52ca3 = [];
		for(var_77c44f00 = 0; var_77c44f00 < var_3afaa57b; var_77c44f00++)
		{
			var_64f52ca3[var_64f52ca3.size] = var_77c44f00;
		}
		for(var_a6872bd0 = 0; var_a6872bd0 < var_64f52ca3.size; var_a6872bd0++)
		{
			randindex = randomint(var_64f52ca3.size);
			var_521b73a = var_64f52ca3[var_a6872bd0];
			var_64f52ca3[var_a6872bd0] = var_64f52ca3[randindex];
			var_64f52ca3[randindex] = var_521b73a;
		}
		replacements = level.var_2ead97d1[var_3afaa57b];
		for(var_4d83f68a = 0; var_4d83f68a < replacements.size; var_4d83f68a++)
		{
			randindex = randomint(replacements.size);
			var_521b73a = replacements[var_4d83f68a];
			replacements[var_4d83f68a] = replacements[randindex];
			replacements[randindex] = var_521b73a;
		}
		var_b7d663a9 = 0;
		foreach(replacement in replacements)
		{
			var_b1229237 = GetNextArrayKey(var_a4b2a635, var_29604996);
			while(var_b7d663a9 < var_64f52ca3.size && replacement.count > 0)
			{
				var_efecc884 = var_64f52ca3[var_b7d663a9];
				if(isdefined(var_7003bde7[var_efecc884]))
				{
				}
				else
				{
					var_7003bde7[var_efecc884] = replacement.replacement;
					replacement.count--;
				}
				var_b7d663a9++;
			}
		}
	}
	var_77c44f00 = 0;
	var_f2cf27c4 = 0;
	while(true)
	{
		if(!isdefined(level.var_52b56362))
		{
			return;
		}
		deathcircle = level.var_fb91af8[level.var_52b56362];
		var_caba78c2 = minwaittime;
		if(isarray(minwaittime))
		{
			var_caba78c2 = minwaittime[int(min(var_77c44f00, minwaittime.size - 1))];
		}
		var_205efcd5 = var_fe6b2eab;
		if(isarray(var_fe6b2eab))
		{
			var_205efcd5 = var_fe6b2eab[int(min(var_77c44f00, var_fe6b2eab.size - 1))];
		}
		var_edd69b13 = deathcircle.var_edd69b13;
		var_fdd51794 = deathcircle.var_fdd51794;
		var_7565ca79 = var_edd69b13 + var_fdd51794;
		waittime = var_7565ca79 - var_205efcd5;
		var_ef5e1b44 = spawnstruct();
		var_ef5e1b44.var_7f40d76c = 0;
		var_ef5e1b44.heightoffset = 0;
		if(waittime > var_caba78c2)
		{
			var_972b892d = var_b76aef06[var_f2cf27c4];
			if(var_972b892d > 0)
			{
				var_9356dcab = randomint(var_972b892d);
				for(index = 0; index < var_972b892d; index++)
				{
					var_6ed927a6 = undefined;
					if(index == var_9356dcab)
					{
						var_6ed927a6 = var_7003bde7[var_f2cf27c4];
					}
					if(isdefined(level.var_2089aa11) && !isdefined(var_6ed927a6) && (isdefined(getgametypesetting(#"hash_24918193d72a5866")) && getgametypesetting(#"hash_24918193d72a5866")))
					{
						var_6ed927a6 = level.var_2089aa11;
					}
					level thread function_2d47ee1e(var_6ed927a6, var_caba78c2, waittime, var_ef5e1b44);
					var_77c44f00++;
				}
			}
		}
		if(var_77c44f00 >= var_b2003e21)
		{
			return;
		}
		level waittill(#"hash_1ff3496c9049969");
		var_f2cf27c4++;
	}
}

/*
	Name: function_1c1e1a45
	Namespace: namespace_3d2704b3
	Checksum: 0xDB19A763
	Offset: 0xC68
	Size: 0xD0
	Parameters: 2
	Flags: Linked
*/
function function_1c1e1a45(var_b3b96cdb = undefined, var_47d17dcb = 0)
{
	level flagsys::wait_till(#"hash_405e46788e83af41");
	var_3d3a70a8 = 0;
	while(true)
	{
		if(!isdefined(level.var_52b56362))
		{
			return;
		}
		level thread namespace_8f74625a::function_7d4a448f(var_47d17dcb);
		var_3d3a70a8++;
		if(isdefined(var_b3b96cdb) && var_3d3a70a8 > var_b3b96cdb)
		{
			return;
		}
		level waittill(#"hash_1ff3496c9049969");
	}
}

/*
	Name: function_9d6e1370
	Namespace: namespace_3d2704b3
	Checksum: 0xCBCB2359
	Offset: 0xD40
	Size: 0x526
	Parameters: 4
	Flags: Linked
*/
function function_9d6e1370(vehicletype, var_b76aef06 = 1, minwaittime = 20, var_fe6b2eab = 20)
{
	if(!isdefined(vehicletype))
	{
		return;
	}
	if(isint(var_b76aef06) && var_b76aef06 < 1)
	{
		return;
	}
	level flagsys::wait_till(#"hash_405e46788e83af41");
	if(isarray(minwaittime))
	{
		foreach(key, value in minwaittime)
		{
			minwaittime[key] = minwaittime[key] * level.var_8d8322b4;
		}
	}
	else
	{
		minwaittime = minwaittime * level.var_8d8322b4;
	}
	if(isarray(var_fe6b2eab))
	{
		foreach(key, value in var_fe6b2eab)
		{
			var_fe6b2eab[key] = var_fe6b2eab[key] * level.var_8d8322b4;
		}
	}
	else
	{
		var_fe6b2eab = var_fe6b2eab / level.var_8d8322b4;
	}
	var_b2003e21 = 0;
	if(!isarray(var_b76aef06))
	{
		var_b2003e21 = var_b76aef06;
		var_b76aef06 = [];
		for(index = 0; index < var_b2003e21; index++)
		{
			var_b76aef06[index] = 1;
		}
	}
	else
	{
		for(index = 0; index < var_b76aef06.size; index++)
		{
			var_b2003e21 = var_b2003e21 + var_b76aef06[index];
		}
	}
	var_77c44f00 = 0;
	var_f2cf27c4 = 0;
	while(true)
	{
		if(!isdefined(level.var_52b56362))
		{
			return;
		}
		deathcircle = level.var_fb91af8[level.var_52b56362];
		var_caba78c2 = minwaittime;
		if(isarray(minwaittime))
		{
			var_caba78c2 = minwaittime[int(min(var_77c44f00, minwaittime.size - 1))];
		}
		var_205efcd5 = var_fe6b2eab;
		if(isarray(var_fe6b2eab))
		{
			var_205efcd5 = var_fe6b2eab[int(min(var_77c44f00, var_fe6b2eab.size - 1))];
		}
		var_edd69b13 = deathcircle.var_edd69b13;
		var_fdd51794 = deathcircle.var_fdd51794;
		var_7565ca79 = var_edd69b13 + var_fdd51794;
		waittime = var_7565ca79 - var_205efcd5;
		var_ef5e1b44 = spawnstruct();
		var_ef5e1b44.var_7f40d76c = 1;
		var_ef5e1b44.heightoffset = 0;
		var_30d3ad8b = vehicletype;
		if(isarray(vehicletype))
		{
			var_30d3ad8b = vehicletype[randomint(vehicletype.size)];
		}
		if(waittime > var_caba78c2)
		{
			var_972b892d = var_b76aef06[var_f2cf27c4];
			for(index = 0; index < var_972b892d; index++)
			{
				level thread function_2d47ee1e(undefined, var_caba78c2, waittime, var_ef5e1b44, 1, var_30d3ad8b);
				var_77c44f00++;
			}
		}
		if(var_77c44f00 >= var_b2003e21)
		{
			return;
		}
		level waittill(#"hash_1ff3496c9049969");
		var_f2cf27c4++;
	}
}

