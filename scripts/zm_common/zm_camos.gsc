// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\activecamo_shared.gsc;

#namespace zm_camos;

/*
	Name: __init__system__
	Namespace: zm_camos
	Checksum: 0xD7561F2C
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_camos", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_camos
	Checksum: 0x89002DA7
	Offset: 0xE0
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_connect);
	level.var_f06de157 = &function_264bcab7;
	level.var_3993dc8e = &function_4092decc;
	level.var_b219667f = 1;
}

/*
	Name: on_connect
	Namespace: zm_camos
	Checksum: 0x784F8DF3
	Offset: 0x150
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self thread function_5ae5fabe();
}

/*
	Name: function_79be4786
	Namespace: zm_camos
	Checksum: 0xDCE3235B
	Offset: 0x178
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_79be4786(weapon)
{
	weapon = function_264bcab7(weapon);
	weaponoptions = self getbuildkitweaponoptions(weapon);
	var_3ded6a21 = getcamoindex(weaponoptions);
	var_a99ac61d = getactivecamo(var_3ded6a21);
	if(!isdefined(var_a99ac61d) || var_a99ac61d == #"")
	{
		return;
	}
	return var_3ded6a21;
}

/*
	Name: function_7c982eb6
	Namespace: zm_camos
	Checksum: 0xE082EBD8
	Offset: 0x230
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_7c982eb6(weapon)
{
	weapon = function_264bcab7(weapon);
	s_active_camo = function_e5ed6edb(weapon);
	if(isdefined(s_active_camo))
	{
		weaponstate = s_active_camo.var_dd54a13b[weapon];
		if(isdefined(weaponstate) && isdefined(weaponstate.stagenum))
		{
			return weaponstate.stagenum;
		}
	}
}

/*
	Name: function_6f75f3d3
	Namespace: zm_camos
	Checksum: 0x23CA2918
	Offset: 0x2D0
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_6f75f3d3(weapon, current_weaponoptions)
{
	var_515e20e6 = zm_weapons::is_weapon_upgraded(weapon);
	weapon = function_264bcab7(weapon);
	if(self function_d0ae71bb(weapon))
	{
		return getcamoindex(current_weaponoptions);
	}
	if(var_515e20e6 && isdefined(self.var_3f021416) && isdefined(self.var_3f021416[weapon]))
	{
		return self.var_3f021416[weapon];
	}
	if(isdefined(current_weaponoptions))
	{
		return getcamoindex(current_weaponoptions);
	}
}

/*
	Name: function_4f727cf5
	Namespace: zm_camos
	Checksum: 0xBEB7B698
	Offset: 0x3B0
	Size: 0x20A
	Parameters: 3
	Flags: Linked
*/
function function_4f727cf5(weapon, weaponoptions = self getbuildkitweaponoptions(weapon), var_b07a5171 = 0)
{
	weapon = function_264bcab7(weapon);
	if(isdefined(weaponoptions) && self function_d0ae71bb(weapon))
	{
		return getcamoindex(weaponoptions);
	}
	if(!isdefined(level.pack_a_punch_camo_index))
	{
		if(isdefined(weaponoptions))
		{
			return getcamoindex(weaponoptions);
		}
		return;
	}
	if(isdefined(level.pack_a_punch_camo_index_number_variants))
	{
		if(!isdefined(self.var_3f021416))
		{
			self.var_3f021416 = [];
		}
		else if(!isarray(self.var_3f021416))
		{
			self.var_3f021416 = array(self.var_3f021416);
		}
		var_e5c037f4 = self.var_3f021416[weapon];
		if(var_b07a5171 && isdefined(var_e5c037f4) && var_e5c037f4 >= level.pack_a_punch_camo_index)
		{
			var_c44040bf = var_e5c037f4 + 1;
			if(var_c44040bf >= (level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants))
			{
				var_c44040bf = level.pack_a_punch_camo_index;
			}
		}
		else
		{
			n_offset = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
			var_c44040bf = level.pack_a_punch_camo_index + n_offset;
		}
		self.var_3f021416[weapon] = var_c44040bf;
		return var_c44040bf;
	}
	return level.pack_a_punch_camo_index;
}

