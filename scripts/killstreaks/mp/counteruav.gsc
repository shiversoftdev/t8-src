// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\killstreaks\killstreak_hacking.gsc;
#using scripts\killstreaks\airsupport.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\killstreaks\killstreak_detect.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\tweakables_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;

#namespace counteruav;

/*
	Name: __init__system__
	Namespace: counteruav
	Checksum: 0x9DE26BBF
	Offset: 0x218
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"counteruav", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: counteruav
	Checksum: 0x88EF36BB
	Offset: 0x268
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.activecounteruavs = [];
	level.counter_uav_offsets = buildoffsetlist((0, 0, 0), 3, 450, 450);
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			level.activecounteruavs[team] = 0;
		}
	}
	else
	{
		level.activecounteruavs = [];
	}
	level.activeplayercounteruavs = [];
	level.counter_uav_entities = [];
	if(tweakables::gettweakablevalue("killstreak", "allowcounteruav"))
	{
		killstreaks::register_killstreak("killstreak_counteruav", &activatecounteruav);
	}
	clientfield::register("toplayer", "counteruav", 1, 1, "int");
	level thread watchcounteruavs();
	callback::on_connect(&onplayerconnect);
	callback::on_spawned(&onplayerspawned);
	callback::on_joined_team(&onplayerjoinedteam);
	callback::on_finalize_initialization(&function_3675de8b);
	callback::on_connect(&onplayerconnect);
	callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
	/#
		if(getdvarint(#"scr_cuav_offset_debug", 0))
		{
			level thread waitanddebugdrawoffsetlist();
		}
	#/
}

/*
	Name: fx_flesh_hit_neck_fatal
	Namespace: counteruav
	Checksum: 0x8173A109
	Offset: 0x500
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function fx_flesh_hit_neck_fatal(params)
{
	foreach(player in params.players)
	{
		if(level.activeplayercounteruavs[player.entnum] > 0)
		{
			scoregiven = scoreevents::processscoreevent(#"counter_uav_assist", player, undefined, undefined);
			if(isdefined(scoregiven))
			{
				player challenges::earnedcuavassistscore(scoregiven);
				killstreakindex = level.killstreakindices[#"counteruav"];
				killstreaks::killstreak_assist(player, self, killstreakindex);
			}
		}
	}
}

/*
	Name: function_3675de8b
	Namespace: counteruav
	Checksum: 0x44E05E61
	Offset: 0x620
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_3675de8b()
{
	initrotatingrig();
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon(#"counteruav"), &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: counteruav
	Checksum: 0x44AB2521
	Offset: 0x690
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(cuav, attackingplayer)
{
	cuav hackedprefunction(attackingplayer);
	cuav.owner = attackingplayer;
	cuav setowner(attackingplayer);
	cuav killstreaks::configure_team_internal(attackingplayer, 1);
	if(isdefined(level.var_f1edf93f))
	{
		cuav notify(#"hacked");
		cuav notify(#"cancel_timeout");
		var_eb79e7c3 = int([[level.var_f1edf93f]]() * 1000);
		cuav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
	}
}

/*
	Name: onplayerconnect
	Namespace: counteruav
	Checksum: 0xC038CE35
	Offset: 0x7C8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function onplayerconnect()
{
	self.entnum = self getentitynumber();
	if(!level.teambased)
	{
		level.activecounteruavs[self.entnum] = 0;
	}
	level.activeplayercounteruavs[self.entnum] = 0;
}

/*
	Name: onplayerspawned
	Namespace: counteruav
	Checksum: 0x2980AFAF
	Offset: 0x830
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function onplayerspawned()
{
	if(self enemycounteruavactive())
	{
		self clientfield::set_to_player("counteruav", 1);
	}
	else
	{
		self clientfield::set_to_player("counteruav", 0);
	}
}

/*
	Name: initrotatingrig
	Namespace: counteruav
	Checksum: 0xF379C027
	Offset: 0x898
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function initrotatingrig()
{
	if(isdefined(level.var_98c93497))
	{
		map_center = airsupport::getmapcenter();
		rotator_offset = ((isdefined(level.var_98c93497) ? level.var_98c93497 : map_center[0]), (isdefined(level.var_31be45ec) ? level.var_31be45ec : map_center[1]), (isdefined(level.var_8ac94558) ? level.var_8ac94558 : 1200));
		level.var_f6bf445b = spawn("script_model", rotator_offset);
	}
	else
	{
		level.var_f6bf445b = spawn("script_model", airsupport::getmapcenter() + ((isdefined(level.var_f2afd3a) ? level.var_f2afd3a : 0), (isdefined(level.var_e500f46c) ? level.var_e500f46c : 0), 1200));
	}
	level.var_f6bf445b setmodel(#"tag_origin");
	level.var_f6bf445b.angles = vectorscale((0, 1, 0), 115);
	level.var_f6bf445b hide();
	level.var_f6bf445b thread rotaterig();
	level.var_f6bf445b thread swayrig();
}

/*
	Name: rotaterig
	Namespace: counteruav
	Checksum: 0xBF37AE0B
	Offset: 0xA78
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function rotaterig()
{
	for(;;)
	{
		self rotateyaw(360, 60);
		wait(60);
	}
}

/*
	Name: swayrig
	Namespace: counteruav
	Checksum: 0xF7F5CB23
	Offset: 0xAB0
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function swayrig()
{
	centerorigin = self.origin;
	for(;;)
	{
		z = randomintrange(-200, -100);
		time = randomintrange(3, 6);
		self moveto(centerorigin + (0, 0, z), time, 1, 1);
		wait(time);
		z = randomintrange(100, 200);
		time = randomintrange(3, 6);
		self moveto(centerorigin + (0, 0, z), time, 1, 1);
		wait(time);
	}
}

/*
	Name: generaterandompoints
	Namespace: counteruav
	Checksum: 0x3592EC11
	Offset: 0xBC8
	Size: 0x14A
	Parameters: 1
	Flags: None
*/
function generaterandompoints(count)
{
	points = [];
	for(i = 0; i < count; i++)
	{
		point = airsupport::getrandommappoint((isdefined(level.cuav_map_x_offset) ? level.cuav_map_x_offset : 0), (isdefined(level.cuav_map_y_offset) ? level.cuav_map_y_offset : 0), (isdefined(level.cuav_map_x_percentage) ? level.cuav_map_x_percentage : 0.5), (isdefined(level.cuav_map_y_percentage) ? level.cuav_map_y_percentage : 0.5));
		minflyheight = airsupport::getminimumflyheight();
		point = point + (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000));
		points[i] = point;
	}
	return points;
}

