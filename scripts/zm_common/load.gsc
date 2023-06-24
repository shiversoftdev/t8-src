// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\zm\weaponobjects.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_aoe.gsc;
#using scripts\zm_common\bots\zm_bot.gsc;
#using scripts\core_common\audio_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\dialog_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\load_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm_common\art.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\gametypes\clientids.gsc;
#using scripts\zm_common\gametypes\serversettings.gsc;
#using scripts\zm_common\gametypes\shellshock.gsc;
#using scripts\zm_common\gametypes\spawnlogic.gsc;
#using scripts\zm_common\gametypes\spectating.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_clone.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace load;

/*
	Name: main
	Namespace: load
	Checksum: 0x9E36E891
	Offset: 0x300
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function main()
{
	/#
		/#
			assert(isdefined(level.first_frame), "");
		#/
	#/
	zm::init();
	level._loadstarted = 1;
	register_clientfields();
	level.aitriggerspawnflags = getaitriggerflags() | 8192;
	level.vehicletriggerspawnflags = getvehicletriggerflags();
	level thread start_intro_screen_zm();
	footsteps();
	system::wait_till("all");
	level thread art_review();
	level flagsys::set(#"load_main_complete");
}

/*
	Name: footsteps
	Namespace: load
	Checksum: 0xD098EE3B
	Offset: 0x420
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function footsteps()
{
	if(isdefined(level.fx_exclude_footsteps) && level.fx_exclude_footsteps)
	{
		return;
	}
	zombie_utility::setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
	zombie_utility::setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
	zombie_utility::setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
	zombie_utility::setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
	zombie_utility::setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
	zombie_utility::setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
	zombie_utility::setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

/*
	Name: start_intro_screen_zm
	Namespace: load
	Checksum: 0x703C1B88
	Offset: 0x670
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function start_intro_screen_zm()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] lui::screen_fade_out(0, undefined);
		players[i] val::set(#"start_intro_screen_zm", "freezecontrols");
	}
	wait(1);
}

/*
	Name: register_clientfields
	Namespace: load
	Checksum: 0x3A5CDF33
	Offset: 0x718
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("allplayers", "zmbLastStand", 1, 1, "int");
}

