// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace gestures;

/*
	Name: __init__system__
	Namespace: gestures
	Checksum: 0xFEE3996D
	Offset: 0xA8
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"gestures", undefined, &main, undefined);
}

/*
	Name: main
	Namespace: gestures
	Checksum: 0xD0619651
	Offset: 0xE8
	Size: 0x324
	Parameters: 0
	Flags: Linked
*/
function main()
{
	function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_dw");
	function_a5202150(#"hash_419f11534af12a76", "sig_buckler_dw");
	function_a5202150(#"ges_blinded", "sig_buckler_dw");
	function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_dw");
	function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_dw");
	function_a5202150(#"ges_grab", "sig_buckler_dw");
	function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_dw");
	function_a5202150(#"hash_577f00f59de390db", "sig_buckler_dw");
	function_a5202150(#"ges_shocked", "sig_buckler_dw");
	function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_dw");
	function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_turret");
	function_a5202150(#"hash_419f11534af12a76", "sig_buckler_turret");
	function_a5202150(#"ges_blinded", "sig_buckler_turret");
	function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_turret");
	function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_turret");
	function_a5202150(#"ges_grab", "sig_buckler_turret");
	function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_turret");
	function_a5202150(#"hash_577f00f59de390db", "sig_buckler_turret");
	function_a5202150(#"ges_shocked", "sig_buckler_turret");
	function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_turret");
}

/*
	Name: give_gesture
	Namespace: gestures
	Checksum: 0x8134E42C
	Offset: 0x418
	Size: 0xC2
	Parameters: 1
	Flags: None
*/
function give_gesture(gestureweapon)
{
	/#
		assert(gestureweapon != level.weaponnone, "");
	#/
	/#
		assert(!isdefined(self.gestureweapon) || self.gestureweapon == level.weaponnone, "");
	#/
	self setactionslot(3, "taunt");
	self giveweapon(gestureweapon);
	self.gestureweapon = gestureweapon;
}

/*
	Name: clear_gesture
	Namespace: gestures
	Checksum: 0x35D4A0DA
	Offset: 0x4E8
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function clear_gesture()
{
	self notify(#"cleargesture");
	if(isdefined(self.gestureweapon) && self.gestureweapon != level.weaponnone)
	{
		self setactionslot(3, "");
		self takeweapon(self.gestureweapon);
		self.gestureweapon = level.weaponnone;
	}
}

/*
	Name: function_e198bde3
	Namespace: gestures
	Checksum: 0xA8BDBF04
	Offset: 0x580
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_e198bde3(var_ee58f129)
{
	if(!isdefined(var_ee58f129))
	{
		return 0;
	}
	if(var_ee58f129 == "")
	{
		return 0;
	}
	var_45e6768d = var_ee58f129;
	if(!ishash(var_45e6768d))
	{
		var_45e6768d = hash(var_45e6768d);
	}
	return var_45e6768d;
}

/*
	Name: function_a5202150
	Namespace: gestures
	Checksum: 0x4CE8AB5F
	Offset: 0x600
	Size: 0x192
	Parameters: 2
	Flags: Linked
*/
function function_a5202150(var_ee58f129, weaponname)
{
	if(!isdefined(level.var_5ccfbb37))
	{
		level.var_5ccfbb37 = [];
	}
	var_45e6768d = function_e198bde3(var_ee58f129);
	if(!ishash(var_45e6768d))
	{
		return;
	}
	weapon = getweapon(weaponname);
	if(!isdefined(weapon) || weapon == level.weaponnone)
	{
		return;
	}
	if(!isdefined(level.var_5ccfbb37[var_45e6768d]))
	{
		level.var_5ccfbb37[var_45e6768d] = spawnstruct();
	}
	if(!isdefined(level.var_5ccfbb37[var_45e6768d].weapons))
	{
		level.var_5ccfbb37[var_45e6768d].weapons = [];
	}
	if(!isdefined(level.var_5ccfbb37[var_45e6768d].weapons[weapon]))
	{
		level.var_5ccfbb37[var_45e6768d].weapons[weapon] = spawnstruct();
	}
	level.var_5ccfbb37[var_45e6768d].weapons[weapon].var_fa9d3758 = 1;
}

/*
	Name: function_ba4529d4
	Namespace: gestures
	Checksum: 0x3D048EA7
	Offset: 0x7A0
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function function_ba4529d4(var_ee58f129)
{
	if(!isdefined(level.var_5ccfbb37))
	{
		level.var_5ccfbb37 = [];
	}
	var_45e6768d = function_e198bde3(var_ee58f129);
	if(!ishash(var_45e6768d))
	{
		return;
	}
	if(!isdefined(level.var_5ccfbb37[var_45e6768d]))
	{
		level.var_5ccfbb37[var_45e6768d] = spawnstruct();
	}
	level.var_5ccfbb37[var_45e6768d].var_93380a93 = 1;
}

/*
	Name: function_8cc27b6d
	Namespace: gestures
	Checksum: 0x26F4E297
	Offset: 0x868
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function function_8cc27b6d(var_ee58f129)
{
	var_45e6768d = function_e198bde3(var_ee58f129);
	if(!ishash(var_45e6768d))
	{
		return false;
	}
	weapon = self getcurrentweapon();
	if(isdefined(self.disablegestures) && self.disablegestures)
	{
		return false;
	}
	if(!isdefined(weapon) || level.weaponnone == weapon)
	{
		return false;
	}
	if(isdefined(weapon.var_d2751f9d) && weapon.var_d2751f9d)
	{
		return false;
	}
	if(isdefined(weapon.var_554be9f7) && weapon.var_554be9f7 && self isfiring())
	{
		return false;
	}
	if(isdefined(level.var_5ccfbb37) && isdefined(level.var_5ccfbb37[var_45e6768d]) && isdefined(level.var_5ccfbb37[var_45e6768d].weapons) && isdefined(level.var_5ccfbb37[var_45e6768d].weapons[weapon.rootweapon]) && (isdefined(level.var_5ccfbb37[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758) && level.var_5ccfbb37[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758))
	{
		return false;
	}
	if(weapon.isdualwield && isdefined(level.var_5ccfbb37) && isdefined(level.var_5ccfbb37[var_45e6768d]) && (isdefined(level.var_5ccfbb37[var_45e6768d].var_93380a93) && level.var_5ccfbb37[var_45e6768d].var_93380a93))
	{
		return false;
	}
	if(self function_55acff10())
	{
		return false;
	}
	return true;
}

/*
	Name: function_c77349d4
	Namespace: gestures
	Checksum: 0x5C7D1349
	Offset: 0xAE0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_c77349d4(var_851342cf)
{
	var_ee58f129 = undefined;
	if(isdefined(var_851342cf))
	{
		weapon = self getcurrentweapon();
		var_53050505 = weapon.var_6566504b;
		var_ee58f129 = function_d12fe2ad(var_851342cf, var_53050505);
	}
	return var_ee58f129;
}

/*
	Name: play_gesture
	Namespace: gestures
	Checksum: 0x760B682
	Offset: 0xB60
	Size: 0x8E
	Parameters: 7
	Flags: Linked
*/
function play_gesture(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall)
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(self function_8cc27b6d(var_ee58f129))
	{
		return self function_b6cc48ed(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
	}
	return 0;
}

/*
	Name: function_b6cc48ed
	Namespace: gestures
	Checksum: 0xDBAAEF5D
	Offset: 0xBF8
	Size: 0x6A
	Parameters: 7
	Flags: Linked
*/
function function_b6cc48ed(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall)
{
	return self playgestureviewmodel(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

/*
	Name: function_56e00fbf
	Namespace: gestures
	Checksum: 0x153B54C
	Offset: 0xC70
	Size: 0x92
	Parameters: 7
	Flags: None
*/
function function_56e00fbf(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall)
{
	if(!isdefined(self))
	{
		return 0;
	}
	var_ee58f129 = self function_c77349d4(var_851342cf);
	return play_gesture(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

/*
	Name: function_e62f6dde
	Namespace: gestures
	Checksum: 0xA28E9483
	Offset: 0xD10
	Size: 0x92
	Parameters: 7
	Flags: None
*/
function function_e62f6dde(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall)
{
	if(!isdefined(self))
	{
		return 0;
	}
	var_ee58f129 = self function_c77349d4(var_851342cf);
	return function_b6cc48ed(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, stopall);
}

/*
	Name: function_f3e2696f
	Namespace: gestures
	Checksum: 0x56057E39
	Offset: 0xDB0
	Size: 0x23A
	Parameters: 7
	Flags: Linked
*/
function function_f3e2696f(ent, weapon, weapon_options, timeout, var_1e89628f, var_1d78d31, callbackfail)
{
	self endon(#"death");
	self disableweaponcycling();
	while(self isswitchingweapons())
	{
		waitframe(1);
	}
	self enableweaponcycling();
	var_f3b15ce0 = 0;
	if(!self giveandfireoffhand(weapon, weapon_options))
	{
		if(isdefined(callbackfail))
		{
			self [[callbackfail]](ent, var_f3b15ce0);
		}
		return;
	}
	while(true)
	{
		result = undefined;
		result = self waittilltimeout(timeout, #"grenade_pullback", #"offhand_fire", #"offhand_end");
		if(result._notify == #"timeout")
		{
			break;
		}
		if(result.weapon == weapon)
		{
			if(result._notify == #"offhand_end")
			{
				break;
			}
			else
			{
				if(result._notify == #"grenade_pullback")
				{
					var_f3b15ce0 = 1;
					if(isdefined(var_1e89628f))
					{
						self [[var_1e89628f]](ent);
					}
					continue;
				}
				else if(result._notify == #"offhand_fire")
				{
					if(isdefined(var_1d78d31))
					{
						self [[var_1d78d31]](ent);
					}
					return;
				}
			}
		}
	}
	if(isdefined(callbackfail))
	{
		self [[callbackfail]](ent, var_f3b15ce0);
	}
}

