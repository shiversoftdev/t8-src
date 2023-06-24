// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_death_perception;

/*
	Name: __init__system__
	Namespace: zm_perk_death_perception
	Checksum: 0x7C757FB5
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_death_perception", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_death_perception
	Checksum: 0x23561A04
	Offset: 0x1C0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_death_perception_perk_for_level();
	level.var_1c1febec = [];
	for(i = 0; i < getmaxlocalclients(); i++)
	{
		level.var_1c1febec[i] = 0;
	}
	ai::add_ai_spawn_function(&function_731d83de);
	scene::function_2e58158b(&function_dd6c1a8b);
	zm_perks::function_f3c80d73("zombie_perk_bottle_death_perception", "zombie_perk_totem_death_perception");
}

/*
	Name: enable_death_perception_perk_for_level
	Namespace: zm_perk_death_perception
	Checksum: 0xD4B9274A
	Offset: 0x290
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function enable_death_perception_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_awareness", &function_6e0b6101, &function_95ed7b4a);
	zm_perks::register_perk_effects(#"specialty_awareness", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_awareness", &function_9b484511);
	zm_perks::function_b60f4a9f(#"specialty_awareness", #"p8_zm_vapor_altar_icon_01_deathperception", "zombie/fx8_perk_altar_symbol_ambient_death_perception", #"zmperksdeathperception");
}

/*
	Name: function_9b484511
	Namespace: zm_perk_death_perception
	Checksum: 0x80F724D1
	Offset: 0x380
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_9b484511()
{
}

/*
	Name: function_6e0b6101
	Namespace: zm_perk_death_perception
	Checksum: 0xED8E8CB9
	Offset: 0x390
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_6e0b6101()
{
	clientfield::register("toplayer", "perk_death_perception_visuals", 1, 1, "int", &perk_death_perception_visuals, 0, 0);
}

/*
	Name: function_95ed7b4a
	Namespace: zm_perk_death_perception
	Checksum: 0x80F724D1
	Offset: 0x3E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_95ed7b4a()
{
}

/*
	Name: perk_death_perception_visuals
	Namespace: zm_perk_death_perception
	Checksum: 0x131392DA
	Offset: 0x3F8
	Size: 0x226
	Parameters: 7
	Flags: Linked
*/
function perk_death_perception_visuals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(newval && (!(isdefined(level.var_dc60105c) && level.var_dc60105c)) && !isigcactive(localclientnum))
	{
		level.var_1c1febec[localclientnum] = 1;
		a_ai = function_793a9f3d(localclientnum);
		foreach(ai in a_ai)
		{
			ai function_731d83de(localclientnum);
		}
		self thread function_fff5377e(localclientnum);
	}
	else
	{
		level.var_1c1febec[localclientnum] = 0;
		a_ai = function_793a9f3d(localclientnum);
		foreach(ai in a_ai)
		{
			ai stoprenderoverridebundle(#"hash_30651f363ef055e9");
		}
		self notify(#"hash_45ed6efeef67b773");
	}
}

/*
	Name: function_731d83de
	Namespace: zm_perk_death_perception
	Checksum: 0xC0DEE1F1
	Offset: 0x628
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_731d83de(localclientnum)
{
	if(level.var_1c1febec[localclientnum] && self.team === #"axis")
	{
		self playrenderoverridebundle(#"hash_30651f363ef055e9");
	}
}

/*
	Name: function_fff5377e
	Namespace: zm_perk_death_perception
	Checksum: 0xFA170F32
	Offset: 0x690
	Size: 0x284
	Parameters: 1
	Flags: Linked
*/
function function_fff5377e(localclientnum)
{
	self endon(#"death", #"hash_45ed6efeef67b773");
	while(true)
	{
		if(!(isdefined(level.var_dc60105c) && level.var_dc60105c) && !isigcactive(localclientnum))
		{
			a_ai = function_793a9f3d(localclientnum);
			a_ai = arraysortclosest(a_ai, self.origin, undefined, undefined, 200);
			var_8475afc1 = anglestoforward(self.angles);
			foreach(ai in a_ai)
			{
				if(isalive(ai))
				{
					if(vectordot(var_8475afc1, vectornormalize(ai.origin - self.origin)) < 0.35)
					{
						var_f2c7b8b0 = ai.origin;
						if(ai.type === #"vehicle")
						{
							var_f2c7b8b0 = (ai.origin[0], ai.origin[1], self.origin[2]);
						}
						var_5d77125a = 1000 * ((0.05 + (0.016 * a_ai.size)) + 0.015);
						self addawarenessindicator(var_f2c7b8b0, "noncombat_danger", int(var_5d77125a));
					}
					waitframe(1);
				}
			}
		}
		wait(0.05);
	}
}

/*
	Name: function_793a9f3d
	Namespace: zm_perk_death_perception
	Checksum: 0xFCC7A624
	Offset: 0x920
	Size: 0xB2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_793a9f3d(localclientnum)
{
	a_ai = getentarraybytype(localclientnum, 15);
	a_vh = getentarraybytype(localclientnum, 12);
	a_ai = arraycombine(a_ai, a_vh, 0, 0);
	if(a_ai.size)
	{
		a_ai = array::filter(a_ai, 0, &function_6a5f77);
	}
	return a_ai;
}

/*
	Name: function_6a5f77
	Namespace: zm_perk_death_perception
	Checksum: 0xA14484D1
	Offset: 0x9E0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_6a5f77(val)
{
	return val.team === #"axis";
}

/*
	Name: function_25410869
	Namespace: zm_perk_death_perception
	Checksum: 0x18C25123
	Offset: 0xA10
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_25410869(localclientnum)
{
	if(self == function_5c10bd79(localclientnum))
	{
		value = self clientfield::get_to_player("perk_death_perception_visuals");
		self perk_death_perception_visuals(localclientnum, undefined, value, undefined, undefined, undefined, undefined);
	}
}

/*
	Name: function_dd6c1a8b
	Namespace: zm_perk_death_perception
	Checksum: 0x5B713F60
	Offset: 0xA90
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_dd6c1a8b(localclientnum, b_igc_active)
{
	self function_25410869(localclientnum);
}

