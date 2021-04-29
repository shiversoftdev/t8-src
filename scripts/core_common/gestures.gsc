// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace gestures;

/*
	Name: function_89f2df9
	Namespace: gestures
	Checksum: 0xFEE3996D
	Offset: 0xA8
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	function_a5202150(#"hash_7a39b364d97900f7", "sig_buckler_dw");
	function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_dw");
	function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_dw");
	function_a5202150(#"hash_26e7f22deb4c8e29", "sig_buckler_dw");
	function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_dw");
	function_a5202150(#"hash_577f00f59de390db", "sig_buckler_dw");
	function_a5202150(#"hash_685cf93764bc532a", "sig_buckler_dw");
	function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_dw");
	function_a5202150(#"hash_23c6eb5541cbc62f", "sig_buckler_turret");
	function_a5202150(#"hash_419f11534af12a76", "sig_buckler_turret");
	function_a5202150(#"hash_7a39b364d97900f7", "sig_buckler_turret");
	function_a5202150(#"hash_4f15a5e59317b738", "sig_buckler_turret");
	function_a5202150(#"hash_6dbb203d420a583", "sig_buckler_turret");
	function_a5202150(#"hash_26e7f22deb4c8e29", "sig_buckler_turret");
	function_a5202150(#"hash_681eef1744584fb2", "sig_buckler_turret");
	function_a5202150(#"hash_577f00f59de390db", "sig_buckler_turret");
	function_a5202150(#"hash_685cf93764bc532a", "sig_buckler_turret");
	function_a5202150(#"hash_5723248289b2a00b", "sig_buckler_turret");
}

/*
	Name: function_f8ae6f87
	Namespace: gestures
	Checksum: 0x8134E42C
	Offset: 0x418
	Size: 0xC2
	Parameters: 1
	Flags: None
*/
function function_f8ae6f87(gestureweapon)
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
	Name: function_ae63f496
	Namespace: gestures
	Checksum: 0x35D4A0DA
	Offset: 0x4E8
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_ae63f496()
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
	if(!function_7a600918(var_45e6768d))
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
	if(!function_7a600918(var_45e6768d))
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
	if(!function_7a600918(var_45e6768d))
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
	if(!function_7a600918(var_45e6768d))
	{
		return 0;
	}
	weapon = self getcurrentweapon();
	if(isdefined(self.var_89b32012) && self.var_89b32012)
	{
		return 0;
	}
	if(!isdefined(weapon) || level.weaponnone == weapon)
	{
		return 0;
	}
	if(isdefined(weapon.var_d2751f9d) && weapon.var_d2751f9d)
	{
		return 0;
	}
	if(isdefined(weapon.var_554be9f7) && weapon.var_554be9f7 && self isfiring())
	{
		return 0;
	}
	if(isdefined(level.var_5ccfbb37) && isdefined(level.var_5ccfbb37[var_45e6768d]) && isdefined(level.var_5ccfbb37[var_45e6768d].weapons) && isdefined(level.var_5ccfbb37[var_45e6768d].weapons[weapon.rootweapon]) && (isdefined(level.var_5ccfbb37[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758) && level.var_5ccfbb37[var_45e6768d].weapons[weapon.rootweapon].var_fa9d3758))
	{
		return 0;
	}
	if(weapon.isdualwield && isdefined(level.var_5ccfbb37) && isdefined(level.var_5ccfbb37[var_45e6768d]) && (isdefined(level.var_5ccfbb37[var_45e6768d].var_93380a93) && level.var_5ccfbb37[var_45e6768d].var_93380a93))
	{
		return 0;
	}
	if(self function_55acff10())
	{
		return 0;
	}
	return 1;
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
	Name: function_b204f6e3
	Namespace: gestures
	Checksum: 0x760B682
	Offset: 0xB60
	Size: 0x8E
	Parameters: 7
	Flags: Linked
*/
function function_b204f6e3(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436)
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(self function_8cc27b6d(var_ee58f129))
	{
		return self function_b6cc48ed(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436);
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
function function_b6cc48ed(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436)
{
	return self playgestureviewmodel(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436);
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
function function_56e00fbf(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436)
{
	if(!isdefined(self))
	{
		return 0;
	}
	var_ee58f129 = self function_c77349d4(var_851342cf);
	return function_b204f6e3(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436);
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
function function_e62f6dde(var_851342cf, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436)
{
	if(!isdefined(self))
	{
		return 0;
	}
	var_ee58f129 = self function_c77349d4(var_851342cf);
	return function_b6cc48ed(var_ee58f129, target, var_a085312c, blendtime, starttime, var_15fc620c, var_e67d2436);
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
function function_f3e2696f(ent, weapon, weapon_options, timeout, var_1e89628f, var_1d78d31, var_289bde21)
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
		if(isdefined(var_289bde21))
		{
			self [[var_289bde21]](ent, var_f3b15ce0);
		}
		return;
	}
	while(true)
	{
		result = undefined;
		result = self waittill_timeout(timeout, #"grenade_pullback", #"hash_7b6a55a9b65e3194", #"offhand_end");
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
			else if(result._notify == #"grenade_pullback")
			{
				var_f3b15ce0 = 1;
				if(isdefined(var_1e89628f))
				{
					self [[var_1e89628f]](ent);
				}
				continue;
			}
			else if(result._notify == #"hash_7b6a55a9b65e3194")
			{
				if(isdefined(var_1d78d31))
				{
					self [[var_1d78d31]](ent);
				}
				return;
			}
		}
	}
	if(isdefined(var_289bde21))
	{
		self [[var_289bde21]](ent, var_f3b15ce0);
	}
}

