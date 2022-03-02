// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_9269886b;

/*
	Name: init
	Namespace: namespace_9269886b
	Checksum: 0xC25303A0
	Offset: 0x188
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&on_player_connect);
	callback::on_ai_killed(&function_48f916b);
	callback::on_ai_killed(&function_bde94bdf);
	level thread function_df71a9b9();
	level thread shard_watcher();
	level thread function_9785ebce();
	level thread pap_watcher();
	level.n_electric_trap_kills = 0;
	level.var_36067f1f = 0;
	level.var_8265e44f = 0;
	level.var_4b81bb64 = 0;
	level.var_9e22ff45 = 0;
	callback::on_ai_killed(&function_2c104547);
}

/*
	Name: on_player_connect
	Namespace: namespace_9269886b
	Checksum: 0x90717A9D
	Offset: 0x2B8
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread function_e0aaa050();
	self thread function_f37ba127();
	self thread function_5e1138a2();
	self.var_f50a2a9b = 0;
	self.var_5e47a087 = 0;
	self.var_31ce05fd = 0;
	self.var_c9f12812 = array(0, 0, 0, 0);
}

/*
	Name: shard_watcher
	Namespace: namespace_9269886b
	Checksum: 0xE0D1B5B
	Offset: 0x358
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function shard_watcher()
{
	level endon(#"game_ended");
	self waittill(#"hash_5aa1c9627e8626e0");
	/#
		iprintlnbold("" + "");
	#/
	self zm_utility::giveachievement_wrapper("zm_white_shard", 1);
}

/*
	Name: function_e0aaa050
	Namespace: namespace_9269886b
	Checksum: 0x5D078BBF
	Offset: 0x3E0
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_e0aaa050()
{
	level endon(#"game_ended", #"hash_5aa1c9627e8626e0");
	self endon(#"death", #"disconnect");
	for(i = 0; i < 20; i++)
	{
		level waittill(#"end_of_round");
		if(self.zone_name !== "zone_security_checkpoint")
		{
			return;
		}
	}
	/#
		iprintlnbold("" + "");
	#/
	self zm_utility::giveachievement_wrapper("zm_white_starting", 0);
}

/*
	Name: function_f37ba127
	Namespace: namespace_9269886b
	Checksum: 0xF84EC0AA
	Offset: 0x4D8
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_f37ba127()
{
	level endon(#"game_ended", #"hash_5aa1c9627e8626e0");
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_13f3f231b45420ef");
		if(waitresult.e_player === self)
		{
			/#
				iprintlnbold("" + "");
			#/
			self zm_utility::giveachievement_wrapper("zm_white_unlock", 0);
			return;
		}
		wait(0.5);
	}
}

/*
	Name: function_9785ebce
	Namespace: namespace_9269886b
	Checksum: 0x7CE9B3E9
	Offset: 0x5B8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_9785ebce()
{
	level endon(#"game_ended", #"hash_5aa1c9627e8626e0");
	for(i = 0; i < 4; i++)
	{
		level waittill(#"hash_13f3f231b45420ef");
	}
	/#
		iprintlnbold("" + "");
	#/
	self zm_utility::giveachievement_wrapper("zm_white_mod", 1);
}

/*
	Name: function_2c104547
	Namespace: namespace_9269886b
	Checksum: 0xCBB34CAF
	Offset: 0x670
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function function_2c104547(s_params)
{
	e_attacker = s_params.eattacker;
	if(!isdefined(e_attacker) || !isdefined(e_attacker._trap_type))
	{
		return;
	}
	switch(e_attacker._trap_type)
	{
		case "electric":
		{
			if(level.n_electric_trap_kills < 12)
			{
				level.n_electric_trap_kills++;
				/#
					iprintln("" + level.n_electric_trap_kills);
				#/
			}
			break;
		}
		case "rotating":
		{
			if(level.var_36067f1f < 12)
			{
				level.var_36067f1f++;
				/#
					iprintln("" + level.var_36067f1f);
				#/
			}
			break;
		}
		case "acid":
		{
			if(level.var_8265e44f < 12)
			{
				level.var_8265e44f++;
				/#
					iprintln("" + level.var_8265e44f);
				#/
			}
			break;
		}
		case "fire":
		{
			if(level.var_4b81bb64 < 12)
			{
				level.var_4b81bb64++;
				/#
					iprintln("" + level.var_4b81bb64);
				#/
			}
			break;
		}
		case "soul":
		{
			if(level.var_9e22ff45 < 12)
			{
				level.var_9e22ff45++;
				/#
					iprintln("" + level.var_9e22ff45);
				#/
			}
			break;
		}
	}
	if(level.n_electric_trap_kills > 11 && level.var_36067f1f > 11 && level.var_8265e44f > 11 && level.var_4b81bb64 > 11 && level.var_9e22ff45 > 11)
	{
		/#
			iprintlnbold("" + "");
		#/
		self zm_utility::giveachievement_wrapper("zm_white_trap", 1);
		callback::remove_on_ai_killed(&function_2c104547);
	}
}

/*
	Name: pap_watcher
	Namespace: namespace_9269886b
	Checksum: 0xD70C5169
	Offset: 0x980
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function pap_watcher()
{
	level endon(#"game_ended", #"hash_5aa1c9627e8626e0");
	level waittill(#"pap_power_ready");
	if(level.round_number <= 5)
	{
		/#
			iprintlnbold("" + "");
		#/
		zm_utility::giveachievement_wrapper("zm_white_pap", 1);
	}
}

/*
	Name: function_48f916b
	Namespace: namespace_9269886b
	Checksum: 0xF71501A6
	Offset: 0xA30
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_48f916b(params)
{
	e_attacker = params.eattacker;
	if(!isplayer(e_attacker) || !isdefined(e_attacker.var_f50a2a9b))
	{
		return;
	}
	if(params.weapon.name != #"galvaknuckles_t8")
	{
		return;
	}
	e_attacker.var_f50a2a9b++;
	/#
		iprintln("" + e_attacker.var_f50a2a9b);
	#/
	if(e_attacker.var_f50a2a9b >= 115)
	{
		/#
			iprintlnbold("" + "");
		#/
		e_attacker zm_utility::giveachievement_wrapper("zm_white_knuckles", 0);
		e_attacker.var_f50a2a9b = undefined;
	}
}

/*
	Name: function_5e1138a2
	Namespace: namespace_9269886b
	Checksum: 0x163AB6EA
	Offset: 0xB58
	Size: 0x19E
	Parameters: 0
	Flags: Linked
*/
function function_5e1138a2()
{
	level endon(#"hash_5aa1c9627e8626e0");
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"perk_bought");
		if(isdefined(waitresult.n_slot))
		{
			self.var_c9f12812[waitresult.n_slot] = 1;
			self thread perk_watcher();
			for(i = 0; i < 35; i++)
			{
				wait(1);
				if(self function_91cfddc4())
				{
					/#
						iprintlnbold("" + (i + 1));
					#/
					/#
						iprintlnbold("" + "");
					#/
					self zm_utility::giveachievement_wrapper("zm_white_perk", 0);
					self notify(#"hash_1305a28597a2e439");
					return;
				}
			}
			self notify(#"hash_1305a28597a2e439");
			self.var_c9f12812 = array(0, 0, 0, 0);
		}
	}
}

/*
	Name: perk_watcher
	Namespace: namespace_9269886b
	Checksum: 0xD03674E3
	Offset: 0xD00
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function perk_watcher()
{
	self endon(#"hash_1305a28597a2e439", #"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"perk_bought");
		if(isdefined(waitresult.n_slot))
		{
			self.var_c9f12812[waitresult.n_slot] = 1;
		}
	}
}

/*
	Name: function_91cfddc4
	Namespace: namespace_9269886b
	Checksum: 0x848F8D5C
	Offset: 0xD90
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_91cfddc4()
{
	foreach(bought in self.var_c9f12812)
	{
		if(!bought)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_df71a9b9
	Namespace: namespace_9269886b
	Checksum: 0xA5A8C03D
	Offset: 0xE10
	Size: 0x1E2
	Parameters: 0
	Flags: Linked
*/
function function_df71a9b9()
{
	level endon(#"game_ended", #"hash_5aa1c9627e8626e0");
	while(true)
	{
		var_ddb40357 = undefined;
		var_ddb40357 = level waittill(#"hash_4543ba0bff75332e");
		e_attacker = var_ddb40357.e_player;
		if(isplayer(e_attacker) && isdefined(e_attacker.var_5e47a087))
		{
			var_2b198109 = getaiteamarray(level.zombie_team);
			e_attacker.var_5e47a087 = 0;
			foreach(e_zombie in var_2b198109)
			{
				if(e_zombie.var_6ee03e9a === 1)
				{
					e_attacker.var_5e47a087++;
				}
			}
			/#
				iprintln("" + e_attacker.var_5e47a087);
			#/
			if(e_attacker.var_5e47a087 >= 10)
			{
				/#
					iprintlnbold("" + "");
				#/
				e_attacker zm_utility::giveachievement_wrapper("zm_white_stun", 0);
				e_attacker.var_5e47a087 = undefined;
			}
		}
	}
}

/*
	Name: function_bde94bdf
	Namespace: namespace_9269886b
	Checksum: 0xE4A18C39
	Offset: 0x1000
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function function_bde94bdf(params)
{
	e_attacker = params.eattacker;
	if(!(isdefined(self.var_b421bafe) && self.var_b421bafe))
	{
		return;
	}
	if(!isplayer(e_attacker) || !isdefined(e_attacker.var_31ce05fd))
	{
		return;
	}
	if(params.smeansofdeath === "MOD_GRENADE_SPLASH" || params.smeansofdeath === "MOD_GRENADE")
	{
		e_attacker.var_31ce05fd++;
		/#
			iprintln("" + e_attacker.var_31ce05fd);
		#/
		if(e_attacker.var_31ce05fd >= 15)
		{
			/#
				iprintlnbold("" + "");
			#/
			e_attacker zm_utility::giveachievement_wrapper("zm_white_roof", 0);
			e_attacker.var_31ce05fd = undefined;
		}
	}
}

