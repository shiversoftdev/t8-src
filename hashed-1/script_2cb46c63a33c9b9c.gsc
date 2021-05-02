// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_20ac552ee498eb9d;
#using script_299f56e6d0b16416;
#using script_35598499769dbb3d;
#using script_35b5ff21c2a0960f;
#using script_3b034476f596d018;
#using script_3f9e0dc8454d98e1;
#using script_4d000493c57bb851;
#using script_5660bae5b402a1eb;
#using script_5b4f7a8178990872;
#using script_6ce38ab036223e6e;
#using script_7224d61ed502ea07;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_puppeteer_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\gametypes\globallogic.gsc;
#using scripts\zm_common\gametypes\globallogic_player.gsc;
#using scripts\zm_common\gametypes\globallogic_spawn.gsc;
#using scripts\zm_common\gametypes\zm_gametype.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_daily_challenges.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_ffotd.gsc;
#using scripts\zm_common\zm_game_module.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_cc96b007;

/*
	Name: zombify_player
	Namespace: namespace_cc96b007
	Checksum: 0xA6ADAAC0
	Offset: 0x2D0
	Size: 0x24C
	Parameters: 0
	Flags: Linked
*/
function zombify_player()
{
	self zm_score::player_died_penalty();
	self recordplayerdeathzombies();
	if(isdefined(level.deathcard_spawn_func))
	{
		self [[level.deathcard_spawn_func]]();
	}
	if(isdefined(level.func_clone_plant_respawn) && isdefined(self.s_clone_plant))
	{
		self [[level.func_clone_plant_respawn]]();
		return;
	}
	if(!isdefined(zombie_utility::function_d2dfacfd(#"zombify_player")) || !zombie_utility::function_d2dfacfd(#"zombify_player"))
	{
		self thread zm_player::spawnspectator();
		return;
	}
	self val::set(#"zombify_player", "ignoreme", 1);
	self.is_zombie = 1;
	self.zombification_time = gettime();
	self.team = level.zombie_team;
	self notify(#"zombified");
	if(isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
	}
	self.revivetrigger = undefined;
	self setmovespeedscale(0.3);
	self reviveplayer();
	self takeallweapons();
	self disableweaponcycling();
	self disableoffhandweapons();
	self thread zombie_utility::zombie_eye_glow();
	self thread playerzombie_player_damage();
	self thread playerzombie_soundboard();
}

/*
	Name: playerzombie_player_damage
	Namespace: namespace_cc96b007
	Checksum: 0x6CA8EE34
	Offset: 0x528
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function playerzombie_player_damage()
{
	self endon(#"death", #"disconnect");
	self thread playerzombie_infinite_health();
	self.zombiehealth = level.zombie_health;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		amount = waitresult.amount;
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			waitframe(1);
			continue;
		}
		self.zombiehealth = self.zombiehealth - amount;
		if(self.zombiehealth <= 0)
		{
			self thread playerzombie_downed_state();
			self waittill(#"playerzombie_downed_state_done");
			self.zombiehealth = level.zombie_health;
		}
	}
}

/*
	Name: playerzombie_downed_state
	Namespace: namespace_cc96b007
	Checksum: 0xE559A1C2
	Offset: 0x670
	Size: 0x196
	Parameters: 0
	Flags: Linked
*/
function playerzombie_downed_state()
{
	self endon(#"death", #"disconnect");
	downtime = 15;
	starttime = gettime();
	endtime = starttime + downtime * 1000;
	self thread playerzombie_downed_hud();
	self.playerzombie_soundboard_disable = 1;
	self thread zombie_utility::zombie_eye_glow_stop();
	self disableweapons();
	self allowstand(0);
	self allowcrouch(0);
	self allowprone(1);
	while(gettime() < endtime)
	{
		waitframe(1);
	}
	self.playerzombie_soundboard_disable = 0;
	self thread zombie_utility::zombie_eye_glow();
	self enableweapons();
	self allowstand(1);
	self allowcrouch(0);
	self allowprone(0);
	self notify(#"playerzombie_downed_state_done");
}

/*
	Name: playerzombie_downed_hud
	Namespace: namespace_cc96b007
	Checksum: 0xFCA6C126
	Offset: 0x810
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function playerzombie_downed_hud()
{
	/#
		self endon(#"death", #"disconnect");
		text = newdebughudelem(self);
		text.alignx = "";
		text.aligny = "";
		text.horzalign = "";
		text.vertalign = "";
		text.foreground = 1;
		text.font = "";
		text.fontscale = 1.8;
		text.alpha = 0;
		text.color = (1, 1, 1);
		text settext(#"hash_574da66f3a4d92dd");
		text.y = -113;
		if(self issplitscreen())
		{
			text.y = -137;
		}
		text fadeovertime(0.1);
		text.alpha = 1;
		self waittill(#"playerzombie_downed_state_done");
		text fadeovertime(0.1);
		text.alpha = 0;
	#/
}

/*
	Name: playerzombie_infinite_health
	Namespace: namespace_cc96b007
	Checksum: 0x1F6EE51E
	Offset: 0x9C8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function playerzombie_infinite_health()
{
	self endon(#"death", #"disconnect");
	bighealth = 100000;
	while(true)
	{
		if(self.health < bighealth)
		{
			self.health = bighealth;
		}
		wait(0.1);
	}
}

/*
	Name: playerzombie_soundboard
	Namespace: namespace_cc96b007
	Checksum: 0x78B5D480
	Offset: 0xA40
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function playerzombie_soundboard()
{
	self endon(#"death", #"disconnect");
	self.playerzombie_soundboard_disable = 0;
	self.buttonpressed_use = 0;
	self.buttonpressed_attack = 0;
	self.buttonpressed_ads = 0;
	self.usesound_waittime = 3000;
	self.usesound_nexttime = gettime();
	usesound = "playerzombie_usebutton_sound";
	self.attacksound_waittime = 3000;
	self.attacksound_nexttime = gettime();
	attacksound = "playerzombie_attackbutton_sound";
	self.adssound_waittime = 3000;
	self.adssound_nexttime = gettime();
	adssound = "playerzombie_adsbutton_sound";
	self.inputsound_nexttime = gettime();
	while(true)
	{
		if(self.playerzombie_soundboard_disable)
		{
			waitframe(1);
			continue;
		}
		if(self usebuttonpressed())
		{
			if(self can_do_input("use"))
			{
				self thread playerzombie_play_sound(usesound);
				self thread playerzombie_waitfor_buttonrelease("use");
				self.usesound_nexttime = gettime() + self.usesound_waittime;
			}
		}
		else if(self attackbuttonpressed())
		{
			if(self can_do_input("attack"))
			{
				self thread playerzombie_play_sound(attacksound);
				self thread playerzombie_waitfor_buttonrelease("attack");
				self.attacksound_nexttime = gettime() + self.attacksound_waittime;
			}
		}
		else if(self adsbuttonpressed())
		{
			if(self can_do_input("ads"))
			{
				self thread playerzombie_play_sound(adssound);
				self thread playerzombie_waitfor_buttonrelease("ads");
				self.adssound_nexttime = gettime() + self.adssound_waittime;
			}
		}
		waitframe(1);
	}
}

/*
	Name: can_do_input
	Namespace: namespace_cc96b007
	Checksum: 0x81FE6E2
	Offset: 0xCF0
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function can_do_input(inputtype)
{
	if(gettime() < self.inputsound_nexttime)
	{
		return 0;
	}
	cando = 0;
	switch(inputtype)
	{
		case "use":
		{
			if(gettime() >= self.usesound_nexttime && !self.buttonpressed_use)
			{
				cando = 1;
			}
			break;
		}
		case "attack":
		{
			if(gettime() >= self.attacksound_nexttime && !self.buttonpressed_attack)
			{
				cando = 1;
			}
			break;
		}
		case "ads":
		{
			if(gettime() >= self.usesound_nexttime && !self.buttonpressed_ads)
			{
				cando = 1;
			}
			break;
		}
		default:
		{
			/#
				assertmsg("" + inputtype);
			#/
			break;
		}
	}
	return cando;
}

/*
	Name: playerzombie_play_sound
	Namespace: namespace_cc96b007
	Checksum: 0x705C56F3
	Offset: 0xE20
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function playerzombie_play_sound(alias)
{
	self zm_utility::play_sound_on_ent(alias);
}

/*
	Name: playerzombie_waitfor_buttonrelease
	Namespace: namespace_cc96b007
	Checksum: 0x27A0E3DF
	Offset: 0xE50
	Size: 0x182
	Parameters: 1
	Flags: Linked
*/
function playerzombie_waitfor_buttonrelease(inputtype)
{
	if(inputtype != "use" && inputtype != "attack" && inputtype != "ads")
	{
		/#
			assertmsg("" + inputtype + "");
		#/
		return;
	}
	notifystring = "waitfor_buttonrelease_" + inputtype;
	self notify(notifystring);
	self endon(notifystring);
	if(inputtype == "use")
	{
		self.buttonpressed_use = 1;
		while(self usebuttonpressed())
		{
			waitframe(1);
		}
		self.buttonpressed_use = 0;
	}
	else if(inputtype == "attack")
	{
		self.buttonpressed_attack = 1;
		while(self attackbuttonpressed())
		{
			waitframe(1);
		}
		self.buttonpressed_attack = 0;
	}
	else if(inputtype == "ads")
	{
		self.buttonpressed_ads = 1;
		while(self adsbuttonpressed())
		{
			waitframe(1);
		}
		self.buttonpressed_ads = 0;
	}
}

