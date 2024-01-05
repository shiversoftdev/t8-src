// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_powerups.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_powerup_zombie_blood;

/*
	Name: __init__system__
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x6B07C55D
	Offset: 0x170
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register("zm_powerup_zombie_blood", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_zombie_blood
	Checksum: 0xE4D08031
	Offset: 0x1B0
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"player_zombie_blood_fx", 1, 1, "int", &toggle_player_zombie_blood_fx, 0, 1);
	level._effect[#"zombie_blood"] = "player/fx8_plyr_pstfx_katana_rush_loop";
	level._effect[#"zombie_blood_1st"] = "player/fx8_plyr_pstfx_katana_rush_loop";
	level._effect[#"zombie_blood_3p"] = "maps/zm_escape/fx8_pwr_up_blood";
	level._effect[#"hash_508127d9fa072319"] = "maps/zm_escape/fx8_pwr_up_blood_trail";
	zm_powerups::include_zombie_powerup("zombie_blood");
	zm_powerups::add_zombie_powerup("zombie_blood", "powerup_zombie_blood");
}

/*
	Name: toggle_player_zombie_blood_fx
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x5B79FA75
	Offset: 0x2F0
	Size: 0x374
	Parameters: 7
	Flags: Linked
*/
function toggle_player_zombie_blood_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(!isdefined(self.var_ea67fd25))
	{
		self.var_ea67fd25 = [];
	}
	if(!isdefined(self.var_ea67fd25[localclientnum]))
	{
		self.var_ea67fd25[localclientnum] = [];
	}
	if(self.var_ea67fd25[localclientnum].size)
	{
		self postfx::stoppostfxbundle(#"hash_4c9c4b6464bd9a1c");
		foreach(n_fx_id in self.var_ea67fd25[localclientnum])
		{
			stopfx(localclientnum, n_fx_id);
			n_fx_id = undefined;
		}
		if(newval == 0)
		{
			self.var_ea67fd25[localclientnum] = undefined;
		}
	}
	if(newval == 1)
	{
		if(self getlocalclientnumber() === localclientnum)
		{
			self thread postfx::playpostfxbundle(#"hash_4c9c4b6464bd9a1c");
			self.var_ea67fd25[localclientnum][self.var_ea67fd25[localclientnum].size] = playfxoncamera(localclientnum, level._effect[#"zombie_blood_1st"]);
		}
		else
		{
			self.var_ea67fd25[localclientnum][self.var_ea67fd25[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"zombie_blood_3p"], self, "j_eyeball_le");
			self.var_ea67fd25[localclientnum][self.var_ea67fd25[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_508127d9fa072319"], self, "j_eyeball_le");
		}
		if(!isdefined(self.var_f83eefc6))
		{
			self playsound(localclientnum, #"hash_7a3f11d83a3345c7");
			self.var_f83eefc6 = self playloopsound(#"hash_e994a747679fc33");
		}
	}
	else if(isdefined(self.var_f83eefc6))
	{
		self playsound(localclientnum, #"hash_5460a8de45586842");
		self stoploopsound(self.var_f83eefc6);
	}
}

