// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_phantom_reload;

/*
	Name: __init__system__
	Namespace: zm_bgb_phantom_reload
	Checksum: 0x38FD5258
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_phantom_reload", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_phantom_reload
	Checksum: 0xF3880BE9
	Offset: 0xE0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_phantom_reload", "time", 240, &enable, &disable, undefined, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_phantom_reload
	Checksum: 0x3E8B484
	Offset: 0x160
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self thread function_44514728();
}

/*
	Name: disable
	Namespace: zm_bgb_phantom_reload
	Checksum: 0xDB3DA149
	Offset: 0x188
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self notify(#"hash_1980fe24a98adbe4");
}

/*
	Name: function_44514728
	Namespace: zm_bgb_phantom_reload
	Checksum: 0x20C66831
	Offset: 0x1A8
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function function_44514728()
{
	self endon(#"hash_1980fe24a98adbe4");
	while(true)
	{
		self waittill(#"reload_start");
		w_current = self getcurrentweapon();
		if(w_current.isabilityweapon)
		{
			continue;
		}
		if(math::cointoss(30))
		{
			n_clip_size = w_current.clipsize;
			self setweaponammoclip(w_current, n_clip_size);
		}
		self waittill(#"reload");
	}
}

