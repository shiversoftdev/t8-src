// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace blood;

/*
	Name: function_89f2df9
	Namespace: blood
	Checksum: 0x33AEA648
	Offset: 0x388
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"blood", undefined, &__postload_init__, undefined);
}

/*
	Name: __postload_init__
	Namespace: blood
	Checksum: 0xB1E5E87
	Offset: 0x3C8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function __postload_init__()
{
	function_dd830dee();
	callback::on_localplayer_spawned(&function_e79ccfd8);
	callback::on_localclient_connect(&localclient_connect);
	level.var_f771ff42 = util::is_mature();
}

/*
	Name: function_d18a9e97
	Namespace: blood
	Checksum: 0x1AFC697A
	Offset: 0x440
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_d18a9e97(localclientnum)
{
	return level.blood.var_de10c136.var_51036e02[localclientnum];
}

/*
	Name: localclient_connect
	Namespace: blood
	Checksum: 0xC9A9DFC
	Offset: 0x478
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function localclient_connect(localclientnum)
{
	level thread player_splatter(localclientnum);
}

/*
	Name: function_e79ccfd8
	Namespace: blood
	Checksum: 0x5B124E9
	Offset: 0x4A8
	Size: 0x224
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e79ccfd8(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	if(function_148ccc79(localclientnum, #"hash_73c750f53749d44d"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
	}
	self.var_957f4b6b = #"hash_44dcb6ac5e8787e0";
	self.var_36732900 = "rob_wound_blood_splatter";
	function_162fe6ec(localclientnum);
	self.var_9861062 = 0;
	if(level.blood.var_14a2badb.stage == 0)
	{
		self.var_28fdff3c = 1;
		self.var_dff3bb2c = 1;
	}
	else
	{
		self.var_28fdff3c = 0;
		self.var_dff3bb2c = 0;
	}
	self.stage2amount = 0;
	self.stage3amount = 0;
	self.lastbloodupdate = 0;
	self stop_breath(localclientnum);
	level thread wait_game_ended(localclientnum);
	self function_5d482e78("rob_wound_blood_splatter");
	self function_5d482e78("rob_wound_blood_splatter_reaper");
	self thread function_87544c4a(localclientnum);
	self thread function_493a8fbc(localclientnum);
	new_health_model_ui_model = createuimodel(getuimodelforcontroller(localclientnum), "usingNewHealthModel");
	if(isdefined(new_health_model_ui_model))
	{
		setuimodelvalue(new_health_model_ui_model, level.new_health_model);
	}
}

/*
	Name: setcontrollerlightbarcolorpulsing
	Namespace: blood
	Checksum: 0x3F1F7AA1
	Offset: 0x6D8
	Size: 0xB4
	Parameters: 3
	Flags: Linked, Private
*/
private function setcontrollerlightbarcolorpulsing(localclientnum, color, pulserate)
{
	curcolor = color * 0.2;
	scale = gettime() % pulserate / pulserate * 0.5;
	if(scale > 1)
	{
		scale = scale - 2 * -1;
	}
	curcolor = curcolor + color * 0.8 * scale;
	setcontrollerlightbarcolor(localclientnum, curcolor);
}

/*
	Name: function_e67f278c
	Namespace: blood
	Checksum: 0xD33AE92F
	Offset: 0x798
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e67f278c(localclientnum)
{
	if(!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange))
	{
		if(self.stage3amount > 0)
		{
			setcontrollerlightbarcolorpulsing(localclientnum, (1, 0, 0), 600);
		}
		else if(self.stage2amount == 1)
		{
			setcontrollerlightbarcolorpulsing(localclientnum, vectorscale((1, 0, 0), 0.8), 1200);
		}
		else if(!sessionmodeiscampaigngame() || codegetuimodelclientfield(self, "playerAbilities.inRange") && getgadgetpower(localclientnum) == 1)
		{
			setcontrollerlightbarcolorpulsing(localclientnum, (1, 1, 0), 2000);
		}
		else if(isdefined(level.controllercolor) && isdefined(level.controllercolor[localclientnum]))
		{
			setcontrollerlightbarcolor(localclientnum, level.controllercolor[localclientnum]);
		}
		else
		{
			setcontrollerlightbarcolor(localclientnum);
		}
	}
}

/*
	Name: enter_critical_health
	Namespace: blood
	Checksum: 0x2B9571D8
	Offset: 0x918
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function enter_critical_health(localclientnum)
{
	self thread play_critical_health_rumble(localclientnum);
	self play_breath(localclientnum);
}

/*
	Name: play_critical_health_rumble
	Namespace: blood
	Checksum: 0xC3552A42
	Offset: 0x960
	Size: 0x158
	Parameters: 1
	Flags: Linked, Private
*/
private function play_critical_health_rumble(localclientnum)
{
	self endon(#"death", #"disconnect", #"critical_health_end", #"spawned");
	var_cf155b98 = "new_health_stage_critical";
	while(true)
	{
		self waittill(#"hash_7b55313d89ce26ed");
		self playrumbleonentity(localclientnum, var_cf155b98);
		name = self getmpdialogname();
		if(!isdefined(name))
		{
			name = #"human";
		}
		if(name == #"reaper")
		{
			sound = #"hash_5efb63d6f3917a19";
		}
		else
		{
			sound = #"mpl_player_heartbeat";
		}
		if(!(isdefined(self.var_e9dd2ca0) && self.var_e9dd2ca0))
		{
			self playsound(localclientnum, sound);
		}
	}
}

/*
	Name: play_breath
	Namespace: blood
	Checksum: 0xF3D5EEFB
	Offset: 0xAC0
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function play_breath(localclientnum)
{
	self stop_breath(localclientnum);
	snd_handle = function_604c9983(localclientnum, "chr_health_low_breath_loop", 0.1);
	level.hurt_breath_snd_handle[localclientnum] = snd_handle;
	self thread watch_end_breath(localclientnum);
}

/*
	Name: watch_end_breath
	Namespace: blood
	Checksum: 0x38C7200
	Offset: 0xB50
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
private function watch_end_breath(localclientnum)
{
	self waittill(#"death", #"disconnect", #"critical_health_end", #"spawned");
	stop_breath(localclientnum);
}

/*
	Name: stop_breath
	Namespace: blood
	Checksum: 0x84050D10
	Offset: 0xBC0
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function stop_breath(localclientnum)
{
	if(!isdefined(level.hurt_breath_snd_handle))
	{
		level.hurt_breath_snd_handle = [];
	}
	if(isdefined(level.hurt_breath_snd_handle[localclientnum]))
	{
		function_d48752e(localclientnum, level.hurt_breath_snd_handle[localclientnum], 1);
		level.hurt_breath_snd_handle[localclientnum] = undefined;
	}
}

/*
	Name: wait_game_ended
	Namespace: blood
	Checksum: 0xA4900770
	Offset: 0xC48
	Size: 0xDE
	Parameters: 1
	Flags: Linked, Private
*/
private function wait_game_ended(localclientnum)
{
	if(!isdefined(level.watching_blood_game_ended))
	{
		level.watching_blood_game_ended = [];
	}
	if(level.watching_blood_game_ended[localclientnum] === 1)
	{
		return;
	}
	level.watching_blood_game_ended[localclientnum] = 1;
	level waittill(#"game_ended");
	stop_breath(localclientnum);
	localplayer = function_5c10bd79(localclientnum);
	if(isdefined(localplayer))
	{
		localplayer notify(#"critical_health_end");
	}
	level.watching_blood_game_ended[localclientnum] = 0;
}

/*
	Name: function_8e228a1d
	Namespace: blood
	Checksum: 0xEF60FB98
	Offset: 0xD30
	Size: 0x74
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8e228a1d(localclientnum, damage)
{
	if(damage > level.blood.var_14a2badb.damage_threshold)
	{
		self function_bf9d3071(self.var_36732900);
		self thread function_f192f00b(localclientnum, self.var_36732900);
	}
}

/*
	Name: function_f192f00b
	Namespace: blood
	Checksum: 0x8D1D4309
	Offset: 0xDB0
	Size: 0x1BC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_f192f00b(localclientnum, var_14a2badb)
{
	self notify("5572d7357c805da5");
	self endon("5572d7357c805da5");
	self endon(#"death");
	self endon(#"killbloodoverlay");
	self function_78233d29(var_14a2badb, "", "U Offset", randomfloatrange(0, 1));
	self function_78233d29(var_14a2badb, "", "V Offset", randomfloatrange(0, 1));
	self function_78233d29(var_14a2badb, "", "Threshold", 1);
	wait(float(level.blood.var_14a2badb.hold_time) / 1000);
	self thread ramprobsetting(localclientnum, 1, 0, level.blood.var_14a2badb.fade_time, "Threshold");
	wait(float(level.blood.var_14a2badb.fade_time) / 1000);
	self function_5d482e78(var_14a2badb);
}

/*
	Name: ramprobsetting
	Namespace: blood
	Checksum: 0x59CF729D
	Offset: 0xF78
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function ramprobsetting(localclientnum, from, to, ramptime, key)
{
	self endon(#"death");
	self endon(#"killbloodoverlay");
	self notify("rampROBsetting" + key);
	self endon("rampROBsetting" + key);
	util::lerp_generic(localclientnum, ramptime, &function_1126eb8c, from, to, key, self.var_36732900);
}

/*
	Name: function_1126eb8c
	Namespace: blood
	Checksum: 0xEA4E65D7
	Offset: 0x1038
	Size: 0xAC
	Parameters: 8
	Flags: Linked
*/
function function_1126eb8c(currenttime, elapsedtime, localclientnum, duration, var_2347e08e, var_991d3376, key, var_14a2badb)
{
	percent = elapsedtime / duration;
	amount = var_991d3376 * percent + var_2347e08e * 1 - percent;
	self function_78233d29(var_14a2badb, "", key, amount);
}

/*
	Name: function_672c739
	Namespace: blood
	Checksum: 0x97B6BB98
	Offset: 0x10F0
	Size: 0x274
	Parameters: 2
	Flags: Linked
*/
function function_672c739(localclientnum, var_c03dca7e)
{
	if(isdefined(var_c03dca7e) && var_c03dca7e)
	{
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Enable Tint", 0.9);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color R", 4);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color G", 4);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color B", 4);
	}
	else if(util::function_2c435484())
	{
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Enable Tint", 1);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color R", 0.15);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color G", 0.13);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color B", 0.24);
	}
	else
	{
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Enable Tint", 1);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color R", 0.3);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color G", 0.025);
		function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Tint Color B", 0);
	}
}

