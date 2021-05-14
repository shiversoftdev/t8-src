// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_229f24b1662651c4;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\_prop_controls.gsc;
#using scripts\mp_common\gametypes\dogtags.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\prop.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;
#using scripts\mp_common\gametypes\spawnlogic.gsc;
#using scripts\mp_common\util.gsc;

#namespace namespace_829e1a63;

/*
	Name: function_e46dab5e
	Namespace: namespace_829e1a63
	Checksum: 0x35850B2
	Offset: 0x100
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function function_e46dab5e(path, var_c669188)
{
	/#
		var_2f3fa528 = "" + path + "";
		var_f71fadd = "" + var_c669188 + "";
		var_9dcc2004 = "" + var_2f3fa528 + "" + var_f71fadd;
		adddebugcommand(var_9dcc2004);
	#/
}

/*
	Name: function_93440c52
	Namespace: namespace_829e1a63
	Checksum: 0x578AB1C
	Offset: 0x1A0
	Size: 0x1866
	Parameters: 0
	Flags: None
*/
function function_93440c52()
{
	/#
		var_6631295a = 0;
		var_e68b7091 = 0;
		var_28c934a0 = 0;
		var_27e85424 = 0;
		var_e535ed97 = 0;
		var_f4098dd1 = 0;
		var_94dbbfd9 = 0;
		var_b948ae6c = 0;
		minigame_on = getdvarint(#"scr_prop_minigame", 1);
		var_95ae3da3 = getdvarint(#"hash_38ca626afad6fe7d", 1);
		var_f6fe53f9 = getdvarfloat(#"player_swimdamage", 10);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 1);
		util::set_dvar_int_if_unset("", 1);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		util::set_dvar_int_if_unset("", 0);
		setdvar(#"hash_4424a07b5272599a", 0);
		setdvar(#"hash_34a3e2c00f7cd27f", 0);
		setdvar(#"hash_3fd977c7de8de72b", 0);
		setdvar(#"hash_5fea18fb5a6e0027", 0);
		setdvar(#"hash_69637702c083dc28", 0);
		setdvar(#"hash_2a03924a528ff9a8", 0);
		setdvar(#"hash_740b6f4a4aa58f21", 0);
		setdvar(#"hash_7115842bdfa67a2b", 0);
		if(getdvarint(#"hash_70c6c4a3e9254926", 0) != 0)
		{
			adddebugcommand("");
		}
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "" + 4 + "");
		function_e46dab5e("", "" + 0.25 + "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		function_e46dab5e("", "");
		while(true)
		{
			if(isdefined(level.prematch_over) && level.prematch_over)
			{
				level.allow_teamchange = getdvarint(#"hash_7f436a7b31a003f3", 0);
				level.var_a7997034 = getdvarint(#"hash_4819c54cbad5ed87", 0) != 0;
			}
			if(getdvarint(#"hash_38ca626afad6fe7d", 0) != var_95ae3da3 && isdefined(level.players))
			{
				var_95ae3da3 = getdvarint(#"hash_38ca626afad6fe7d", 0);
				if(!isdefined(level.players[0].changepropkey))
				{
					iprintlnbold("");
				}
				else
				{
					foreach(player in level.players)
					{
						if(isdefined(player.team) && player util::isprop())
						{
							player namespace_314165c4::propabilitykeysvisible(var_95ae3da3, 1);
						}
					}
					level.elim_hud.alpha = var_95ae3da3;
				}
			}
			if(getdvarint(#"hash_2c678eea20875ddd", 0) != var_28c934a0 && isdefined(level.players))
			{
				foreach(player in level.players)
				{
					if(player util::isprop())
					{
						var_28c934a0 = getdvarint(#"hash_2c678eea20875ddd", 0);
						player.var_f18a4260 = !(isdefined(player.var_f18a4260) && player.var_f18a4260);
						player iprintlnbold((player.var_f18a4260 ? "" : ""));
					}
				}
			}
			if(getdvarint(#"hash_4aab269ba89e7cb6", 0) != var_27e85424 && isdefined(level.players))
			{
				foreach(player in level.players)
				{
					if(player util::isprop())
					{
						var_27e85424 = getdvarint(#"hash_4aab269ba89e7cb6", 0);
						player.var_7ddbf78d = !(isdefined(player.var_7ddbf78d) && player.var_7ddbf78d);
						player iprintlnbold((player.var_7ddbf78d ? "" : ""));
					}
				}
			}
			if(getdvarint(#"hash_53ee83feb4db4606", 0) != var_e535ed97 && isdefined(level.players))
			{
				foreach(player in level.players)
				{
					if(player util::isprop())
					{
						var_e535ed97 = getdvarint(#"hash_53ee83feb4db4606", 0);
						player.var_d0e95c44 = !(isdefined(player.var_d0e95c44) && player.var_d0e95c44);
						player iprintlnbold((player.var_d0e95c44 ? "" : ""));
					}
				}
			}
			if(getdvarint(#"hash_62162f1f94cbba77", 0) != var_f4098dd1)
			{
				var_f4098dd1 = getdvarint(#"hash_62162f1f94cbba77", 0);
				if(var_f4098dd1)
				{
					setdvar(#"hash_7ebe9ee37349aae2", 1);
					setdvar(#"hash_263969a4f5f48bd1", 1);
					setdvar(#"hash_21c715cded2e84e9", 10000);
				}
				else
				{
					setdvar(#"hash_7ebe9ee37349aae2", 1600);
					setdvar(#"hash_263969a4f5f48bd1", 1000);
					setdvar(#"hash_21c715cded2e84e9", 400);
					iprintlnbold((var_f4098dd1 ? "" : ""));
				}
			}
			if(getdvarint(#"hash_618be616410fad95", 0) != var_94dbbfd9 && isdefined(level.players))
			{
				foreach(player in level.players)
				{
					if(player prop::function_84793f03())
					{
						var_94dbbfd9 = getdvarint(#"hash_618be616410fad95", 0);
						player.var_8df5658d = !(isdefined(player.var_8df5658d) && player.var_8df5658d);
						player iprintlnbold((player.var_8df5658d ? "" : ""));
					}
				}
			}
			var_6271c461 = getdvarint(#"hash_21d7ba8da36d4023", 0);
			if(var_6271c461 != var_6631295a)
			{
				var_6631295a = var_6271c461;
				function_ad983215(!var_6271c461);
			}
			var_90cd8304 = getdvarint(#"hash_34a3e2c00f7cd27f", 0);
			if(var_90cd8304 != var_e68b7091)
			{
				var_e68b7091 = var_90cd8304;
				result = function_fd3c3ed0(var_90cd8304);
				if(!result)
				{
					var_e68b7091 = !var_90cd8304;
				}
				if(var_e68b7091)
				{
					level.drown_damage = 0;
				}
				else
				{
					level.drown_damage = var_f6fe53f9;
				}
			}
			if(getdvarint(#"hash_3fd977c7de8de72b", 0) != 0)
			{
				function_cb8ecc99();
				setdvar(#"hash_3fd977c7de8de72b", 0);
			}
			if(getdvarint(#"hash_5fea18fb5a6e0027", 0) != 0)
			{
				function_2b23b2b6();
				setdvar(#"hash_5fea18fb5a6e0027", 0);
			}
			if(getdvarint(#"hash_69637702c083dc28", 0) != 0)
			{
				function_f2e19297();
				setdvar(#"hash_69637702c083dc28", 0);
			}
			if(getdvarint(#"hash_7115842bdfa67a2b", 0) != 0)
			{
				if(isdefined(level.players) && isdefined(level.players[0]))
				{
					level thread prop::function_c4aeb146(#"score_last_alive", level.players[0]);
				}
				setdvar(#"hash_7115842bdfa67a2b", 0);
			}
			if(getdvarint(#"hash_34e9a7fac83d28a6", 0) != 0)
			{
				function_ad8cc361();
			}
			if(getdvarint(#"hash_7b2608d6176b79f4", 0))
			{
				function_38964c72();
			}
			if(getdvarint(#"hash_4424a07b5272599a", 0) != 0)
			{
				function_89b4b4c();
				setdvar(#"hash_4424a07b5272599a", 0);
			}
			if(getdvarint(#"hash_84008139ad85e21", 0) != 0)
			{
				if(isdefined(level.players) && isdefined(level.players[0]))
				{
					level.players[0] namespace_314165c4::canlock();
				}
			}
			if(getdvarint(#"hash_2fa05819a4eeb99b", 0) != 0 || getdvarint(#"hash_84008139ad85e21", 0) != 0)
			{
				function_1f3923fa();
			}
			if(getdvarint(#"hash_2a03924a528ff9a8", 0) != 0)
			{
				function_5e0d41c4();
				setdvar(#"hash_2a03924a528ff9a8", 0);
			}
			if(getdvarint(#"hash_740b6f4a4aa58f21", 0) != 0)
			{
				function_5646cd5c();
				setdvar(#"hash_740b6f4a4aa58f21", 0);
			}
			if(getdvarint(#"hash_2441330d88677536", 0) != 0 && isdefined(level.players))
			{
				level notify(#"hash_72a9d8619c126022");
				setdvar(#"hash_2441330d88677536", 0);
			}
			if(getdvarint(#"hash_7da18bcec6fafe7f", 0) != 0)
			{
				function_34a7562e();
			}
			if(getdvarint(#"hash_745b5ef88dd291e1", 0) != 0)
			{
				function_f06fb157();
			}
			if(getdvarint(#"hash_3c0e90252ca92099", 0) != 0)
			{
				function_b7c018a7();
			}
			if(getdvarint(#"scr_prop_minigame", 1) != minigame_on && isdefined(level.players) && level.players.size > 0)
			{
				minigame_on = getdvarint(#"scr_prop_minigame", 1);
				iprintlnbold((minigame_on ? "" : ""));
			}
			if(getdvarint(#"hash_6132db0becb8f98", 0) != var_b948ae6c && isdefined(level.players) && level.players.size > 0)
			{
				var_b948ae6c = getdvarint(#"hash_6132db0becb8f98", 0);
				if(var_b948ae6c == 2)
				{
					iprintlnbold("");
				}
				else if(var_b948ae6c == 1)
				{
					iprintlnbold("");
				}
				else
				{
					iprintlnbold("");
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_ad983215
	Namespace: namespace_829e1a63
	Checksum: 0xCFC46A28
	Offset: 0x1A10
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function function_ad983215(enabled)
{
	/#
		setdvar(#"com_statmon", enabled);
		setdvar(#"hash_37468b91055d5271", enabled);
		setdvar(#"cg_drawfps", enabled);
		setdvar(#"hash_61537eefc769c7b3", enabled);
		setdvar(#"hash_59587b459995b6eb", enabled);
		setdvar(#"hash_173fd7265ae0b7b1", enabled);
		setdvar(#"hash_2d3acd259cd6aca6", enabled);
	#/
}

/*
	Name: function_fd3c3ed0
	Namespace: namespace_829e1a63
	Checksum: 0x33D3BE64
	Offset: 0x1B10
	Size: 0xE0
	Parameters: 1
	Flags: None
*/
function function_fd3c3ed0(enabled)
{
	/#
		if(!isdefined(level.players) || level.players.size == 0)
		{
			return 0;
		}
		player = level.players[0];
		if(!isdefined(player) || !isalive(player) || isdefined(player.placementoffset) || !isdefined(player.prop))
		{
			return 0;
		}
		if(enabled)
		{
			player function_673195f3();
		}
		else
		{
			player function_401f47cd();
		}
		return 1;
	#/
}

/*
	Name: function_9cd2eb63
	Namespace: namespace_829e1a63
	Checksum: 0x91301F3F
	Offset: 0x1C00
	Size: 0x86
	Parameters: 5
	Flags: None
*/
function function_9cd2eb63(color, label, value, text, var_e1fb743e)
{
	/#
		hudelem = namespace_314165c4::addupperrighthudelem(label, value, text, var_e1fb743e);
		hudelem.alpha = 0.5;
		hudelem.color = color;
		return hudelem;
	#/
}

/*
	Name: function_673195f3
	Namespace: namespace_829e1a63
	Checksum: 0x8B3BDB4
	Offset: 0x1C90
	Size: 0x1C4
	Parameters: 0
	Flags: None
*/
function function_673195f3()
{
	/#
		self namespace_314165c4::cleanuppropcontrolshud();
		self namespace_314165c4::function_1e25f968();
		if(self issplitscreen())
		{
			self.currenthudy = -10;
		}
		else
		{
			self.currenthudy = -80;
		}
		self.var_5f51d2ee = function_1eca597a(self.prop.info.modelname);
		white = (1, 1, 1);
		red = (1, 0, 0);
		green = (0, 1, 0);
		blue = (0, 0.5, 1);
		self.var_28df7051 = array(self.placementmodel, self.var_3634d14e, self.var_a2614669, self.var_5ee5df03, self.var_66df6677, self.var_ec9a93, self.var_811d1afa, self.var_d7336ed8, self.var_334e2710, self.var_faa235b5, self.var_35eb52f1, self.var_a2f59097);
		self.placementindex = 0;
		self function_8d3ffd86();
		self thread function_c3c92269();
		self thread function_4a5dac11();
		self thread function_1e509052();
	#/
}

/*
	Name: function_401f47cd
	Namespace: namespace_829e1a63
	Checksum: 0x2B25134B
	Offset: 0x1E60
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function function_401f47cd()
{
	/#
		self notify(#"hash_3ecc0277d544b441");
		namespace_314165c4::safedestroy(self.placementmodel);
		namespace_314165c4::safedestroy(self.var_3634d14e);
		namespace_314165c4::safedestroy(self.var_a2614669);
		namespace_314165c4::safedestroy(self.var_5ee5df03);
		namespace_314165c4::safedestroy(self.var_66df6677);
		namespace_314165c4::safedestroy(self.var_ec9a93);
		namespace_314165c4::safedestroy(self.var_811d1afa);
		namespace_314165c4::safedestroy(self.var_d7336ed8);
		namespace_314165c4::safedestroy(self.var_334e2710);
		namespace_314165c4::safedestroy(self.var_faa235b5);
		namespace_314165c4::safedestroy(self.var_35eb52f1);
		namespace_314165c4::safedestroy(self.var_a2f59097);
		self function_cc5afb75();
		self namespace_314165c4::propcontrolshud();
		self namespace_314165c4::setupkeybindings();
	#/
}

/*
	Name: function_1e509052
	Namespace: namespace_829e1a63
	Checksum: 0xB2C939E1
	Offset: 0x1FF0
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_1e509052()
{
	/#
		self endon(#"game_ended", #"disconnect", #"hash_3ecc0277d544b441");
		self waittill(#"death");
		setdvar(#"hash_34a3e2c00f7cd27f", 0);
	#/
}

/*
	Name: debugaxis
	Namespace: namespace_829e1a63
	Checksum: 0x27B1A0F7
	Offset: 0x2068
	Size: 0x13C
	Parameters: 6
	Flags: None
*/
function debugaxis(origin, angles, size, alpha, depthtest, duration)
{
	/#
		var_d40c3d87 = anglestoforward(angles) * size;
		var_bdd51119 = anglestoright(angles) * size;
		var_2792648e = anglestoup(angles) * size;
		line(origin, origin + var_d40c3d87, (1, 0, 0), alpha, 0, duration);
		line(origin, origin + var_bdd51119, (0, 1, 0), alpha, 0, duration);
		line(origin, origin + var_2792648e, (0, 0, 1), alpha, 0, duration);
	#/
}

/*
	Name: function_c3c92269
	Namespace: namespace_829e1a63
	Checksum: 0xE9BFF6D1
	Offset: 0x21B0
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function function_c3c92269()
{
	/#
		self endon(#"hash_3ecc0277d544b441");
		while(true)
		{
			debugaxis(self.origin, self.angles, 100, 1, 0, 1);
			box(self.origin, self getmins(), self getmaxs(), self.angles[1], (1, 0, 1), 1, 0, 1);
			waitframe(1);
		}
	#/
}

/*
	Name: function_4a5dac11
	Namespace: namespace_829e1a63
	Checksum: 0x4B766D30
	Offset: 0x2268
	Size: 0x1A8
	Parameters: 0
	Flags: None
*/
function function_4a5dac11()
{
	/#
		self endon(#"hash_3ecc0277d544b441");
		self function_ea8e45a8(0);
		while(true)
		{
			waitresult = undefined;
			waitresult = self waittill(#"up", #"down", #"left", #"right", #"shot");
			msg = waitresult._notify;
			if(!isdefined(msg))
			{
				continue;
			}
			if(msg == "")
			{
				self function_92f23bcd(-1);
			}
			else if(msg == "")
			{
				self function_92f23bcd(1);
			}
			else if(msg == "")
			{
				self function_cdf89a29(1);
			}
			else if(msg == "")
			{
				self function_cdf89a29(-1);
			}
			else if(msg == "")
			{
				function_77511c75();
			}
		}
	#/
}

/*
	Name: function_92f23bcd
	Namespace: namespace_829e1a63
	Checksum: 0xC56962D8
	Offset: 0x2418
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_92f23bcd(val)
{
	/#
		self endon(#"hash_77b8180aa53275f8");
		function_ea8e45a8(val);
		wait(0.5);
		while(true)
		{
			function_ea8e45a8(val);
			wait(0.05);
		}
	#/
}

/*
	Name: function_ea8e45a8
	Namespace: namespace_829e1a63
	Checksum: 0x992CF273
	Offset: 0x2488
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function function_ea8e45a8(val)
{
	/#
		hudelem = self.var_28df7051[self.placementindex];
		hudelem.alpha = 0.5;
		hudelem.fontscale = 1;
		self.placementindex = self.placementindex + val;
		if(self.placementindex >= self.var_28df7051.size)
		{
			self.placementindex = 0;
		}
		else if(self.placementindex < 0)
		{
			self.placementindex = self.var_28df7051.size - 1;
		}
		hudelem = self.var_28df7051[self.placementindex];
		hudelem.alpha = 1;
		hudelem.fontscale = 1.3;
	#/
}

/*
	Name: function_cdf89a29
	Namespace: namespace_829e1a63
	Checksum: 0xE770E8E2
	Offset: 0x2580
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_cdf89a29(val)
{
	/#
		self endon(#"hash_77b8180aa53275f8");
		function_75154360(val);
		wait(0.05);
		while(true)
		{
			function_75154360(val);
			wait(0.05);
		}
	#/
}

/*
	Name: function_5ee4d3a8
	Namespace: namespace_829e1a63
	Checksum: 0x275CA93C
	Offset: 0x25F0
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function function_5ee4d3a8(var_7e1f6a77)
{
	/#
		var_59345149 = self.var_5f51d2ee + var_7e1f6a77;
		if(var_59345149 >= level.propindex.size)
		{
			var_59345149 = 0;
		}
		else if(var_59345149 < 0)
		{
			var_59345149 = level.propindex.size - 1;
		}
		self.var_5f51d2ee = var_59345149;
	#/
}

/*
	Name: function_1eca597a
	Namespace: namespace_829e1a63
	Checksum: 0xE1307DD4
	Offset: 0x2670
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function function_1eca597a(var_8ba3b403)
{
	/#
		for(index = 0; index < level.propindex.size; index++)
		{
			if(level.proplist[level.propindex[index][0]][level.propindex[index][1]].modelname == var_8ba3b403)
			{
				return index;
			}
		}
	#/
}

/*
	Name: function_75154360
	Namespace: namespace_829e1a63
	Checksum: 0xE7CCED59
	Offset: 0x2700
	Size: 0xEFC
	Parameters: 1
	Flags: None
*/
function function_75154360(val)
{
	/#
		hudelem = self.var_28df7051[self.placementindex];
		if(hudelem == self.placementmodel)
		{
			function_5ee4d3a8(val);
			self.prop.info = level.proplist[level.propindex[self.var_5f51d2ee][0]][level.propindex[self.var_5f51d2ee][1]];
			namespace_314165c4::propchangeto(self.prop.info);
			self.placementmodel settext("" + self.var_5f51d2ee + "" + self.prop.info.modelname);
			self.var_3634d14e settext("" + self.prop.info.propsizetext);
			self.var_a2614669 setvalue(self.prop.info.propsize);
			self.var_5ee5df03 setvalue(self.prop.info.var_9846ca56);
			self.var_66df6677 setvalue(self.prop.info.xyzoffset[0]);
			self.var_ec9a93 setvalue(self.prop.info.xyzoffset[1]);
			self.var_811d1afa setvalue(self.prop.info.xyzoffset[2]);
			self.var_d7336ed8 setvalue(self.prop.info.anglesoffset[0]);
			self.var_334e2710 setvalue(self.prop.info.anglesoffset[1]);
			self.var_faa235b5 setvalue(self.prop.info.anglesoffset[2]);
			self.var_35eb52f1 setvalue(self.prop.info.propheight);
			self.var_a2f59097 setvalue(self.prop.info.proprange);
		}
		else if(hudelem == self.var_3634d14e || hudelem == self.var_a2614669)
		{
			sizes = array("", "", "", "", "", "");
			index = 0;
			for(i = 0; i < sizes.size; i++)
			{
				if(sizes[i] == self.prop.info.propsizetext)
				{
					index = i;
					break;
				}
			}
			index = index + val;
			if(index < 0)
			{
				index = sizes.size - 1;
			}
			else if(index >= sizes.size)
			{
				index = 0;
			}
			self.prop.info.propsizetext = sizes[index];
			self.prop.info.propsize = prop::getpropsize(self.prop.info.propsizetext);
			self.var_3634d14e settext("" + self.prop.info.propsizetext);
			self.var_a2614669 setvalue(self.prop.info.propsize);
			self.health = self.prop.info.propsize;
			self.maxhealth = self.health;
		}
		else if(hudelem == self.var_5ee5df03)
		{
			var_dfa19677 = 0.1;
			var_34b4cc47 = 10;
			var_59913b42 = 0.01;
			self.prop.info.var_9846ca56 = self.prop.info.var_9846ca56 + var_59913b42 * val;
			self.prop.info.var_9846ca56 = math::clamp(self.prop.info.var_9846ca56, var_dfa19677, var_34b4cc47);
			self.prop setscale(self.prop.info.var_9846ca56);
			self.var_5ee5df03 setvalue(self.prop.info.var_9846ca56);
		}
		else if(hudelem == self.var_66df6677)
		{
			self.prop unlink();
			self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0] + val, self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2]);
			self.prop.xyzoffset = self.prop.info.xyzoffset;
			self.var_66df6677 setvalue(self.prop.info.xyzoffset[0]);
			function_c2ab2206();
		}
		else if(hudelem == self.var_ec9a93)
		{
			self.prop unlink();
			self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1] + val, self.prop.info.xyzoffset[2]);
			self.prop.xyzoffset = self.prop.info.xyzoffset;
			self.var_ec9a93 setvalue(self.prop.info.xyzoffset[1]);
			function_c2ab2206();
		}
		else if(hudelem == self.var_811d1afa)
		{
			self.prop unlink();
			self.prop.info.xyzoffset = (self.prop.info.xyzoffset[0], self.prop.info.xyzoffset[1], self.prop.info.xyzoffset[2] + val);
			self.prop.xyzoffset = self.prop.info.xyzoffset;
			self.var_811d1afa setvalue(self.prop.info.xyzoffset[2]);
			function_c2ab2206();
		}
		else if(hudelem == self.var_d7336ed8)
		{
			self.prop unlink();
			self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0] + val, self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2]);
			self.prop.anglesoffset = self.prop.info.anglesoffset;
			self.var_d7336ed8 setvalue(self.prop.info.anglesoffset[0]);
			function_c2ab2206();
		}
		else if(hudelem == self.var_334e2710)
		{
			self.prop unlink();
			self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1] + val, self.prop.info.anglesoffset[2]);
			self.prop.anglesoffset = self.prop.info.anglesoffset;
			self.var_334e2710 setvalue(self.prop.info.anglesoffset[1]);
			function_c2ab2206();
		}
		else if(hudelem == self.var_faa235b5)
		{
			self.prop unlink();
			self.prop.info.anglesoffset = (self.prop.info.anglesoffset[0], self.prop.info.anglesoffset[1], self.prop.info.anglesoffset[2] + val);
			self.prop.anglesoffset = self.prop.info.anglesoffset;
			self.var_faa235b5 setvalue(self.prop.info.anglesoffset[2]);
			function_c2ab2206();
		}
		else if(hudelem == self.var_35eb52f1)
		{
			adjust = 10;
			self.prop.info.propheight = self.prop.info.propheight + adjust * val;
			self.prop.info.propheight = math::clamp(self.prop.info.propheight, -30, 40);
			self.thirdpersonheightoffset = self.prop.info.propheight;
			self setclientthirdperson(1);
			self.var_35eb52f1 setvalue(self.prop.info.propheight);
		}
		else if(hudelem == self.var_a2f59097)
		{
			adjust = 10;
			self.prop.info.proprange = self.prop.info.proprange + adjust * val;
			self.prop.info.proprange = math::clamp(self.prop.info.proprange, 50, 360);
			self.thirdpersonrange = self.prop.info.proprange;
			self setclientthirdperson(1);
			self.var_a2f59097 setvalue(self.prop.info.proprange);
		}
	#/
}

/*
	Name: function_c2ab2206
	Namespace: namespace_829e1a63
	Checksum: 0x807F28D
	Offset: 0x3608
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_c2ab2206()
{
	/#
		self.prop.origin = self.propent.origin;
		self prop::applyxyzoffset();
		self prop::applyanglesoffset();
		self.prop linkto(self.propent);
	#/
}

/*
	Name: function_8d3ffd86
	Namespace: namespace_829e1a63
	Checksum: 0xD615CBF1
	Offset: 0x3688
	Size: 0x1E4
	Parameters: 0
	Flags: None
*/
function function_8d3ffd86()
{
	/#
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
		self namespace_314165c4::notifyonplayercommand("", "");
	#/
}

/*
	Name: function_cc5afb75
	Namespace: namespace_829e1a63
	Checksum: 0x7C5F4A60
	Offset: 0x3878
	Size: 0x1E4
	Parameters: 0
	Flags: None
*/
function function_cc5afb75()
{
	/#
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
		self namespace_314165c4::notifyonplayercommandremove("", "");
	#/
}

/*
	Name: function_cbef3d63
	Namespace: namespace_829e1a63
	Checksum: 0xC7749026
	Offset: 0x3A68
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function function_cbef3d63(vec)
{
	/#
		return isdefined(vec) && (vec[0] != 0 || vec[1] != 0 || vec[2] != 0);
	#/
}

/*
	Name: function_a840713e
	Namespace: namespace_829e1a63
	Checksum: 0x5B73BC09
	Offset: 0x3AC0
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function function_a840713e(propinfo)
{
	/#
		return isdefined(propinfo.propheight) && propinfo.propheight != prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
	#/
}

/*
	Name: function_7a3672a6
	Namespace: namespace_829e1a63
	Checksum: 0xB4764F12
	Offset: 0x3B10
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function function_7a3672a6(propinfo)
{
	/#
		return isdefined(propinfo.proprange) && propinfo.proprange != prop::getthirdpersonrangeforsize(propinfo.propsize);
	#/
}

/*
	Name: function_2dc5c497
	Namespace: namespace_829e1a63
	Checksum: 0xFFFDD2A
	Offset: 0x3B60
	Size: 0x264
	Parameters: 2
	Flags: None
*/
function function_2dc5c497(file, propinfo)
{
	/#
		var_74b91a95 = "" + propinfo.modelname + "" + propinfo.propsizetext + "" + propinfo.var_9846ca56;
		if(function_cbef3d63(propinfo.xyzoffset))
		{
			var_74b91a95 = var_74b91a95 + "" + propinfo.xyzoffset[0] + "" + propinfo.xyzoffset[1] + "" + propinfo.xyzoffset[2];
		}
		else
		{
			var_74b91a95 = var_74b91a95 + "";
		}
		if(function_cbef3d63(propinfo.anglesoffset))
		{
			var_74b91a95 = var_74b91a95 + "" + propinfo.anglesoffset[0] + "" + propinfo.anglesoffset[1] + "" + propinfo.anglesoffset[2];
		}
		else
		{
			var_74b91a95 = var_74b91a95 + "";
		}
		if(function_a840713e(propinfo))
		{
			var_74b91a95 = var_74b91a95 + "" + propinfo.propheight;
		}
		else
		{
			var_74b91a95 = var_74b91a95 + "" + prop::getthirdpersonheightoffsetforsize(propinfo.propsize);
		}
		if(function_7a3672a6(propinfo))
		{
			var_74b91a95 = var_74b91a95 + "" + propinfo.proprange;
		}
		else
		{
			var_74b91a95 = var_74b91a95 + "" + prop::getthirdpersonrangeforsize(propinfo.propsize);
		}
		fprintln(file, var_74b91a95);
	#/
}

/*
	Name: function_8639a7b0
	Namespace: namespace_829e1a63
	Checksum: 0x16714008
	Offset: 0x3DD0
	Size: 0x5C
	Parameters: 2
	Flags: None
*/
function function_8639a7b0(file, propinfo)
{
	/#
		var_74b91a95 = "" + propinfo.modelname + "";
		fprintln(file, var_74b91a95);
	#/
}

/*
	Name: function_62b9b9ac
	Namespace: namespace_829e1a63
	Checksum: 0x7BB0EE86
	Offset: 0x3E38
	Size: 0x10C
	Parameters: 2
	Flags: None
*/
function function_62b9b9ac(file, propsizetext)
{
	/#
		foreach(var_8889f985 in level.proplist)
		{
			foreach(propinfo in var_8889f985)
			{
				if(propinfo.propsizetext == propsizetext)
				{
					function_2dc5c497(file, propinfo);
				}
			}
		}
	#/
}

/*
	Name: plaza_dom_point_neutral_b_secured
	Namespace: namespace_829e1a63
	Checksum: 0x9EDD8097
	Offset: 0x3F50
	Size: 0x10C
	Parameters: 2
	Flags: None
*/
function plaza_dom_point_neutral_b_secured(file, propsizetext)
{
	/#
		foreach(var_8889f985 in level.proplist)
		{
			foreach(propinfo in var_8889f985)
			{
				if(propinfo.propsizetext == propsizetext)
				{
					function_8639a7b0(file, propinfo);
				}
			}
		}
	#/
}

/*
	Name: function_79d57521
	Namespace: namespace_829e1a63
	Checksum: 0xF31E84EC
	Offset: 0x4068
	Size: 0x314
	Parameters: 2
	Flags: None
*/
function function_79d57521(file, var_7723a9cd)
{
	/#
		var_7e52c89c = var_7723a9cd + "";
		var_44c49e4e = var_7723a9cd + "";
		var_473e8b8d = var_7723a9cd + "";
		var_ca180226 = level.script + "";
		var_19494914 = level.script + "";
		var_155d523d = "";
		var_7770e500 = "";
		var_d6ade535 = "";
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "" + var_7e52c89c + "");
		fprintln(file, "" + var_44c49e4e + "");
		fprintln(file, "" + var_473e8b8d + "" + var_155d523d);
		fprintln(file, "" + var_7e52c89c + "" + var_d6ade535);
		fprintln(file, "" + var_44c49e4e + "" + var_7770e500);
		fprintln(file, "");
		fprintln(file, "" + var_ca180226 + "" + var_7723a9cd);
		fprintln(file, "" + var_19494914 + "" + var_44c49e4e + "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
	#/
}

/*
	Name: function_cb8ecc99
	Namespace: namespace_829e1a63
	Checksum: 0x2549CFFE
	Offset: 0x4388
	Size: 0x3AC
	Parameters: 0
	Flags: None
*/
function function_cb8ecc99()
{
	/#
		platform = "";
		if(level.orbis)
		{
			platform = "";
		}
		else if(level.durango)
		{
			platform = "";
		}
		var_7723a9cd = level.script + "";
		var_7e52c89c = var_7723a9cd + "";
		var_b522696f = "" + platform + "";
		var_d6ade535 = "";
		file = openfile(var_7e52c89c, "");
		if(file == -1)
		{
			iprintlnbold("" + var_b522696f + var_7e52c89c + "");
			println("" + var_b522696f + var_7e52c89c + "");
			return;
		}
		function_79d57521(file, var_7723a9cd);
		fprintln(file, "");
		function_62b9b9ac(file, "");
		fprintln(file, "");
		fprintln(file, "");
		function_62b9b9ac(file, "");
		fprintln(file, "");
		fprintln(file, "");
		function_62b9b9ac(file, "");
		fprintln(file, "");
		fprintln(file, "");
		function_62b9b9ac(file, "");
		fprintln(file, "");
		fprintln(file, "");
		function_62b9b9ac(file, "");
		iprintlnbold("" + var_b522696f + var_7e52c89c + "" + var_d6ade535);
		println("" + var_b522696f + var_7e52c89c + "" + var_d6ade535);
		closefile(file);
	#/
}

/*
	Name: function_2b23b2b6
	Namespace: namespace_829e1a63
	Checksum: 0xB31015CA
	Offset: 0x4740
	Size: 0x394
	Parameters: 0
	Flags: None
*/
function function_2b23b2b6()
{
	/#
		platform = "";
		if(level.orbis)
		{
			platform = "";
		}
		else if(level.durango)
		{
			platform = "";
		}
		var_7723a9cd = level.script + "";
		var_7e52c89c = var_7723a9cd + "";
		var_b522696f = "" + platform + "";
		var_d6ade535 = "";
		file = openfile(var_7e52c89c, "");
		if(file == -1)
		{
			iprintlnbold("" + var_b522696f + var_7e52c89c + "");
			println("" + var_b522696f + var_7e52c89c + "");
			return;
		}
		fprintln(file, "");
		plaza_dom_point_neutral_b_secured(file, "");
		fprintln(file, "");
		fprintln(file, "");
		plaza_dom_point_neutral_b_secured(file, "");
		fprintln(file, "");
		fprintln(file, "");
		plaza_dom_point_neutral_b_secured(file, "");
		fprintln(file, "");
		fprintln(file, "");
		plaza_dom_point_neutral_b_secured(file, "");
		fprintln(file, "");
		fprintln(file, "");
		plaza_dom_point_neutral_b_secured(file, "");
		iprintlnbold("" + var_b522696f + var_7e52c89c + "" + var_d6ade535);
		println("" + var_b522696f + var_7e52c89c + "" + var_d6ade535);
		closefile(file);
	#/
}

/*
	Name: function_f2e19297
	Namespace: namespace_829e1a63
	Checksum: 0x56F6CD86
	Offset: 0x4AE0
	Size: 0xC34
	Parameters: 0
	Flags: None
*/
function function_f2e19297()
{
	/#
		platform = "";
		if(level.orbis)
		{
			platform = "";
		}
		else if(level.durango)
		{
			platform = "";
		}
		var_7723a9cd = level.script + "";
		var_7e52c89c = var_7723a9cd + "";
		var_44c49e4e = var_7723a9cd + "";
		var_473e8b8d = var_7723a9cd + "";
		var_ca180226 = level.script + "";
		var_19494914 = level.script + "";
		var_b522696f = "" + platform + "";
		var_155d523d = "";
		var_7770e500 = "";
		var_d6ade535 = "";
		file = openfile(var_7e52c89c, "");
		if(file == -1)
		{
			iprintlnbold("" + var_b522696f + var_7e52c89c + "");
			println("" + var_b522696f + var_7e52c89c + "");
			return;
		}
		function_79d57521(file, var_7723a9cd);
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		closefile(file);
		file = openfile(var_44c49e4e, "");
		if(file == -1)
		{
			iprintlnbold("" + var_b522696f + var_44c49e4e + "");
			println("" + var_b522696f + var_44c49e4e + "");
			return;
		}
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		fprintln(file, "");
		closefile(file);
		file = openfile(var_473e8b8d, "");
		if(file == -1)
		{
			iprintlnbold("" + var_b522696f + var_473e8b8d + "");
			println("" + var_b522696f + var_473e8b8d + "");
			return;
		}
		fprintln(file, "" + var_7e52c89c);
		fprintln(file, "" + var_44c49e4e);
		closefile(file);
		iprintlnbold("" + var_b522696f);
		println("" + var_b522696f);
	#/
}

/*
	Name: function_77511c75
	Namespace: namespace_829e1a63
	Checksum: 0x16D36E91
	Offset: 0x5720
	Size: 0x3C2
	Parameters: 0
	Flags: None
*/
function function_77511c75()
{
	/#
		player = level.players[0];
		if(!isdefined(player) || !isalive(player) || (!(isdefined(player.hasspawned) && player.hasspawned)))
		{
			return;
		}
		if(isdefined(level.players[1]))
		{
			var_3473cb36 = level.players[1];
		}
		else
		{
			var_3473cb36 = bot::add_bot(util::getotherteam(player.team));
		}
		if(!isdefined(var_3473cb36.pers[#"participation"]))
		{
			var_3473cb36.pers[#"participation"] = 0;
		}
		if(!isdefined(var_3473cb36.hits))
		{
			var_3473cb36.hits = 0;
		}
		setdvar(#"hash_3835bf18bc27fe80", 0);
		setdvar(#"bot_allowmovement", 0);
		player.health = player.maxhealth;
		weapon = getweapon("");
		end = player.origin;
		dir = anglestoforward(player.angles);
		start = end + dir * 100 + vectorscale((0, 0, 1), 30);
		magicbullet(weapon, start, end, var_3473cb36);
		var_9b67aa0b = -1 * dir;
		start = end + var_9b67aa0b * 100 + vectorscale((0, 0, 1), 30);
		magicbullet(weapon, start, end, var_3473cb36);
		var_70d65e57 = anglestoright(player.angles);
		start = end + var_70d65e57 * 100 + vectorscale((0, 0, 1), 30);
		magicbullet(weapon, start, end, var_3473cb36);
		var_3d34e352 = -1 * var_70d65e57;
		start = end + var_3d34e352 * 100 + vectorscale((0, 0, 1), 30);
		magicbullet(weapon, start, end, var_3473cb36);
		start = end + vectorscale((0, 0, 1), 100);
		magicbullet(weapon, start, end, var_3473cb36);
		player waittill_timeout(0.3, #"damage");
		wait(0.05);
		player.health = player.maxhealth;
	#/
}

/*
	Name: function_ad8cc361
	Namespace: namespace_829e1a63
	Checksum: 0x3E8D76E8
	Offset: 0x5AF0
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function function_ad8cc361()
{
	/#
		if(!isdefined(level.players))
		{
			return;
		}
		foreach(player in level.players)
		{
			if(isdefined(player) && isdefined(player.team) && player.team == game.defenders)
			{
				print3d(player.origin + vectorscale((0, 0, 1), 50), "" + player.health);
			}
		}
	#/
}

/*
	Name: function_34a7562e
	Namespace: namespace_829e1a63
	Checksum: 0x5B7F82DC
	Offset: 0x5BE8
	Size: 0x110
	Parameters: 0
	Flags: None
*/
function function_34a7562e()
{
	/#
		if(!isdefined(level.players))
		{
			return;
		}
		foreach(player in level.players)
		{
			velocity = player getvelocity();
			var_a79358cf = (velocity[0], velocity[1], 0);
			speed = length(var_a79358cf);
			print3d(player.origin + vectorscale((0, 0, 1), 50), "" + speed);
		}
	#/
}

/*
	Name: function_38964c72
	Namespace: namespace_829e1a63
	Checksum: 0x91349624
	Offset: 0x5D00
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function function_38964c72()
{
	/#
		if(!isdefined(level.players))
		{
			return;
		}
		foreach(player in level.players)
		{
			if(isdefined(player) && isdefined(player.prop))
			{
				player namespace_314165c4::get_ground_normal(player.prop, 1);
			}
		}
	#/
}

/*
	Name: function_ed0598d
	Namespace: namespace_829e1a63
	Checksum: 0xE1923699
	Offset: 0x5DC0
	Size: 0x2BE
	Parameters: 3
	Flags: None
*/
function function_ed0598d(propinfo, origin, angles)
{
	/#
		propent = spawn("", origin);
		propent setcontents(0);
		propent notsolid();
		propent setplayercollision(0);
		prop = spawn("", propent.origin);
		prop.angles = angles;
		prop setmodel(propinfo.modelname);
		prop setscale(propinfo.var_9846ca56);
		prop setcandamage(1);
		prop.xyzoffset = propinfo.xyzoffset;
		prop.anglesoffset = propinfo.anglesoffset;
		prop.health = 1;
		prop setplayercollision(0);
		forward = anglestoforward(angles) * prop.xyzoffset[0];
		right = anglestoright(angles) * prop.xyzoffset[1];
		up = anglestoup(angles) * prop.xyzoffset[2];
		prop.origin = prop.origin + forward;
		prop.origin = prop.origin + right;
		prop.origin = prop.origin + up;
		prop.angles = prop.angles + prop.anglesoffset;
		prop linkto(propent);
		propent.prop = prop;
		propent.propinfo = propinfo;
		return propent;
	#/
}

/*
	Name: function_89b4b4c
	Namespace: namespace_829e1a63
	Checksum: 0x4AD3A648
	Offset: 0x6088
	Size: 0x226
	Parameters: 0
	Flags: None
*/
function function_89b4b4c()
{
	/#
		player = level.players[0];
		angles = player.angles;
		dir = anglestoforward(angles);
		origin = player.origin + vectorscale((0, 0, 1), 100);
		if(!isdefined(level.var_98714fa7))
		{
			level.var_98714fa7 = [];
			foreach(category in level.proplist)
			{
				foreach(propinfo in category)
				{
					level.var_98714fa7[level.var_98714fa7.size] = function_ed0598d(propinfo, origin, angles);
					origin = origin + dir * 60;
				}
			}
		}
		else
		{
			foreach(propent in level.var_98714fa7)
			{
				propent.origin = origin;
				origin = origin + dir * 60;
			}
		}
	#/
}

/*
	Name: function_1f3923fa
	Namespace: namespace_829e1a63
	Checksum: 0x69078329
	Offset: 0x62B8
	Size: 0x344
	Parameters: 0
	Flags: None
*/
function function_1f3923fa()
{
	/#
		if(!isdefined(level.var_f8f7808e))
		{
			return;
		}
		color = (0, 1, 0);
		if(!level.var_f8f7808e.success)
		{
			color = (1, 0, 0);
		}
		print3d(level.var_f8f7808e.playerorg + vectorscale((0, 0, 1), 50), level.var_f8f7808e.type);
		box(level.var_f8f7808e.playerorg, level.var_f8f7808e.playermins, level.var_f8f7808e.playermaxs, level.var_f8f7808e.playerangles[1], color);
		if(isdefined(level.var_f8f7808e.origin1))
		{
			sphere(level.var_f8f7808e.origin1, 5, color);
			line(level.var_f8f7808e.playerorg, level.var_f8f7808e.origin1);
			if(isdefined(level.var_f8f7808e.text1))
			{
				print3d(level.var_f8f7808e.origin1 + vectorscale((0, 0, -1), 10), level.var_f8f7808e.text1);
			}
		}
		if(isdefined(level.var_f8f7808e.origin2))
		{
			sphere(level.var_f8f7808e.origin2, 5, color);
			line(level.var_f8f7808e.playerorg, level.var_f8f7808e.origin2);
			if(isdefined(level.var_f8f7808e.text2))
			{
				print3d(level.var_f8f7808e.origin2 + vectorscale((0, 0, 1), 10), level.var_f8f7808e.text2);
			}
		}
		if(isdefined(level.var_f8f7808e.origin3))
		{
			sphere(level.var_f8f7808e.origin3, 5, color);
			line(level.var_f8f7808e.playerorg, level.var_f8f7808e.origin3);
			if(isdefined(level.var_f8f7808e.text3))
			{
				print3d(level.var_f8f7808e.origin3 + vectorscale((0, 0, 1), 30), level.var_f8f7808e.text3);
			}
		}
	#/
}

/*
	Name: function_cded003e
	Namespace: namespace_829e1a63
	Checksum: 0x87946BA2
	Offset: 0x6608
	Size: 0x16C
	Parameters: 4
	Flags: None
*/
function function_cded003e(propinfo, origin, angles, team)
{
	/#
		var_6e55957c = spawn("", origin);
		var_6e55957c.targetname = "";
		var_6e55957c setmodel(propinfo.modelname);
		var_6e55957c setscale(propinfo.var_9846ca56);
		var_6e55957c.angles = angles;
		var_6e55957c setcandamage(1);
		var_6e55957c.fakehealth = 50;
		var_6e55957c.health = 99999;
		var_6e55957c.maxhealth = 99999;
		var_6e55957c thread prop::function_aa8db165(&namespace_314165c4::damageclonewatch);
		var_6e55957c setplayercollision(0);
		var_6e55957c makesentient();
		var_6e55957c setteam(team);
	#/
}

/*
	Name: function_5646cd5c
	Namespace: namespace_829e1a63
	Checksum: 0xE571F973
	Offset: 0x6780
	Size: 0x236
	Parameters: 0
	Flags: None
*/
function function_5646cd5c()
{
	/#
		player = level.players[0];
		angles = player.angles;
		dir = anglestoforward(angles);
		origin = player.origin + vectorscale((0, 0, 1), 100);
		if(isdefined(level.var_2ebdcb74))
		{
			foreach(clone in level.var_2ebdcb74)
			{
				clone namespace_314165c4::function_d1a1cc8d();
			}
		}
		level.var_2ebdcb74 = [];
		foreach(category in level.proplist)
		{
			foreach(propinfo in category)
			{
				level.var_2ebdcb74[level.var_2ebdcb74.size] = function_cded003e(propinfo, origin, angles, util::getotherteam(player.team));
				origin = origin + dir * 60;
			}
		}
	#/
}

/*
	Name: function_5e0d41c4
	Namespace: namespace_829e1a63
	Checksum: 0x83780679
	Offset: 0x69C0
	Size: 0x10A
	Parameters: 0
	Flags: None
*/
function function_5e0d41c4()
{
	/#
		player = level.players[0];
		angles = player.angles;
		dir = anglestoforward(angles);
		origin = player.origin + dir * vectorscale((0, 0, 1), 100);
		propinfo = prop::getnextprop(player);
		if(!isdefined(level.var_2ebdcb74))
		{
			level.var_2ebdcb74 = [];
		}
		level.var_2ebdcb74[level.var_2ebdcb74.size] = function_cded003e(propinfo, origin, angles, util::getotherteam(player.team));
	#/
}

/*
	Name: function_f06fb157
	Namespace: namespace_829e1a63
	Checksum: 0x7DC6D40D
	Offset: 0x6AD8
	Size: 0xD8
	Parameters: 0
	Flags: None
*/
function function_f06fb157()
{
	/#
		if(!isdefined(level.players))
		{
			return;
		}
		foreach(player in level.players)
		{
			box(player.origin, player getmins(), player getmaxs(), player.angles[1], (1, 0, 1), 1, 0, 1);
		}
	#/
}

/*
	Name: function_b7c018a7
	Namespace: namespace_829e1a63
	Checksum: 0x1823CC51
	Offset: 0x6BB8
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function function_b7c018a7()
{
	/#
		if(!isdefined(level.var_1103f74e) || !isdefined(level.var_1103f74e.targets))
		{
			return;
		}
		for(i = 0; i < level.var_1103f74e.targets.size; i++)
		{
			target = level.var_1103f74e.targets[i];
			if(isdefined(target))
			{
				print3d(target.origin + vectorscale((0, 0, 1), 30), "" + target.fakehealth);
			}
		}
	#/
}

