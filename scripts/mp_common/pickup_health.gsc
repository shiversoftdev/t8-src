// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\gadgets\gadget_health_regen.gsc;
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace pickup_health;

/*
	Name: __init__system__
	Namespace: pickup_health
	Checksum: 0x181FB090
	Offset: 0x110
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"pickup_health", &__init__, undefined, #"weapons");
}

/*
	Name: __init__
	Namespace: pickup_health
	Checksum: 0xBDD433CB
	Offset: 0x160
	Size: 0x12E
	Parameters: 0
	Flags: Private
*/
function private __init__()
{
	callback::on_connect(&onconnect);
	callback::on_spawned(&onspawned);
	ability_player::register_gadget_activation_callbacks(23, &onhealthregen, &offhealthregen);
	level.healingdisabled = &offhealthregen;
	level.var_99a34951 = getgametypesetting(#"hash_712f4c2a96bca56e");
	level.var_33a3ef40 = getgametypesetting(#"hash_647310a2fe3554f7");
	level.var_aff59367 = getgametypesetting(#"hash_44533f4f290c5e77");
	level.pickup_respawn_time = getgametypesetting(#"hash_6a2434c947c86b9b");
}

/*
	Name: function_e963e37d
	Namespace: pickup_health
	Checksum: 0x5885F90D
	Offset: 0x298
	Size: 0x24A
	Parameters: 0
	Flags: None
*/
function function_e963e37d()
{
	var_7a23c03b = getentarray("pickup_health", "targetname");
	foreach(pickup in var_7a23c03b)
	{
		pickup.trigger = spawn("trigger_radius_use", pickup.origin + vectorscale((0, 0, 1), 15), 0, 120, 100);
		pickup.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
		pickup.trigger triggerignoreteam();
		pickup.gameobject = gameobjects::create_use_object(#"neutral", pickup.trigger, [], vectorscale((0, 0, 1), 60), "pickup_health");
		pickup.gameobject gameobjects::set_objective_entity(pickup.gameobject);
		pickup.gameobject gameobjects::set_visible_team(#"any");
		pickup.gameobject gameobjects::allow_use(#"any");
		pickup.gameobject gameobjects::set_use_time(0);
		pickup.gameobject.usecount = 0;
		pickup.gameobject.var_5ecd70 = pickup;
		pickup.gameobject.onuse = &function_5bb13b48;
	}
}

/*
	Name: function_dd4bf8ac
	Namespace: pickup_health
	Checksum: 0x79E0D125
	Offset: 0x4F0
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_dd4bf8ac(num)
{
	if(self.pers[#"pickup_health"] < level.var_99a34951)
	{
		self.pers[#"pickup_health"] = self.pers[#"pickup_health"] + num;
		self function_2bcfabea();
		return true;
	}
	return false;
}

/*
	Name: onconnect
	Namespace: pickup_health
	Checksum: 0xFE3F5E30
	Offset: 0x588
	Size: 0x3E
	Parameters: 0
	Flags: Private
*/
function private onconnect()
{
	if(!isdefined(self.pers[#"pickup_health"]))
	{
		self.pers[#"pickup_health"] = 0;
	}
}

/*
	Name: onspawned
	Namespace: pickup_health
	Checksum: 0x9F506E64
	Offset: 0x5D0
	Size: 0x1C
	Parameters: 0
	Flags: Private
*/
function private onspawned()
{
	self function_3fbb0e22();
}

/*
	Name: function_3fbb0e22
	Namespace: pickup_health
	Checksum: 0xD1C80417
	Offset: 0x5F8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_3fbb0e22()
{
	waitframe(1);
	self function_2bcfabea();
}

/*
	Name: onhealthregen
	Namespace: pickup_health
	Checksum: 0x51456269
	Offset: 0x620
	Size: 0x2E
	Parameters: 2
	Flags: Private
*/
function private onhealthregen(slot, weapon)
{
	self.pers[#"pickup_health"]--;
}

/*
	Name: offhealthregen
	Namespace: pickup_health
	Checksum: 0x823707F1
	Offset: 0x658
	Size: 0x4C
	Parameters: 2
	Flags: Private
*/
function private offhealthregen(slot, weapon)
{
	self gadgetdeactivate(self.gadget_health_regen_slot, self.gadget_health_regen_weapon);
	thread healingdone();
}

/*
	Name: healingdone
	Namespace: pickup_health
	Checksum: 0x62B0B445
	Offset: 0x6B0
	Size: 0x24
	Parameters: 0
	Flags: Private
*/
function private healingdone()
{
	wait(0.5);
	self function_2bcfabea();
}

/*
	Name: function_5bb13b48
	Namespace: pickup_health
	Checksum: 0xB332F833
	Offset: 0x6E0
	Size: 0x1DC
	Parameters: 1
	Flags: Private
*/
function private function_5bb13b48(player)
{
	if(isdefined(player) && isplayer(player))
	{
		if(player function_dd4bf8ac(1))
		{
			if(isdefined(self.objectiveid))
			{
				objective_setinvisibletoplayer(self.objectiveid, player);
			}
			self.var_5ecd70 setinvisibletoplayer(player);
			self.trigger setinvisibletoplayer(player);
			player playsoundtoplayer(#"hash_8a4d3f134fa94d7", player);
			self.usecount++;
			player gestures::function_56e00fbf(#"gestable_grab", undefined, 0);
			if(isdefined(level.var_aff59367) && level.var_aff59367)
			{
				self thread function_7a80944d(player);
			}
		}
		else
		{
			player iprintlnbold(#"hash_5a11b7ef0cd7e33b");
			player playsoundtoplayer(#"uin_unavailable_charging", player);
		}
	}
	if(!(isdefined(level.var_aff59367) && level.var_aff59367) && self.usecount >= level.var_ad9d03e7)
	{
		self.var_5ecd70 delete();
		self gameobjects::disable_object(1);
	}
}

/*
	Name: function_7a80944d
	Namespace: pickup_health
	Checksum: 0x50E3E32F
	Offset: 0x8C8
	Size: 0xC4
	Parameters: 1
	Flags: Private
*/
function private function_7a80944d(player)
{
	level endon(#"game_ended");
	self endon(#"death");
	player endon(#"disconnect");
	wait((isdefined(level.pickup_respawn_time) ? level.pickup_respawn_time : 0));
	if(isdefined(self.objectiveid))
	{
		objective_setvisibletoplayer(self.objectiveid, player);
	}
	self.var_5ecd70 setvisibletoplayer(player);
	self.trigger setvisibletoplayer(player);
}

/*
	Name: function_2bcfabea
	Namespace: pickup_health
	Checksum: 0xDD7CCD7C
	Offset: 0x998
	Size: 0x15C
	Parameters: 0
	Flags: Private
*/
function private function_2bcfabea()
{
	if(!isdefined(self) || !isdefined(self.pers[#"pickup_health"]))
	{
		return;
	}
	if(self.pers[#"pickup_health"] <= 0)
	{
		self gadget_health_regen::power_off();
		if(isdefined(self.gadget_health_regen_slot))
		{
			self function_19ed70ca(self.gadget_health_regen_slot, 1);
		}
		if(self.pers[#"pickup_health"] < 0)
		{
			self.pers[#"pickup_health"] = 0;
		}
	}
	else
	{
		self gadget_health_regen::power_on();
		if(self.pers[#"pickup_health"] > level.var_99a34951)
		{
			self.pers[#"pickup_health"] = level.var_99a34951;
		}
	}
	self clientfield::set_player_uimodel("hudItems.numHealthPickups", self.pers[#"pickup_health"]);
}

