// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_escape_pebble.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace zm_escape_magicbox;

/*
	Name: __init__system__
	Namespace: zm_escape_magicbox
	Checksum: 0x5A1035A8
	Offset: 0x108
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_escape_magicbox", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_escape_magicbox
	Checksum: 0x48BD41F9
	Offset: 0x158
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.locked_magic_box_cost = 2000;
	level.custom_magicbox_state_handler = &set_locked_magicbox_state;
	level.var_f39bb42a = &watch_for_lock;
	level.var_555605da = &clean_up_locked_box;
	level.custom_firesale_box_leave = 1;
}

/*
	Name: __main__
	Namespace: zm_escape_magicbox
	Checksum: 0x2B48DC2
	Offset: 0x1D0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.chest_joker_model = #"hash_4b77dcb67eb0dc91";
	level.chest_joker_custom_movement = &custom_joker_movement;
}

/*
	Name: custom_joker_movement
	Namespace: zm_escape_magicbox
	Checksum: 0x48FC408B
	Offset: 0x210
	Size: 0x258
	Parameters: 0
	Flags: Linked
*/
function custom_joker_movement()
{
	v_origin = self.weapon_model.origin - vectorscale((0, 0, 1), 5);
	if(isdefined(self.weapon_model))
	{
		self.weapon_model delete();
		self.weapon_model = undefined;
	}
	var_f67ecd64 = util::spawn_model(level.chest_joker_model, v_origin, self.angles + vectorscale((0, 1, 0), 180));
	var_f67ecd64.targetname = "box_lock";
	var_f67ecd64 setcandamage(1);
	level.var_c7626f2a[#"box_lock"] = &pebble::function_bdd1bac8;
	level notify(#"hash_219aba01ff2d6de4");
	playsoundatposition(#"hash_7c7d8771a48e8871", var_f67ecd64.origin);
	wait(0.5);
	level notify(#"weapon_fly_away_start");
	wait(1);
	var_f67ecd64 rotateyaw(3000, 4, 4);
	wait(3);
	var_f67ecd64 movez(20, 0.5, 0.5);
	var_f67ecd64 waittill(#"movedone");
	var_f67ecd64 movez(-100, 0.5, 0.5);
	var_f67ecd64 waittill(#"movedone");
	level notify(#"hash_3698278a3a5d8beb");
	var_f67ecd64 delete();
	self notify(#"box_moving");
	level notify(#"weapon_fly_away_end");
}

/*
	Name: watch_for_lock
	Namespace: zm_escape_magicbox
	Checksum: 0x70AD379C
	Offset: 0x470
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function watch_for_lock()
{
	self endon(#"user_grabbed_weapon", #"chest_accessed");
	self waittill(#"box_locked");
	self notify(#"kill_chest_think");
	self.grab_weapon_hint = 0;
	self.chest_user = undefined;
	wait(0.1);
	self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
	self thread zm_magicbox::treasure_chest_think();
}

/*
	Name: clean_up_locked_box
	Namespace: zm_escape_magicbox
	Checksum: 0xE545CC27
	Offset: 0x528
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function clean_up_locked_box()
{
	self endon(#"box_spin_done");
	self.owner waittill(#"box_locked");
	if(isdefined(self.weapon_model))
	{
		self.weapon_model delete();
		self.weapon_model = undefined;
	}
	if(isdefined(self.weapon_model_dw))
	{
		self.weapon_model_dw delete();
		self.weapon_model_dw = undefined;
	}
	self hidezbarrierpiece(3);
	self hidezbarrierpiece(4);
	self setzbarrierpiecestate(3, "closed");
	self setzbarrierpiecestate(4, "closed");
}

/*
	Name: magic_box_locks
	Namespace: zm_escape_magicbox
	Checksum: 0x53210B8
	Offset: 0x630
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function magic_box_locks()
{
	self.owner.is_locked = 1;
	self.owner notify(#"box_locked");
	self playsound(#"zmb_hellbox_lock");
	self clientfield::set("magicbox_open_fx", 0);
	self setzbarrierpiecestate(5, "closing");
	while(self getzbarrierpiecestate(5) == "closing")
	{
		wait(0.5);
	}
	self notify(#"locked");
}

/*
	Name: magic_box_unlocks
	Namespace: zm_escape_magicbox
	Checksum: 0x9E084125
	Offset: 0x708
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function magic_box_unlocks()
{
	self playsound(#"zmb_hellbox_unlock");
	self setzbarrierpiecestate(5, "opening");
	while(self getzbarrierpiecestate(5) == "opening")
	{
		wait(0.5);
	}
	self setzbarrierpiecestate(2, "closed");
	self showzbarrierpiece(2);
	self hidezbarrierpiece(5);
	self notify(#"unlocked");
	self.owner.is_locked = undefined;
}

/*
	Name: set_locked_magicbox_state
	Namespace: zm_escape_magicbox
	Checksum: 0x8E520BB8
	Offset: 0x7F8
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function set_locked_magicbox_state(state)
{
	switch(state)
	{
		case "locking":
		{
			self showzbarrierpiece(5);
			self thread magic_box_locks();
			self.state = "locking";
			break;
		}
		case "unlocking":
		{
			self showzbarrierpiece(5);
			self thread magic_box_unlocks();
			self.state = "close";
			break;
		}
	}
}

/*
	Name: function_be66db38
	Namespace: zm_escape_magicbox
	Checksum: 0xE30474B4
	Offset: 0x8C8
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function function_be66db38()
{
	/#
		level flagsys::wait_till("");
		e_box = undefined;
		for(i = 0; i < level.chests.size; i++)
		{
			if(isdefined(level.chests[i].zbarrier.state === "") && level.chests[i].zbarrier.state === "")
			{
				e_box = level.chests[i];
				break;
			}
		}
		if(isdefined(e_box))
		{
			while(distance(level.players[0].origin, e_box.origin) > 128)
			{
				wait(1);
			}
			e_box.zbarrier zm_magicbox::set_magic_box_zbarrier_state("");
		}
	#/
}

