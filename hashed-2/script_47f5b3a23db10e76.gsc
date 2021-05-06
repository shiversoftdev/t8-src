// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using script_545a0bac37bda541;
#using script_57f7003580bb15e0;
#using script_6c8abe14025b47c4;
#using script_79a7e1c31a3e8cc;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace smart_cover;

/*
	Name: init_shared
	Namespace: smart_cover
	Checksum: 0x7A8C15C
	Offset: 0x360
	Size: 0x54C
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	level.var_5101157d = spawnstruct();
	if(sessionmodeismultiplayergame())
	{
		if(getgametypesetting(#"competitivesettings") === 1)
		{
			level.var_5101157d.bundle = getscriptbundle(#"hash_1df8cd70e8310c57");
		}
		else
		{
			level.var_5101157d.bundle = getscriptbundle(#"hash_25c242b3e86ced05");
		}
	}
	else if(function_f99d2668())
	{
		level.var_5101157d.bundle = getscriptbundle(#"hash_25e448b3e889dd9d");
	}
	else if(sessionmodeiscampaigngame())
	{
		level.var_5101157d.bundle = getscriptbundle(#"hash_25a046b3e8500d6b");
	}
	level.var_5101157d.var_ac3f76c7 = "smart_cover_objective_full";
	level.var_5101157d.var_546a220c = "smart_cover_objective_open";
	level.var_5101157d.var_8d86ade8 = getweapon("ability_smart_cover");
	level.var_5101157d.var_4115bb3a = getweapon(#"hash_34575452eba07c65");
	level.var_5101157d.var_d6a27a84 = [];
	function_8434338d();
	ability_player::register_gadget_should_notify(27, 1);
	weaponobjects::function_e6400478(#"ability_smart_cover", &function_21e722f6, 1);
	callback::on_spawned(&on_player_spawned);
	level.var_5101157d.var_f115c746 = [];
	deployable::function_2e088f73(level.var_5101157d.var_8d86ade8, &function_b7f5b1cc, &function_a47ce1c2, undefined, undefined, 1);
	level.var_5101157d.var_357db326 = 10000;
	level.var_5101157d.var_ff1a491d = level.var_5101157d.bundle.var_76d79155 * level.var_5101157d.bundle.var_76d79155;
	if(!function_f99d2668())
	{
		globallogic_score::function_5a241bd8(level.var_5101157d.var_8d86ade8, &function_92112113);
		globallogic_score::function_86f90713(level.var_5101157d.var_8d86ade8, &function_92112113);
	}
	clientfield::register("clientuimodel", "hudItems.smartCoverState", 1, 1, "int");
	clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float");
	clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int");
	callback::on_end_game(&on_end_game);
	setdvar(#"hash_4d17057924212aa9", 20);
	setdvar(#"hash_686a676b28ae0af4", 0);
	setdvar(#"hash_7f893c50ae5356c8", -15);
	setdvar(#"hash_70ce44b2b0b4005", 30);
	setdvar(#"hash_477cc29b988c0b75", -10);
	setdvar(#"hash_41cfd0e34c53ef02", 30);
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: smart_cover
	Checksum: 0x6D5F9AC4
	Offset: 0x8B8
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](level.var_5101157d.var_8d86ade8, &function_bff5c062);
	}
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](level.var_5101157d.var_8d86ade8, &function_127fb8f3);
	}
}

/*
	Name: function_716c6c70
	Namespace: smart_cover
	Checksum: 0xA815126C
	Offset: 0x940
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_716c6c70()
{
	self endon(#"death", #"hash_602ae7ca650d6287");
	util::wait_network_frame(1);
	if(isdefined(self) && self getentitytype() == 6)
	{
		self clientfield::set("start_smartcover_microwave", 0);
	}
	util::wait_network_frame(1);
	if(isdefined(self) && self getentitytype() == 6)
	{
		self clientfield::set("start_smartcover_microwave", 1);
	}
}

/*
	Name: function_bff5c062
	Namespace: smart_cover
	Checksum: 0x89F396D5
	Offset: 0xA30
	Size: 0x2E2
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(var_5391a162, var_dbd1a594)
{
	var_5391a162.owner weaponobjects::hackerremoveweapon(var_5391a162);
	var_5391a162 notify(#"hacked");
	if(isdefined(var_5391a162.grenade))
	{
		var_5391a162.grenade notify(#"hacked");
	}
	var_5391a162 notify(#"hash_602ae7ca650d6287");
	function_375cfa56(var_5391a162, var_5391a162.owner);
	var_5391a162.owner = var_dbd1a594;
	var_5391a162 setowner(var_dbd1a594);
	var_5391a162.team = var_dbd1a594.team;
	if(isdefined(var_5391a162.var_40bfd9cf))
	{
		var_5391a162 influencers::remove_influencer(var_5391a162.var_40bfd9cf);
	}
	var_5391a162.var_40bfd9cf = var_5391a162 influencers::create_entity_enemy_influencer("turret_close", var_dbd1a594.team);
	var_5391a162 thread function_37f1dcd1();
	var_5391a162 thread function_d82c03d4(var_dbd1a594);
	array::add(var_dbd1a594.var_5391a162.var_19e1ea69, var_5391a162);
	var_26c9fcc2 = function_57f553e9(var_dbd1a594.var_5391a162.var_19e1ea69, level.var_5101157d.bundle.var_a0b69d8b);
	if(isdefined(var_26c9fcc2))
	{
		var_26c9fcc2 function_2a494565(1);
	}
	var_5391a162 thread function_716c6c70();
	if(isdefined(level.var_f1edf93f))
	{
		var_eb79e7c3 = [[level.var_f1edf93f]]();
		var_5391a162 thread function_b397b517(var_eb79e7c3);
	}
	if(isdefined(var_5391a162.var_7766a3c) && var_5391a162.var_7766a3c)
	{
		var_5391a162 startmicrowave();
		var_5391a162.var_7766a3c = 0;
		if(isdefined(level.var_fc1bbaef))
		{
			[[level.var_fc1bbaef]](var_5391a162);
		}
		var_5391a162.var_7766a3c = 0;
	}
}

/*
	Name: on_end_game
	Namespace: smart_cover
	Checksum: 0x1D5114C0
	Offset: 0xD20
	Size: 0x1E0
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	if(!isdefined(level.var_5101157d) || !isdefined(level.var_5101157d.var_8d86ade8))
	{
		return;
	}
	foreach(player in level.players)
	{
		var_9d063af9 = player gadgetgetslot(level.var_5101157d.var_8d86ade8);
		player gadgetdeactivate(var_9d063af9, level.var_5101157d.var_8d86ade8);
		player function_48e08b4(var_9d063af9, level.var_5101157d.var_8d86ade8);
	}
	if(!isdefined(level.var_5101157d.var_f115c746))
	{
		return;
	}
	var_73137502 = arraycopy(level.var_5101157d.var_f115c746);
	foreach(var_5391a162 in var_73137502)
	{
		if(!isdefined(var_5391a162))
		{
			continue;
		}
		var_5391a162 function_2a494565(1);
	}
}

/*
	Name: function_8434338d
	Namespace: smart_cover
	Checksum: 0xD91C58A5
	Offset: 0xF08
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_8434338d()
{
	setdvar(#"hash_4f4ce3cb18b004bc", 8);
	setdvar(#"hash_417afa70d515fba5", (isdefined(level.var_5101157d.bundle.var_76d79155) ? level.var_5101157d.bundle.var_76d79155 : 0));
	setdvar(#"hash_1d8eb304f5cf8033", 1);
	setdvar(#"hash_71f8bd4cd30de4b3", (isdefined(level.var_5101157d.bundle.var_e35fc674) ? level.var_5101157d.bundle.var_e35fc674 : 0));
	setdvar(#"hash_39a564d4801c4b2e", (isdefined(level.var_5101157d.bundle.var_1f0ae388) ? level.var_5101157d.bundle.var_1f0ae388 : 0));
}

/*
	Name: function_649f8cbe
	Namespace: smart_cover
	Checksum: 0x3399D4A6
	Offset: 0x1088
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_649f8cbe(func)
{
	level.var_c8d7d200 = func;
}

/*
	Name: function_a9427b5c
	Namespace: smart_cover
	Checksum: 0x41CC5F2A
	Offset: 0x10B0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_a9427b5c(func)
{
	level.var_a430cceb = func;
}

/*
	Name: function_b397b517
	Namespace: smart_cover
	Checksum: 0xDABE89B8
	Offset: 0x10D8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_b397b517(var_84e5ee08)
{
	self endon(#"death", #"hash_602ae7ca650d6287");
	timeouttime = (isdefined(var_84e5ee08) ? var_84e5ee08 : level.var_5101157d.bundle.timeout);
	if((isdefined(timeouttime) ? timeouttime : 0) == 0)
	{
		return;
	}
	wait(timeouttime);
	if(isdefined(self))
	{
		self thread function_2a494565(1);
	}
}

/*
	Name: function_b11be5dc
	Namespace: smart_cover
	Checksum: 0xF96DD8FA
	Offset: 0x1190
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_b11be5dc()
{
	if(!isdefined(self.var_5391a162))
	{
		return;
	}
	foreach(var_5391a162 in self.var_5391a162.var_58e8b64d)
	{
		if(isdefined(var_5391a162))
		{
			var_5391a162 function_2a494565(1);
		}
	}
}

/*
	Name: function_bd071599
	Namespace: smart_cover
	Checksum: 0x2EA7A341
	Offset: 0x1238
	Size: 0x38C
	Parameters: 2
	Flags: Linked
*/
function function_bd071599(player, var_5391a162)
{
	level endon(#"game_ended");
	player notify(#"hash_53db5f084a244a94");
	player endon(#"hash_53db5f084a244a94");
	player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");
	var_5391a162 endon(#"death");
	var_f5929597 = gettime() + int((isdefined(level.var_5101157d.bundle.var_fee887dc) ? level.var_5101157d.bundle.var_fee887dc : 0) * 1000);
	player.var_622765b5 = 1;
	currenttime = gettime();
	timeelapsed = 0;
	while(var_f5929597 > gettime())
	{
		if(!player gamepadusedlast())
		{
			break;
		}
		if(!player offhandspecialbuttonpressed())
		{
			player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
			player.var_622765b5 = 0;
			return;
		}
		timeelapsed = gettime() - currenttime;
		var_1cf1ae8b = timeelapsed / int((isdefined(level.var_5101157d.bundle.var_fee887dc) ? level.var_5101157d.bundle.var_fee887dc : 0) * 1000);
		player clientfield::set_player_uimodel("huditems.abilityDelayProgress", var_1cf1ae8b);
		waitframe(1);
	}
	player thread gestures::function_f3e2696f(player, level.var_5101157d.var_4115bb3a, undefined, 0.75, undefined, undefined, undefined);
	if(isdefined(level.var_5101157d.bundle.var_d47e600f))
	{
		var_5391a162 playsound(level.var_5101157d.bundle.var_d47e600f);
	}
	player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
	player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
	wait((isdefined(level.var_5101157d.bundle.detonationtime) ? level.var_5101157d.bundle.detonationtime : 0));
	player.var_622765b5 = 0;
	player.var_d3bf8986 = 1;
	var_5391a162 function_2a494565(1);
}

/*
	Name: function_7ecb04ff
	Namespace: smart_cover
	Checksum: 0xFAA134DC
	Offset: 0x15D0
	Size: 0x426
	Parameters: 1
	Flags: Linked
*/
function function_7ecb04ff(player)
{
	level endon(#"game_ended");
	player notify(#"hash_51faf1a32d7e36b0");
	player endon(#"hash_51faf1a32d7e36b0");
	player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");
	while(true)
	{
		waitframe(1);
		while(level.inprematchperiod)
		{
			waitframe(1);
			continue;
		}
		if(!player hasweapon(level.var_5101157d.var_8d86ade8))
		{
			return;
		}
		var_9d063af9 = player gadgetgetslot(level.var_5101157d.var_8d86ade8);
		if(!isdefined(var_9d063af9) || var_9d063af9 == -1)
		{
			continue;
		}
		ammocount = player getammocount(level.var_5101157d.var_8d86ade8);
		gadgetpower = player gadgetpowerget(var_9d063af9);
		if(gadgetpower >= 100 || ammocount > 0)
		{
			player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
			player clientfield::set_player_uimodel("hudItems.smartCoverState", 0);
			continue;
		}
		if(player.var_5391a162.var_19e1ea69.size == 0)
		{
			continue;
		}
		if((isdefined(level.var_5101157d.bundle.var_ad7084b4) ? level.var_5101157d.bundle.var_ad7084b4 : 0))
		{
			player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
			player clientfield::set_player_uimodel("hudItems.smartCoverState", 1);
			if((isdefined(level.var_5101157d.bundle.var_ad7084b4) ? level.var_5101157d.bundle.var_ad7084b4 : 0) && player offhandspecialbuttonpressed() && (!isdefined(player.var_622765b5) || !player.var_622765b5) && !(isdefined(player.var_d3bf8986) ? player.var_d3bf8986 : 0))
			{
				foreach(var_5391a162 in player.var_5391a162.var_58e8b64d)
				{
					if(!isdefined(var_5391a162))
					{
						continue;
					}
					var_5391a162 thread function_bd071599(player, var_5391a162);
					break;
				}
			}
			else if(!player offhandspecialbuttonpressed() && (isdefined(player.var_d3bf8986) ? player.var_d3bf8986 : 0))
			{
				player.var_d3bf8986 = 0;
			}
		}
	}
}

/*
	Name: on_player_spawned
	Namespace: smart_cover
	Checksum: 0x22EC9046
	Offset: 0x1A00
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	if(!isdefined(self.var_5391a162))
	{
		self.var_5391a162 = spawnstruct();
		self.var_5391a162.var_58e8b64d = [];
		self.var_5391a162.var_19e1ea69 = [];
		self.var_5391a162.var_d5258d02 = [];
	}
	if(!self hasweapon(level.var_5101157d.var_8d86ade8) && self.var_5391a162.var_58e8b64d.size > 0)
	{
		self function_b11be5dc();
	}
	self clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
	self.var_622765b5 = 0;
	self reset_being_microwaved();
}

/*
	Name: function_b7f5b1cc
	Namespace: smart_cover
	Checksum: 0xE7688191
	Offset: 0x1B00
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function function_b7f5b1cc(origin, angles, player)
{
	if(isdefined(level.var_b57c1895))
	{
		return [[level.var_b57c1895]](origin, angles, player);
	}
	return 1;
}

/*
	Name: function_a47ce1c2
	Namespace: smart_cover
	Checksum: 0xD41617D1
	Offset: 0x1B58
	Size: 0x1F0
	Parameters: 1
	Flags: Linked
*/
function function_a47ce1c2(player)
{
	var_b43e8dc2 = player function_287dcf4b(level.var_5101157d.bundle.var_63aab046, level.var_5101157d.bundle.maxwidth, 1, 1, level.var_5101157d.var_8d86ade8);
	player.var_5391a162.var_add809de = var_b43e8dc2;
	var_9e596670 = 0;
	if(isdefined(var_b43e8dc2) && isdefined(var_b43e8dc2.origin))
	{
		var_9e596670 = function_bf4c81d2(var_b43e8dc2.origin, level.var_5101157d.var_ff1a491d);
	}
	var_2b68b641 = function_54267517(var_b43e8dc2.origin);
	var_1e5ed37a = isdefined(var_b43e8dc2) && var_b43e8dc2.isvalid && !var_9e596670 && !var_2b68b641;
	if(var_1e5ed37a && (isdefined(var_b43e8dc2.width) ? var_b43e8dc2.width : 0) >= level.var_5101157d.bundle.maxwidth)
	{
		player function_bf191832(var_1e5ed37a, var_b43e8dc2.origin, var_b43e8dc2.angles);
	}
	else
	{
		player function_bf191832(var_1e5ed37a, (0, 0, 0), (0, 0, 0));
	}
	return var_b43e8dc2;
}

/*
	Name: function_408a9ea8
	Namespace: smart_cover
	Checksum: 0x831ED4C8
	Offset: 0x1D50
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_408a9ea8(var_bf2bf1a)
{
	var_bf2bf1a endon(#"death");
	var_bf2bf1a useanimtree("generic");
	var_bf2bf1a setanim(level.var_5101157d.bundle.deployanim);
	animtime = 0;
	while(animtime < 1)
	{
		var_bf2bf1a clientfield::set("smartcover_placed", 1 - animtime);
		animtime = var_bf2bf1a getanimtime(level.var_5101157d.bundle.deployanim);
		waitframe(1);
	}
}

/*
	Name: function_548a710a
	Namespace: smart_cover
	Checksum: 0xF0DC26CF
	Offset: 0x1E40
	Size: 0x350
	Parameters: 1
	Flags: None
*/
function function_548a710a(traceresults)
{
	if(!traceresults.var_e2543923 && !traceresults.var_e18fd6c3)
	{
		return traceresults.origin;
	}
	halfwidth = level.var_5101157d.bundle.maxwidth * 0.5;
	var_93cd60ae = halfwidth * halfwidth;
	var_b80b6889 = distance2d(traceresults.origin, traceresults.var_c0e006dc);
	var_65ea35de = distance2d(traceresults.origin, traceresults.var_44cf251d);
	if(traceresults.var_e2543923 && traceresults.var_e18fd6c3)
	{
		var_a5b1e71f = traceresults.var_c0e006dc;
		var_807a7846 = traceresults.var_44cf251d;
	}
	else if(traceresults.var_e2543923 && var_b80b6889 < halfwidth)
	{
		var_a5b1e71f = traceresults.var_c0e006dc;
		var_279f200d = vectornormalize(traceresults.var_44cf251d - traceresults.var_c0e006dc);
		var_807a7846 = traceresults.var_c0e006dc + level.var_5101157d.bundle.maxwidth * var_279f200d;
	}
	else if(traceresults.var_e2543923 && var_b80b6889 >= halfwidth)
	{
		return traceresults.origin;
	}
	if(traceresults.var_e18fd6c3 && var_65ea35de < halfwidth)
	{
		var_807a7846 = traceresults.var_44cf251d;
		var_3b65a70e = vectornormalize(traceresults.var_c0e006dc - traceresults.var_44cf251d);
		var_a5b1e71f = traceresults.var_44cf251d + level.var_5101157d.bundle.maxwidth * var_3b65a70e;
	}
	else if(traceresults.var_e18fd6c3 && var_65ea35de >= halfwidth)
	{
		return traceresults.origin;
	}
	direction = vectornormalize(var_a5b1e71f - var_807a7846);
	origin = (var_807a7846[0], var_807a7846[1], traceresults.origin[2]) + level.var_5101157d.bundle.maxwidth * 0.5 * direction;
	return origin;
}

/*
	Name: function_3b96637
	Namespace: smart_cover
	Checksum: 0x64477FA6
	Offset: 0x2198
	Size: 0x3B4
	Parameters: 2
	Flags: Linked
*/
function function_3b96637(watcher, owner)
{
	self endon(#"death");
	player = owner;
	self.var_52a68abf = 1;
	self hide();
	if(!isdefined(player.var_5391a162.var_add809de) || !player.var_5391a162.var_add809de.isvalid)
	{
		player deployable::function_416f03e6(level.var_5101157d.var_8d86ade8);
		return;
	}
	var_bf2bf1a = player function_63c86d6(watcher, self, player.var_5391a162.var_add809de.var_83050ca1, player.var_5391a162.var_add809de.angles, 1);
	var_bf2bf1a.angles = player.angles;
	var_bf2bf1a.var_8120c266 = [];
	var_bf2bf1a.var_9a3bd50f = 0;
	array::add(player.var_5391a162.var_19e1ea69, var_bf2bf1a);
	var_26c9fcc2 = function_57f553e9(player.var_5391a162.var_19e1ea69, level.var_5101157d.bundle.var_a0b69d8b);
	if(isdefined(var_26c9fcc2))
	{
		var_26c9fcc2 function_2a494565(1);
	}
	if(isdefined(level.var_c8d7d200))
	{
		owner [[level.var_c8d7d200]](self);
	}
	self thread function_d82c03d4(player);
	if(isdefined(level.var_5101157d.bundle.deployanim))
	{
		thread function_408a9ea8(var_bf2bf1a);
	}
	if((isdefined(level.var_5101157d.bundle.var_ad7084b4) ? level.var_5101157d.bundle.var_ad7084b4 : 0))
	{
		player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
	}
	var_bf2bf1a.var_40bfd9cf = var_bf2bf1a influencers::create_entity_enemy_influencer("turret_close", owner.team);
	var_bf2bf1a util::function_c596f193();
	if(isdefined(level.var_5101157d.var_8d86ade8.var_414fa79e))
	{
		player playrumbleonentity(level.var_5101157d.var_8d86ade8.var_414fa79e);
	}
	thread function_7ecb04ff(player);
	var_bf2bf1a thread function_670cd4a3();
	var_bf2bf1a thread function_b397b517();
}

/*
	Name: function_670cd4a3
	Namespace: smart_cover
	Checksum: 0xB5F06E1D
	Offset: 0x2558
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_670cd4a3()
{
	self endon(#"death");
	self.var_19fde5b7 = [];
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_stuck");
		if(isdefined(waitresult.projectile))
		{
			array::add(self.var_19fde5b7, waitresult.projectile);
		}
	}
}

/*
	Name: function_21e722f6
	Namespace: smart_cover
	Checksum: 0x6D699747
	Offset: 0x25E0
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function function_21e722f6(watcher)
{
	watcher.watchforfire = 1;
	watcher.onspawn = &function_3b96637;
	watcher.deleteonplayerspawn = 0;
}

/*
	Name: function_d82c03d4
	Namespace: smart_cover
	Checksum: 0xDB8C8F46
	Offset: 0x2630
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_d82c03d4(player)
{
	self endon(#"death", #"hacked");
	player waittill(#"joined_team", #"disconnect");
	player function_b11be5dc();
}

/*
	Name: function_37f1dcd1
	Namespace: smart_cover
	Checksum: 0xD81151EE
	Offset: 0x26A8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_37f1dcd1()
{
	level endon(#"game_ended");
	self.owner endon(#"disconnect", #"joined_team", #"changed_specialist", #"hacked");
	self endon(#"hash_5de1fc3780ea0eaa");
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(!isdefined(self))
	{
		return;
	}
	self thread onkilled(waitresult);
}

/*
	Name: ondamage
	Namespace: smart_cover
	Checksum: 0xFF5DFF51
	Offset: 0x2770
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function ondamage()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(isdefined(waitresult.attacker) && isplayer(waitresult.attacker))
		{
			if(waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker))
			{
				waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
			}
		}
	}
}

/*
	Name: function_375cfa56
	Namespace: smart_cover
	Checksum: 0x2D6173BA
	Offset: 0x2880
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_375cfa56(var_5391a162, owner)
{
	if(isdefined(owner))
	{
		arrayremovevalue(owner.var_5391a162.var_19e1ea69, var_5391a162);
	}
}

/*
	Name: function_2a494565
	Namespace: smart_cover
	Checksum: 0x3384F8BF
	Offset: 0x28D0
	Size: 0x514
	Parameters: 1
	Flags: Linked
*/
function function_2a494565(isselfdestruct)
{
	var_5391a162 = self;
	var_5391a162 notify(#"hash_5de1fc3780ea0eaa");
	var_5391a162 clientfield::set("enemyequip", 0);
	var_5391a162 clientfield::set("friendlyequip", 0);
	if(isdefined(var_5391a162.objectiveid))
	{
		objective_delete(var_5391a162.objectiveid);
		gameobjects::release_obj_id(var_5391a162.objectiveid);
	}
	if(isdefined(level.var_5101157d.bundle.var_35fbc280))
	{
		if(isdefined(isselfdestruct) && isselfdestruct)
		{
			var_415135a0 = level.var_5101157d.bundle.var_28811698;
			var_72db9941 = level.var_5101157d.bundle.var_5493f8b0;
		}
		else
		{
			var_415135a0 = level.var_5101157d.bundle.var_35fbc280;
			var_72db9941 = level.var_5101157d.bundle.var_b3756378;
		}
		var_b0e81be9 = (isdefined(self gettagorigin("tag_cover_base_d0")) ? self gettagorigin("tag_cover_base_d0") : self.origin);
		var_505e3308 = (isdefined(self gettagangles("tag_cover_base_d0")) ? self gettagangles("tag_cover_base_d0") : self.angles);
		var_8fec56c4 = anglestoforward(var_505e3308);
		var_61753233 = anglestoup(var_505e3308);
		playfx(var_415135a0, var_b0e81be9, var_8fec56c4, var_61753233);
		if(isdefined(var_72db9941))
		{
			var_5391a162 playsound(var_72db9941);
		}
	}
	if(isdefined(level.var_5101157d.bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle"))
	{
		playfx(level.var_5101157d.bundle.var_bb6c29b4, var_5391a162.origin);
	}
	var_28eaeb22 = -1;
	arrayremovevalue(level.var_5101157d.var_f115c746, var_5391a162);
	if(isdefined(var_5391a162.owner))
	{
		arrayremovevalue(var_5391a162.owner.var_5391a162.var_58e8b64d, var_5391a162);
		arrayremovevalue(var_5391a162.owner.var_5391a162.var_19e1ea69, var_5391a162);
	}
	if(isdefined(level.var_5101157d.bundle.var_f4e0e7d7) && level.var_5101157d.bundle.var_f4e0e7d7)
	{
		var_5391a162 stopmicrowave();
		var_5391a162 notify(#"microwave_turret_shutdown");
	}
	if(isdefined(var_5391a162.owner))
	{
		var_5391a162.owner globallogic_score::function_d3ca3608(#"hash_78cb6a053f51a857");
	}
	deployable::function_81598103(var_5391a162);
	if(isdefined(var_5391a162.killcament))
	{
		var_5391a162.killcament thread util::deleteaftertime(5);
	}
	if(isdefined(var_5391a162.grenade))
	{
		var_5391a162.grenade thread util::deleteaftertime(1);
	}
	if(isdefined(var_5391a162.trigger))
	{
		var_5391a162.trigger delete();
	}
	var_5391a162 delete();
}

/*
	Name: onkilled
	Namespace: smart_cover
	Checksum: 0xF074802D
	Offset: 0x2DF0
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function onkilled(var_c946c04c)
{
	var_5391a162 = self;
	if(var_c946c04c.attacker != var_5391a162.owner)
	{
		var_5391a162.owner globallogic_score::function_5829abe3(var_c946c04c.attacker, var_c946c04c.weapon, var_5391a162.weapon);
		if(isdefined(level.var_d2600afc))
		{
			self [[level.var_d2600afc]](var_c946c04c.attacker, var_5391a162.owner, var_5391a162.weapon, var_c946c04c.weapon);
		}
		if(isdefined(self.owner))
		{
			self.owner thread killstreaks::play_taacom_dialog("smartCoverWeaponDestroyedFriendly");
		}
	}
	var_5391a162.var_d02ddb8e = var_c946c04c.weapon;
	if(isdefined(level.var_a430cceb))
	{
		var_5391a162 [[level.var_a430cceb]](var_c946c04c.attacker, var_5391a162.var_d02ddb8e);
	}
	var_5391a162 thread function_2a494565(0);
}

/*
	Name: function_884d0700
	Namespace: smart_cover
	Checksum: 0xE6BD2B3C
	Offset: 0x2F58
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_884d0700(var_796be15d)
{
	return (self.team == #"allies" ? level.var_5101157d.bundle.var_ee0c73a5 : level.var_5101157d.bundle.var_d3ea02d6);
}

/*
	Name: getmodel
	Namespace: smart_cover
	Checksum: 0xB59EFADB
	Offset: 0x2FC0
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function getmodel(var_796be15d)
{
	return (self.team == #"allies" ? level.var_5101157d.bundle.var_397ed90c : level.var_5101157d.bundle.var_b256e3da);
}

/*
	Name: function_d2368084
	Namespace: smart_cover
	Checksum: 0xA524649A
	Offset: 0x3028
	Size: 0x59A
	Parameters: 12
	Flags: Linked
*/
function function_d2368084(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex)
{
	if(weapon === getweapon(#"shock_rifle") && smeansofdeath === "MOD_DOT")
	{
		return 0;
	}
	bundle = level.var_5101157d.bundle;
	startinghealth = (isdefined(self.startinghealth) ? self.startinghealth : 0);
	if((isdefined(self.health) ? self.health : 0) < startinghealth * 0.5 && !self.var_2cf2e843 === 1 && isdefined(self.owner) && isplayer(self.owner) && !eattacker === self.owner)
	{
		self.owner thread killstreaks::play_taacom_dialog("smartCoverWeaponDamaged");
		self.var_2cf2e843 = 1;
	}
	if(isdefined(bundle.rocketstokill) && weapon == getweapon(#"launcher_standard"))
	{
		idamage = startinghealth / bundle.rocketstokill;
	}
	if(isdefined(bundle.kshero_annihilator) && weapon == getweapon(#"hero_annihilator"))
	{
		idamage = startinghealth / bundle.kshero_annihilator;
	}
	else if(isdefined(bundle.var_2e48926e) && weapon == getweapon(#"hero_flamethrower"))
	{
		idamage = startinghealth / bundle.var_2e48926e;
	}
	else if(isdefined(bundle.kshero_gravityspikes) && weapon == getweapon(#"hash_4bb2d7f789b561eb"))
	{
		idamage = startinghealth / bundle.kshero_gravityspikes;
	}
	else if(isdefined(bundle.var_4be7d629) && weapon == getweapon(#"shock_rifle") && smeansofdeath == "MOD_IMPACT")
	{
		idamage = startinghealth / bundle.var_4be7d629;
	}
	else if(isdefined(bundle.var_843b7bd3) && weapon.statname == #"planemortar")
	{
		idamage = startinghealth / bundle.var_843b7bd3;
	}
	else if(isdefined(bundle.ksdartstokill) && (weapon == getweapon(#"dart_blade") || weapon == getweapon(#"dart_turret")))
	{
		idamage = startinghealth / bundle.ksdartstokill;
	}
	else if(isdefined(bundle.var_8eca21ba) && weapon.statname == #"recon_car")
	{
		idamage = startinghealth / bundle.var_8eca21ba;
	}
	else if(isdefined(bundle.ksremote_missile_missile) && weapon.statname == #"remote_missile_missile")
	{
		idamage = startinghealth / bundle.ksremote_missile_missile;
	}
	else if(isdefined(bundle.kshero_pineapplegun) && weapon == getweapon(#"hero_pineapplegun"))
	{
		idamage = startinghealth / bundle.kshero_pineapplegun;
	}
	else if(isdefined(bundle.kshero_bowlauncher) && weapon.statname == #"hash_40380537847df901" && (smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE_SPLASH"))
	{
		idamage = startinghealth / bundle.kshero_bowlauncher;
	}
	return int(idamage);
}

/*
	Name: function_20be77a3
	Namespace: smart_cover
	Checksum: 0xA1B481FA
	Offset: 0x35D0
	Size: 0x232
	Parameters: 1
	Flags: Linked
*/
function function_20be77a3(var_5391a162)
{
	var_5391a162.var_eda9690f = [];
	var_dec635d = anglestoforward(var_5391a162.angles);
	var_2358ae9 = anglestoright(var_5391a162.angles);
	var_526ec5aa = var_5391a162.origin + (0, 0, 1) * getdvarfloat(#"hash_4d17057924212aa9", 1);
	var_5391a162.var_eda9690f[var_5391a162.var_eda9690f.size] = var_526ec5aa + var_dec635d * getdvarfloat(#"hash_477cc29b988c0b75", 1);
	var_5391a162.var_eda9690f[var_5391a162.var_eda9690f.size] = var_5391a162.var_eda9690f[0] + (0, 0, 1) * getdvarfloat(#"hash_41cfd0e34c53ef02", 1);
	backpoint = var_526ec5aa + var_dec635d * getdvarfloat(#"hash_7f893c50ae5356c8", 1);
	var_5391a162.var_eda9690f[var_5391a162.var_eda9690f.size] = backpoint + var_2358ae9 * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
	var_5391a162.var_eda9690f[var_5391a162.var_eda9690f.size] = backpoint - var_2358ae9 * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
}

/*
	Name: function_63c86d6
	Namespace: smart_cover
	Checksum: 0x9A657FED
	Offset: 0x3810
	Size: 0x706
	Parameters: 5
	Flags: Linked
*/
function function_63c86d6(watcher, var_5ebbec19, origin, angles, var_796be15d)
{
	player = self;
	var_89b6fd44 = spawn("script_model", origin);
	var_89b6fd44.targetname = "smart_cover";
	var_5ebbec19.var_5391a162 = var_89b6fd44;
	var_89b6fd44.grenade = var_5ebbec19;
	var_89b6fd44 setmodel(player getmodel(var_796be15d));
	watcher.objectarray[watcher.objectarray.size] = var_89b6fd44;
	var_c6f47ca9 = getdvarint(#"hash_1d8eb304f5cf8033", 0);
	if(var_c6f47ca9 == 1)
	{
		var_89b6fd44 function_41b29ff0(player function_884d0700(var_796be15d));
	}
	var_89b6fd44.angles = angles;
	var_89b6fd44.owner = player;
	var_89b6fd44.takedamage = 1;
	var_89b6fd44.startinghealth = (var_796be15d ? (isdefined(level.var_5101157d.bundle.var_d9317c6b) ? level.var_5101157d.bundle.var_d9317c6b : 100) : (isdefined(level.var_5101157d.bundle.var_4d358e2d) ? level.var_5101157d.bundle.var_4d358e2d : 100));
	var_89b6fd44.health = var_89b6fd44.startinghealth;
	var_89b6fd44 solid();
	if(function_f99d2668())
	{
		var_89b6fd44 disconnectpaths(0);
	}
	else
	{
		var_89b6fd44 disconnectpaths(1);
	}
	var_89b6fd44 setteam(player getteam());
	var_89b6fd44.var_86a21346 = &function_d2368084;
	var_89b6fd44.weapon = level.var_5101157d.var_8d86ade8;
	var_89b6fd44 setweapon(var_89b6fd44.weapon);
	array::add(player.var_5391a162.var_58e8b64d, var_89b6fd44);
	var_c892a9a = (var_796be15d ? level.var_5101157d.var_546a220c : level.var_5101157d.var_ac3f76c7);
	if(isdefined(var_c892a9a))
	{
		var_89b6fd44.objectiveid = gameobjects::get_next_obj_id();
		objective_add(var_89b6fd44.objectiveid, "active", var_89b6fd44, var_c892a9a);
		function_da7940a3(var_89b6fd44.objectiveid, 1);
		objective_setteam(var_89b6fd44.objectiveid, player.team);
	}
	var_9d063af9 = player gadgetgetslot(level.var_5101157d.var_8d86ade8);
	if(!function_f99d2668())
	{
		self gadgetpowerset(var_9d063af9, 0);
	}
	var_89b6fd44 setteam(player.team);
	array::add(level.var_5101157d.var_f115c746, var_89b6fd44);
	function_20be77a3(var_89b6fd44);
	var_89b6fd44 clientfield::set("friendlyequip", 1);
	var_89b6fd44 clientfield::set("enemyequip", 1);
	var_89b6fd44 thread ondamage();
	var_89b6fd44 thread function_37f1dcd1();
	thread function_18dd6b22(var_89b6fd44);
	player deployable::function_6ec9ee30(var_89b6fd44, level.var_5101157d.var_8d86ade8);
	var_89b6fd44.victimsoundmod = "vehicle";
	if(isdefined(level.var_5101157d.bundle.var_f4e0e7d7) && level.var_5101157d.bundle.var_f4e0e7d7)
	{
		var_89b6fd44 thread startmicrowave();
	}
	killcament = spawn("script_model", var_89b6fd44.origin + ((isdefined(level.var_5101157d.bundle.var_eb9150a5) ? level.var_5101157d.bundle.var_eb9150a5 : 0), (isdefined(level.var_5101157d.bundle.var_26a346c8) ? level.var_5101157d.bundle.var_26a346c8 : 0), (isdefined(level.var_5101157d.bundle.var_d0fb9b7a) ? level.var_5101157d.bundle.var_d0fb9b7a : 0)));
	killcament.targetname = "smart_cover_killcament";
	var_89b6fd44.killcament = killcament;
	watcher.objectarray[watcher.objectarray.size] = killcament;
	return var_89b6fd44;
}

/*
	Name: function_127fb8f3
	Namespace: smart_cover
	Checksum: 0x1BAA5BB3
	Offset: 0x3F20
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_127fb8f3(var_5391a162, var_dbd1a594)
{
	if(!(isdefined(var_5391a162.var_7766a3c) && var_5391a162.var_7766a3c))
	{
		var_5391a162 stopmicrowave();
		var_5391a162 clientfield::set("enemyequip", 0);
	}
	var_5391a162.var_7766a3c = 1;
	if(isdefined(level.var_86e3d17a))
	{
		var_5391a162 notify(#"hash_602ae7ca650d6287");
		var_77b9f495 = [[level.var_86e3d17a]]();
		var_5391a162 thread function_b397b517(var_77b9f495);
	}
	if(isdefined(level.var_1794f85f))
	{
		[[level.var_1794f85f]](var_dbd1a594, "disrupted_barricade");
	}
	return 1;
}

/*
	Name: function_18dd6b22
	Namespace: smart_cover
	Checksum: 0xBAEFF617
	Offset: 0x4030
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_18dd6b22(var_5391a162)
{
	level endon(#"game_ended");
	var_5391a162 endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = var_5391a162 waittill(#"broken");
		if(waitresult.type == "base_piece_broken")
		{
			var_5391a162 function_2a494565(0);
		}
	}
}

/*
	Name: function_bf4c81d2
	Namespace: smart_cover
	Checksum: 0xAE25FDC6
	Offset: 0x40D8
	Size: 0xB6
	Parameters: 2
	Flags: Linked
*/
function function_bf4c81d2(origin, maxdistancesq)
{
	foreach(var_5391a162 in level.var_5101157d.var_f115c746)
	{
		if(!isdefined(var_5391a162))
		{
			continue;
		}
		if(distancesquared(var_5391a162.origin, origin) < maxdistancesq)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: watchweaponchange
	Namespace: smart_cover
	Checksum: 0x78BFFDD0
	Offset: 0x4198
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function watchweaponchange()
{
	player = self;
	self notify(#"hash_7c317ca72a23c2a6");
	self endon(#"hash_7c317ca72a23c2a6");
	while(true)
	{
		if(self weaponswitchbuttonpressed())
		{
			if(isdefined(player.var_5391a162))
			{
				player.var_5391a162.var_5af6633b = 1;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_57f553e9
	Namespace: smart_cover
	Checksum: 0x9A9E819C
	Offset: 0x4228
	Size: 0x6A
	Parameters: 2
	Flags: Linked
*/
function function_57f553e9(var_85947e0d, maxallowed)
{
	if(var_85947e0d.size <= maxallowed)
	{
		return undefined;
	}
	var_73d5d37b = array::pop_front(var_85947e0d, 0);
	var_85947e0d = array::remove_undefined(var_85947e0d, 0);
	return var_73d5d37b;
}

/*
	Name: function_92112113
	Namespace: smart_cover
	Checksum: 0xF0EAF2B4
	Offset: 0x42A0
	Size: 0x366
	Parameters: 5
	Flags: Linked
*/
function function_92112113(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(level.var_5101157d) || !isdefined(level.var_5101157d.var_f115c746) || !isdefined(victim) || !isdefined(attacker) || !isdefined(attackerweapon) || !isdefined(weapon))
	{
		return 0;
	}
	if(isdefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](attackerweapon) || attackerweapon == weapon)
	{
		return 0;
	}
	foreach(var_5391a162 in level.var_5101157d.var_f115c746)
	{
		if(!isdefined(var_5391a162))
		{
			continue;
		}
		if(!isdefined(victim) || !isdefined(victim.team) || !isdefined(var_5391a162.owner))
		{
			continue;
		}
		if(victim == var_5391a162.owner || (level.teambased && !util::function_fbce7263(victim.team, var_5391a162.owner.team)))
		{
			continue;
		}
		var_583e1573 = distancesquared(var_5391a162.origin, attacker.origin);
		if(var_583e1573 > level.var_5101157d.var_357db326)
		{
			continue;
		}
		var_eb870c = distancesquared(victim.origin, var_5391a162.origin);
		var_ae30f518 = distancesquared(victim.origin, attacker.origin);
		var_d9ecf725 = var_ae30f518 > var_583e1573;
		var_1d1ca33b = var_ae30f518 > var_eb870c;
		if(var_d9ecf725 && var_1d1ca33b)
		{
			var_a3aba5a9 = 1;
			var_71eedb0b = var_5391a162.owner;
			break;
		}
	}
	if(isdefined(var_71eedb0b) && isdefined(var_a3aba5a9) && var_a3aba5a9)
	{
		if(var_5391a162.owner == attacker)
		{
			return 1;
		}
		scoreevents::processscoreevent(#"hash_3d0d53aff3c68c68", var_71eedb0b, victim, level.var_5101157d.var_8d86ade8);
	}
	return 0;
}

/*
	Name: function_4e6d9621
	Namespace: smart_cover
	Checksum: 0xBD783ACB
	Offset: 0x4610
	Size: 0x2BC
	Parameters: 3
	Flags: Linked, Private
*/
private function function_4e6d9621(var_5391a162, origins, radii)
{
	/#
		assert(isarray(origins));
	#/
	/#
		assert(!isarray(radii) || origins.size == radii.size);
	#/
	/#
		assert(isdefined(var_5391a162.var_eda9690f) && var_5391a162.var_eda9690f.size > 0);
	#/
	foreach(var_592587c3 in var_5391a162.var_eda9690f)
	{
		for(index = 0; index < origins.size; index++)
		{
			distance = distancesquared(origins[index], var_592587c3);
			radius = (isarray(radii) ? radii[index] : radii);
			var_d3892c92 = radius + getdvarfloat(#"hash_4d17057924212aa9", 1);
			if(getdvarint(#"hash_686a676b28ae0af4", 0) == 1)
			{
				/#
					sphere(origins[index], radius, (0, 0, 1), 0.5, 0, 10, 500);
					sphere(var_592587c3, getdvarfloat(#"hash_4d17057924212aa9", 1), (1, 0, 0), 0.5, 0, 10, 500);
				#/
			}
			radiussqr = var_d3892c92 * var_d3892c92;
			if(distance < radiussqr)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_e3a901c
	Namespace: smart_cover
	Checksum: 0xF38B91A4
	Offset: 0x48D8
	Size: 0xD2
	Parameters: 2
	Flags: Linked
*/
function function_e3a901c(origins, radii)
{
	if(!isdefined(level.var_5101157d.var_f115c746))
	{
		return 0;
	}
	foreach(var_5391a162 in level.var_5101157d.var_f115c746)
	{
		if(!isdefined(var_5391a162))
		{
			continue;
		}
		if(function_4e6d9621(var_5391a162, origins, radii))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: reset_being_microwaved
	Namespace: smart_cover
	Checksum: 0x2A4F0A99
	Offset: 0x49B8
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function reset_being_microwaved()
{
	self.lastmicrowavedby = undefined;
	self.beingmicrowavedby = undefined;
}

/*
	Name: startmicrowave
	Namespace: smart_cover
	Checksum: 0x6CCC9726
	Offset: 0x49D8
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function startmicrowave()
{
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}
	self clientfield::set("start_smartcover_microwave", 1);
	loc_00004A62:
	loc_00004AA6:
	self.trigger = spawn("trigger_radius", self.origin + (0, 0, (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0) * -1), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0), (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0) * 2);
	self thread turretthink();
	/#
		self thread turretdebugwatch();
	#/
}

/*
	Name: stopmicrowave
	Namespace: smart_cover
	Checksum: 0x9BB0E21F
	Offset: 0x4B70
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function stopmicrowave()
{
	if(!isdefined(self))
	{
		return;
	}
	self playsound(#"mpl_microwave_beam_off");
	if(self getentitytype() == 6)
	{
		self clientfield::set("start_smartcover_microwave", 0);
	}
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}
	/#
		self notify(#"stop_turret_debug");
	#/
}

/*
	Name: turretdebugwatch
	Namespace: smart_cover
	Checksum: 0xBC53D3D7
	Offset: 0x4C28
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function turretdebugwatch()
{
	turret = self;
	turret endon(#"stop_turret_debug");
	for(;;)
	{
		if(getdvarint(#"scr_microwave_turret_debug", 0) != 0)
		{
			turret turretdebug();
			waitframe(1);
			continue;
		}
		wait(1);
	}
}

/*
	Name: turretdebug
	Namespace: smart_cover
	Checksum: 0x52C11FB0
	Offset: 0x4CB0
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function turretdebug()
{
	turret = self;
	angles = turret gettagangles("tag_flash");
	origin = turret gettagorigin("tag_flash");
	cone_apex = origin;
	forward = anglestoforward(angles);
	dome_apex = cone_apex + vectorscale(forward, (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0));
	/#
		util::debug_spherical_cone(cone_apex, dome_apex, (isdefined(level.var_5101157d.bundle.var_cbd5f27c) ? level.var_5101157d.bundle.var_cbd5f27c : 0), 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
	#/
}

/*
	Name: turretthink
	Namespace: smart_cover
	Checksum: 0x6518F834
	Offset: 0x4E38
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function turretthink()
{
	turret = self;
	turret endon(#"microwave_turret_shutdown");
	turret endon(#"death");
	turret.trigger endon(#"death");
	turret.turret_vehicle_entnum = turret getentitynumber();
	while(true)
	{
		waitresult = undefined;
		waitresult = turret.trigger waittill(#"trigger");
		ent = waitresult.activator;
		if(ent == turret)
		{
			continue;
		}
		if(!isdefined(ent.beingmicrowavedby))
		{
			ent.beingmicrowavedby = [];
		}
		if(turret microwaveturretaffectsentity(ent) && !isdefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum]))
		{
			turret thread microwaveentity(ent);
		}
	}
}

/*
	Name: microwaveentitypostshutdowncleanup
	Namespace: smart_cover
	Checksum: 0xB3FA565E
	Offset: 0x4F98
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function microwaveentitypostshutdowncleanup(entity)
{
	entity endon(#"disconnect", #"end_microwaveentitypostshutdowncleanup");
	self endon(#"death");
	turret = self;
	turret_vehicle_entnum = turret.turret_vehicle_entnum;
	turret waittill(#"microwave_turret_shutdown");
	if(isdefined(entity))
	{
		if(isdefined(entity.beingmicrowavedby) && isdefined(entity.beingmicrowavedby[turret_vehicle_entnum]))
		{
			entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
		}
	}
}

/*
	Name: microwaveentity
	Namespace: smart_cover
	Checksum: 0xC13F2416
	Offset: 0x5068
	Size: 0x850
	Parameters: 1
	Flags: Linked
*/
function microwaveentity(entity)
{
	turret = self;
	turret endon(#"microwave_turret_shutdown", #"death");
	entity endon(#"disconnect", #"death");
	if(isplayer(entity))
	{
		entity endon(#"joined_team", #"joined_spectators");
	}
	turret thread microwaveentitypostshutdowncleanup(entity);
	entity.beingmicrowavedby[turret.turret_vehicle_entnum] = turret.owner;
	entity.microwavedamageinitialdelay = 1;
	entity.microwaveeffect = 0;
	shellshockscalar = 1;
	viewkickscalar = 1;
	damagescalar = 1;
	if(isplayer(entity) && entity hasperk(#"specialty_microwaveprotection"))
	{
		shellshockscalar = getdvarfloat(#"specialty_microwaveprotection_shellshock_scalar", 0.5);
		viewkickscalar = getdvarfloat(#"specialty_microwaveprotection_viewkick_scalar", 0.5);
		damagescalar = getdvarfloat(#"specialty_microwaveprotection_damage_scalar", 0.5);
	}
	if(getgametypesetting(#"competitivesettings") === 1)
	{
		var_756fda07 = function_4d1e7b48(#"hash_4571e9bb8d1be2af");
		var_2b29cf8c = function_4d1e7b48(#"hash_13ef8ef2acaa9aec");
	}
	else
	{
		var_756fda07 = function_4d1e7b48(#"hash_c4add0a4174cd7");
		var_2b29cf8c = function_4d1e7b48(#"hash_2fd689f15507ff4a");
	}
	turret_vehicle_entnum = turret.turret_vehicle_entnum;
	var_2b29cf8c.killcament = turret;
	while(true)
	{
		if(!isdefined(turret) || !isdefined(turret.trigger) || !turret microwaveturretaffectsentity(entity))
		{
			if(!isdefined(entity))
			{
				return;
			}
			if(isdefined(entity.beingmicrowavedby[turret_vehicle_entnum]))
			{
				entity thread status_effect::function_408158ef(var_756fda07.var_67e2281d, var_756fda07.var_18d16a6b);
				entity thread status_effect::function_408158ef(var_2b29cf8c.var_67e2281d, var_2b29cf8c.var_18d16a6b);
				if(isdefined(entity.var_553267c8))
				{
					entity stoprumble(entity.var_553267c8);
					entity.var_553267c8 = undefined;
				}
			}
			entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
			if(isdefined(entity.microwavepoisoning) && entity.microwavepoisoning)
			{
				entity.microwavepoisoning = 0;
			}
			entity notify(#"end_microwaveentitypostshutdowncleanup");
			return;
		}
		damage = (isdefined(level.var_5101157d.bundle.var_d2369c5a) ? level.var_5101157d.bundle.var_d2369c5a : 0) * damagescalar;
		if(level.hardcoremode)
		{
			damage = damage * (isdefined(level.var_5101157d.bundle.var_78c1e37b) ? level.var_5101157d.bundle.var_78c1e37b : 0.25);
		}
		if(!isai(entity) && entity util::mayapplyscreeneffect())
		{
			if(!isdefined(entity.microwavepoisoning) || !entity.microwavepoisoning)
			{
				entity.microwavepoisoning = 1;
				entity.microwaveeffect = 0;
			}
		}
		if(isdefined(entity.microwavedamageinitialdelay))
		{
			wait(randomfloatrange(0.1, 0.3));
			entity.microwavedamageinitialdelay = undefined;
		}
		entity thread status_effect::status_effect_apply(var_2b29cf8c, level.var_5101157d.var_8d86ade8, self, 0);
		entity.microwaveeffect++;
		entity.lastmicrowavedby = turret.owner;
		time = gettime();
		if(isplayer(entity) && isdefined(entity.clientid))
		{
			entity playsoundtoplayer(#"hash_5eecc78116b1fc85", entity);
			if(!entity isremotecontrolling() && time - (isdefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950)
			{
				if(entity.microwaveeffect % 2 == 1)
				{
					entity viewkick(int(25 * viewkickscalar), turret.origin);
					entity.microwaveshellshockandviewkicktime = time;
					entity thread status_effect::status_effect_apply(var_756fda07, level.var_5101157d.var_8d86ade8, self, 0);
					var_83cd8106 = level.var_5101157d.bundle.var_5223868e;
					if(isdefined(var_83cd8106))
					{
						entity playrumbleonentity(var_83cd8106);
						entity.var_553267c8 = var_83cd8106;
					}
				}
			}
			if(!isdefined(turret.var_84ac42b3))
			{
				turret.var_84ac42b3 = [];
			}
			turret.var_84ac42b3[entity.clientid] = 1;
			if(!(isdefined(level.var_5101157d.bundle.var_74dcfa31) ? level.var_5101157d.bundle.var_74dcfa31 : 0) && entity.microwaveeffect % 3 == 2)
			{
				scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, level.var_5101157d.var_8d86ade8, turret.var_84ac42b3.size);
			}
		}
		wait(0.5);
	}
}

/*
	Name: microwaveturretaffectsentity
	Namespace: smart_cover
	Checksum: 0x3E992B87
	Offset: 0x58C0
	Size: 0x4DA
	Parameters: 1
	Flags: Linked
*/
function microwaveturretaffectsentity(entity)
{
	turret = self;
	if(!isalive(entity))
	{
		return 0;
	}
	if(!isplayer(entity) && !isai(entity))
	{
		return 0;
	}
	if(entity.ignoreme === 1)
	{
		return 0;
	}
	if(isdefined(turret.carried) && turret.carried)
	{
		return 0;
	}
	if(turret weaponobjects::isstunned())
	{
		return 0;
	}
	if(isdefined(turret.owner) && entity == turret.owner)
	{
		return 0;
	}
	if(!damage::friendlyfirecheck(turret.owner, entity, 0))
	{
		return 0;
	}
	if(isplayer(entity) && entity geteye()[2] < turret.origin[2])
	{
		return 0;
	}
	if(isai(entity))
	{
		var_caf90a7c = entity.maxs[2] - entity.mins[2] + entity.origin[2];
		if(var_caf90a7c < turret.origin[2])
		{
			return 0;
		}
	}
	if((isdefined(level.var_5101157d.bundle.var_7ba68eb6) ? level.var_5101157d.bundle.var_7ba68eb6 : 0) > 0 && entity.origin[2] > turret.origin[2] + level.var_5101157d.bundle.var_7ba68eb6)
	{
		return 0;
	}
	if(distancesquared(entity.origin, turret.origin) > (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0) * (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0))
	{
		return 0;
	}
	angles = turret getangles();
	realorigin = turret.origin + vectorscale((0, 0, 1), 30);
	forward = anglestoforward(angles);
	origin = realorigin - forward * 50;
	shoot_at_pos = entity getshootatpos(turret);
	var_29d7e93f = vectornormalize(shoot_at_pos - realorigin);
	var_2d95367c = vectordot(var_29d7e93f, forward);
	if(var_2d95367c < 0)
	{
		return 0;
	}
	entdirection = vectornormalize(shoot_at_pos - origin);
	dot = vectordot(entdirection, forward);
	if(dot < cos((isdefined(level.var_5101157d.bundle.var_cbd5f27c) ? level.var_5101157d.bundle.var_cbd5f27c : 0)))
	{
		return 0;
	}
	if(entity damageconetrace(origin, turret, forward) <= 0)
	{
		return 0;
	}
	return 1;
}

