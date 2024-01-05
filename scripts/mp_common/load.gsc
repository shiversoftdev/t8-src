// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\util.gsc;
#using scripts\mp_common\load.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace load;

/*
	Name: main
	Namespace: load
	Checksum: 0xCC9D1527
	Offset: 0x208
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function main()
{
	/#
		assert(isdefined(level.first_frame), "");
	#/
	level._loadstarted = 1;
	/#
		util::check_art_mode();
	#/
	/#
		util::apply_dev_overrides();
	#/
	setclearanceceiling(30);
	register_clientfields();
	level.aitriggerspawnflags = getaitriggerflags();
	level.vehicletriggerspawnflags = getvehicletriggerflags();
	setup_traversals();
	level.globallogic_audio_dialog_on_player_override = &globallogic_audio::leader_dialog_on_player;
	level.growing_hitmarker = 1;
	system::wait_till("all");
	level flagsys::set(#"load_main_complete");
}

/*
	Name: setfootstepeffect
	Namespace: load
	Checksum: 0x493558B8
	Offset: 0x358
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function setfootstepeffect(name, fx)
{
	/#
		assert(isdefined(name), "");
	#/
	/#
		assert(isdefined(fx), "");
	#/
	if(!isdefined(anim.optionalstepeffects))
	{
		anim.optionalstepeffects = [];
	}
	anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
	level._effect["step_" + name] = fx;
}

/*
	Name: footsteps
	Namespace: load
	Checksum: 0xBA412190
	Offset: 0x410
	Size: 0x224
	Parameters: 0
	Flags: None
*/
function footsteps()
{
	setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
	setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
	setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
	setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
	setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
	setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
	setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

/*
	Name: init_traverse
	Namespace: load
	Checksum: 0x18A4C39C
	Offset: 0x640
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function init_traverse()
{
	point = getent(self.target, "targetname");
	if(isdefined(point))
	{
		self.traverse_height = point.origin[2];
		point delete();
	}
	else
	{
		point = struct::get(self.target, "targetname");
		if(isdefined(point))
		{
			self.traverse_height = point.origin[2];
		}
	}
}

/*
	Name: setup_traversals
	Namespace: load
	Checksum: 0x6216FD30
	Offset: 0x700
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function setup_traversals()
{
	potential_traverse_nodes = getallnodes();
	for(i = 0; i < potential_traverse_nodes.size; i++)
	{
		node = potential_traverse_nodes[i];
		if(node.type == #"begin")
		{
			node init_traverse();
		}
	}
}

/*
	Name: register_clientfields
	Namespace: load
	Checksum: 0x3793B7B5
	Offset: 0x798
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("missile", "cf_m_proximity", 1, 1, "int");
	clientfield::register("missile", "cf_m_emp", 1, 1, "int");
	clientfield::register("missile", "cf_m_stun", 1, 1, "int");
}

