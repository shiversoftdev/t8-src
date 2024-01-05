// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_bgb_respin_cycle;

/*
	Name: __init__system__
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x722CD7A9
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_respin_cycle", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x3A3E8854
	Offset: 0x140
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_respin_cycle", "activated", 1, undefined, undefined, &validation, &activation);
	clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter");
}

/*
	Name: validation
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x1D9F15D1
	Offset: 0x1F0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	for(i = 0; i < level.chests.size; i++)
	{
		chest = level.chests[i];
		if(isdefined(chest.zbarrier.weapon_model) && isdefined(chest.chest_user) && self == chest.chest_user)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: activation
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x26CD6295
	Offset: 0x288
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"disconnect");
	for(i = 0; i < level.chests.size; i++)
	{
		chest = level.chests[i];
		if(isdefined(chest.zbarrier.weapon_model) && isdefined(chest.chest_user) && self == chest.chest_user)
		{
			chest thread function_80b33681(self);
		}
	}
}

/*
	Name: function_80b33681
	Namespace: zm_bgb_respin_cycle
	Checksum: 0xF452BB1E
	Offset: 0x348
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_80b33681(player)
{
	self.zbarrier clientfield::increment("zm_bgb_respin_cycle");
	if(isdefined(self.zbarrier.weapon_model))
	{
		self.zbarrier.weapon_model notify(#"kill_respin_think_thread");
	}
	self.no_fly_away = 1;
	self.zbarrier notify(#"box_hacked_respin");
	self.zbarrier playsound(#"zmb_bgb_powerup_respin");
	self thread zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
	self.zbarrier thread zm_magicbox::treasure_chest_weapon_spawn(self, player);
	self.zbarrier waittill(#"randomization_done");
	self.no_fly_away = undefined;
	if(!level flag::get("moving_chest_now"))
	{
		self.grab_weapon_hint = 1;
		self.grab_weapon = self.zbarrier.weapon;
		self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
		self thread zm_magicbox::treasure_chest_timeout();
	}
}

