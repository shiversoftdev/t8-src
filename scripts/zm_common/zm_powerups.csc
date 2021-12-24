// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_powerups;

/*
	Name: init
	Namespace: zm_powerups
	Checksum: 0xD8C24C48
	Offset: 0x1F8
	Size: 0x36C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(!isdefined(level.zombie_powerups))
	{
		level.zombie_powerups = [];
	}
	add_zombie_powerup("insta_kill_ug", "powerup_instant_kill_ug", 1);
	level._effect[#"powerup_on"] = #"zombie/fx_powerup_on_green_zmb";
	level._effect[#"powerup_intro"] = #"hash_630b0bc30e08935f";
	level._effect[#"powerup_grabbed"] = #"zombie/fx_powerup_grab_green_zmb";
	level._effect[#"powerup_on_solo"] = #"zombie/fx_powerup_on_solo_zmb";
	level._effect[#"hash_1bbdf961a543a8a4"] = #"hash_5c054ea9b299c2f0";
	level._effect[#"powerup_grabbed_solo"] = #"zombie/fx_powerup_grab_solo_zmb";
	level._effect[#"powerup_on_caution"] = #"zombie/fx_powerup_on_caution_zmb";
	level._effect[#"hash_216d76ce6f19d51c"] = #"hash_2e09347c65fb17c1";
	level._effect[#"powerup_grabbed_caution"] = #"zombie/fx_powerup_grab_caution_zmb";
	if(isdefined(level.using_zombie_powerups) && level.using_zombie_powerups)
	{
		level._effect[#"powerup_on_red"] = #"zombie/fx_powerup_on_red_zmb";
		level._effect[#"hash_68ab4922f64db792"] = #"hash_62b15f4f400643ab";
		level._effect[#"powerup_grabbed_red"] = #"zombie/fx_powerup_grab_red_zmb";
	}
	clientfield::register("scriptmover", "powerup_fx", 1, 3, "int", &powerup_fx_callback, 0, 0);
	clientfield::register("scriptmover", "powerup_intro_fx", 1, 3, "int", &function_618b5680, 0, 0);
	clientfield::register("scriptmover", "powerup_grabbed_fx", 1, 3, "int", &function_9f7265fd, 0, 0);
}

/*
	Name: add_zombie_powerup
	Namespace: zm_powerups
	Checksum: 0x124B2915
	Offset: 0x570
	Size: 0x2DA
	Parameters: 3
	Flags: Linked
*/
function add_zombie_powerup(powerup_name, client_field_name, clientfield_version = 1)
{
	if(isdefined(level.zombie_include_powerups) && !isdefined(level.zombie_include_powerups[powerup_name]))
	{
		return;
	}
	switch(powerup_name)
	{
		case "full_ammo":
		{
			var_f530d747 = "zmPowerupMaxAmmo";
			break;
		}
		case "fire_sale":
		{
			var_f530d747 = "zmPowerupFireSale";
			break;
		}
		case "bonus_points_player_shared":
		case "bonus_points_player":
		case "bonus_points_team":
		{
			var_f530d747 = "zmPowerupChaosPoints";
			break;
		}
		case "free_perk":
		{
			var_f530d747 = "zmPowerupFreePerk";
			break;
		}
		case "nuke":
		{
			var_f530d747 = "zmPowerupNuke";
			break;
		}
		case "hero_weapon_power":
		{
			var_f530d747 = "zmPowerupSpecialWeapon";
			break;
		}
		case "insta_kill":
		{
			var_f530d747 = "zmPowerupInstakill";
			break;
		}
		case "double_points":
		{
			var_f530d747 = "zmPowerupDouble";
			break;
		}
		case "carpenter":
		{
			var_f530d747 = "zmPowerupCarpenter";
			break;
		}
		default:
		{
			var_f530d747 = "";
		}
	}
	if(var_f530d747 != "" && (!(isdefined(getgametypesetting(var_f530d747)) && getgametypesetting(var_f530d747))))
	{
		return;
	}
	struct = spawnstruct();
	struct.powerup_name = powerup_name;
	level.zombie_powerups[powerup_name] = struct;
	if(isdefined(client_field_name))
	{
		var_4e6e65fa = ("hudItems.zmPowerUps." + client_field_name) + ".state";
		clientfield::register("clientuimodel", var_4e6e65fa, clientfield_version, 2, "int", &powerup_state_callback, 0, 1);
		struct.client_field_name = var_4e6e65fa;
	}
}