/*
	Name: movementmanagerthink
	Namespace: counteruav
	Checksum: 0xCF44AA77
	Offset: 0xD20
	Size: 0x12E
	Parameters: 1
	Flags: None
*/
function movementmanagerthink(teamorentnum)
{
	while(true)
	{
		level waittill(#"counter_uav_updated");
		activecount = 0;
		while(level.activecounteruavs[teamorentnum] > 0)
		{
			if(activecount == 0)
			{
				activecount = level.activecounteruavs[teamorentnum];
			}
			currentindex = level.counter_uav_position_index[teamorentnum];
			newindex = currentindex;
			while(newindex == currentindex)
			{
				newindex = randomintrange(0, 20);
			}
			destination = level.counter_uav_positions[newindex];
			level.counter_uav_position_index[teamorentnum] = newindex;
			level notify("counter_uav_move_" + teamorentnum);
			wait(5 + randomintrange(5, 10));
		}
	}
}

/*
	Name: getcurrentposition
	Namespace: counteruav
	Checksum: 0x3F20A0E7
	Offset: 0xE58
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function getcurrentposition(teamorentnum)
{
	baseposition = level.counter_uav_positions[level.counter_uav_position_index[teamorentnum]];
	offset = level.counter_uav_offsets[self.cuav_offset_index];
	return baseposition + offset;
}

/*
	Name: assignfirstavailableoffsetindex
	Namespace: counteruav
	Checksum: 0xB0E821C1
	Offset: 0xEC0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function assignfirstavailableoffsetindex()
{
	self.cuav_offset_index = getfirstavailableoffsetindex();
	maintaincouteruaventities();
}

/*
	Name: getfirstavailableoffsetindex
	Namespace: counteruav
	Checksum: 0xC28F6D15
	Offset: 0xEF8
	Size: 0x11E
	Parameters: 0
	Flags: Linked
*/
function getfirstavailableoffsetindex()
{
	available_offsets = [];
	for(i = 0; i < level.counter_uav_offsets.size; i++)
	{
		available_offsets[i] = 1;
	}
	foreach(cuav in level.counter_uav_entities)
	{
		if(isdefined(cuav))
		{
			available_offsets[cuav.cuav_offset_index] = 0;
		}
	}
	for(i = 0; i < available_offsets.size; i++)
	{
		if(available_offsets[i])
		{
			return i;
		}
	}
	/#
		util::warning("");
	#/
	return 0;
}

/*
	Name: maintaincouteruaventities
	Namespace: counteruav
	Checksum: 0xB8649EFB
	Offset: 0x1020
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function maintaincouteruaventities()
{
	for(i = level.counter_uav_entities.size; i >= 0; i--)
	{
		if(!isdefined(level.counter_uav_entities[i]))
		{
			arrayremoveindex(level.counter_uav_entities, i);
		}
	}
}

/*
	Name: waitanddebugdrawoffsetlist
	Namespace: counteruav
	Checksum: 0xA53E3F85
	Offset: 0x1090
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function waitanddebugdrawoffsetlist()
{
	/#
		level endon(#"game_ended");
		wait(10);
		debugdrawoffsetlist();
	#/
}

/*
	Name: debugdrawoffsetlist
	Namespace: counteruav
	Checksum: 0xE47FFC22
	Offset: 0x10D0
	Size: 0xD0
	Parameters: 0
	Flags: None
*/
function debugdrawoffsetlist()
{
	/#
		baseposition = level.counter_uav_positions[0];
		foreach(offset in level.counter_uav_offsets)
		{
			util::debug_sphere(baseposition + offset, 24, (0.95, 0.05, 0.05), 0.75, 9999999);
		}
	#/
}

/*
	Name: buildoffsetlist
	Namespace: counteruav
	Checksum: 0x226D89D5
	Offset: 0x11A8
	Size: 0x142
	Parameters: 4
	Flags: Linked
*/
function buildoffsetlist(startoffset, depth, offset_x, offset_y)
{
	offsets = [];
	for(col = 0; col < depth; col++)
	{
		itemcount = math::pow(2, col);
		startingindex = itemcount - 1;
		for(i = 0; i < itemcount; i++)
		{
			x = offset_x * col;
			y = 0;
			if(itemcount > 1)
			{
				y = i * offset_y;
				total_y = offset_y * startingindex;
				y = y - (total_y / 2);
			}
			offsets[startingindex + i] = startoffset + (x, y, 0);
		}
	}
	return offsets;
}

/*
	Name: function_af281272
	Namespace: counteruav
	Checksum: 0xFFAA831C
	Offset: 0x12F8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_af281272()
{
	self endon(#"delete");
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(!isdefined(self))
	{
		return;
	}
	destroycounteruav(waitresult.attacker, waitresult.weapon);
}

/*
	Name: activatecounteruav
	Namespace: counteruav
	Checksum: 0xE0F45759
	Offset: 0x1370
	Size: 0x2C0
	Parameters: 0
	Flags: Linked
*/
function activatecounteruav()
{
	if(self killstreakrules::iskillstreakallowed("counteruav", self.team) == 0)
	{
		return false;
	}
	killstreak_id = self killstreakrules::killstreakstart("counteruav", self.team);
	if(killstreak_id == -1)
	{
		return false;
	}
	counteruav = spawncounteruav(self, killstreak_id);
	if(!isdefined(counteruav))
	{
		return false;
	}
	counteruav clientfield::set("enemyvehicle", 1);
	counteruav.killstreak_id = killstreak_id;
	counteruav thread killstreaks::waittillemp(&destroycounteruavbyemp);
	counteruav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
	counteruav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
	counteruav thread function_af281272();
	counteruav thread killstreaks::function_2b6aa9e8("counteruav", &destroycounteruav, &onlowhealth, undefined);
	counteruav playloopsound("veh_uav_engine_loop", 1);
	counteruav function_7c61ce31();
	self killstreaks::play_killstreak_start_dialog("counteruav", self.team, killstreak_id);
	counteruav killstreaks::play_pilot_dialog_on_owner("arrive", "counteruav", killstreak_id);
	counteruav thread killstreaks::player_killstreak_threat_tracking("counteruav");
	self stats::function_e24eec31(getweapon("counteruav"), #"used", 1);
	return true;
}

/*
	Name: function_7c61ce31
	Namespace: counteruav
	Checksum: 0x40CF2788
	Offset: 0x1638
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_7c61ce31()
{
	minflyheight = int(airsupport::getminimumflyheight());
	zoffset = minflyheight + (isdefined(level.var_97961f83) ? level.var_97961f83 : 2500);
	angle = randomint(360);
	loc_000016FC:
	radiusoffset = (isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint((isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000));
	xoffset = cos(angle) * radiusoffset;
	yoffset = sin(angle) * radiusoffset;
	anglevector = vectornormalize((xoffset, yoffset, zoffset));
	anglevector = anglevector * zoffset;
	anglevector = (anglevector[0], anglevector[1], zoffset - level.var_f6bf445b.origin[2]);
	self linkto(level.var_f6bf445b, "tag_origin", anglevector, (0, angle + 90, 0));
}

/*
	Name: hackedprefunction
	Namespace: counteruav
	Checksum: 0xC82C41F1
	Offset: 0x1820
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function hackedprefunction(hacker)
{
	cuav = self;
	cuav resetactivecounteruav();
}

/*
	Name: spawncounteruav
	Namespace: counteruav
	Checksum: 0xEEDE84E1
	Offset: 0x1858
	Size: 0x27E
	Parameters: 2
	Flags: Linked
*/
function spawncounteruav(owner, killstreak_id)
{
	minflyheight = airsupport::getminimumflyheight();
	bundle = struct::get_script_bundle("killstreak", "killstreak_counteruav");
	cuav = spawnvehicle(bundle.ksvehicle, airsupport::getmapcenter() + (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000)), (0, 0, 0), "counteruav");
	cuav assignfirstavailableoffsetindex();
	cuav killstreaks::configure_team("counteruav", killstreak_id, owner, undefined, undefined, &configureteampost);
	cuav killstreak_hacking::enable_hacking("counteruav", &hackedprefunction, undefined);
	cuav.targetname = "counteruav";
	cuav util::function_c596f193();
	cuav.weapon = getweapon("counteruav");
	cuav setweapon(cuav.weapon);
	killstreak_detect::killstreaktargetset(cuav);
	cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
	cuav setdrawinfrared(1);
	if(!isdefined(level.counter_uav_entities))
	{
		level.counter_uav_entities = [];
	}
	else if(!isarray(level.counter_uav_entities))
	{
		level.counter_uav_entities = array(level.counter_uav_entities);
	}
	level.counter_uav_entities[level.counter_uav_entities.size] = cuav;
	return cuav;
}

/*
	Name: configureteampost
	Namespace: counteruav
	Checksum: 0x295BC97F
	Offset: 0x1AE0
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function configureteampost(owner, ishacked)
{
	cuav = self;
	if(ishacked == 0)
	{
		cuav teams::hidetosameteam();
	}
	else
	{
		cuav setvisibletoall();
	}
	cuav thread teams::waituntilteamchangesingleton(owner, "CUAV_watch_team_change_" + cuav getentitynumber(), &onteamchange, self.entnum, "death", "leaving", "crashing");
	cuav addactivecounteruav();
}

/*
	Name: listenformove
	Namespace: counteruav
	Checksum: 0x45F88912
	Offset: 0x1BC0
	Size: 0x72
	Parameters: 0
	Flags: None
*/
function listenformove()
{
	self endon(#"death", #"leaving");
	while(true)
	{
		self thread counteruavmove();
		level waittill("counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum);
	}
}

/*
	Name: counteruavmove
	Namespace: counteruav
	Checksum: 0x842F1F92
	Offset: 0x1C40
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function counteruavmove()
{
	self endon(#"death", #"leaving");
	level endon("counter_uav_move_" + self.team);
	destination = (0, 0, 0);
	if(level.teambased)
	{
		destination = self getcurrentposition(self.team);
	}
	else
	{
		destination = self getcurrentposition(self.ownerentnum);
	}
	lookangles = vectortoangles(destination - self.origin);
	rotationaccelerationduration = 0.5 * 0.2;
	rotationdecelerationduration = 0.5 * 0.2;
	travelaccelerationduration = 5 * 0.2;
	traveldecelerationduration = 5 * 0.2;
	self setgoal(destination, 1, 0);
}

/*
	Name: playfx
	Namespace: counteruav
	Checksum: 0xDCEEA08A
	Offset: 0x1D98
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function playfx(name)
{
	self endon(#"death");
	wait(0.1);
	if(isdefined(self))
	{
		playfxontag(name, self, "tag_origin");
	}
}

/*
	Name: onlowhealth
	Namespace: counteruav
	Checksum: 0x6C6D85F9
	Offset: 0x1DF8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function onlowhealth(attacker, weapon)
{
	self.is_damaged = 1;
	params = level.killstreakbundle[#"counteruav"];
	if(isdefined(params.fxlowhealth))
	{
		playfxontag(params.fxlowhealth, self, "tag_origin");
	}
}

/*
	Name: onteamchange
	Namespace: counteruav
	Checksum: 0x7E2A1304
	Offset: 0x1E80
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function onteamchange(entnum, event)
{
	destroycounteruav(undefined, undefined);
}

/*
	Name: onplayerjoinedteam
	Namespace: counteruav
	Checksum: 0x92B2CFA7
	Offset: 0x1EB8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function onplayerjoinedteam(params)
{
	hideallcounteruavstosameteam();
}

/*
	Name: ontimeout
	Namespace: counteruav
	Checksum: 0xC17EB55F
	Offset: 0x1EE0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function ontimeout()
{
	self.leaving = 1;
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](self, 0);
	}
	self.owner globallogic_audio::play_taacom_dialog("timeout", "counteruav");
	self airsupport::leave(5);
	wait(5);
	self removeactivecounteruav();
	if(target_istarget(self))
	{
		target_remove(self);
	}
	self delete();
}

/*
	Name: ontimecheck
	Namespace: counteruav
	Checksum: 0x9FB18C34
	Offset: 0x1FC0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function ontimecheck()
{
	self killstreaks::play_pilot_dialog_on_owner("timecheck", "counteruav", self.killstreak_id);
}

/*
	Name: destroycounteruavbyemp
	Namespace: counteruav
	Checksum: 0xD4388CAB
	Offset: 0x2000
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function destroycounteruavbyemp(attacker, arg)
{
	destroycounteruav(attacker, getweapon(#"emp"));
}

/*
	Name: destroycounteruav
	Namespace: counteruav
	Checksum: 0x11B0454C
	Offset: 0x2050
	Size: 0x1EC
	Parameters: 2
	Flags: Linked
*/
function destroycounteruav(attacker, weapon)
{
	if(self.leaving !== 1)
	{
		self killstreaks::play_destroyed_dialog_on_owner("counteruav", self.killstreak_id);
	}
	attacker = self [[level.figure_out_attacker]](attacker);
	if(isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker)))
	{
		attacker battlechatter::function_dd6a6012("counteruav", weapon);
		challenges::destroyedaircraft(attacker, weapon, 0, 0);
		self killstreaks::function_73566ec7(attacker, weapon, self.owner);
		luinotifyevent(#"player_callout", 2, #"hash_3544b7c59fa5c59c", attacker.entnum);
		attacker challenges::addflyswatterstat(weapon, self);
	}
	self.var_d02ddb8e = weapon;
	self playsound(#"evt_helicopter_midair_exp");
	self removeactivecounteruav();
	if(target_istarget(self))
	{
		target_remove(self);
	}
	self thread deletecounteruav();
}

/*
	Name: deletecounteruav
	Namespace: counteruav
	Checksum: 0x59C1A944
	Offset: 0x2248
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function deletecounteruav()
{
	self notify(#"crashing");
	params = level.killstreakbundle[#"counteruav"];
	if(isdefined(params.ksexplosionfx))
	{
		self thread playfx(params.ksexplosionfx);
	}
	if(isdefined(params.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle"))
	{
		self thread playfx(params.var_bb6c29b4);
	}
	wait(0.1);
	if(isdefined(self))
	{
		self setmodel(#"tag_origin");
	}
	wait(0.2);
	if(isdefined(self))
	{
		self notify(#"delete");
		self delete();
	}
}

/*
	Name: enemycounteruavactive
	Namespace: counteruav
	Checksum: 0x8AC22074
	Offset: 0x2390
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function enemycounteruavactive()
{
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			if(team == self.team)
			{
				continue;
			}
			if(teamhasactivecounteruav(team))
			{
				return true;
			}
		}
	}
	else
	{
		enemies = self teams::getenemyplayers();
		foreach(player in enemies)
		{
			if(player hasactivecounteruav())
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: hasactivecounteruav
	Namespace: counteruav
	Checksum: 0xEECDF8A9
	Offset: 0x24E8
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function hasactivecounteruav()
{
	return level.activecounteruavs[self.entnum] > 0;
}

/*
	Name: teamhasactivecounteruav
	Namespace: counteruav
	Checksum: 0x1D5BDB72
	Offset: 0x2508
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function teamhasactivecounteruav(team)
{
	return level.activecounteruavs[team] > 0;
}

/*
	Name: hasindexactivecounteruav
	Namespace: counteruav
	Checksum: 0x20780F17
	Offset: 0x2530
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function hasindexactivecounteruav(team_or_entnum)
{
	return level.activecounteruavs[team_or_entnum] > 0;
}

/*
	Name: addactivecounteruav
	Namespace: counteruav
	Checksum: 0x1BF8EE7A
	Offset: 0x2558
	Size: 0x1B8
	Parameters: 0
	Flags: Linked
*/
function addactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]++;
		foreach(team, _ in level.teams)
		{
			if(!util::function_fbce7263(team, self.team))
			{
				continue;
			}
			if(killstreaks::hassatellite(team))
			{
				self.owner challenges::blockedsatellite();
			}
		}
	}
	else
	{
		level.activecounteruavs[self.ownerentnum]++;
		keys = getarraykeys(level.activecounteruavs);
		for(i = 0; i < keys.size; i++)
		{
			if(keys[i] == self.ownerentnum)
			{
				continue;
			}
			if(killstreaks::hassatellite(keys[i]))
			{
				self.owner challenges::blockedsatellite();
				break;
			}
		}
	}
	level.activeplayercounteruavs[self.ownerentnum]++;
	level notify(#"counter_uav_updated");
}

/*
	Name: removeactivecounteruav
	Namespace: counteruav
	Checksum: 0xD8CF8A01
	Offset: 0x2718
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function removeactivecounteruav()
{
	cuav = self;
	cuav resetactivecounteruav();
	cuav killstreakrules::killstreakstop("counteruav", self.originalteam, self.killstreak_id);
}

/*
	Name: resetactivecounteruav
	Namespace: counteruav
	Checksum: 0x8FA436B5
	Offset: 0x2778
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function resetactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]--;
		/#
			assert(level.activecounteruavs[self.team] >= 0);
		#/
		if(level.activecounteruavs[self.team] < 0)
		{
			level.activecounteruavs[self.team] = 0;
		}
	}
	else if(isdefined(self.owner))
	{
		/#
			assert(isdefined(self.ownerentnum));
		#/
		if(!isdefined(self.ownerentnum))
		{
			self.ownerentnum = self.owner getentitynumber();
		}
		level.activecounteruavs[self.ownerentnum]--;
		/#
			assert(level.activecounteruavs[self.ownerentnum] >= 0);
		#/
		if(level.activecounteruavs[self.ownerentnum] < 0)
		{
			level.activecounteruavs[self.ownerentnum] = 0;
		}
	}
	level.activeplayercounteruavs[self.ownerentnum]--;
	level notify(#"counter_uav_updated");
}

/*
	Name: watchcounteruavs
	Namespace: counteruav
	Checksum: 0x507681B6
	Offset: 0x2900
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function watchcounteruavs()
{
	while(true)
	{
		level waittill(#"counter_uav_updated");
		foreach(player in level.players)
		{
			if(player enemycounteruavactive())
			{
				player clientfield::set_to_player("counteruav", 1);
				continue;
			}
			player clientfield::set_to_player("counteruav", 0);
		}
	}
}

/*
	Name: hideallcounteruavstosameteam
	Namespace: counteruav
	Checksum: 0x42D24198
	Offset: 0x29F0
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function hideallcounteruavstosameteam()
{
	foreach(counteruav in level.counter_uav_entities)
	{
		if(isdefined(counteruav))
		{
			counteruav teams::hidetosameteam();
		}
	}
}

