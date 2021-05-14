// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_perk_quick_revive;

/*
	Name: function_89f2df9
	Namespace: zm_perk_quick_revive
	Checksum: 0x5443F863
	Offset: 0x208
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_perk_quick_revive", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_quick_revive
	Checksum: 0x74469F86
	Offset: 0x250
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_quick_revive_perk_for_level();
}

/*
	Name: enable_quick_revive_perk_for_level
	Namespace: zm_perk_quick_revive
	Checksum: 0x9B7D07
	Offset: 0x270
	Size: 0x25C
	Parameters: 0
	Flags: Linked
*/
function enable_quick_revive_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_quickrevive", #"perk_quick_revive", 2000, #"hash_1fe09aea69fefa7", getweapon("zombie_perk_bottle_revive"), getweapon("zombie_perk_totem_quick_revive"), #"hash_4a827056d0e273fd");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_quickrevive", #"perk_quick_revive", 2000, #"hash_8f2aa407d227799", getweapon("zombie_perk_bottle_revive"), getweapon("zombie_perk_totem_quick_revive"), #"hash_4a827056d0e273fd");
	}
	zm_perks::register_perk_precache_func(#"specialty_quickrevive", &quick_revive_precache);
	zm_perks::register_perk_clientfields(#"specialty_quickrevive", &quick_revive_register_clientfield, &quick_revive_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_quickrevive", &quick_revive_perk_machine_setup);
	zm_perks::register_perk_threads(#"specialty_quickrevive", &give_quick_revive_perk, &take_quick_revive_perk);
	zm_perks::register_perk_host_migration_params(#"specialty_quickrevive", "vending_revive", "revive_light");
	zm_perks::register_perk_machine_power_override(#"specialty_quickrevive", &turn_revive_on);
}

/*
	Name: quick_revive_precache
	Namespace: zm_perk_quick_revive
	Checksum: 0xD1C8C5F7
	Offset: 0x4D8
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function quick_revive_precache()
{
	if(isdefined(level.quick_revive_precache_override_func))
	{
		[[level.quick_revive_precache_override_func]]();
		return;
	}
	level._effect[#"revive_light"] = #"zombie/fx_perk_quick_revive_zmb";
	level.machine_assets[#"specialty_quickrevive"] = spawnstruct();
	level.machine_assets[#"specialty_quickrevive"].weapon = getweapon("zombie_perk_bottle_revive");
	level.machine_assets[#"specialty_quickrevive"].off_model = "p7_zm_vending_revive";
	level.machine_assets[#"specialty_quickrevive"].on_model = "p7_zm_vending_revive";
}

/*
	Name: quick_revive_register_clientfield
	Namespace: zm_perk_quick_revive
	Checksum: 0x80F724D1
	Offset: 0x5F0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_register_clientfield()
{
}

/*
	Name: quick_revive_set_clientfield
	Namespace: zm_perk_quick_revive
	Checksum: 0xFC75FF99
	Offset: 0x600
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function quick_revive_set_clientfield(state)
{
}

/*
	Name: quick_revive_perk_machine_setup
	Namespace: zm_perk_quick_revive
	Checksum: 0x17B7C704
	Offset: 0x618
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function quick_revive_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_revive_jingle";
	use_trigger.script_string = "revive_perk";
	use_trigger.script_label = "mus_perks_revive_sting";
	use_trigger.target = "vending_revive";
	perk_machine.script_string = "revive_perk";
	perk_machine.targetname = "vending_revive";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "revive_perk";
	}
}

/*
	Name: turn_revive_on
	Namespace: zm_perk_quick_revive
	Checksum: 0x485FA99A
	Offset: 0x6D8
	Size: 0x5C2
	Parameters: 0
	Flags: Linked
*/
function turn_revive_on()
{
	level endon(#"stop_quickrevive_logic");
	level flag::wait_till("start_zombie_round_logic");
	while(true)
	{
		machine = getentarray("vending_revive", "targetname");
		machine_triggers = getentarray("vending_revive", "target");
		for(i = 0; i < machine.size; i++)
		{
			machine[i] setmodel(level.machine_assets[#"specialty_quickrevive"].off_model);
			if(isdefined(level.quick_revive_final_pos))
			{
				level.quick_revive_default_origin = level.quick_revive_final_pos;
			}
			if(!isdefined(level.quick_revive_default_origin))
			{
				level.quick_revive_default_origin = machine[i].origin;
				level.quick_revive_default_angles = machine[i].angles;
			}
			level.quick_revive_machine = machine[i];
		}
		array::thread_all(machine, &zm_perks::set_power_on, 0);
		for(i = 0; i < machine.size; i++)
		{
			if(isdefined(machine[i].classname) && machine[i].classname == "script_model")
			{
				if(isdefined(machine[i].script_noteworthy) && machine[i].script_noteworthy == "clip")
				{
					machine_clip = machine[i];
					continue;
				}
				machine[i] setmodel(level.machine_assets[#"specialty_quickrevive"].on_model);
				machine[i] playsound(#"zmb_perks_power_on");
				machine[i] vibrate(vectorscale((0, -1, 0), 100), 0.3, 0.4, 3);
				machine_model = machine[i];
				machine[i] thread zm_perks::perk_fx("revive_light");
				exploder::exploder("quick_revive_lgts");
				machine[i] notify(#"stop_loopsound");
				machine[i] thread zm_perks::play_loop_on_machine();
				if(isdefined(machine_triggers[i]))
				{
					machine_clip = machine_triggers[i].clip;
				}
				if(isdefined(machine_triggers[i]))
				{
					blocker_model = machine_triggers[i].blocker_model;
				}
			}
		}
		util::wait_network_frame();
		array::thread_all(machine, &zm_perks::set_power_on, 1);
		if(isdefined(level.machine_assets[#"specialty_quickrevive"].power_on_callback))
		{
			array::thread_all(machine, level.machine_assets[#"specialty_quickrevive"].power_on_callback);
		}
		level notify(#"specialty_quickrevive_power_on");
		if(isdefined(machine_model))
		{
			machine_model.ishidden = 0;
		}
		notify_str = undefined;
		notify_str = level waittill(#"revive_off", #"revive_hide", #"stop_quickrevive_logic");
		should_hide = 0;
		if(notify_str._notify == "revive_hide")
		{
			should_hide = 1;
		}
		if(isdefined(level.machine_assets[#"specialty_quickrevive"].power_off_callback))
		{
			array::thread_all(machine, level.machine_assets[#"specialty_quickrevive"].power_off_callback);
		}
		for(i = 0; i < machine.size; i++)
		{
			if(isdefined(machine[i].classname) && machine[i].classname == "script_model")
			{
				machine[i] zm_perks::turn_perk_off(should_hide);
			}
		}
	}
}

/*
	Name: unhide_quickrevive
	Namespace: zm_perk_quick_revive
	Checksum: 0xAFA714A3
	Offset: 0xCA8
	Size: 0x466
	Parameters: 0
	Flags: None
*/
function unhide_quickrevive()
{
	while(zm_perks::players_are_in_perk_area(level.quick_revive_machine))
	{
		wait(0.1);
	}
	if(isdefined(level.quick_revive_machine_clip))
	{
		level.quick_revive_machine_clip show();
		level.quick_revive_machine_clip disconnectpaths();
	}
	if(isdefined(level.quick_revive_final_pos))
	{
		level.quick_revive_machine.origin = level.quick_revive_final_pos;
	}
	playfx(level._effect[#"poltergeist"], level.quick_revive_machine.origin);
	if(isdefined(level.quick_revive_trigger) && isdefined(level.quick_revive_trigger.blocker_model))
	{
		level.quick_revive_trigger.blocker_model hide();
	}
	level.quick_revive_machine show();
	level.quick_revive_machine solid();
	if(isdefined(level.quick_revive_machine.original_pos))
	{
		level.quick_revive_default_origin = level.quick_revive_machine.original_pos;
		level.quick_revive_default_angles = level.quick_revive_machine.original_angles;
	}
	direction = level.quick_revive_machine.origin;
	direction = (direction[1], direction[0], 0);
	if(direction[1] < 0 || (direction[0] > 0 && direction[1] > 0))
	{
		direction = (direction[0], direction[1] * -1, 0);
	}
	else if(direction[0] < 0)
	{
		direction = (direction[0] * -1, direction[1], 0);
	}
	org = level.quick_revive_default_origin;
	if(isdefined(level.quick_revive_linked_ent))
	{
		org = level.quick_revive_linked_ent.origin;
		if(isdefined(level.quick_revive_linked_ent_offset))
		{
			org = org + level.quick_revive_linked_ent_offset;
		}
	}
	if(!(isdefined(level.quick_revive_linked_ent_moves) && level.quick_revive_linked_ent_moves) && level.quick_revive_machine.origin != org)
	{
		level.quick_revive_machine moveto(org, 3);
		level.quick_revive_machine vibrate(direction, 10, 0.5, 2.9);
		level.quick_revive_machine waittill(#"movedone");
		level.quick_revive_machine.angles = level.quick_revive_default_angles;
	}
	else if(isdefined(level.quick_revive_linked_ent))
	{
		org = level.quick_revive_linked_ent.origin;
		if(isdefined(level.quick_revive_linked_ent_offset))
		{
			org = org + level.quick_revive_linked_ent_offset;
		}
		level.quick_revive_machine.origin = org;
	}
	level.quick_revive_machine vibrate(vectorscale((0, -1, 0), 100), 0.3, 0.4, 3);
	if(isdefined(level.quick_revive_linked_ent))
	{
		level.quick_revive_machine linkto(level.quick_revive_linked_ent);
	}
	level.quick_revive_machine.ishidden = 0;
}

/*
	Name: restart_quickrevive
	Namespace: zm_perk_quick_revive
	Checksum: 0x26749A09
	Offset: 0x1118
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function restart_quickrevive()
{
	vending_machines = zm_perks::get_perk_machines();
	foreach(trigger in vending_machines)
	{
		if(!isdefined(trigger.script_noteworthy))
		{
			continue;
		}
		if(trigger.script_noteworthy == #"specialty_quickrevive")
		{
			trigger notify(#"stop_quickrevive_logic");
			trigger thread zm_perks::vending_trigger_think();
			trigger triggerenable(1);
		}
	}
}

/*
	Name: update_quickrevive_power_state
	Namespace: zm_perk_quick_revive
	Checksum: 0x30347669
	Offset: 0x1210
	Size: 0x196
	Parameters: 1
	Flags: None
*/
function update_quickrevive_power_state(poweron)
{
	foreach(item in level.powered_items)
	{
		if(isdefined(item.target) && isdefined(item.target.script_noteworthy) && item.target.script_noteworthy == "specialty_quickrevive")
		{
			if(item.power && !poweron)
			{
				if(!isdefined(item.powered_count))
				{
					item.powered_count = 0;
				}
				else if(item.powered_count > 0)
				{
					item.powered_count--;
				}
			}
			else if(!item.power && poweron)
			{
				if(!isdefined(item.powered_count))
				{
					item.powered_count = 0;
				}
				item.powered_count++;
			}
			if(!isdefined(item.depowered_count))
			{
				item.depowered_count = 0;
			}
			item.power = poweron;
		}
	}
}

/*
	Name: give_quick_revive_perk
	Namespace: zm_perk_quick_revive
	Checksum: 0x80F724D1
	Offset: 0x13B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function give_quick_revive_perk()
{
}

/*
	Name: take_quick_revive_perk
	Namespace: zm_perk_quick_revive
	Checksum: 0x5D7CB0EA
	Offset: 0x13C0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function take_quick_revive_perk(b_pause, str_perk, str_result, n_slot)
{
}