/*
	Name: function_27d3ba05
	Namespace: blood
	Checksum: 0x3CFEBD8D
	Offset: 0x1370
	Size: 0x68
	Parameters: 1
	Flags: Linked, Private
*/
private function function_27d3ba05(localclientnum)
{
	if(function_92beaa28(localclientnum) && !function_d17ae3cc(localclientnum))
	{
		return 0;
	}
	if(level.var_4ecf5754 === #"hash_65cfe78dc61dd3af")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_47d0632f
	Namespace: blood
	Checksum: 0x57BA12DB
	Offset: 0x13E0
	Size: 0xCC
	Parameters: 5
	Flags: Linked, Private
*/
private function function_47d0632f(localclientnum, damage, death, dot, var_c03dca7e)
{
	splatter = function_d18a9e97(localclientnum);
	splatter.var_c03dca7e = var_c03dca7e;
	splatter.var_120a7b2c++;
	var_cd141ca2 = splatter.var_120a7b2c % 4;
	if(function_27d3ba05(localclientnum))
	{
		level thread splatter_postfx(localclientnum, self, damage, var_cd141ca2, death, dot);
	}
}

/*
	Name: update_damage_effects
	Namespace: blood
	Checksum: 0x5CE886AA
	Offset: 0x14B8
	Size: 0xF4
	Parameters: 3
	Flags: Linked, Private
*/
private function update_damage_effects(localclientnum, damage, death)
{
	if(isdefined(self.dot_no_splatter) && self.dot_no_splatter && damage < 10 && damage > 0)
	{
		self.dot_no_splatter = 0;
	}
	else if(self.var_430c4b70 === 1 && damage > 0)
	{
		function_47d0632f(localclientnum, damage, death, 1, 0);
		self.var_430c4b70 = 0;
	}
	else if(damage > 0)
	{
		function_47d0632f(localclientnum, damage, death, 0, 0);
	}
	self function_8e228a1d(localclientnum, damage);
}

/*
	Name: player_splatter
	Namespace: blood
	Checksum: 0x7AD42C89
	Offset: 0x15B8
	Size: 0x30A
	Parameters: 1
	Flags: Linked, Private
*/
private function player_splatter(localclientnum)
{
	level notify("player_splatter" + localclientnum);
	level endon("player_splatter" + localclientnum);
	while(true)
	{
		level waittill(#"hash_518e8873ad943492");
		while(true)
		{
			splatter = function_d18a9e97(localclientnum);
			blur = 0;
			opacity = 0;
			for(i = 0; i < 4; i++)
			{
				if(isdefined(splatter.var_d47f98a4[i][#"hash_2151e5b1dafa374"]) && splatter.var_d47f98a4[i][#"hash_2151e5b1dafa374"] > blur)
				{
					blur = splatter.var_d47f98a4[i][#"hash_2151e5b1dafa374"];
				}
				if(isdefined(splatter.var_d47f98a4[i][#"opacity"]) && splatter.var_d47f98a4[i][#"opacity"] > opacity)
				{
					opacity = splatter.var_d47f98a4[i][#"opacity"];
				}
			}
			if(blur > 0 || opacity > 0)
			{
				splatter.var_9e4cc220 = 1;
				function_a837926b(localclientnum, #"hash_73c750f53749d44d");
				function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Blur Amount", blur);
				if(isdefined(splatter.var_c03dca7e) && splatter.var_c03dca7e)
				{
					opacity = opacity * 0.05;
				}
				function_4238734d(localclientnum, #"hash_73c750f53749d44d", "Opacity", opacity);
				function_672c739(localclientnum, splatter.var_c03dca7e);
			}
			else if(isdefined(splatter.var_9e4cc220) && splatter.var_9e4cc220)
			{
				splatter.var_9e4cc220 = 0;
				codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
			}
			else
			{
				break;
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_b51756a0
	Namespace: blood
	Checksum: 0x873F049A
	Offset: 0x18D0
	Size: 0xAE
	Parameters: 3
	Flags: Linked, Private
*/
private function function_b51756a0(localclientnum, splatter, damage)
{
	if(damage > level.blood.var_de10c136.dot.var_6264f8dd)
	{
		return 1;
	}
	if(!isdefined(splatter.var_90495387))
	{
		return 1;
	}
	if(getservertime(localclientnum) - splatter.var_90495387 < level.blood.var_de10c136.dot.var_372dff4b)
	{
		return 0;
	}
	return 1;
}

/*
	Name: splatter_postfx
	Namespace: blood
	Checksum: 0x4AE7D80B
	Offset: 0x1988
	Size: 0x45C
	Parameters: 6
	Flags: Linked, Private
*/
private function splatter_postfx(localclientnum, player, damage, var_cd141ca2, death, dot)
{
	level notify(localclientnum + "splatter_postfx" + var_cd141ca2);
	level endon(localclientnum + "splatter_postfx" + var_cd141ca2);
	blur = 0;
	opacity = 0;
	var_587ce5b0 = 0;
	var_49774f1 = 0;
	hold_time = 0;
	splatter = function_d18a9e97(localclientnum);
	if(dot && !death)
	{
		splatter.var_90495387 = getservertime(localclientnum);
		blur = level.blood.var_de10c136.dot.blur;
		opacity = level.blood.var_de10c136.dot.opacity;
		var_587ce5b0 = level.blood.var_de10c136.dot.var_587ce5b0;
		hold_time = level.blood.var_de10c136.dot.hold_time;
	}
	else if(function_b51756a0(localclientnum, splatter, damage))
	{
		for(i = level.blood.var_de10c136.var_58f1f80e - 1; i >= 0; i--)
		{
			if(damage > level.blood.var_de10c136.range[i].start || (level.blood.scriptbundle.var_3e1e9389 - 1 == i && death))
			{
				blur = level.blood.var_de10c136.range[i].blur;
				opacity = level.blood.var_de10c136.range[i].opacity;
				var_587ce5b0 = level.blood.var_de10c136.var_587ce5b0[i];
				var_49774f1 = level.blood.var_de10c136.var_49774f1[i];
				hold_time = level.blood.var_de10c136.hold_time[i];
				break;
			}
		}
	}
	if(isdefined(level.var_7db2b064) && [[level.var_7db2b064]](localclientnum, player, damage))
	{
		blur = 0;
		opacity = 0;
		var_587ce5b0 = 0;
		var_49774f1 = 0;
		hold_time = 0;
	}
	level thread rampvalue(localclientnum, 0, opacity, var_587ce5b0, var_cd141ca2, "Opacity");
	level thread rampvalue(localclientnum, 0, blur, var_587ce5b0, var_cd141ca2, "Blur Amount");
	wait(float(var_587ce5b0) / 1000);
	wait(float(hold_time) / 1000);
	level thread rampvalue(localclientnum, opacity, 0, var_49774f1, var_cd141ca2, "Opacity");
	level thread rampvalue(localclientnum, blur, 0, var_49774f1, var_cd141ca2, "Blur Amount");
}

/*
	Name: rampvalue
	Namespace: blood
	Checksum: 0xBB9D0368
	Offset: 0x1DF0
	Size: 0xAC
	Parameters: 6
	Flags: Linked
*/
function rampvalue(localclientnum, var_2347e08e, var_991d3376, ramptime, var_cd141ca2, key)
{
	level notify(localclientnum + "rampValue" + var_cd141ca2 + key);
	level endon(localclientnum + "rampValue" + var_cd141ca2 + key);
	util::lerp_generic(localclientnum, ramptime, &function_441ef0ca, var_2347e08e, var_991d3376, var_cd141ca2, key);
}

/*
	Name: function_441ef0ca
	Namespace: blood
	Checksum: 0x6D9481C2
	Offset: 0x1EA8
	Size: 0x134
	Parameters: 8
	Flags: Linked
*/
function function_441ef0ca(currenttime, elapsedtime, localclientnum, duration, var_2347e08e, var_991d3376, var_cd141ca2, key)
{
	percent = 1;
	if(duration > 0)
	{
		percent = elapsedtime / duration;
	}
	amount = var_991d3376 * percent + var_2347e08e * 1 - percent;
	splatter = function_d18a9e97(localclientnum);
	if(amount > 0 && isdefined(splatter.var_d47f98a4[var_cd141ca2][key]) && splatter.var_d47f98a4[var_cd141ca2][key] == 0)
	{
		level notify(#"hash_518e8873ad943492");
	}
	splatter.var_d47f98a4[var_cd141ca2][key] = amount;
}

/*
	Name: player_base_health
	Namespace: blood
	Checksum: 0x7DC19567
	Offset: 0x1FE8
	Size: 0x8A
	Parameters: 0
	Flags: Linked, Private
*/
private function player_base_health()
{
	if(!self function_700ca4f5())
	{
		return 150;
	}
	basehealth = self function_3b0f0852();
	basehealth = basehealth + (isdefined(level.var_90bb9821) ? level.var_90bb9821 : 0);
	if(isdefined(self.var_ee9b8af0))
	{
		basehealth = self.var_ee9b8af0;
	}
	return basehealth;
}

/*
	Name: function_55d01d42
	Namespace: blood
	Checksum: 0x5DA76A88
	Offset: 0x2080
	Size: 0x13A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_55d01d42()
{
	/#
		assert(self function_700ca4f5());
	#/
	character_index = self getcharacterbodytype();
	fields = getcharacterfields(character_index, currentsessionmode());
	if(isdefined(fields) && (isdefined(fields.digitalblood) ? fields.digitalblood : 0))
	{
		self.var_957f4b6b = #"hash_21152915158b09dd";
		self.var_36732900 = "rob_wound_blood_splatter_reaper";
	}
	else if(util::is_mature())
	{
		self.var_957f4b6b = #"hash_263a0659c7ff81ad";
		self.var_36732900 = "rob_wound_blood_splatter";
	}
	else
	{
		self.var_957f4b6b = #"hash_44dcb6ac5e8787e0";
		self.var_36732900 = "rob_wound_blood_splatter";
	}
}

/*
	Name: function_87544c4a
	Namespace: blood
	Checksum: 0x9366CB2A
	Offset: 0x21C8
	Size: 0x39E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_87544c4a(localclientnum)
{
	self endon(#"disconnect");
	self endon(#"death");
	self endon(#"killbloodoverlay");
	self util::function_6d0694af();
	basehealth = player_base_health();
	priorplayerhealth = renderhealthoverlayhealth(localclientnum, (isdefined(self.prop) ? 0 : basehealth));
	var_a234f6c2 = basehealth * priorplayerhealth;
	var_4cdccc55 = util::is_mature();
	self function_55d01d42();
	self thread function_8d8880(localclientnum);
	while(true)
	{
		forceupdate = 0;
		if(util::is_mature() != var_4cdccc55)
		{
			forceupdate = 1;
			self function_436ee4c2(localclientnum, #"hash_263a0659c7ff81ad");
			self function_436ee4c2(localclientnum, #"hash_44dcb6ac5e8787e0");
			var_4cdccc55 = util::is_mature();
			self function_55d01d42();
		}
		if(renderhealthoverlay(localclientnum))
		{
			basehealth = player_base_health();
			playerhealth = renderhealthoverlayhealth(localclientnum, (isdefined(self.prop) ? 0 : basehealth));
			var_406028bf = basehealth * playerhealth;
			damageamount = var_a234f6c2 - var_406028bf;
			update_damage_effects(localclientnum, damageamount, playerhealth == 0);
			shouldenabledoverlay = 0;
			if(playerhealth < 1)
			{
				shouldenabledoverlay = 1;
			}
			else if(isdefined(self.blood_enabled) && self.blood_enabled)
			{
				self function_436ee4c2(localclientnum, self.var_957f4b6b);
			}
			priorplayerhealth = playerhealth;
			var_a234f6c2 = var_406028bf;
			if(!(isdefined(self.blood_enabled) && self.blood_enabled) && shouldenabledoverlay)
			{
				self function_70299400(localclientnum);
			}
			self function_9a8dc0ec(localclientnum, var_406028bf, forceupdate);
			self function_e67f278c(localclientnum);
		}
		else if(isdefined(self.blood_enabled) && self.blood_enabled)
		{
			self function_436ee4c2(localclientnum, self.var_957f4b6b);
		}
		waitframe(1);
	}
}

/*
	Name: function_8d8880
	Namespace: blood
	Checksum: 0x951AD627
	Offset: 0x2570
	Size: 0x23C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8d8880(localclientnum)
{
	self endon(#"disconnect");
	self endon(#"death");
	self endon(#"killbloodoverlay");
	if(!level.blood.var_f5479429)
	{
		return;
	}
	while(true)
	{
		waitframe(1);
		if(isdefined(self.blood_enabled) && self.blood_enabled)
		{
			for(pulse = 0; pulse < 2; pulse++)
			{
				self notify(#"hash_7b55313d89ce26ed");
				self thread function_c0cdd1f2(localclientnum, 0, 1, level.blood.var_f2de135e.var_562c41de[pulse], #"hash_152dbb4add22b951", self.var_957f4b6b);
				wait(float(level.blood.var_f2de135e.var_562c41de[pulse]) / 1000);
				wait(float(level.blood.var_f2de135e.var_18f673f1[pulse]) / 1000);
				self thread function_c0cdd1f2(localclientnum, 1, 0, level.blood.var_f2de135e.var_92fc0d45[pulse], #"hash_152dbb4add22b951", self.var_957f4b6b);
				wait(float(level.blood.var_f2de135e.var_92fc0d45[pulse]) / 1000);
				wait(float(level.blood.var_f2de135e.var_5b5500f7[pulse]) / 1000);
			}
		}
	}
}

/*
	Name: function_493a8fbc
	Namespace: blood
	Checksum: 0x3B572832
	Offset: 0x27B8
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
private function function_493a8fbc(localclientnum)
{
	self waittill(#"death");
	self function_436ee4c2(localclientnum, self.var_957f4b6b);
}

/*
	Name: function_1cf17bbc
	Namespace: blood
	Checksum: 0x7B5FB020
	Offset: 0x2808
	Size: 0x6E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_1cf17bbc(localclientnum, new_blood_stage, prior_blood_stage)
{
	if(new_blood_stage >= level.blood.var_14a2badb.stage)
	{
		self.var_28fdff3c = 1;
	}
	else
	{
		self.var_28fdff3c = 0;
	}
	self.var_dff3bb2c = self.var_28fdff3c;
}

/*
	Name: function_e91b92e2
	Namespace: blood
	Checksum: 0x566227A2
	Offset: 0x2880
	Size: 0x1BE
	Parameters: 3
	Flags: Linked, Private
*/
private function function_e91b92e2(localclientnum, new_blood_stage, prior_blood_stage)
{
	if(new_blood_stage == 4)
	{
		self.var_9861062 = 1;
		self enter_critical_health(localclientnum);
		if(isdefined(self.blood_enabled) && self.blood_enabled)
		{
			self function_116b95e5(self.var_957f4b6b, #"hash_152dbb4add22b951", 1);
		}
		if(isdefined(level.blood.scriptbundle.pulse_loop))
		{
			level.blood.var_9af02310 = function_604c9983(localclientnum, level.blood.scriptbundle.pulse_loop);
		}
	}
	else if(self.var_9861062)
	{
		if(isdefined(level.blood.var_9af02310))
		{
			function_d48752e(localclientnum, level.blood.var_9af02310);
			level.blood.var_9af02310 = undefined;
		}
		self.var_9861062 = 0;
		if(isdefined(self.blood_enabled) && self.blood_enabled)
		{
			self function_116b95e5(self.var_957f4b6b, #"hash_152dbb4add22b951", 0);
		}
	}
	if(new_blood_stage < 4)
	{
		self notify(#"critical_health_end");
	}
}

/*
	Name: function_56419db8
	Namespace: blood
	Checksum: 0x7DEE7657
	Offset: 0x2A48
	Size: 0x140
	Parameters: 1
	Flags: Linked, Private
*/
private function function_56419db8(stage)
{
	for(pulse = 0; pulse < 2; pulse++)
	{
		level.blood.var_f2de135e.var_562c41de[pulse] = level.blood.var_f2de135e.var_621835b4[pulse][stage];
		level.blood.var_f2de135e.var_18f673f1[pulse] = level.blood.var_f2de135e.var_a79aba98[pulse][stage];
		level.blood.var_f2de135e.var_92fc0d45[pulse] = level.blood.var_f2de135e.time_out[pulse][stage];
		level.blood.var_f2de135e.var_5b5500f7[pulse] = level.blood.var_f2de135e.var_97aa6fd2[pulse][stage];
	}
}

/*
	Name: play_new_stage_rumble
	Namespace: blood
	Checksum: 0x702332F1
	Offset: 0x2B90
	Size: 0x7E
	Parameters: 1
	Flags: Linked, Private
*/
private function play_new_stage_rumble(localclientnum)
{
	self endon(#"death", #"disconnect");
	for(i = 0; i < 2; i++)
	{
		self playrumbleonentity(localclientnum, "new_health_stage");
		wait(0.4);
	}
}

/*
	Name: function_5a719e5
	Namespace: blood
	Checksum: 0xEAE075F2
	Offset: 0x2C18
	Size: 0x4C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_5a719e5(localclientnum, new_blood_stage, prior_blood_stage)
{
	if(new_blood_stage > 0)
	{
		if(new_blood_stage > prior_blood_stage)
		{
			self thread play_new_stage_rumble(localclientnum);
		}
	}
}

/*
	Name: function_9a8dc0ec
	Namespace: blood
	Checksum: 0xF3ED631
	Offset: 0x2C70
	Size: 0x4EA
	Parameters: 3
	Flags: Linked, Private
*/
private function function_9a8dc0ec(localclientnum, playerhealth, forceupdate)
{
	if(!isdefined(self.last_blood_stage))
	{
		self.last_blood_stage = 0;
	}
	var_89524e53 = level.blood.threshold[1];
	stage2_threshold = level.blood.threshold[2];
	stage3_threshold = level.blood.threshold[3];
	stage4_threshold = level.blood.threshold[4];
	prior_blood_stage = self.last_blood_stage;
	new_blood_stage = 0;
	if(!(isdefined(self.nobloodoverlay) && self.nobloodoverlay))
	{
		if(playerhealth <= var_89524e53 && playerhealth > 0)
		{
			if(playerhealth <= stage3_threshold)
			{
				new_blood_stage = (playerhealth <= stage4_threshold ? 4 : 3);
			}
			else
			{
				new_blood_stage = (playerhealth <= stage2_threshold ? 2 : 1);
			}
		}
	}
	if(new_blood_stage != prior_blood_stage || forceupdate)
	{
		ramptime = (prior_blood_stage > new_blood_stage ? level.blood.var_49774f1 : level.blood.var_587ce5b0);
		self thread function_c0cdd1f2(localclientnum, level.blood.fade[prior_blood_stage], level.blood.fade[new_blood_stage], ramptime, #"fade", self.var_957f4b6b);
		self thread function_c0cdd1f2(localclientnum, level.blood.opacity[prior_blood_stage], level.blood.opacity[new_blood_stage], ramptime, #"opacity", self.var_957f4b6b);
		self thread function_c0cdd1f2(localclientnum, level.blood.var_4c8629ad[prior_blood_stage], level.blood.var_4c8629ad[new_blood_stage], ramptime, #"hash_4719d5a85c54db22", self.var_957f4b6b);
		self thread function_c0cdd1f2(localclientnum, level.blood.var_ea220db3[prior_blood_stage], level.blood.var_ea220db3[new_blood_stage], ramptime, #"hash_703cc9e25857079", self.var_957f4b6b);
		self thread function_c0cdd1f2(localclientnum, level.blood.blur[prior_blood_stage], level.blood.blur[new_blood_stage], ramptime, #"blur", self.var_957f4b6b);
		if(level.blood.var_e9d8aaf5)
		{
			self thread function_c0cdd1f2(localclientnum, level.blood.var_c0dfc7ef[prior_blood_stage], level.blood.var_c0dfc7ef[new_blood_stage], ramptime, #"hash_20907a894d572d2a", self.var_957f4b6b);
		}
		if(isdefined(self.blood_enabled) && self.blood_enabled)
		{
			self function_116b95e5(self.var_957f4b6b, #"hash_3886e6a5c0c3df4c", level.blood.var_d3813c3a[new_blood_stage]);
		}
		self function_56419db8(new_blood_stage);
		self function_5a719e5(localclientnum, new_blood_stage, prior_blood_stage);
		self function_1cf17bbc(localclientnum, new_blood_stage, prior_blood_stage);
		self function_e91b92e2(localclientnum, new_blood_stage, prior_blood_stage);
	}
	self.last_blood_stage = new_blood_stage;
}

/*
	Name: function_c0cdd1f2
	Namespace: blood
	Checksum: 0x9FEA6990
	Offset: 0x3168
	Size: 0xC4
	Parameters: 6
	Flags: Linked
*/
function function_c0cdd1f2(localclientnum, var_2347e08e, var_991d3376, ramptime, key, postfx)
{
	self endon(#"death");
	self endon(#"hash_6d50f64fe99aed76");
	self notify("rampPostFx" + key + postfx);
	self endon("rampPostFx" + key + postfx);
	util::lerp_generic(localclientnum, ramptime, &function_b0298a0, var_2347e08e, var_991d3376, key, postfx);
}

/*
	Name: function_b0298a0
	Namespace: blood
	Checksum: 0x3B52704E
	Offset: 0x3238
	Size: 0xBC
	Parameters: 8
	Flags: Linked
*/
function function_b0298a0(currenttime, elapsedtime, localclientnum, duration, var_2347e08e, var_991d3376, key, postfx)
{
	percent = elapsedtime / duration;
	amount = var_991d3376 * percent + var_2347e08e * 1 - percent;
	if(isdefined(self.blood_enabled) && self.blood_enabled)
	{
		self function_116b95e5(postfx, key, amount);
	}
}

/*
	Name: function_70299400
	Namespace: blood
	Checksum: 0xBA6E6118
	Offset: 0x3300
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_70299400(localclientnum)
{
	if(level.var_4ecf5754 === #"hash_65cfe78dc61dd3af")
	{
		return;
	}
	self.blood_enabled = 1;
	if(isdefined(self.blood_enabled) && self.blood_enabled)
	{
		self codeplaypostfxbundle(self.var_957f4b6b);
	}
}

/*
	Name: function_436ee4c2
	Namespace: blood
	Checksum: 0x68D5EC15
	Offset: 0x3378
	Size: 0x1AC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_436ee4c2(localclientnum, var_957f4b6b)
{
	self notify(#"hash_6d50f64fe99aed76");
	if(isdefined(self))
	{
		if(self function_d2cb869e(var_957f4b6b))
		{
			self codestoppostfxbundle(var_957f4b6b);
		}
		if(self function_d2cb869e(#"hash_73c750f53749d44d"))
		{
			self codestoppostfxbundle(#"hash_73c750f53749d44d");
		}
		self.blood_enabled = 0;
	}
	else if(function_148ccc79(localclientnum, var_957f4b6b))
	{
		codestoppostfxbundlelocal(localclientnum, var_957f4b6b);
	}
	if(function_148ccc79(localclientnum, #"hash_73c750f53749d44d"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_73c750f53749d44d");
	}
	if(!isdefined(self) || (!(isdefined(self.nobloodlightbarchange) && self.nobloodlightbarchange)))
	{
		if(isdefined(level.controllercolor) && isdefined(level.controllercolor[localclientnum]))
		{
			setcontrollerlightbarcolor(localclientnum, level.controllercolor[localclientnum]);
		}
		else
		{
			setcontrollerlightbarcolor(localclientnum);
		}
	}
}

/*
	Name: function_dd830dee
	Namespace: blood
	Checksum: 0x203FDA68
	Offset: 0x3530
	Size: 0x172A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_dd830dee()
{
	level.blood = spawnstruct();
	level.blood.scriptbundle = (getgametypesetting(#"hardcoremode") ? getscriptbundle("hardcore_blood_settings") : getscriptbundle("blood_settings"));
	if(function_f99d2668())
	{
		level.blood.scriptbundle = getscriptbundle("wz_blood_settings");
	}
	/#
		assert(isdefined(level.blood.scriptbundle));
	#/
	if(!isdefined(level.blood.var_e9d8aaf5))
	{
		level.blood.var_e9d8aaf5 = (isdefined(level.blood.scriptbundle.var_e9d8aaf5) ? level.blood.scriptbundle.var_e9d8aaf5 : 0);
	}
	level.blood.var_c0dfc7ef = [];
	if(!isdefined(level.blood.var_c0dfc7ef[0]))
	{
		level.blood.var_c0dfc7ef[0] = (isdefined(level.blood.scriptbundle.var_9e65e691) ? level.blood.scriptbundle.var_9e65e691 : 0);
	}
	if(!isdefined(level.blood.var_c0dfc7ef[1]))
	{
		level.blood.var_c0dfc7ef[1] = (isdefined(level.blood.scriptbundle.var_49ddbdf6) ? level.blood.scriptbundle.var_49ddbdf6 : 0);
	}
	if(!isdefined(level.blood.var_c0dfc7ef[2]))
	{
		level.blood.var_c0dfc7ef[2] = (isdefined(level.blood.scriptbundle.var_83022fca) ? level.blood.scriptbundle.var_83022fca : 0);
	}
	if(!isdefined(level.blood.var_c0dfc7ef[3]))
	{
		level.blood.var_c0dfc7ef[3] = (isdefined(level.blood.scriptbundle.var_90b9cb39) ? level.blood.scriptbundle.var_90b9cb39 : 0);
	}
	if(!isdefined(level.blood.var_c0dfc7ef[4]))
	{
		level.blood.var_c0dfc7ef[4] = (isdefined(level.blood.scriptbundle.var_e790f8e6) ? level.blood.scriptbundle.var_e790f8e6 : 0);
	}
	level.blood.var_d3813c3a = [];
	if(!isdefined(level.blood.var_d3813c3a[0]))
	{
		level.blood.var_d3813c3a[0] = (isdefined(level.blood.scriptbundle.var_fd86eebc) ? level.blood.scriptbundle.var_fd86eebc : 0);
	}
	if(!isdefined(level.blood.var_d3813c3a[1]))
	{
		level.blood.var_d3813c3a[1] = (isdefined(level.blood.scriptbundle.var_e741c232) ? level.blood.scriptbundle.var_e741c232 : 0);
	}
	if(!isdefined(level.blood.var_d3813c3a[2]))
	{
		level.blood.var_d3813c3a[2] = (isdefined(level.blood.scriptbundle.var_e11b35e5) ? level.blood.scriptbundle.var_e11b35e5 : 0);
	}
	if(!isdefined(level.blood.var_d3813c3a[3]))
	{
		level.blood.var_d3813c3a[3] = (isdefined(level.blood.scriptbundle.var_cadf096d) ? level.blood.scriptbundle.var_cadf096d : 0);
	}
	if(!isdefined(level.blood.var_d3813c3a[4]))
	{
		level.blood.var_d3813c3a[4] = (isdefined(level.blood.scriptbundle.var_c3ad7b0a) ? level.blood.scriptbundle.var_c3ad7b0a : 0);
	}
	level.blood.blur = [];
	if(!isdefined(level.blood.blur[0]))
	{
		level.blood.blur[0] = (isdefined(level.blood.scriptbundle.var_d4e546df) ? level.blood.scriptbundle.var_d4e546df : 0);
	}
	if(!isdefined(level.blood.blur[1]))
	{
		level.blood.blur[1] = (isdefined(level.blood.scriptbundle.var_e6a76a63) ? level.blood.scriptbundle.var_e6a76a63 : 0);
	}
	if(!isdefined(level.blood.blur[2]))
	{
		level.blood.blur[2] = (isdefined(level.blood.scriptbundle.var_b9320f69) ? level.blood.scriptbundle.var_b9320f69 : 0);
	}
	if(!isdefined(level.blood.blur[3]))
	{
		level.blood.blur[3] = (isdefined(level.blood.scriptbundle.var_9af9d2f9) ? level.blood.scriptbundle.var_9af9d2f9 : 0);
	}
	if(!isdefined(level.blood.blur[4]))
	{
		level.blood.blur[4] = (isdefined(level.blood.scriptbundle.var_acaf7664) ? level.blood.scriptbundle.var_acaf7664 : 0);
	}
	level.blood.opacity = [];
	if(!isdefined(level.blood.opacity[0]))
	{
		level.blood.opacity[0] = (isdefined(level.blood.scriptbundle.var_a05e6a18) ? level.blood.scriptbundle.var_a05e6a18 : 0);
	}
	if(!isdefined(level.blood.opacity[1]))
	{
		level.blood.opacity[1] = (isdefined(level.blood.scriptbundle.var_920ccd75) ? level.blood.scriptbundle.var_920ccd75 : 0);
	}
	if(!isdefined(level.blood.opacity[2]))
	{
		level.blood.opacity[2] = (isdefined(level.blood.scriptbundle.var_54f2533d) ? level.blood.scriptbundle.var_54f2533d : 0);
	}
	if(!isdefined(level.blood.opacity[3]))
	{
		level.blood.opacity[3] = (isdefined(level.blood.scriptbundle.var_467fb658) ? level.blood.scriptbundle.var_467fb658 : 0);
	}
	if(!isdefined(level.blood.opacity[4]))
	{
		level.blood.opacity[4] = (isdefined(level.blood.scriptbundle.var_ed5b8411) ? level.blood.scriptbundle.var_ed5b8411 : 0);
	}
	level.blood.threshold = [];
	if(!isdefined(level.blood.threshold[0]))
	{
		level.blood.threshold[0] = (isdefined(level.blood.scriptbundle.var_4e06fd93) ? level.blood.scriptbundle.var_4e06fd93 : 0);
	}
	if(!isdefined(level.blood.threshold[1]))
	{
		level.blood.threshold[1] = (isdefined(level.blood.scriptbundle.var_3bc4590e) ? level.blood.scriptbundle.var_3bc4590e : 0);
	}
	if(!isdefined(level.blood.threshold[2]))
	{
		level.blood.threshold[2] = (isdefined(level.blood.scriptbundle.var_bc1cd9c5) ? level.blood.scriptbundle.var_bc1cd9c5 : 0);
	}
	if(!isdefined(level.blood.threshold[3]))
	{
		level.blood.threshold[3] = (isdefined(level.blood.scriptbundle.var_91558437) ? level.blood.scriptbundle.var_91558437 : 0);
	}
	if(!isdefined(level.blood.threshold[4]))
	{
		level.blood.threshold[4] = (isdefined(level.blood.scriptbundle.var_7f6fe064) ? level.blood.scriptbundle.var_7f6fe064 : 0);
	}
	level.blood.fade = [];
	if(!isdefined(level.blood.fade[0]))
	{
		level.blood.fade[0] = (isdefined(level.blood.scriptbundle.var_5eab69fa) ? level.blood.scriptbundle.var_5eab69fa : 0);
	}
	if(!isdefined(level.blood.fade[1]))
	{
		level.blood.fade[1] = (isdefined(level.blood.scriptbundle.var_83dbb45a) ? level.blood.scriptbundle.var_83dbb45a : 0);
	}
	if(!isdefined(level.blood.fade[2]))
	{
		level.blood.fade[2] = (isdefined(level.blood.scriptbundle.var_720a10b7) ? level.blood.scriptbundle.var_720a10b7 : 0);
	}
	if(!isdefined(level.blood.fade[3]))
	{
		level.blood.fade[3] = (isdefined(level.blood.scriptbundle.var_f1f39088) ? level.blood.scriptbundle.var_f1f39088 : 0);
	}
	if(!isdefined(level.blood.fade[4]))
	{
		level.blood.fade[4] = (isdefined(level.blood.scriptbundle.var_2945ff2c) ? level.blood.scriptbundle.var_2945ff2c : 0);
	}
	level.blood.var_4c8629ad = [];
	if(!isdefined(level.blood.var_4c8629ad[0]))
	{
		level.blood.var_4c8629ad[0] = (isdefined(level.blood.scriptbundle.var_43305756) ? level.blood.scriptbundle.var_43305756 : 0);
	}
	if(!isdefined(level.blood.var_4c8629ad[1]))
	{
		level.blood.var_4c8629ad[1] = (isdefined(level.blood.scriptbundle.var_517af3eb) ? level.blood.scriptbundle.var_517af3eb : 0);
	}
	if(!isdefined(level.blood.var_4c8629ad[2]))
	{
		level.blood.var_4c8629ad[2] = (isdefined(level.blood.scriptbundle.var_6ec52e7f) ? level.blood.scriptbundle.var_6ec52e7f : 0);
	}
	if(!isdefined(level.blood.var_4c8629ad[3]))
	{
		level.blood.var_4c8629ad[3] = (isdefined(level.blood.scriptbundle.var_7cfacaea) ? level.blood.scriptbundle.var_7cfacaea : 0);
	}
	if(!isdefined(level.blood.var_4c8629ad[4]))
	{
		level.blood.var_4c8629ad[4] = (isdefined(level.blood.scriptbundle.var_fd0b4b01) ? level.blood.scriptbundle.var_fd0b4b01 : 0);
	}
	level.blood.var_ea220db3 = [];
	if(!isdefined(level.blood.var_ea220db3[0]))
	{
		level.blood.var_ea220db3[0] = (isdefined(level.blood.scriptbundle.var_79c59717) ? level.blood.scriptbundle.var_79c59717 : 0);
	}
	if(!isdefined(level.blood.var_ea220db3[1]))
	{
		level.blood.var_ea220db3[1] = (isdefined(level.blood.scriptbundle.var_a403eb93) ? level.blood.scriptbundle.var_a403eb93 : 0);
	}
	if(!isdefined(level.blood.var_ea220db3[2]))
	{
		level.blood.var_ea220db3[2] = (isdefined(level.blood.scriptbundle.var_95514e2e) ? level.blood.scriptbundle.var_95514e2e : 0);
	}
	if(!isdefined(level.blood.var_ea220db3[3]))
	{
		level.blood.var_ea220db3[3] = (isdefined(level.blood.scriptbundle.var_bf94a2b4) ? level.blood.scriptbundle.var_bf94a2b4 : 0);
	}
	if(!isdefined(level.blood.var_ea220db3[4]))
	{
		level.blood.var_ea220db3[4] = (isdefined(level.blood.scriptbundle.var_3fe4235d) ? level.blood.scriptbundle.var_3fe4235d : 0);
	}
	function_f50652a9();
	function_b0e51f43();
	level.blood.var_14a2badb = spawnstruct();
	if(!isdefined(level.blood.var_14a2badb.stage))
	{
		level.blood.var_14a2badb.stage = (isdefined(level.blood.scriptbundle.var_5e7ac43f) ? level.blood.scriptbundle.var_5e7ac43f : 0);
	}
	if(!isdefined(level.blood.var_14a2badb.hold_time))
	{
		level.blood.var_14a2badb.hold_time = (isdefined(level.blood.scriptbundle.var_ae06158b) ? level.blood.scriptbundle.var_ae06158b : 0);
	}
	if(!isdefined(level.blood.var_14a2badb.fade_time))
	{
		level.blood.var_14a2badb.fade_time = (isdefined(level.blood.scriptbundle.var_356550c9) ? level.blood.scriptbundle.var_356550c9 : 0);
	}
	if(!isdefined(level.blood.var_14a2badb.damage_threshold))
	{
		level.blood.var_14a2badb.damage_threshold = (isdefined(level.blood.scriptbundle.var_8635c7a1) ? level.blood.scriptbundle.var_8635c7a1 : 0);
	}
	if(!isdefined(level.blood.var_f5479429))
	{
		level.blood.var_f5479429 = (isdefined(level.blood.scriptbundle.var_f5479429) ? level.blood.scriptbundle.var_f5479429 : 0);
	}
	level.blood.var_587ce5b0 = level.blood.scriptbundle.var_587ce5b0;
	level.blood.var_49774f1 = level.blood.scriptbundle.var_49774f1;
	if(!isdefined(level.blood.var_f5479429))
	{
		level.blood.var_f5479429 = (isdefined(level.blood.scriptbundle.var_f5479429) ? level.blood.scriptbundle.var_f5479429 : 0);
	}
}

/*
	Name: function_162fe6ec
	Namespace: blood
	Checksum: 0x171E7A0
	Offset: 0x4C68
	Size: 0x9E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_162fe6ec(localclientnum)
{
	splatter = spawnstruct();
	splatter.var_d47f98a4 = [];
	for(j = 0; j < 4; j++)
	{
		splatter.var_d47f98a4[j] = [];
	}
	splatter.var_120a7b2c = 0;
	level.blood.var_de10c136.var_51036e02[localclientnum] = splatter;
}

/*
	Name: function_b0e51f43
	Namespace: blood
	Checksum: 0x41FCB9AE
	Offset: 0x4D10
	Size: 0xB62
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b0e51f43()
{
	level.blood.var_de10c136 = spawnstruct();
	level.blood.var_de10c136.var_ff95fcfe = [];
	for(i = 0; i < getmaxlocalclients(); i++)
	{
		function_162fe6ec(i);
	}
	if(!isdefined(level.blood.var_de10c136.enabled))
	{
		level.blood.var_de10c136.enabled = (isdefined(level.blood.scriptbundle.var_f70c3e8d) ? level.blood.scriptbundle.var_f70c3e8d : 0);
	}
	if(!isdefined(level.blood.var_de10c136.var_58f1f80e))
	{
		level.blood.var_de10c136.var_58f1f80e = (isdefined(level.blood.scriptbundle.var_58f1f80e) ? level.blood.scriptbundle.var_58f1f80e : 1);
	}
	if(!isdefined(level.blood.var_de10c136.var_3e1e9389))
	{
		level.blood.var_de10c136.var_3e1e9389 = (isdefined(level.blood.scriptbundle.var_3e1e9389) ? level.blood.scriptbundle.var_3e1e9389 : 1);
	}
	level.blood.var_de10c136.range = [];
	level.blood.var_de10c136.var_587ce5b0 = [];
	level.blood.var_de10c136.var_49774f1 = [];
	level.blood.var_de10c136.hold_time = [];
	for(i = 0; i < level.blood.var_de10c136.var_58f1f80e; i++)
	{
		level.blood.var_de10c136.range[i] = spawnstruct();
		if(i > 0)
		{
			if(!isdefined(level.blood.var_de10c136.range[i].start))
			{
				level.blood.var_de10c136.range[i].start = (isdefined(level.blood.scriptbundle.("damage_range_start_" + i)) ? level.blood.scriptbundle.("damage_range_start_" + i) : level.blood.var_de10c136.range[i - 1].start);
			}
		}
		else if(!isdefined(level.blood.var_de10c136.range[i].start))
		{
			level.blood.var_de10c136.range[i].start = (isdefined(level.blood.scriptbundle.("damage_range_start_" + i)) ? level.blood.scriptbundle.("damage_range_start_" + i) : 0);
		}
		if(!isdefined(level.blood.var_de10c136.range[i].blur))
		{
			level.blood.var_de10c136.range[i].blur = (isdefined(level.blood.scriptbundle.("damage_range_blur_" + i)) ? level.blood.scriptbundle.("damage_range_blur_" + i) : 0);
		}
		if(!isdefined(level.blood.var_de10c136.range[i].opacity))
		{
			level.blood.var_de10c136.range[i].opacity = (isdefined(level.blood.scriptbundle.("damage_range_opacity_" + i)) ? level.blood.scriptbundle.("damage_range_opacity_" + i) : 0);
		}
		if(!isdefined(level.blood.var_de10c136.var_587ce5b0[i]))
		{
			level.blood.var_de10c136.var_587ce5b0[i] = (isdefined(level.blood.scriptbundle.("hit_flash_ramp_in_time_" + i)) ? level.blood.scriptbundle.("hit_flash_ramp_in_time_" + i) : 0);
		}
		if(!isdefined(level.blood.var_de10c136.var_49774f1[i]))
		{
			level.blood.var_de10c136.var_49774f1[i] = (isdefined(level.blood.scriptbundle.("hit_flash_ramp_out_time_" + i)) ? level.blood.scriptbundle.("hit_flash_ramp_out_time_" + i) : 0);
		}
		if(!isdefined(level.blood.var_de10c136.hold_time[i]))
		{
			level.blood.var_de10c136.hold_time[i] = (isdefined(level.blood.scriptbundle.("hit_flash_hold_time_" + i)) ? level.blood.scriptbundle.("hit_flash_hold_time_" + i) : 0);
		}
	}
	level.blood.var_de10c136.dot = spawnstruct();
	if(!isdefined(level.blood.var_de10c136.dot.blur))
	{
		level.blood.var_de10c136.dot.blur = (isdefined(level.blood.scriptbundle.("dot_blur")) ? level.blood.scriptbundle.("dot_blur") : 0);
	}
	if(!isdefined(level.blood.var_de10c136.dot.opacity))
	{
		level.blood.var_de10c136.dot.opacity = (isdefined(level.blood.scriptbundle.("dot_opacity")) ? level.blood.scriptbundle.("dot_opacity") : 0);
	}
	if(!isdefined(level.blood.var_de10c136.dot.var_587ce5b0))
	{
		level.blood.var_de10c136.dot.var_587ce5b0 = (isdefined(level.blood.scriptbundle.("dot_hit_flash_ramp_in_time")) ? level.blood.scriptbundle.("dot_hit_flash_ramp_in_time") : 0);
	}
	if(!isdefined(level.blood.var_de10c136.dot.var_49774f1))
	{
		level.blood.var_de10c136.dot.var_49774f1 = (isdefined(level.blood.scriptbundle.("dot_hit_flash_ramp_out_time")) ? level.blood.scriptbundle.("dot_hit_flash_ramp_out_time") : 0);
	}
	if(!isdefined(level.blood.var_de10c136.dot.hold_time))
	{
		level.blood.var_de10c136.dot.hold_time = (isdefined(level.blood.scriptbundle.("dot_hit_flash_hold_time")) ? level.blood.scriptbundle.("dot_hit_flash_hold_time") : 0);
	}
	if(!isdefined(level.blood.var_de10c136.dot.var_6264f8dd))
	{
		level.blood.var_de10c136.dot.var_6264f8dd = (isdefined(level.blood.scriptbundle.("dot_ignore_damage_threshold")) ? level.blood.scriptbundle.("dot_ignore_damage_threshold") : 0);
	}
	if(!isdefined(level.blood.var_de10c136.dot.var_372dff4b))
	{
		level.blood.var_de10c136.dot.var_372dff4b = (isdefined(level.blood.scriptbundle.("dot_ignore_damage_time")) ? level.blood.scriptbundle.("dot_ignore_damage_time") : 0);
	}
}

/*
	Name: function_f50652a9
	Namespace: blood
	Checksum: 0x17D898CA
	Offset: 0x5880
	Size: 0x1BA2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f50652a9()
{
	level.blood.var_f2de135e = spawnstruct();
	level.blood.var_f2de135e.var_621835b4 = [];
	level.blood.var_f2de135e.var_a79aba98 = [];
	level.blood.var_f2de135e.time_out = [];
	level.blood.var_f2de135e.var_97aa6fd2 = [];
	level.blood.var_f2de135e.var_562c41de = [];
	level.blood.var_f2de135e.var_18f673f1 = [];
	level.blood.var_f2de135e.var_92fc0d45 = [];
	level.blood.var_f2de135e.var_5b5500f7 = [];
	level.blood.var_f2de135e.var_621835b4[0] = [];
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[0][0]))
	{
		level.blood.var_f2de135e.var_621835b4[0][0] = (isdefined(level.blood.scriptbundle.var_b3272558) ? level.blood.scriptbundle.var_b3272558 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[0][1]))
	{
		level.blood.var_f2de135e.var_621835b4[0][1] = (isdefined(level.blood.scriptbundle.var_d014df1f) ? level.blood.scriptbundle.var_d014df1f : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[0][2]))
	{
		level.blood.var_f2de135e.var_621835b4[0][2] = (isdefined(level.blood.scriptbundle.var_bdca3a8a) ? level.blood.scriptbundle.var_bdca3a8a : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[0][3]))
	{
		level.blood.var_f2de135e.var_621835b4[0][3] = (isdefined(level.blood.scriptbundle.var_ab891608) ? level.blood.scriptbundle.var_ab891608 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[0][4]))
	{
		level.blood.var_f2de135e.var_621835b4[0][4] = (isdefined(level.blood.scriptbundle.var_996371bd) ? level.blood.scriptbundle.var_996371bd : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_562c41de[0]))
	{
		level.blood.var_f2de135e.var_562c41de[0] = level.blood.var_f2de135e.var_621835b4[0][0];
	}
	level.blood.var_f2de135e.var_621835b4[1] = [];
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[1][0]))
	{
		level.blood.var_f2de135e.var_621835b4[1][0] = (isdefined(level.blood.scriptbundle.var_8623b2d2) ? level.blood.scriptbundle.var_8623b2d2 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[1][1]))
	{
		level.blood.var_f2de135e.var_621835b4[1][1] = (isdefined(level.blood.scriptbundle.var_7862174f) ? level.blood.scriptbundle.var_7862174f : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[1][2]))
	{
		level.blood.var_f2de135e.var_621835b4[1][2] = (isdefined(level.blood.scriptbundle.var_d2b4cbf3) ? level.blood.scriptbundle.var_d2b4cbf3 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[1][3]))
	{
		level.blood.var_f2de135e.var_621835b4[1][3] = (isdefined(level.blood.scriptbundle.var_bcf6a077) ? level.blood.scriptbundle.var_bcf6a077 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_621835b4[1][4]))
	{
		level.blood.var_f2de135e.var_621835b4[1][4] = (isdefined(level.blood.scriptbundle.var_af1f04c8) ? level.blood.scriptbundle.var_af1f04c8 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_562c41de[1]))
	{
		level.blood.var_f2de135e.var_562c41de[1] = level.blood.var_f2de135e.var_621835b4[1][0];
	}
	level.blood.var_f2de135e.var_a79aba98[0] = [];
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[0][0]))
	{
		level.blood.var_f2de135e.var_a79aba98[0][0] = (isdefined(level.blood.scriptbundle.var_a647a17d) ? level.blood.scriptbundle.var_a647a17d : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[0][1]))
	{
		level.blood.var_f2de135e.var_a79aba98[0][1] = (isdefined(level.blood.scriptbundle.var_2fc5ae5) ? level.blood.scriptbundle.var_2fc5ae5 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[0][2]))
	{
		level.blood.var_f2de135e.var_a79aba98[0][2] = (isdefined(level.blood.scriptbundle.var_10be7669) ? level.blood.scriptbundle.var_10be7669 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[0][3]))
	{
		level.blood.var_f2de135e.var_a79aba98[0][3] = (isdefined(level.blood.scriptbundle.var_9147f772) ? level.blood.scriptbundle.var_9147f772 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[0][4]))
	{
		level.blood.var_f2de135e.var_a79aba98[0][4] = (isdefined(level.blood.scriptbundle.var_5f8a13f7) ? level.blood.scriptbundle.var_5f8a13f7 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_18f673f1[0]))
	{
		level.blood.var_f2de135e.var_18f673f1[0] = level.blood.var_f2de135e.var_a79aba98[0][0];
	}
	level.blood.var_f2de135e.var_a79aba98[1] = [];
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[1][0]))
	{
		level.blood.var_f2de135e.var_a79aba98[1][0] = (isdefined(level.blood.scriptbundle.var_96868f33) ? level.blood.scriptbundle.var_96868f33 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[1][1]))
	{
		level.blood.var_f2de135e.var_a79aba98[1][1] = (isdefined(level.blood.scriptbundle.var_16780f18) ? level.blood.scriptbundle.var_16780f18 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[1][2]))
	{
		level.blood.var_f2de135e.var_a79aba98[1][2] = (isdefined(level.blood.scriptbundle.var_48c373ae) ? level.blood.scriptbundle.var_48c373ae : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[1][3]))
	{
		level.blood.var_f2de135e.var_a79aba98[1][3] = (isdefined(level.blood.scriptbundle.var_38fed425) ? level.blood.scriptbundle.var_38fed425 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_a79aba98[1][4]))
	{
		level.blood.var_f2de135e.var_a79aba98[1][4] = (isdefined(level.blood.scriptbundle.var_6b3d38a1) ? level.blood.scriptbundle.var_6b3d38a1 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_18f673f1[1]))
	{
		level.blood.var_f2de135e.var_18f673f1[1] = level.blood.var_f2de135e.var_a79aba98[1][0];
	}
	level.blood.var_f2de135e.time_out[0] = [];
	if(!isdefined(level.blood.var_f2de135e.time_out[0][0]))
	{
		level.blood.var_f2de135e.time_out[0][0] = (isdefined(level.blood.scriptbundle.var_54f5763f) ? level.blood.scriptbundle.var_54f5763f : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[0][1]))
	{
		level.blood.var_f2de135e.time_out[0][1] = (isdefined(level.blood.scriptbundle.var_7cedbf3) ? level.blood.scriptbundle.var_7cedbf3 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[0][2]))
	{
		level.blood.var_f2de135e.time_out[0][2] = (isdefined(level.blood.scriptbundle.var_3959bf08) ? level.blood.scriptbundle.var_3959bf08 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[0][3]))
	{
		level.blood.var_f2de135e.time_out[0][3] = (isdefined(level.blood.scriptbundle.var_3e6f492f) ? level.blood.scriptbundle.var_3e6f492f : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[0][4]))
	{
		level.blood.var_f2de135e.time_out[0][4] = (isdefined(level.blood.scriptbundle.var_704a2ce8) ? level.blood.scriptbundle.var_704a2ce8 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_92fc0d45[0]))
	{
		level.blood.var_f2de135e.var_92fc0d45[0] = level.blood.var_f2de135e.time_out[0][0];
	}
	level.blood.var_f2de135e.time_out[1] = [];
	if(!isdefined(level.blood.var_f2de135e.time_out[1][0]))
	{
		level.blood.var_f2de135e.time_out[1][0] = (isdefined(level.blood.scriptbundle.var_50fd2cd8) ? level.blood.scriptbundle.var_50fd2cd8 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[1][1]))
	{
		level.blood.var_f2de135e.time_out[1][1] = (isdefined(level.blood.scriptbundle.var_b2c3f064) ? level.blood.scriptbundle.var_b2c3f064 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[1][2]))
	{
		level.blood.var_f2de135e.time_out[1][2] = (isdefined(level.blood.scriptbundle.var_855a1591) ? level.blood.scriptbundle.var_855a1591 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[1][3]))
	{
		level.blood.var_f2de135e.time_out[1][3] = (isdefined(level.blood.scriptbundle.var_9731393f) ? level.blood.scriptbundle.var_9731393f : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.time_out[1][4]))
	{
		level.blood.var_f2de135e.time_out[1][4] = (isdefined(level.blood.scriptbundle.var_e9dd5e9a) ? level.blood.scriptbundle.var_e9dd5e9a : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_92fc0d45[1]))
	{
		level.blood.var_f2de135e.var_92fc0d45[1] = level.blood.var_f2de135e.time_out[1][0];
	}
	level.blood.var_f2de135e.var_97aa6fd2[0] = [];
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][0]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[0][0] = (isdefined(level.blood.scriptbundle.var_9e799d8c) ? level.blood.scriptbundle.var_9e799d8c : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][1]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[0][1] = (isdefined(level.blood.scriptbundle.var_8bb8f80b) ? level.blood.scriptbundle.var_8bb8f80b : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][2]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[0][2] = (isdefined(level.blood.scriptbundle.var_7205c4a5) ? level.blood.scriptbundle.var_7205c4a5 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][3]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[0][3] = (isdefined(level.blood.scriptbundle.var_619e23d6) ? level.blood.scriptbundle.var_619e23d6 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[0][4]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[0][4] = (isdefined(level.blood.scriptbundle.var_56f00e7a) ? level.blood.scriptbundle.var_56f00e7a : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_5b5500f7[0]))
	{
		level.blood.var_f2de135e.var_5b5500f7[0] = level.blood.var_f2de135e.var_97aa6fd2[0][0];
	}
	level.blood.var_f2de135e.var_97aa6fd2[1] = [];
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][0]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[1][0] = (isdefined(level.blood.scriptbundle.var_ff41f2f5) ? level.blood.scriptbundle.var_ff41f2f5 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][1]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[1][1] = (isdefined(level.blood.scriptbundle.var_f0f35658) ? level.blood.scriptbundle.var_f0f35658 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][2]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[1][2] = (isdefined(level.blood.scriptbundle.var_9cf6ae3c) ? level.blood.scriptbundle.var_9cf6ae3c : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][3]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[1][3] = (isdefined(level.blood.scriptbundle.var_1ca22db5) ? level.blood.scriptbundle.var_1ca22db5 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_97aa6fd2[1][4]))
	{
		level.blood.var_f2de135e.var_97aa6fd2[1][4] = (isdefined(level.blood.scriptbundle.var_6530117) ? level.blood.scriptbundle.var_6530117 : 0);
	}
	if(!isdefined(level.blood.var_f2de135e.var_5b5500f7[1]))
	{
		level.blood.var_f2de135e.var_5b5500f7[1] = level.blood.var_f2de135e.var_97aa6fd2[1][0];
	}
}