/*
	Name: function_a24c564f
	Namespace: zm_camos
	Checksum: 0xFFF28005
	Offset: 0x5C8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_a24c564f(var_c34665fc, weapon)
{
	weapon = function_264bcab7(weapon);
	self notify(var_c34665fc, {#weapon:weapon});
}

/*
	Name: function_264bcab7
	Namespace: zm_camos
	Checksum: 0xA59994EA
	Offset: 0x620
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_264bcab7(weapon)
{
	if(isdefined(weapon) && weapon != level.weaponnone)
	{
		weapon = zm_weapons::function_93cd8e76(weapon, 1);
	}
	return weapon;
}

/*
	Name: function_e5ed6edb
	Namespace: zm_camos
	Checksum: 0x50A60DCE
	Offset: 0x678
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e5ed6edb(weapon)
{
	weaponoptions = self getbuildkitweaponoptions(weapon);
	if(!isdefined(self.pers) || !isdefined(self.pers[#"activecamo"]))
	{
		return;
	}
	var_3ded6a21 = getcamoindex(weaponoptions);
	var_a99ac61d = getactivecamo(var_3ded6a21);
	if(!isdefined(var_a99ac61d) || !isdefined(self.pers[#"activecamo"][var_a99ac61d]))
	{
		return;
	}
	return self.pers[#"activecamo"][var_a99ac61d];
}

/*
	Name: function_d0ae71bb
	Namespace: zm_camos
	Checksum: 0x98BA8E1E
	Offset: 0x770
	Size: 0x72
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d0ae71bb(weapon)
{
	if(isdefined(self function_79be4786(weapon)))
	{
		return true;
	}
	weaponoptions = self getbuildkitweaponoptions(weapon);
	if(function_2470f404(weaponoptions) != 0)
	{
		return true;
	}
	return false;
}

/*
	Name: function_7b29c2d2
	Namespace: zm_camos
	Checksum: 0xAEFEBF80
	Offset: 0x7F0
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_7b29c2d2(weapon)
{
	if(!isdefined(self.var_88ebd633))
	{
		self.var_88ebd633 = {};
	}
	var_fcad15af = function_264bcab7(weapon);
	if(!isdefined(self.var_88ebd633.var_92177fec) || self.var_88ebd633.var_92177fec != var_fcad15af)
	{
		self.var_88ebd633.var_92177fec = var_fcad15af;
		self.var_88ebd633.var_d9449a3 = 0;
	}
	self.var_88ebd633.var_d9449a3++;
	if(self.var_88ebd633.var_d9449a3 >= 5)
	{
		self thread activecamo::function_896ac347(weapon, #"rapid_kills", 1);
		self.var_88ebd633.var_d9449a3 = 0;
		self notify(#"hash_7e9b17b054c01cb3");
	}
	else if(self.var_88ebd633.var_d9449a3 == 1)
	{
		self thread function_160898c();
	}
}

/*
	Name: function_160898c
	Namespace: zm_camos
	Checksum: 0xBC106C03
	Offset: 0x940
	Size: 0x4E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_160898c()
{
	self notify(#"hash_7e9b17b054c01cb3");
	self endon(#"death", #"hash_7e9b17b054c01cb3");
	wait(5);
	self.var_88ebd633.var_d9449a3 = 0;
}

/*
	Name: function_432cf6d
	Namespace: zm_camos
	Checksum: 0xA4C26CA0
	Offset: 0x998
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_432cf6d(weapon)
{
	if(!isdefined(self.var_88ebd633))
	{
		self.var_88ebd633 = {};
	}
	var_fcad15af = function_264bcab7(weapon);
	if(!isdefined(self.var_88ebd633.var_d45de2ae) || self.var_88ebd633.var_d45de2ae != var_fcad15af)
	{
		self.var_88ebd633.var_d45de2ae = var_fcad15af;
		self.var_88ebd633.var_bcacb3a3 = 0;
	}
	self.var_88ebd633.var_bcacb3a3++;
	if(self.var_88ebd633.var_bcacb3a3 >= 5)
	{
		self thread activecamo::function_896ac347(weapon, #"rapid_headshots", 1);
		self.var_88ebd633.var_bcacb3a3 = 0;
		self notify(#"hash_3dbf3a8521ba1621");
	}
	else if(self.var_88ebd633.var_bcacb3a3 == 1)
	{
		self thread function_d01affa9();
	}
}

/*
	Name: function_d01affa9
	Namespace: zm_camos
	Checksum: 0x67DCFA9A
	Offset: 0xAE8
	Size: 0x4E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d01affa9()
{
	self notify(#"hash_3dbf3a8521ba1621");
	self endon(#"death", #"hash_3dbf3a8521ba1621");
	wait(7);
	self.var_88ebd633.var_bcacb3a3 = 0;
}

/*
	Name: function_4092decc
	Namespace: zm_camos
	Checksum: 0xCD4F3E
	Offset: 0xB40
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_4092decc(weapon)
{
	if(zm_weapons::is_weapon_upgraded(weapon))
	{
		self activecamo::function_896ac347(weapon, #"hash_203688d7883cf38c", 1);
		if(zm_pap_util::function_7352d8cc(weapon))
		{
			self activecamo::function_896ac347(weapon, #"hash_300fdf15a515feda", 1);
		}
	}
	else
	{
		self function_a24c564f(#"reset_pack", weapon);
	}
}

/*
	Name: function_5ae5fabe
	Namespace: zm_camos
	Checksum: 0x7336E879
	Offset: 0xC10
	Size: 0x4EC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5ae5fabe()
{
	if(self stats::get_stat_global(#"weapons_mastery_assault") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_assault", #"challenges", #"statvalue") >= 42)
	{
		self stats::function_dad108fa(#"weapons_mastery_assault", 1);
	}
	if(self stats::get_stat_global(#"hash_517bf5c8991ad97a") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_cqb", #"challenges", #"statvalue") >= 21)
	{
		self stats::function_dad108fa(#"hash_517bf5c8991ad97a", 1);
	}
	if(self stats::get_stat_global(#"weapons_mastery_lmg") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_lmg", #"challenges", #"statvalue") >= 28)
	{
		self stats::function_dad108fa(#"weapons_mastery_lmg", 1);
	}
	if(self stats::get_stat_global(#"secondary_mastery_pistol") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_pistol", #"challenges", #"statvalue") >= 28)
	{
		self stats::function_dad108fa(#"secondary_mastery_pistol", 1);
	}
	if(self stats::get_stat_global(#"weapons_mastery_smg") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_smg", #"challenges", #"statvalue") >= 49)
	{
		self stats::function_dad108fa(#"weapons_mastery_smg", 1);
	}
	if(self stats::get_stat_global(#"weapons_mastery_sniper") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_sniper", #"challenges", #"statvalue") >= 28)
	{
		self stats::function_dad108fa(#"weapons_mastery_sniper", 1);
	}
	if(self stats::get_stat_global(#"weapons_mastery_tactical") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_tactical", #"challenges", #"statvalue") >= 28)
	{
		self stats::function_dad108fa(#"weapons_mastery_tactical", 1);
	}
	if(self stats::get_stat_global(#"secondary_mastery") == 4)
	{
		self stats::function_dad108fa(#"weapons_mastery", 1);
	}
}