/*
	Name: include_zombie_powerup
	Namespace: zm_powerups
	Checksum: 0x80C075B3
	Offset: 0x858
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function include_zombie_powerup(powerup_name)
{
	if(!isdefined(level.zombie_include_powerups))
	{
		level.zombie_include_powerups = [];
	}
	level.zombie_include_powerups[powerup_name] = 1;
}

/*
	Name: powerup_state_callback
	Namespace: zm_powerups
	Checksum: 0x7D3974B2
	Offset: 0x8A8
	Size: 0x76
	Parameters: 7
	Flags: Linked
*/
function powerup_state_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"powerup", {#state:newval, #powerup:fieldname});
}

/*
	Name: powerup_fx_callback
	Namespace: zm_powerups
	Checksum: 0xA799DA42
	Offset: 0x928
	Size: 0x15C
	Parameters: 7
	Flags: Linked
*/
function powerup_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_d6070ac5(localclientnum);
	switch(newval)
	{
		case 1:
		{
			str_fx = level._effect[#"powerup_on"];
			break;
		}
		case 2:
		{
			str_fx = level._effect[#"powerup_on_solo"];
			break;
		}
		case 3:
		{
			str_fx = level._effect[#"powerup_on_red"];
			break;
		}
		case 4:
		{
			str_fx = level._effect[#"powerup_on_caution"];
			break;
		}
		default:
		{
			return;
		}
	}
	self play_powerup_fx(localclientnum, str_fx);
}

/*
	Name: function_618b5680
	Namespace: zm_powerups
	Checksum: 0x2927BCE4
	Offset: 0xA90
	Size: 0x15C
	Parameters: 7
	Flags: Linked
*/
function function_618b5680(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_d6070ac5(localclientnum);
	switch(newval)
	{
		case 1:
		{
			str_fx = level._effect[#"powerup_intro"];
			break;
		}
		case 2:
		{
			str_fx = level._effect[#"hash_1bbdf961a543a8a4"];
			break;
		}
		case 3:
		{
			str_fx = level._effect[#"hash_68ab4922f64db792"];
			break;
		}
		case 4:
		{
			str_fx = level._effect[#"hash_216d76ce6f19d51c"];
		}
		return;
	}
	self play_powerup_fx(localclientnum, str_fx, 1);
}

/*
	Name: function_9f7265fd
	Namespace: zm_powerups
	Checksum: 0xB8848545
	Offset: 0xBF8
	Size: 0x14C
	Parameters: 7
	Flags: Linked
*/
function function_9f7265fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 1:
		{
			str_fx = level._effect[#"powerup_grabbed"];
			break;
		}
		case 2:
		{
			str_fx = level._effect[#"powerup_grabbed_solo"];
			break;
		}
		case 3:
		{
			str_fx = level._effect[#"powerup_grabbed_red"];
			break;
		}
		case 4:
		{
			str_fx = level._effect[#"powerup_grabbed_caution"];
			break;
		}
		default:
		{
			return;
		}
	}
	playfx(localclientnum, str_fx, self.origin);
}

/*
	Name: function_d6070ac5
	Namespace: zm_powerups
	Checksum: 0x354B65D6
	Offset: 0xD50
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d6070ac5(localclientnum)
{
	if(isdefined(self.n_powerup_fx))
	{
		stopfx(localclientnum, self.n_powerup_fx);
		self.n_powerup_fx = undefined;
	}
	if(isdefined(self.var_71e06c56))
	{
		self stoploopsound(self.var_71e06c56);
		self.var_71e06c56 = undefined;
	}
}

/*
	Name: play_powerup_fx
	Namespace: zm_powerups
	Checksum: 0xBF88B643
	Offset: 0xDD0
	Size: 0x14A
	Parameters: 3
	Flags: Linked, Private
*/
private function play_powerup_fx(localclientnum, str_fx, var_6df65756 = 0)
{
	if(self.model !== #"tag_origin")
	{
		forcestreamxmodel(self.model);
		util::delay(1, undefined, &stopforcestreamingxmodel, self.model);
	}
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(var_6df65756 && !isdefined(self.var_71e06c56))
	{
		self playsound(localclientnum, #"hash_3a25dc0ad86a722c");
		self.var_71e06c56 = self playloopsound(#"hash_3119fa236ffcf847");
	}
	self.n_powerup_fx = util::playfxontag(localclientnum, str_fx, self, "tag_origin");
}

/*
	Name: function_cc33adc8
	Namespace: zm_powerups
	Checksum: 0xF7901054
	Offset: 0xF28
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_cc33adc8()
{
	return util::function_5df4294() != "zcleansed";
}

