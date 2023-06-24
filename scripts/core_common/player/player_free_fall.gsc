// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d29de500c266470;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace player_free_fall;

/*
	Name: __init__system__
	Namespace: player_free_fall
	Checksum: 0x2F5540DF
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"player_free_fall", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: player_free_fall
	Checksum: 0x57B1FBCA
	Offset: 0x120
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::add_callback(#"freefall", &function_c9a18304);
	callback::add_callback(#"parachute", &function_26d46af3);
	callback::add_callback(#"debug_movement", &function_a7e644f6);
	level.parachute_weapon = getweapon(#"parachute");
	/#
		level thread function_1fc427dc();
	#/
}

/*
	Name: function_d2a1520c
	Namespace: player_free_fall
	Checksum: 0x77085261
	Offset: 0x208
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_d2a1520c()
{
	wingsuit = self namespace_eb06e24d::function_c772633d();
	if(self util::is_female())
	{
		return wingsuit.var_5677bd3d;
	}
	return wingsuit.var_94166112;
}

/*
	Name: function_c9a18304
	Namespace: player_free_fall
	Checksum: 0xAAC5184E
	Offset: 0x268
	Size: 0x204
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c9a18304(eventstruct)
{
	model = function_d2a1520c();
	if(eventstruct.freefall)
	{
		if(!self isattached(model))
		{
			self attach(model);
		}
		if(!isdefined(eventstruct.var_695a7111) || eventstruct.var_695a7111)
		{
			parachute = self namespace_eb06e24d::function_fc6b6f3b();
			parachute_weapon = parachute.("parachute");
			if(isdefined(parachute_weapon))
			{
				if(!self hasweapon(parachute_weapon))
				{
					self giveweapon(parachute_weapon);
				}
				self switchtoweaponimmediate(parachute_weapon);
				self thread function_b6e83203(0.5);
			}
		}
	}
	else
	{
		if(self isattached(model))
		{
			self detach(model);
		}
		if(!self function_9a0edd92())
		{
			parachute = self namespace_eb06e24d::function_fc6b6f3b();
			parachute_weapon = parachute.("parachute");
			if(isdefined(parachute_weapon))
			{
				if(self hasweapon(parachute_weapon))
				{
					self takeweapon(parachute_weapon);
				}
			}
		}
		self setclientuivisibilityflag("weapon_hud_visible", 1);
	}
}

/*
	Name: function_6aac1790
	Namespace: player_free_fall
	Checksum: 0x293771BD
	Offset: 0x478
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6aac1790(var_dbb94a)
{
}

/*
	Name: function_b6e83203
	Namespace: player_free_fall
	Checksum: 0xD8867FCF
	Offset: 0x4C0
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b6e83203(delay)
{
	if(isdefined(delay))
	{
		self endon(#"death", #"disconnect");
		wait(delay);
	}
	parachute = self namespace_eb06e24d::function_fc6b6f3b();
	var_dbb94a = parachute.("parachuteLit");
	function_6aac1790(var_dbb94a);
}

/*
	Name: function_26d46af3
	Namespace: player_free_fall
	Checksum: 0x1E40B82E
	Offset: 0x558
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_26d46af3(eventstruct)
{
	if(eventstruct.parachute)
	{
		self function_b6e83203();
	}
	else
	{
		parachute = self namespace_eb06e24d::function_fc6b6f3b();
		parachute_weapon = parachute.("parachute");
		var_dbb94a = parachute.("parachuteLit");
		if(isdefined(parachute_weapon))
		{
			self takeweapon(parachute_weapon);
		}
	}
}

/*
	Name: function_a7e644f6
	Namespace: player_free_fall
	Checksum: 0xA076007C
	Offset: 0x610
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a7e644f6(eventstruct)
{
	if(!eventstruct.debug_movement)
	{
		if(getdvarint(#"hash_bfa71d08f383550", 0))
		{
			speed = 8800;
			velocity = anglestoforward(self getplayerangles()) * speed;
			self function_2ffa8aaf(1, velocity, getdvarint(#"hash_bfa71d08f383550", 0) == 1);
		}
	}
}

/*
	Name: function_1fc427dc
	Namespace: player_free_fall
	Checksum: 0x9C550484
	Offset: 0x6F0
	Size: 0x124
	Parameters: 0
	Flags: Private
*/
function private function_1fc427dc()
{
	/#
		mapname = util::get_map_name();
		waitframe(1);
		waitframe(1);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		adddebugcommand(("" + mapname) + "");
		waitframe(1);
		adddebugcommand(("" + mapname) + "");
	#/
}

