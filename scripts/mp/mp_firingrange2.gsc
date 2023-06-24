// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp\mp_firingrange2_sound.gsc;
#using script_5b1004c482bcdc6c;
#using scripts\mp\mp_firingrange2_fx.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\compass.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\load.gsc;

#namespace mp_firingrange2;

/*
	Name: main
	Namespace: mp_firingrange2
	Checksum: 0x6F50D872
	Offset: 0x770
	Size: 0x148C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	load::main();
	compass::setupminimap("");
	level.cleandepositpoints = array((495, 1345, -64.5), (-667, 1040, -51), (937.25, 91.25, -120), (1627, 1770, -48), (-123.75, 2390, -44));
	level function_89088577();
	alleytrigger = getent("alleyTrigger", "targetname");
	windowtrigger = getent("triggerwindowTarget", "targetname");
	target1 = getent("fieldTarget_BackLeft", "targetname");
	phys1 = getent("phys_fieldTarget_BackLeft", "targetname");
	phys1 linkto(target1);
	col1 = getent("col_fieldTarget_BackLeft", "targetname");
	col1 linkto(target1);
	target2 = getent("fieldTarget_FrontLeft", "targetname");
	phys2 = getent("phys_fieldTarget_FrontLeft", "targetname");
	phys2 linkto(target2);
	col2 = getent("col_fieldTarget_FrontLeft", "targetname");
	col2 linkto(target2);
	target3 = getent("fieldTarget_Middle", "targetname");
	phys3 = getent("phys_fieldTarget_Middle", "targetname");
	phys3 linkto(target3);
	col3 = getent("col_fieldTarget_Middle", "targetname");
	col3 linkto(target3);
	target4 = getent("fieldTarget_BackRight", "targetname");
	phys4 = getent("phys_fieldTarget_BackRight", "targetname");
	phys4 linkto(target4);
	col4 = getent("col_fieldTarget_BackRight", "targetname");
	col4 linkto(target4);
	target5 = getent("fieldTarget_FrontRight", "targetname");
	phys5 = getent("phys_fieldTarget_FrontRight", "targetname");
	phys5 linkto(target5);
	col5 = getent("col_fieldTarget_FrontRight", "targetname");
	col5 linkto(target5);
	target6 = getent("trenchTarget_GroundWall", "targetname");
	col6 = getent("col_trenchTarget_GroundWall", "targetname");
	col6 linkto(target6);
	target7 = getent("trailerTarget_Window", "targetname");
	phys7 = getent("phys_trailerTarget_Window", "targetname");
	phys7 linkto(target7);
	col7 = getent("col_trailerTarget_Window", "targetname");
	col7 linkto(target7);
	target8 = getent("alleyTarget_Cover", "targetname");
	phys8 = getent("phys_alleyTarget_Cover", "targetname");
	phys8 linkto(target8);
	var_37b018e6 = getent("mantle_alleyTarget_Cover", "targetname");
	var_37b018e6 linkto(target8);
	col8 = getent("col_alleyTarget_Cover", "targetname");
	col8 linkto(target8);
	target9 = getent("alleyTarget_Path", "targetname");
	phys9 = getent("phys_alleyTarget_Path", "targetname");
	phys9 linkto(target9);
	var_8f08c796 = getent("mantle_alleyTarget_Path", "targetname");
	var_8f08c796 linkto(target9);
	col9 = getent("col_alleyTarget_Path", "targetname");
	col9 linkto(target9);
	target10 = getent("centerTarget_Sandbags", "targetname");
	phys10 = getent("phys_centerTarget_Sandbags", "targetname");
	phys10 linkto(target10);
	var_14f08938 = getent("mantle_centerTarget_Sandbags", "targetname");
	var_14f08938 linkto(target10);
	col10 = getent("col_centerTarget_Sandbags", "targetname");
	col10 linkto(target10);
	target11 = getent("towerTarget_Front", "targetname");
	col11 = getent("col_towerTarget_Front", "targetname");
	col11 linkto(target11);
	target12 = getent("towerTarget_Back", "targetname");
	col12 = getent("col_towerTarget_Back", "targetname");
	col12 linkto(target12);
	target13 = getent("centerTarget_Path", "targetname");
	phys13 = getent("phys_centerTarget_Path", "targetname");
	phys13 linkto(target13);
	col13 = getent("col_centerTarget_Path", "targetname");
	col13 linkto(target13);
	target14 = getent("centerTarget_PathBunkerL", "targetname");
	target15 = getent("centerTarget_PathBunkerR", "targetname");
	target16 = getent("steelBuildingTarget_Slide1", "targetname");
	col16 = getent("col_steelBuildingTarget_Slide1", "targetname");
	col16 linkto(target16);
	target17 = getent("steelBuildingTarget_PopUp", "targetname");
	col17 = getent("col_steelBuildingTarget_PopUp", "targetname");
	col17 linkto(target17);
	target18 = getent("target_alleyWindow1", "targetname");
	phys18 = getent("phys_target_alleyWindow1", "targetname");
	phys18 linkto(target18);
	col18 = getent("col_target_alleyWindow1", "targetname");
	col18 linkto(target18);
	target19 = getent("target_alleyWindow2", "targetname");
	phys19 = getent("phys_target_alleyWindow2", "targetname");
	phys19 linkto(target19);
	col19 = getent("col_target_alleyWindow2", "targetname");
	col19 linkto(target19);
	target20 = getent("target_alleyWindow3", "targetname");
	phys20 = getent("phys_target_alleyWindow3", "targetname");
	phys20 linkto(target20);
	speaker1 = getent("loudspeaker1", "targetname");
	speaker2 = getent("loudspeaker2", "targetname");
	target16 thread damagetargetlights(speaker1, "amb_target_buzzer", "shot_target_light_1");
	target17 thread damagetargetlights(speaker2, "amb_target_buzzer", "shot_target_light_2");
	target1 setcandamage(1);
	target2 setcandamage(1);
	target3 setcandamage(1);
	target4 setcandamage(1);
	target5 setcandamage(1);
	target8 setcandamage(1);
	target9 setcandamage(1);
	target10 setcandamage(1);
	target13 setcandamage(1);
	target14 setcandamage(1);
	target15 setcandamage(1);
	target16 setcandamage(1);
	target17 setcandamage(1);
	target18 setcandamage(1);
	target19 setcandamage(1);
	target20 setcandamage(1);
	target1 thread damagetarget(1);
	target2 thread damagetarget(1);
	target3 thread damagetarget(1);
	target4 thread damagetarget(1);
	target5 thread damagetarget(1);
	target8 thread damagetarget(2);
	target9 thread damagetarget(2);
	target10 thread damagetarget(2);
	target13 thread damagetarget(2);
	target14 thread damagetarget(3);
	target15 thread damagetarget(3);
	target18 thread damagetarget(4);
	target19 thread damagetarget(4);
	target20 thread damagetarget(5);
	target1 thread movetarget(4, 220, 10.1);
	target2 thread movetarget(4, 220, 5.2);
	target3 thread movetarget(4, 220, 10.3);
	target4 thread movetarget(3, 290, 8.4);
	target5 thread movetarget(3, 285, 3);
	target6 thread movetarget(1, 228, 8.1);
	target7 thread movetarget(7, (57, 23, 0), 3);
	target8 thread movetarget(1, 250, 5.5);
	target9 thread movetarget(1, 146, 8.6);
	target10 thread movetarget(1, 165, 8.7);
	target11 thread movetarget(4, 136, 5.05);
	target12 thread movetarget(3, 136, 7.15);
	target13 thread movetarget(1, 228, 8.25);
	target16 thread movetarget(4, 164, 5.35);
	target17 thread movetarget(5, 48, 5.45);
	target18 thread movetarget(3, 270, 8.55);
	target19 thread movetarget(6, 70, 6.65);
	target20 thread movetarget(1, 130, 5.75);
	target1.dynamicent = 1;
	target2.dynamicent = 1;
	target3.dynamicent = 1;
	target4.dynamicent = 1;
	target5.dynamicent = 1;
	target6.dynamicent = 1;
	target7.dynamicent = 1;
	target8.dynamicent = 1;
	target9.dynamicent = 1;
	target9.dynamicent = 1;
	target10.dynamicent = 1;
	target11.dynamicent = 1;
	target12.dynamicent = 1;
	target13.dynamicent = 1;
	target14.dynamicent = 1;
	target15.dynamicent = 1;
	target16.dynamicent = 1;
	target17.dynamicent = 1;
	target18.dynamicent = 1;
	target19.dynamicent = 1;
	target20.dynamicent = 1;
	target11 thread rotatetarget(2, 90, 0.5, 2);
	target12 thread rotatetarget(1, 90, 0.7, 3);
	alleytrigger thread triggercheck(target9);
	windowtrigger thread triggercheck(target7);
	level spawnkilltrigger();
}

/*
	Name: spawnkilltrigger
	Namespace: mp_firingrange2
	Checksum: 0x30FCBD75
	Offset: 0x1C08
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function spawnkilltrigger()
{
	trigger = spawn("trigger_radius", (-935, 350, -11), 0, 128, 150);
	trigger thread watchkilltrigger();
}

/*
	Name: watchkilltrigger
	Namespace: mp_firingrange2
	Checksum: 0x54BB8A9
	Offset: 0x1C68
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function watchkilltrigger()
{
	level endon(#"game_ended");
	trigger = self;
	while(true)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		waitresult.activator dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
	}
}

/*
	Name: function_89088577
	Namespace: mp_firingrange2
	Checksum: 0xB1A2EFDB
	Offset: 0x1D18
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_89088577()
{
	spawncollision("collision_clip_wall_64x64x10", "collider", (-141.336, 2606, 12.6981), vectorscale((1, 0, 0), 334.398));
	spawncollision("collision_clip_wall_64x64x10", "collider", (-141.336, 2670, 12.6981), vectorscale((1, 0, 0), 334.398));
	spawncollision("collision_clip_wall_64x64x10", "collider", (-110, 2686.2, 12.7937), (334.698, 270, 2.63793E-06));
	spawncollision("collision_clip_wall_64x64x10", "collider", (-86, 2686.2, 12.7937), (334.698, 270, 2.63793E-06));
}

/*
	Name: vectoangles
	Namespace: mp_firingrange2
	Checksum: 0x39DC453F
	Offset: 0x1E38
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function vectoangles(vector)
{
	yaw = 0;
	vecx = vector[0];
	vecy = vector[1];
	if(vecx == 0 && vecy == 0)
	{
		return 0;
	}
	if(vecy < 0.001 && vecy > -0.001)
	{
		vecy = 0.001;
	}
	yaw = atan(vecx / vecy);
	if(vecy < 0)
	{
		yaw = yaw + 180;
	}
	return 90 - yaw;
}

/*
	Name: triggercheck
	Namespace: mp_firingrange2
	Checksum: 0xA70A1096
	Offset: 0x1F10
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function triggercheck(target)
{
	self endon(#"game_ended");
	while(true)
	{
		result = undefined;
		result = self waittill(#"trigger");
		distance = distance(target.origin, self.origin);
		if(distance <= 90)
		{
			target notify(#"targetstopmoving");
			while(isdefined(result.activator) && result.activator istouching(self) && distance <= 90)
			{
				if(distancesquared(target.origin, target.railpoints[0]) < distancesquared(result.activator.origin, target.railpoints[0]))
				{
					target.preferrednextpos = 0;
				}
				else
				{
					target.preferrednextpos = 1;
				}
				wait(0.25);
			}
		}
	}
}

/*
	Name: damagetarget
	Namespace: mp_firingrange2
	Checksum: 0xDE6CB690
	Offset: 0x2088
	Size: 0x40E
	Parameters: 1
	Flags: Linked
*/
function damagetarget(dir)
{
	self endon(#"game_ended");
	while(true)
	{
		self waittill(#"damage", level.attacker);
		switch(dir)
		{
			case 1:
			{
				self rotateroll(self.angles[1] + 90, 0.1);
				wait(0.2);
				self rotateroll(self.angles[1] - 90, 0.1);
				wait(0.2);
				self playsound("amb_target_flip");
				break;
			}
			case 2:
			{
				rotation = 1;
				if(isdefined(level.attacker) && isplayer(level.attacker))
				{
					yaw = get2dyaw(level.attacker.origin, self.origin);
					if(level.attacker.angles[1] > yaw)
					{
						rotation = -1;
					}
				}
				self rotateyaw(self.angles[2] + (180 * rotation), 0.3);
				self playsound("amb_target_twirl");
				self waittill(#"rotatedone");
				break;
			}
			case 3:
			{
				self rotateroll(self.angles[0] - 90, 0.1);
				wait(0.2);
				self rotateroll(self.angles[0] + 90, 0.1);
				wait(0.2);
				self playsound("amb_target_flip");
				break;
			}
			case 4:
			{
				self rotateroll(self.angles[1] - 90, 0.1);
				wait(0.2);
				self rotateroll(self.angles[1] + 90, 0.1);
				wait(0.2);
				self playsound("amb_target_flip");
				break;
			}
			case 5:
			{
				self rotateroll(self.angles[0] - 90, 0.1);
				wait(0.2);
				self rotateroll(self.angles[0] + 90, 0.1);
				wait(0.2);
				self playsound("amb_target_flip");
				break;
			}
		}
	}
}

/*
	Name: damagetargetlights
	Namespace: mp_firingrange2
	Checksum: 0x4396B204
	Offset: 0x24A0
	Size: 0xA0
	Parameters: 3
	Flags: Linked
*/
function damagetargetlights(speaker, alias, exploderhandle)
{
	self endon(#"game_ended");
	while(true)
	{
		self waittill(#"damage");
		speaker playsound(alias);
		exploder::exploder(exploderhandle);
		wait(0.5);
		exploder::stop_exploder(exploderhandle);
	}
}

/*
	Name: movetarget
	Namespace: mp_firingrange2
	Checksum: 0x9707655E
	Offset: 0x2548
	Size: 0x308
	Parameters: 3
	Flags: Linked
*/
function movetarget(dir, dis, speed)
{
	self endon(#"game_ended");
	keepmoving = 1;
	startpos = self.origin;
	farpos = self.origin;
	sound = spawn("script_origin", self.origin);
	sound linkto(self);
	sound playloopsound("amb_target_chain");
	switch(dir)
	{
		case 1:
		{
			farpos = self.origin + (0, dis, 0);
			break;
		}
		case 2:
		{
			farpos = self.origin - (0, dis, 0);
			break;
		}
		case 3:
		{
			farpos = self.origin + (dis, 0, 0);
			break;
		}
		case 4:
		{
			farpos = self.origin - (dis, 0, 0);
			break;
		}
		case 5:
		{
			farpos = self.origin + (0, 0, dis);
			break;
		}
		case 6:
		{
			farpos = self.origin - (0, 0, dis);
			break;
		}
		case 7:
		{
			farpos = self.origin - dis;
			break;
		}
	}
	self.railpoints = [];
	self.railpoints[0] = startpos;
	self.railpoints[1] = farpos;
	self.preferrednextpos = 1;
	self.playertrigger = 0;
	while(true)
	{
		nextpos = self.railpoints[self.preferrednextpos];
		if(self.preferrednextpos == 0)
		{
			self.preferrednextpos = 1;
		}
		else
		{
			self.preferrednextpos = 0;
		}
		self moveto(nextpos, speed);
		self util::waittill_either("movedone", "targetStopMoving");
		self playsound("amb_target_stop");
	}
}

/*
	Name: rotatetarget
	Namespace: mp_firingrange2
	Checksum: 0x19464759
	Offset: 0x2858
	Size: 0x50E
	Parameters: 4
	Flags: Linked
*/
function rotatetarget(dir, deg, speed, pausetime)
{
	self endon(#"game_ended");
	while(true)
	{
		switch(dir)
		{
			case 1:
			{
				self rotateyaw(self.angles[2] + deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				self rotateyaw(self.angles[2] - deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				break;
			}
			case 2:
			{
				self rotateyaw(self.angles[2] - deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				self rotateyaw(self.angles[2] + deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				break;
			}
			case 3:
			{
				self rotateroll(self.angles[0] + deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				self rotateroll(self.angles[0] - deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				break;
			}
			case 4:
			{
				self rotateroll(self.angles[0] - deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				self rotateroll(self.angles[0] + deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				break;
			}
			case 5:
			{
				self rotateroll(self.angles[1] + deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				self rotateroll(self.angles[1] - deg, speed);
				self playsound("amb_target_rotate");
				wait(pausetime);
				break;
			}
			case 6:
			{
				self rotatepitch(self.angles[1] - deg, speed);
				wait(pausetime);
				self rotatepitch(self.angles[1] + deg, speed);
				wait(pausetime);
				break;
			}
			case 7:
			{
				self rotateto((self.angles[0] + 90, self.angles[1] - 90, self.angles[2] + 45), speed);
				wait(pausetime);
				self rotateto((self.angles[0] - 90, self.angles[1] + 90, self.angles[2] - 45), speed);
				wait(pausetime);
			}
		}
	}
}

/*
	Name: get2dyaw
	Namespace: mp_firingrange2
	Checksum: 0x3C85B405
	Offset: 0x2D70
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function get2dyaw(start, end)
{
	vector = (end[0] - start[0], end[1] - start[1], 0);
	return vectoangles(vector);
}

