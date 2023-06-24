// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm\perk\zm_perk_death_dash.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_death_dash;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_death_dash
	Checksum: 0xF5908B87
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_death_dash", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x14A8C56
	Offset: 0x140
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
}

/*
	Name: function_27473e44
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x9A25C8E3
	Offset: 0x160
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_death_dash", "mod_death_dash", #"perk_death_dash", #"specialty_death_dash", 3000);
	zm_perks::register_perk_clientfields(#"specialty_mod_death_dash", &register_clientfield, &set_clientfield);
	zm_perks::register_perk_threads(#"specialty_mod_death_dash", &give_perk, &take_perk);
}

/*
	Name: register_clientfield
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x1B05FCD
	Offset: 0x240
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function register_clientfield()
{
	clientfield::register("allplayers", "death_dash_pulse", 24000, 1, "counter");
}

/*
	Name: set_clientfield
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x3979DBEB
	Offset: 0x280
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function set_clientfield(state)
{
}

/*
	Name: give_perk
	Namespace: zm_perk_mod_death_dash
	Checksum: 0xB1661D50
	Offset: 0x298
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
	self thread function_6607df78();
	if(!isdefined(self.var_3dd38cd4))
	{
		self.var_3dd38cd4 = new throttle();
		[[ self.var_3dd38cd4 ]]->initialize(4, 0.05);
	}
}

/*
	Name: take_perk
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x9B01E485
	Offset: 0x300
	Size: 0x36
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_3e32f308aae32783");
}

/*
	Name: function_6607df78
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x19C45182
	Offset: 0x340
	Size: 0x2B2
	Parameters: 0
	Flags: Linked
*/
function function_6607df78()
{
	self endon(#"death", #"hash_3e32f308aae32783");
	level endon(#"end_game");
	while(true)
	{
		self waittill(#"hash_6e2a731bbdb686b8");
		self clientfield::increment("death_dash_pulse", 1);
		self playrumbleonentity("talon_spike");
		var_baf7d060 = getaiteamarray(level.zombie_team);
		a_ai_zombies = array::get_all_closest(self.origin, var_baf7d060, undefined, undefined, 256);
		foreach(ai_zombie in a_ai_zombies)
		{
			if(!isalive(ai_zombie) || (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death))
			{
				continue;
			}
			if(!isdefined(ai_zombie.var_6f84b820))
			{
				continue;
			}
			switch(ai_zombie.var_6f84b820)
			{
				case "heavy":
				case "miniboss":
				case "enhanced":
				{
					if(!(isdefined(ai_zombie.knockdown) && ai_zombie.knockdown))
					{
						ai_zombie ai::stun();
					}
					break;
				}
				case "popcorn":
				{
					ai_zombie.var_96d5504c = 1;
					[[ self.var_3dd38cd4 ]]->waitinqueue(ai_zombie);
					ai_zombie thread zm_perk_death_dash::function_c1c51837(self);
					ai_zombie.var_96d5504c = undefined;
					break;
				}
				case "basic":
				{
					ai_zombie zombie_utility::setup_zombie_knockdown(self);
					break;
				}
			}
		}
	}
}

