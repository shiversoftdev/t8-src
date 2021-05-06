// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_2dc48f46bfeac894;
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using script_6c8abe14025b47c4;
#using script_79a7e1c31a3e8cc;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\draft.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;

#namespace namespace_bba43f7d;

/*
	Name: function_89f2df9
	Namespace: namespace_bba43f7d
	Checksum: 0x1464F568
	Offset: 0x330
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_291bf0f079b2eb91", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: namespace_bba43f7d
	Checksum: 0x17320A71
	Offset: 0x380
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(game.var_6ccfdacd))
	{
		game.var_6ccfdacd = 0;
	}
	level.var_934fb97 = spawnstruct();
	level.var_934fb97.var_27fce4c0 = [];
	level.var_934fb97.var_d741a6a4 = [];
	level.var_934fb97.bundle = getscriptbundle("killstreak_supplypod");
	level.var_934fb97.weapon = getweapon("gadget_supplypod");
	level.var_934fb97.var_ff101fac = getweapon(#"hash_3b38033eca0a3bdd");
	if(!isdefined(level.killstreakbundle))
	{
		level.killstreakbundle = [];
	}
	level.killstreakbundle[#"killstreak_supplypod"] = level.var_934fb97.bundle;
	level.var_dc8edcba = &function_827486aa;
	setupcallbacks();
	setupclientfields();
	deployable::function_2e088f73(level.var_934fb97.weapon, &function_1f8cd247);
	globallogic_score::function_5a241bd8(getweapon(#"gadget_supplypod"), &function_92856c6);
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: namespace_bba43f7d
	Checksum: 0xB0C51FAB
	Offset: 0x588
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](level.var_934fb97.weapon, &function_bff5c062);
	}
}

/*
	Name: function_127fb8f3
	Namespace: namespace_bba43f7d
	Checksum: 0xC3964F87
	Offset: 0x5D0
	Size: 0xB4
	Parameters: 2
	Flags: None
*/
function function_127fb8f3(var_bba43f7d, var_dbd1a594)
{
	var_bba43f7d.gameobject gameobjects::allow_use(#"none");
	if(isdefined(level.var_86e3d17a))
	{
		var_21a8dd4c = [[level.var_86e3d17a]]();
		if((isdefined(var_21a8dd4c) ? var_21a8dd4c : 0) > 0)
		{
			var_bba43f7d notify(#"hash_602ae7ca650d6287");
			var_bba43f7d thread weaponobjects::weapon_object_timeout(var_bba43f7d.var_2d045452, var_21a8dd4c);
		}
	}
}

/*
	Name: function_bff5c062
	Namespace: namespace_bba43f7d
	Checksum: 0x3EDDD0FE
	Offset: 0x690
	Size: 0x44C
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(var_bba43f7d, var_dbd1a594)
{
	if(!isdefined(var_bba43f7d.gameobject))
	{
		return;
	}
	original_owner = var_bba43f7d.owner;
	var_bba43f7d.owner weaponobjects::hackerremoveweapon(var_bba43f7d);
	var_bba43f7d.owner function_890b2784();
	var_bba43f7d.owner = var_dbd1a594;
	var_bba43f7d setowner(var_dbd1a594);
	var_bba43f7d setteam(var_dbd1a594 getteam());
	var_bba43f7d.team = var_dbd1a594 getteam();
	var_bba43f7d.gameobject gameobjects::set_owner_team(var_dbd1a594.team);
	var_bba43f7d.gameobject gameobjects::set_visible_team(#"friendly");
	var_bba43f7d.gameobject gameobjects::allow_use(#"friendly");
	var_bba43f7d notify(#"hash_523ddcbd662010e5");
	var_bba43f7d notify(#"hacked");
	if(isdefined(var_bba43f7d.var_2d045452))
	{
		var_bba43f7d.var_2d045452 notify(#"hacked");
	}
	var_bba43f7d thread function_b44dec0b(var_dbd1a594);
	var_bba43f7d thread function_a2c40499(var_dbd1a594);
	var_bba43f7d thread watchfordamage();
	var_bba43f7d thread watchfordeath();
	var_a87deb22 = 1;
	if(!level.teambased)
	{
		var_bba43f7d.gameobject.trigger setteamfortrigger(var_bba43f7d.team);
	}
	if(isdefined(level.var_f1edf93f) && isdefined(var_bba43f7d.var_2d045452))
	{
		var_21a8dd4c = [[level.var_f1edf93f]]();
		if((isdefined(var_21a8dd4c) ? var_21a8dd4c : 0))
		{
			var_bba43f7d.var_2d045452 notify(#"hash_602ae7ca650d6287");
			if(isdefined(original_owner))
			{
				watcher = original_owner weaponobjects::getweaponobjectwatcherbyweapon(var_bba43f7d.var_2d045452.weapon);
				if(isdefined(watcher))
				{
					var_bba43f7d.var_2d045452 thread weaponobjects::weapon_object_timeout(watcher, var_21a8dd4c);
					var_a87deb22 = 0;
				}
			}
		}
	}
	if(isdefined(level.var_fc1bbaef))
	{
		[[level.var_fc1bbaef]](var_bba43f7d);
	}
	level.var_934fb97.var_5f6d033b[var_bba43f7d.objectiveid] = var_bba43f7d;
	if(!isdefined(level.var_934fb97.var_27fce4c0[var_dbd1a594.clientid]))
	{
		level.var_934fb97.var_27fce4c0[var_dbd1a594.clientid] = [];
	}
	var_a7edcaed = level.var_934fb97.var_27fce4c0.size + 1;
	array::push(level.var_934fb97.var_27fce4c0[var_dbd1a594.clientid], var_bba43f7d, var_a7edcaed);
	if(var_a87deb22)
	{
		var_bba43f7d thread function_827486aa(0);
	}
}

/*
	Name: function_29de6f1f
	Namespace: namespace_bba43f7d
	Checksum: 0xB44B423B
	Offset: 0xAE8
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_29de6f1f(weapon, meansofdeath = undefined)
{
	baseweapon = weapons::getbaseweapon(weapon);
	var_a489f56 = isdefined(baseweapon.var_b76e0a09) && baseweapon.var_b76e0a09 || (isdefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8);
	iskillstreak = isdefined(killstreaks::get_from_weapon(weapon));
	ismelee = isdefined(meansofdeath) && (meansofdeath == #"mod_melee" || meansofdeath == #"mod_melee_weapon_butt");
	var_4ea2a976 = weapon.name == "launcher_standard_t8" || weapon.name == "sig_buckler_dw";
	if(var_a489f56 || iskillstreak || var_4ea2a976 || ismelee)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_49ef5263
	Namespace: namespace_bba43f7d
	Checksum: 0x1377E18B
	Offset: 0xC48
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_49ef5263()
{
	if(isdefined(self.var_48107b1c) && self.var_48107b1c || (isdefined(self.var_17d74a5c) && self.var_17d74a5c > gettime()))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_1e64d41
	Namespace: namespace_bba43f7d
	Checksum: 0xF92B096F
	Offset: 0xC98
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_1e64d41(weapon)
{
	if(!isdefined(self) || !isplayer(self) || !self function_49ef5263() || !isdefined(weapon) || weapon.name != "launcher_standard_t8")
	{
		return;
	}
	scoreevents::processscoreevent(#"hash_21472dde8e287011", self, undefined, level.var_934fb97.weapon);
	if(isdefined(self.var_bfeea3dd) && isalive(self.var_bfeea3dd) && self != self.var_bfeea3dd)
	{
		scoreevents::processscoreevent(#"hash_131b23d720fc82c3", self.var_bfeea3dd, undefined, level.var_934fb97.weapon);
	}
	self playlocalsound(#"hash_6c2a2fee191330a0");
}

/*
	Name: function_92856c6
	Namespace: namespace_bba43f7d
	Checksum: 0xEA92015E
	Offset: 0xDE8
	Size: 0x134
	Parameters: 5
	Flags: Linked
*/
function function_92856c6(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(attacker) || !isdefined(weapon) || !isdefined(meansofdeath))
	{
		return 0;
	}
	if(!function_29de6f1f(attackerweapon, meansofdeath))
	{
		return 0;
	}
	if(attacker function_49ef5263())
	{
		if(isdefined(attacker.var_bfeea3dd) && isalive(attacker.var_bfeea3dd) && attacker != attacker.var_bfeea3dd)
		{
			scoreevents::processscoreevent(#"hash_131b23d720fc82c3", attacker.var_bfeea3dd, undefined, level.var_934fb97.weapon);
		}
		attacker playlocalsound(#"hash_6c2a2fee191330a0");
		return 1;
	}
	return 0;
}

/*
	Name: function_f579e72b
	Namespace: namespace_bba43f7d
	Checksum: 0x96525DF0
	Offset: 0xF28
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_f579e72b(watcher)
{
	watcher.watchforfire = 1;
	watcher.onspawn = &function_37a2d89d;
	watcher.timeout = float(level.var_934fb97.bundle.ksduration) / 1000;
	watcher.ontimeout = &function_7c0d095c;
	watcher.var_994b472b = &function_f7d9ebce;
	watcher.deleteonplayerspawn = 0;
}

/*
	Name: function_f7d9ebce
	Namespace: namespace_bba43f7d
	Checksum: 0x7FF9A8A7
	Offset: 0xFE8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_f7d9ebce(player)
{
	if(!isdefined(self.var_bba43f7d))
	{
		return;
	}
	self.var_bba43f7d thread function_827486aa(0);
}

/*
	Name: function_7c0d095c
	Namespace: namespace_bba43f7d
	Checksum: 0xAB9E05C9
	Offset: 0x1028
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_7c0d095c()
{
	if(!isdefined(self.var_bba43f7d))
	{
		return;
	}
	self.var_bba43f7d thread function_827486aa(0);
}

/*
	Name: function_37a2d89d
	Namespace: namespace_bba43f7d
	Checksum: 0xB292F2DA
	Offset: 0x1060
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function function_37a2d89d(watcher, owner)
{
	self endon(#"death");
	self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
	self hide();
	self.var_52a68abf = 1;
	self.var_24d0abd1 = 1;
	if(!(isdefined(self.previouslyhacked) && self.previouslyhacked))
	{
		if(isdefined(owner))
		{
			owner stats::function_e24eec31(self.weapon, #"used", 1);
			owner notify(#"hash_291bf0f079b2eb91");
		}
		self waittill_timeout(0.05, #"stationary");
		if(!owner deployable::function_f8fe102f())
		{
			owner setriotshieldfailhint();
			self delete();
			return;
		}
		self deployable::function_dd266e08(owner);
		self.var_3823265d = owner.var_3823265d;
		owner.var_3823265d = undefined;
		owner function_63c23d02(self);
		var_bba43f7d = self.var_bba43f7d;
		var_bba43f7d util::function_c596f193();
	}
}

/*
	Name: function_d7cd849c
	Namespace: namespace_bba43f7d
	Checksum: 0xB4B92AE8
	Offset: 0x1218
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function function_d7cd849c(var_cb0f3959, team)
{
	if(!isdefined(var_cb0f3959))
	{
		return;
	}
	if(!isdefined(level.var_934fb97.var_d741a6a4[var_cb0f3959]))
	{
		level.var_934fb97.var_d741a6a4[var_cb0f3959] = 0;
	}
	var_ad7969ca = level.var_934fb97.var_d741a6a4[var_cb0f3959];
	if(var_ad7969ca != 0 && gettime() < int(5 * 1000) + var_ad7969ca)
	{
		return;
	}
	level.var_934fb97.var_d741a6a4[var_cb0f3959] = gettime();
}

/*
	Name: setupclientfields
	Namespace: namespace_bba43f7d
	Checksum: 0x3D25CB73
	Offset: 0x12F0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function setupclientfields()
{
	clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.goldenBullet", 1, 1, "int");
}

/*
	Name: setupcallbacks
	Namespace: namespace_bba43f7d
	Checksum: 0x837325F8
	Offset: 0x1360
	Size: 0xAC
	Parameters: 0
	Flags: Linked, Private
*/
private function setupcallbacks()
{
	ability_player::register_gadget_activation_callbacks(35, &function_8524b3c5, &function_f4255c84);
	callback::on_player_killed_with_params(&on_player_killed);
	callback::on_spawned(&on_player_spawned);
	weaponobjects::function_e6400478(#"gadget_supplypod", &function_f579e72b, 1);
}

/*
	Name: function_577ff80b
	Namespace: namespace_bba43f7d
	Checksum: 0x93643DF3
	Offset: 0x1418
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_577ff80b()
{
	level endon(#"game_ended");
	self endon(#"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"loadout_given");
}

/*
	Name: on_player_spawned
	Namespace: namespace_bba43f7d
	Checksum: 0x9508BC3B
	Offset: 0x1478
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	player = self;
	if(level.inprematchperiod && draft::is_draft_this_round())
	{
		player thread function_577ff80b();
	}
	self function_46d74bb7(0);
	var_8d33d79 = isdefined(player.var_29fdd9dd) && player.team != player.var_29fdd9dd;
	if((isdefined(player.var_228b6835) ? player.var_228b6835 : 0) || var_8d33d79 || (isdefined(level.var_934fb97.bundle.var_18ede0bb) ? level.var_934fb97.bundle.var_18ede0bb : 0))
	{
		player.var_17d74a5c = undefined;
		player.var_57de9100 = undefined;
		player.var_29fdd9dd = undefined;
		player.var_48107b1c = undefined;
		player clientfield::set_player_uimodel("hudItems.goldenBullet", 0);
	}
	if(isdefined(player.var_17d74a5c))
	{
		if(isdefined(player.var_57de9100))
		{
			player.var_57de9100 gameobjects::hide_waypoint(player);
			player.var_57de9100.trigger setinvisibletoplayer(player);
		}
		player thread function_18f999b5(float(player.var_17d74a5c) / 1000);
		player.var_17d74a5c = player.var_17d74a5c + gettime();
		player clientfield::set_player_uimodel("hudItems.goldenBullet", 1);
	}
}

/*
	Name: function_46d74bb7
	Namespace: namespace_bba43f7d
	Checksum: 0x457FE3AA
	Offset: 0x16C0
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function function_46d74bb7(var_70150641)
{
	if((isdefined(var_70150641) ? var_70150641 : 0))
	{
		players = getplayers(self.team);
	}
	else
	{
		players = getplayers();
	}
	foreach(player in players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		/#
			assert(isdefined(player.clientid));
		#/
		if(!isdefined(player.clientid))
		{
			continue;
		}
		pods = level.var_934fb97.var_27fce4c0[player.clientid];
		if(isdefined(pods))
		{
			foreach(pod in pods)
			{
				if(!isdefined(pod))
				{
					continue;
				}
				if(isdefined(pod.gameobject))
				{
					var_321183ba = pod getteam();
					if(var_321183ba == self.team)
					{
						pod.gameobject gameobjects::show_waypoint(self);
						pod.gameobject.trigger setvisibletoplayer(self);
						continue;
					}
					pod.gameobject gameobjects::hide_waypoint(self);
					pod.gameobject.trigger setinvisibletoplayer(self);
				}
			}
		}
	}
}

/*
	Name: function_8524b3c5
	Namespace: namespace_bba43f7d
	Checksum: 0x787D25D9
	Offset: 0x1930
	Size: 0x66
	Parameters: 2
	Flags: Linked
*/
function function_8524b3c5(slot, playerweapon)
{
	/#
		assert(isplayer(self));
	#/
	self notify(#"hash_4537c6dac90cc3f2", {#weapon:playerweapon});
}

/*
	Name: function_f4255c84
	Namespace: namespace_bba43f7d
	Checksum: 0xF9D39EB1
	Offset: 0x19A0
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_f4255c84(slot, weapon)
{
}

/*
	Name: on_player_killed
	Namespace: namespace_bba43f7d
	Checksum: 0x7B4B0CFE
	Offset: 0x19C0
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function on_player_killed(s_params)
{
}

/*
	Name: getobjectiveid
	Namespace: namespace_bba43f7d
	Checksum: 0x24B2CE04
	Offset: 0x19D8
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function getobjectiveid()
{
	return gameobjects::get_next_obj_id();
}

/*
	Name: deleteobjective
	Namespace: namespace_bba43f7d
	Checksum: 0x8C0E334B
	Offset: 0x19F8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function deleteobjective(objectiveid)
{
	if(isdefined(objectiveid))
	{
		objective_delete(objectiveid);
		gameobjects::release_obj_id(objectiveid);
	}
}

/*
	Name: function_890b2784
	Namespace: namespace_bba43f7d
	Checksum: 0x3FD2323C
	Offset: 0x1A48
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function function_890b2784()
{
	var_10432750 = undefined;
	for(index = 0; index < level.var_934fb97.var_27fce4c0[self.clientid].size; index++)
	{
		if(level.var_934fb97.var_27fce4c0[self.clientid][index] == self)
		{
			var_10432750 = index;
		}
	}
	if(isdefined(var_10432750))
	{
		level.var_934fb97.var_27fce4c0[self.clientid] = array::remove_index(level.var_934fb97.var_27fce4c0[self.clientid], var_10432750, 0);
	}
}

/*
	Name: function_827486aa
	Namespace: namespace_bba43f7d
	Checksum: 0x6EB07
	Offset: 0x1B20
	Size: 0x1FE
	Parameters: 2
	Flags: Linked
*/
function function_827486aa(var_d3213f00, var_7497ba51 = 1)
{
	self notify(#"hash_523ddcbd662010e5");
	self.var_ab0875aa = 1;
	if(isdefined(self.var_83d9bfb5) && self.var_83d9bfb5)
	{
		return;
	}
	deleteobjective(self.objectiveid);
	deleteobjective(self.var_134eefb9);
	self.var_83d9bfb5 = 1;
	level.var_934fb97.var_5f6d033b[self.objectiveid] = undefined;
	self clientfield::set("enemyequip", 0);
	if(isdefined(self.gameobject))
	{
		self.gameobject thread gameobjects::destroy_object(1, 1);
	}
	self function_890b2784();
	if(isdefined(self.owner))
	{
		if(game.state == "playing")
		{
			if(isdefined(var_d3213f00) && var_d3213f00)
			{
				self.owner globallogic_score::function_5829abe3(self.var_846acfcf, self.var_d02ddb8e, level.var_934fb97.weapon);
			}
		}
	}
	if(var_7497ba51 && !var_d3213f00)
	{
		wait((isdefined(level.var_934fb97.bundle.var_fd663ee0) ? level.var_934fb97.bundle.var_fd663ee0 : 0) / 1000);
	}
	function_9d4aabb9(var_d3213f00);
}

/*
	Name: function_9d4aabb9
	Namespace: namespace_bba43f7d
	Checksum: 0x924C7CCC
	Offset: 0x1D28
	Size: 0x42C
	Parameters: 1
	Flags: Linked
*/
function function_9d4aabb9(var_d3213f00)
{
	if(!isdefined(self))
	{
		return;
	}
	player = self.owner;
	if(isdefined(level.var_d2600afc) && (isdefined(self.var_846acfcf) && isdefined(player) && self.var_846acfcf != player))
	{
		self [[level.var_d2600afc]](self.var_846acfcf, player, level.var_934fb97.weapon, self.var_d02ddb8e);
	}
	if(game.state == "playing")
	{
		if(self.health <= 0)
		{
			if(isdefined(level.var_934fb97.bundle.var_b3756378))
			{
				self playsound(level.var_934fb97.bundle.var_b3756378);
			}
		}
		if(isdefined(var_d3213f00) && var_d3213f00)
		{
			if(isdefined(player))
			{
				if(isdefined(level.var_934fb97.var_27fce4c0[player.clientid]) && level.var_934fb97.var_27fce4c0[player.clientid].size > 1)
				{
					player thread globallogic_audio::play_taacom_dialog("supplyPodWeaponDestroyedFriendlyMultiple");
				}
				else
				{
					player thread globallogic_audio::play_taacom_dialog("supplyPodWeaponDestroyedFriendly");
				}
			}
			function_d7cd849c(level.var_934fb97.bundle.var_2ee73347, self.team);
			function_d7cd849c(level.var_934fb97.bundle.var_79efc1, util::getotherteam(self.team));
		}
		else
		{
			function_d7cd849c(level.var_934fb97.bundle.var_10c9ba2d, self.team);
			function_d7cd849c(level.var_934fb97.bundle.var_f29e64de, util::getotherteam(self.team));
		}
	}
	if(isdefined(level.var_934fb97.bundle.ksexplosionfx))
	{
		playfx(level.var_934fb97.bundle.ksexplosionfx, self.origin);
		self playsound(level.var_934fb97.bundle.var_b3756378);
	}
	if(isdefined(level.var_934fb97.bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle"))
	{
		playfx(level.var_934fb97.bundle.var_bb6c29b4, self.origin);
	}
	deployable::function_81598103(self);
	if(isdefined(self.var_2d045452))
	{
		self.var_2d045452 delete();
	}
	self stoploopsound();
	self notify(#"hash_6d5130f90f39295e");
	self delete();
}

/*
	Name: function_5761966a
	Namespace: namespace_bba43f7d
	Checksum: 0x69A619FE
	Offset: 0x2160
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5761966a(var_bba43f7d)
{
	player = self;
	player endon(#"disconnect");
	level endon(#"game_ended");
	var_bba43f7d endon(#"hash_6d5130f90f39295e");
	if(!isdefined(var_bba43f7d.var_7b7607df[player.clientid]))
	{
		return;
	}
	objective_setvisibletoplayer(var_bba43f7d.var_134eefb9, player);
	while(isdefined(var_bba43f7d.var_7b7607df[player.clientid]) && var_bba43f7d.var_7b7607df[player.clientid] > gettime())
	{
		timeremaining = float(var_bba43f7d.var_7b7607df[player.clientid] - gettime()) / 1000;
		if(timeremaining > 0)
		{
			wait(timeremaining);
		}
	}
	objective_setinvisibletoplayer(var_bba43f7d.var_134eefb9, player);
	var_bba43f7d.var_7b7607df[player.clientid] = undefined;
}

/*
	Name: function_3c4843e3
	Namespace: namespace_bba43f7d
	Checksum: 0x84DBC22E
	Offset: 0x22E0
	Size: 0x4A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3c4843e3(var_bba43f7d, timetoadd)
{
	var_bba43f7d.var_7b7607df[self.clientid] = gettime() + int(timetoadd * 1000);
}

/*
	Name: function_a2c40499
	Namespace: namespace_bba43f7d
	Checksum: 0xAF80BCD6
	Offset: 0x2338
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_a2c40499(player)
{
	level endon(#"game_ended");
	self endon(#"hash_523ddcbd662010e5");
	waitresult = undefined;
	waitresult = player waittill(#"disconnect", #"joined_team", #"changed_specialist");
	if(!isdefined(self))
	{
		return;
	}
	var_b08a3652 = 0;
	self thread function_827486aa(var_b08a3652);
}

/*
	Name: watchfordeath
	Namespace: namespace_bba43f7d
	Checksum: 0x9BE517C5
	Offset: 0x23F0
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function watchfordeath()
{
	level endon(#"game_ended");
	self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
	self endon(#"hash_523ddcbd662010e5");
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(!isdefined(self))
	{
		return;
	}
	var_b08a3652 = 1;
	self.var_846acfcf = waitresult.attacker;
	self.var_d02ddb8e = waitresult.weapon;
	if(isdefined(waitresult.attacker) && isdefined(self) && isdefined(self.owner) && waitresult.attacker.team == self.owner.team)
	{
		var_b08a3652 = 0;
	}
	self thread function_827486aa(var_b08a3652);
}

/*
	Name: watchfordamage
	Namespace: namespace_bba43f7d
	Checksum: 0xEA56D978
	Offset: 0x2540
	Size: 0x2A0
	Parameters: 0
	Flags: Linked
*/
function watchfordamage()
{
	self endon(#"death");
	level endon(#"game_ended");
	self endon(#"hash_523ddcbd662010e5");
	var_bba43f7d = self;
	var_bba43f7d endon(#"death");
	var_bba43f7d.health = level.var_934fb97.bundle.kshealth;
	startinghealth = var_bba43f7d.health;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if((isdefined(level.var_934fb97.bundle.var_4f845dc4) ? level.var_934fb97.bundle.var_4f845dc4 : 0) && isdefined(waitresult.attacker) && isplayer(waitresult.attacker))
		{
			var_fd03ecd9 = var_bba43f7d.health / startinghealth;
			objective_setprogress(var_bba43f7d.var_134eefb9, var_fd03ecd9);
			var_adb78fe4 = isdefined(var_bba43f7d.var_7b7607df[waitresult.attacker.clientid]);
			waitresult.attacker function_3c4843e3(var_bba43f7d, level.var_934fb97.bundle.var_c14832cd);
			if(!var_adb78fe4)
			{
				waitresult.attacker thread function_5761966a(var_bba43f7d);
			}
		}
		if(isdefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker))
		{
			waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
		}
	}
}

/*
	Name: function_8d362deb
	Namespace: namespace_bba43f7d
	Checksum: 0x6D713FE5
	Offset: 0x27E8
	Size: 0x11A
	Parameters: 12
	Flags: Linked
*/
function function_8d362deb(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex)
{
	bundle = level.var_934fb97.bundle;
	chargelevel = 0;
	weapon_damage = killstreak_bundles::get_weapon_damage("killstreak_supplypod", bundle.kshealth, attacker, weapon, smeansofdeath, idamage, idflags, chargelevel);
	if(!isdefined(weapon_damage))
	{
		weapon_damage = killstreaks::get_old_damage(attacker, weapon, smeansofdeath, idamage, 1);
	}
	return int(weapon_damage);
}

/*
	Name: function_438ca4e0
	Namespace: namespace_bba43f7d
	Checksum: 0x8EF7B3B2
	Offset: 0x2910
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_438ca4e0()
{
	var_bba43f7d = self;
	var_bba43f7d endon(#"hash_6d5130f90f39295e", #"death");
	level waittill(#"game_ended");
	if(!isdefined(self))
	{
		return;
	}
	self thread function_827486aa(0, 0);
	var_bba43f7d.var_648955e6 = 1;
}

/*
	Name: function_fec0924
	Namespace: namespace_bba43f7d
	Checksum: 0x534F1F4A
	Offset: 0x29A0
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_fec0924()
{
	var_d5110c6d = game.var_6ccfdacd;
	game.var_6ccfdacd = game.var_6ccfdacd + 1;
	return var_d5110c6d;
}

/*
	Name: function_9abdee8c
	Namespace: namespace_bba43f7d
	Checksum: 0xCC259EDB
	Offset: 0x29E0
	Size: 0xA8C
	Parameters: 1
	Flags: Linked
*/
function function_9abdee8c(object)
{
	player = self;
	if(isdefined(level.var_934fb97.var_27fce4c0[player.clientid]) && level.var_934fb97.var_27fce4c0[player.clientid].size >= (isdefined(level.var_934fb97.bundle.var_cbe1e532) ? level.var_934fb97.bundle.var_cbe1e532 : 1))
	{
		obj = level.var_934fb97.var_27fce4c0[player.clientid][0];
		if(isdefined(obj))
		{
			obj thread function_827486aa(0);
		}
		else
		{
			level.var_934fb97.var_27fce4c0[self.clientid] = undefined;
		}
	}
	slot = player gadgetgetslot(level.var_934fb97.weapon);
	player gadgetpowerreset(slot);
	player gadgetpowerset(slot, 0);
	var_bba43f7d = spawn("script_model", object.origin);
	var_bba43f7d setmodel(level.var_934fb97.weapon.var_22082a57);
	object.var_bba43f7d = var_bba43f7d;
	var_bba43f7d.var_2d045452 = object;
	var_bba43f7d function_41b29ff0("wpn_t8_eqp_supply_pod_destructible");
	var_bba43f7d useanimtree("generic");
	var_bba43f7d.owner = player;
	var_bba43f7d.clientid = var_bba43f7d.owner.clientid;
	var_bba43f7d.angles = player.angles;
	var_bba43f7d clientfield::set("supplypod_placed", 1);
	var_bba43f7d setteam(player getteam());
	var_bba43f7d.var_86a21346 = &function_8d362deb;
	var_bba43f7d solid();
	var_bba43f7d show();
	var_bba43f7d.victimsoundmod = "vehicle";
	var_bba43f7d.weapon = level.var_934fb97.weapon;
	var_bba43f7d setweapon(var_bba43f7d.weapon);
	var_bba43f7d.var_57022ab8 = (isdefined(level.var_934fb97.bundle.var_5a0d87e0) ? level.var_934fb97.bundle.var_5a0d87e0 : 20);
	var_bba43f7d.usecount = 0;
	var_bba43f7d.objectiveid = getobjectiveid();
	level.var_934fb97.var_5f6d033b[var_bba43f7d.objectiveid] = var_bba43f7d;
	if(!isdefined(level.var_934fb97.var_27fce4c0[player.clientid]))
	{
		level.var_934fb97.var_27fce4c0[player.clientid] = [];
	}
	var_a7edcaed = level.var_934fb97.var_27fce4c0.size + 1;
	array::push(level.var_934fb97.var_27fce4c0[player.clientid], var_bba43f7d, var_a7edcaed);
	var_bba43f7d setcandamage(1);
	var_bba43f7d clientfield::set("enemyequip", 1);
	var_bba43f7d.var_99d2556b = gettime();
	var_bba43f7d.uniqueid = function_fec0924();
	function_d7cd849c(level.var_934fb97.bundle.var_69b1ff7, player getteam());
	function_d7cd849c(level.var_934fb97.bundle.var_4f37dfe9, util::getotherteam(player getteam()));
	if(isdefined(level.var_934fb97.bundle.var_a0db3d4d))
	{
		var_bba43f7d playloopsound(level.var_934fb97.bundle.var_a0db3d4d);
	}
	if((isdefined(level.var_934fb97.bundle.var_4f845dc4) ? level.var_934fb97.bundle.var_4f845dc4 : 0))
	{
		var_bba43f7d.var_134eefb9 = getobjectiveid();
		var_bba43f7d.var_7b7607df = [];
		objective_add(var_bba43f7d.var_134eefb9, "active", var_bba43f7d.origin, level.var_934fb97.bundle.var_ce75f65c);
		objective_setprogress(var_bba43f7d.var_134eefb9, 1);
		function_da7940a3(var_bba43f7d.var_134eefb9, 1);
		objective_setinvisibletoall(var_bba43f7d.var_134eefb9);
	}
	triggerradius = level.var_934fb97.bundle.var_366f43e9;
	triggerheight = level.var_934fb97.bundle.var_2f1567fb;
	var_b1a6d849 = level.var_934fb97.bundle.var_2d890f85;
	upangle = vectorscale(vectornormalize(anglestoup(var_bba43f7d.angles)), 5);
	var_40989bda = var_bba43f7d.origin + upangle;
	usetrigger = spawn("trigger_radius_use", var_40989bda, 0, triggerradius, triggerheight);
	usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
	usetrigger function_49462027(1, 1 | 4096 | 2 | 8388608 | 2048);
	var_bba43f7d.gameobject = gameobjects::create_use_object(player getteam(), usetrigger, [], undefined, level.var_934fb97.bundle.var_9333131b, 1, 1);
	var_bba43f7d.gameobject gameobjects::set_visible_team(#"friendly");
	var_bba43f7d.gameobject gameobjects::allow_use(#"friendly");
	var_bba43f7d.gameobject gameobjects::set_use_time(var_b1a6d849);
	var_bba43f7d.gameobject.onbeginuse = &function_8c8fb7b5;
	var_bba43f7d.gameobject.onenduse = &function_a1434496;
	var_bba43f7d.gameobject.var_5ecd70 = var_bba43f7d;
	var_bba43f7d.gameobject.var_33d50507 = 1;
	var_bba43f7d.gameobject.dontlinkplayertotrigger = 1;
	var_bba43f7d.gameobject.keepweapon = 1;
	var_bba43f7d.gameobject.requireslos = 1;
	var_bba43f7d.gameobject.var_d647eb08 = 1;
	player deployable::function_6ec9ee30(var_bba43f7d, level.var_934fb97.weapon);
	var_bba43f7d.gameobject function_1446053f(player);
	var_bba43f7d thread function_b44dec0b(player);
	var_bba43f7d thread function_438ca4e0();
	var_bba43f7d thread watchfordamage();
	var_bba43f7d thread watchfordeath();
	var_bba43f7d thread function_a2c40499(player);
}

/*
	Name: function_1446053f
	Namespace: namespace_bba43f7d
	Checksum: 0x4399EFD
	Offset: 0x3478
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_1446053f(player)
{
	self endon(#"death");
	player endon(#"death");
	wait(0.2);
	if(isdefined(self) && isdefined(player))
	{
		self function_a1434496(undefined, player, 1);
	}
}

/*
	Name: function_8c8fb7b5
	Namespace: namespace_bba43f7d
	Checksum: 0xB2CC47D2
	Offset: 0x34F0
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8c8fb7b5(player)
{
}

/*
	Name: function_a143899c
	Namespace: namespace_bba43f7d
	Checksum: 0xAB89A67
	Offset: 0x3508
	Size: 0x14
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a143899c(player, waittime)
{
}

/*
	Name: function_a1434496
	Namespace: namespace_bba43f7d
	Checksum: 0x6E6C736F
	Offset: 0x3528
	Size: 0x4B4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_a1434496(team, player, result)
{
	var_bba43f7d = self.var_5ecd70;
	if(!isdefined(var_bba43f7d))
	{
		return;
	}
	var_bba43f7d.isdisabled = 0;
	if(isdefined(result) && result)
	{
		var_bba43f7d.usecount++;
		if(isdefined(player) && isplayer(player))
		{
			if(var_bba43f7d.owner != player)
			{
				scoreevents::processscoreevent(#"hash_69dbfbd660f8c53e", var_bba43f7d.owner, undefined, level.var_934fb97.weapon);
				relativepos = vectornormalize(player.origin - var_bba43f7d.owner.origin);
				dir = anglestoforward(var_bba43f7d.owner getplayerangles());
				dotproduct = vectordot(dir, relativepos);
				if(isdefined(level.playgadgetsuccess) && var_bba43f7d.usecount >= 1 && !isdefined(self.var_25db02aa) && dotproduct > 0 && sighttracepassed(var_bba43f7d.owner geteye(), self.origin, 1, var_bba43f7d.owner, self))
				{
					self.var_25db02aa = 1;
					var_bba43f7d.owner [[level.playgadgetsuccess]](level.var_934fb97.weapon, undefined, undefined, player);
				}
			}
			var_bba43f7d.owner battlechatter::function_bd715920(level.var_934fb97.weapon, undefined, self.origin, self);
		}
		thread function_a143899c(player, 1.5);
		player thread gestures::function_f3e2696f(var_bba43f7d, level.var_934fb97.var_ff101fac, undefined, 0.5, &function_e8df0c85, undefined, undefined);
		player function_bcf0dd99();
		self gameobjects::hide_waypoint(player);
		self.trigger setinvisibletoplayer(player);
		player.var_57de9100 = self;
		player.var_29fdd9dd = self.team;
		player.var_bfeea3dd = var_bba43f7d.owner;
		player notify(#"hash_69dbfbd660f8c53e");
		if(!(isdefined(level.var_934fb97.bundle.var_18ede0bb) ? level.var_934fb97.bundle.var_18ede0bb : 0))
		{
			duration = (isdefined(level.var_934fb97.bundle.var_84471829) ? level.var_934fb97.bundle.var_84471829 : 30);
			player.var_17d74a5c = gettime() + int(duration * 1000);
			player thread function_18f999b5(duration);
		}
		else
		{
			player.var_48107b1c = 1;
		}
		if(var_bba43f7d.usecount == var_bba43f7d.var_57022ab8)
		{
			var_bba43f7d thread function_827486aa(0);
		}
	}
	else
	{
		thread function_a143899c(player, 0);
	}
}

/*
	Name: function_e8df0c85
	Namespace: namespace_bba43f7d
	Checksum: 0xF7142102
	Offset: 0x39E8
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_e8df0c85(var_bba43f7d)
{
	if(isdefined(var_bba43f7d))
	{
		playfxontag("weapon/fx8_equip_supplypod_canister_launch", var_bba43f7d, "tag_canister_smoke");
		var_715428d3 = "j_wrist_le";
		weapon = self getcurrentweapon();
		var_53050505 = weapon.var_6566504b;
		if(var_53050505 >= 5 && var_53050505 <= 9)
		{
			var_715428d3 = "j_wrist_ri";
		}
		beamlaunch(var_bba43f7d, self, "tag_origin_animate", var_715428d3, level.var_934fb97.weapon);
		playsoundatposition(#"hash_f70797817dfefdb", var_bba43f7d.origin);
	}
}

/*
	Name: function_18f999b5
	Namespace: namespace_bba43f7d
	Checksum: 0x7D3F5B58
	Offset: 0x3B00
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_18f999b5(waittime)
{
	self notify(#"hash_10cd6a20d4e45365");
	self endon(#"hash_10cd6a20d4e45365", #"disconnect");
	result = undefined;
	result = self waittill_timeout(waittime, #"death");
	if(result._notify == #"timeout")
	{
		self function_46d74bb7(1);
	}
	else
	{
		if((isdefined(level.var_934fb97.bundle.var_98da26d) ? level.var_934fb97.bundle.var_98da26d : 0))
		{
			self.var_17d74a5c = self.var_17d74a5c - gettime();
		}
		else
		{
			self.var_17d74a5c = undefined;
			self.var_bfeea3dd = undefined;
		}
	}
	self clientfield::set_player_uimodel("hudItems.goldenBullet", 0);
}

/*
	Name: function_1f8cd247
	Namespace: namespace_bba43f7d
	Checksum: 0x8267348A
	Offset: 0x3C40
	Size: 0x21C
	Parameters: 3
	Flags: Linked
*/
function function_1f8cd247(origin, angles, player)
{
	if(!isdefined(player.var_3823265d))
	{
		player.var_3823265d = spawnstruct();
	}
	var_1898acdc = (isdefined(level.var_934fb97.bundle.var_bdc8276) ? level.var_934fb97.bundle.var_bdc8276 : 0);
	testdistance = var_1898acdc * var_1898acdc;
	ids = getarraykeys(level.var_934fb97.var_27fce4c0);
	foreach(id in ids)
	{
		if(id == player.clientid)
		{
			continue;
		}
		pods = level.var_934fb97.var_27fce4c0[id];
		foreach(pod in pods)
		{
			if(!isdefined(pod))
			{
				continue;
			}
			distsqr = distancesquared(origin, pod.origin);
			if(distsqr <= testdistance)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_63c23d02
	Namespace: namespace_bba43f7d
	Checksum: 0xB989B3BB
	Offset: 0x3E68
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function function_63c23d02(var_bba43f7d)
{
	var_bba43f7d setvisibletoall();
	if(isdefined(var_bba43f7d.othermodel))
	{
		var_bba43f7d.othermodel setinvisibletoall();
	}
	if(isdefined(var_bba43f7d.var_3823265d))
	{
		self function_9abdee8c(var_bba43f7d);
		playsoundatposition(#"hash_66e85d590b4f4b8", var_bba43f7d.origin);
	}
	if(isdefined(level.var_84bf013e))
	{
		self notify(#"supplypod_placed", {#pod:var_bba43f7d});
	}
}

/*
	Name: oncancelplacement
	Namespace: namespace_bba43f7d
	Checksum: 0xA8B615F0
	Offset: 0x3F48
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function oncancelplacement(var_bba43f7d)
{
	slot = self gadgetgetslot(level.var_934fb97.weapon);
	self gadgetdeactivate(slot, level.var_934fb97.weapon, 0);
	self gadgetpowerset(slot, 100);
}

/*
	Name: onshutdown
	Namespace: namespace_bba43f7d
	Checksum: 0x58E87358
	Offset: 0x3FE0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function onshutdown(var_bba43f7d)
{
	if((isdefined(var_bba43f7d.var_ab0875aa) ? var_bba43f7d.var_ab0875aa : 0))
	{
		return;
	}
	var_bba43f7d thread function_827486aa(0);
}

/*
	Name: function_b44dec0b
	Namespace: namespace_bba43f7d
	Checksum: 0xE7B01312
	Offset: 0x4038
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_b44dec0b(player)
{
	var_bba43f7d = self;
	player endon(#"disconnect");
	var_bba43f7d endon(#"death", #"hacked");
	player waittill(#"joined_team", #"changed_specialist");
	var_bba43f7d thread function_827486aa(0);
}

/*
	Name: function_452147b1
	Namespace: namespace_bba43f7d
	Checksum: 0xB16246AF
	Offset: 0x40E0
	Size: 0xB6
	Parameters: 2
	Flags: Linked
*/
function function_452147b1(weapon, weaponindex)
{
	player = self;
	level endon(#"game_ended");
	player notify("on_death_ammon_backup" + weaponindex);
	player endon("on_death_ammon_backup" + weaponindex, #"disconnect");
	player waittill(#"death");
	player.pers["pod_ammo" + weaponindex] = player getweaponammostock(weapon);
}

/*
	Name: function_5bc9564e
	Namespace: namespace_bba43f7d
	Checksum: 0x72EDFBE0
	Offset: 0x41A0
	Size: 0x1B6
	Parameters: 1
	Flags: Linked
*/
function function_5bc9564e(weapon)
{
	player = self;
	level endon(#"game_ended");
	player notify(#"hash_620e9c8ce0a79cf7");
	player endon(#"hash_620e9c8ce0a79cf7", #"disconnect");
	while(isdefined(player.pod_ammo) && player.pod_ammo.size > 0)
	{
		weapon = player getcurrentweapon();
		var_2f9ea2b9 = weapons::getbaseweapon(weapon);
		baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
		if(isdefined(player.pod_ammo[baseweaponindex]) && player.pod_ammo[baseweaponindex])
		{
			var_831b3584 = player getweaponammostock(weapon);
			if(var_831b3584 == 0)
			{
				player setweaponammostock(weapon, int(player.pod_ammo[baseweaponindex]));
				player.pod_ammo[baseweaponindex] = undefined;
				player thread function_452147b1(weapon, baseweaponindex);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_740ec27e
	Namespace: namespace_bba43f7d
	Checksum: 0xFF8C36D3
	Offset: 0x4360
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function function_740ec27e()
{
	player = self;
	primary_weapons = player getweaponslistprimaries();
	foreach(weapon in primary_weapons)
	{
		var_2f9ea2b9 = weapons::getbaseweapon(weapon);
		baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
		player.pod_ammo[baseweaponindex] = (isdefined(level.var_934fb97.bundle.var_8e002961) ? level.var_934fb97.bundle.var_8e002961 : 0) * weapon.clipsize;
	}
	player thread function_5bc9564e();
}

/*
	Name: function_bcf0dd99
	Namespace: namespace_bba43f7d
	Checksum: 0x505631C4
	Offset: 0x44A8
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_bcf0dd99()
{
	player = self;
	primary_weapons = player getweaponslistprimaries();
	foreach(weapon in primary_weapons)
	{
		var_831b3584 = player getweaponammostock(weapon);
		var_6e175b4f = (isdefined(level.var_934fb97.bundle.var_8e002961) ? level.var_934fb97.bundle.var_8e002961 : 0) * weapon.clipsize;
		player setweaponammostock(weapon, int(var_831b3584 + var_6e175b4f));
	}
	player clientfield::set_player_uimodel("hudItems.goldenBullet", 1);
}

/*
	Name: function_b8a25634
	Namespace: namespace_bba43f7d
	Checksum: 0x1EC5325E
	Offset: 0x4618
	Size: 0x1A6
	Parameters: 1
	Flags: None
*/
function function_b8a25634(owner)
{
	player = self;
	var_ab282d2a[0] = level.var_934fb97.bundle.var_b9443d6b;
	var_ab282d2a[1] = level.var_934fb97.bundle.var_ea340924;
	var_ab282d2a[2] = level.var_934fb97.bundle.var_ff3d4d40;
	for(slot = 0; slot < 3; slot++)
	{
		if(!isdefined(var_ab282d2a[slot]))
		{
			continue;
		}
		if(!isdefined(player._gadgets_player[slot]))
		{
			continue;
		}
		cooldown = var_ab282d2a[slot] * (isdefined(player._gadgets_player[slot].var_e4d4fa7e) ? player._gadgets_player[slot].var_e4d4fa7e : 0);
		if(isdefined(owner) && owner)
		{
			cooldown = cooldown * (isdefined(level.var_934fb97.bundle.var_44a195ff) ? level.var_934fb97.bundle.var_44a195ff : 0);
		}
		player gadgetpowerchange(slot, cooldown);
	}
}

/*
	Name: function_de737a35
	Namespace: namespace_bba43f7d
	Checksum: 0x2C5FC8B6
	Offset: 0x47C8
	Size: 0x20C
	Parameters: 0
	Flags: None
*/
function function_de737a35()
{
	player = self;
	weapon = player getcurrentweapon();
	while(weapon == level.weaponnone)
	{
		waitframe(1);
		weapon = player getcurrentweapon();
	}
	slot = player gadgetgetslot(weapon);
	if(slot == 2 || weapon == getweapon(#"sig_buckler_turret"))
	{
		if(isdefined(weapon.var_7a93ed37))
		{
			player gadgetpowerchange(slot, weapon.var_7a93ed37);
		}
		if(isdefined(weapon.var_60563796))
		{
			if(weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw"))
			{
				stockammo = player getweaponammoclip(weapon);
				player setweaponammoclip(weapon, stockammo + int(weapon.var_60563796));
			}
			else
			{
				stockammo = player getweaponammostock(weapon);
				player setweaponammostock(weapon, stockammo + int(weapon.var_60563796));
			}
		}
	}
}

