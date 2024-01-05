// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_sticky_grenade.csc;
#using scripts\weapons\acid_bomb.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\struct.csc;

#namespace callback;

/*
	Name: __init__system__
	Namespace: callback
	Checksum: 0x30280D7F
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"callback", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: callback
	Checksum: 0x15DFE25D
	Offset: 0x150
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread set_default_callbacks();
}

/*
	Name: set_default_callbacks
	Namespace: callback
	Checksum: 0x611DE0D2
	Offset: 0x178
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function set_default_callbacks()
{
	level.callbackplayerspawned = &playerspawned;
	level.callbacklocalclientconnect = &localclientconnect;
	level.callbackplayerlaststand = &playerlaststand;
	level.callbackentityspawned = &entityspawned;
	level.callbackhostmigration = &host_migration;
	level.callbackplayaifootstep = &footsteps::playaifootstep;
	level._custom_weapon_cb_func = &spawned_weapon_type;
	level.var_6b11d5f6 = &function_cbfd8fd6;
}

/*
	Name: localclientconnect
	Namespace: callback
	Checksum: 0x2679FFAF
	Offset: 0x248
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function localclientconnect(localclientnum)
{
	/#
		println("" + localclientnum);
	#/
	callback(#"on_localclient_connect", localclientnum);
	if(isdefined(level.charactercustomizationsetup))
	{
		[[level.charactercustomizationsetup]](localclientnum);
	}
}

/*
	Name: playerlaststand
	Namespace: callback
	Checksum: 0x79780DA
	Offset: 0x2C8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function playerlaststand(localclientnum)
{
	self endon(#"death");
	callback(#"on_player_laststand", localclientnum);
}

/*
	Name: playerspawned
	Namespace: callback
	Checksum: 0x7A93A374
	Offset: 0x318
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function playerspawned(localclientnum)
{
	self endon(#"death");
	util::function_89a98f85();
	if(isdefined(level._playerspawned_override))
	{
		self thread [[level._playerspawned_override]](localclientnum);
		return;
	}
	/#
		println("");
	#/
	if(self function_21c0fa55())
	{
		callback(#"on_localplayer_spawned", localclientnum);
	}
	callback(#"on_player_spawned", localclientnum);
	level.localplayers = getlocalplayers();
}

/*
	Name: entityspawned
	Namespace: callback
	Checksum: 0xF3AE490B
	Offset: 0x410
	Size: 0x380
	Parameters: 1
	Flags: Linked
*/
function entityspawned(localclientnum)
{
	self endon(#"death");
	util::function_89a98f85();
	if(isplayer(self))
	{
		if(isdefined(level._clientfaceanimonplayerspawned))
		{
			self thread [[level._clientfaceanimonplayerspawned]](localclientnum);
		}
	}
	if(isdefined(level._entityspawned_override))
	{
		self thread [[level._entityspawned_override]](localclientnum);
		return;
	}
	if(!isdefined(self.type))
	{
		/#
			println("");
		#/
		return;
	}
	if(self.type == "missile")
	{
		if(isdefined(level._custom_weapon_cb_func))
		{
			self thread [[level._custom_weapon_cb_func]](localclientnum);
		}
		switch(self.weapon.name)
		{
			case "eq_acid_bomb":
			{
				self thread acid_bomb::spawned(localclientnum);
				break;
			}
			case "sticky_grenade":
			{
				self thread sticky_grenade::spawned(localclientnum);
				break;
			}
		}
	}
	else
	{
		if(self.type == "vehicle" || self.type == "helicopter" || self.type == "plane")
		{
			if(isdefined(level._customvehiclecbfunc))
			{
				self thread [[level._customvehiclecbfunc]](localclientnum);
			}
			self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
			self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
			if(self.type == "plane" || self.type == "helicopter")
			{
				self thread vehicle::aircraft_dustkick();
			}
			if(self.archetype === #"bat")
			{
				if(isdefined(level._customactorcbfunc))
				{
					self thread [[level._customactorcbfunc]](localclientnum);
				}
			}
		}
		else
		{
			if(self.type == "actor")
			{
				if(isdefined(level._customactorcbfunc))
				{
					self thread [[level._customactorcbfunc]](localclientnum);
				}
			}
			else
			{
				if(self.type == "scriptmover")
				{
					if(isdefined(self.weapon))
					{
						if(isdefined(level.var_6b11d5f6))
						{
							self thread [[level.var_6b11d5f6]](localclientnum);
						}
					}
				}
				else if(self.type == "NA")
				{
					if(isdefined(self.weapon))
					{
						if(isdefined(level.var_6b11d5f6))
						{
							self thread [[level.var_6b11d5f6]](localclientnum);
						}
					}
				}
			}
		}
	}
}

/*
	Name: host_migration
	Namespace: callback
	Checksum: 0xCE6BF76E
	Offset: 0x798
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function host_migration(localclientnum)
{
	level thread prevent_round_switch_animation();
}

/*
	Name: prevent_round_switch_animation
	Namespace: callback
	Checksum: 0x2E296605
	Offset: 0x7C8
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function prevent_round_switch_animation()
{
	wait(3);
}

