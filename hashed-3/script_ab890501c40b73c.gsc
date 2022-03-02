// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace contracts;

/*
	Name: function_89f2df9
	Namespace: contracts
	Checksum: 0xA7DCFE01
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"contracts", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: contracts
	Checksum: 0xB6AFB595
	Offset: 0x160
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.challengescallbacks))
	{
		level.challengescallbacks = [];
	}
	init_player_contract_events();
	callback::on_finalize_initialization(&finalize_init);
}

/*
	Name: finalize_init
	Namespace: contracts
	Checksum: 0x72FB636B
	Offset: 0x1C0
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function finalize_init()
{
	if(can_process_contracts())
	{
		callback::on_connect(&on_player_connect);
		callback::function_74872db6(&function_74872db6);
		callback::function_189f87c1(&function_189f87c1);
		zm_player::function_a827358a(&function_8968a076);
		level.var_79a93566 = &function_902ef0de;
		level.var_c3e2bb05 = 3;
		/#
			level thread devgui_setup();
			level.var_b4ef4d73 = 1;
		#/
	}
}

/*
	Name: on_player_connect
	Namespace: contracts
	Checksum: 0x6BA71DEB
	Offset: 0x2B8
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self setup_player_contracts(3, &registerpower_grid_displaycontrolrobotmelee);
	self.var_6fd8da7 = 0;
	self.var_45ce0c21 = 0;
	if(self is_contract_active(#"hash_672bb6ed2dd40cab") || (isdefined(level.var_b4ef4d73) && level.var_b4ef4d73))
	{
		self thread function_677a89c8();
	}
	if(self is_contract_active(#"hash_7a3b8f92688f1d73") || (isdefined(level.var_b4ef4d73) && level.var_b4ef4d73))
	{
		self thread function_30dc9a23();
	}
	if(self is_contract_active(#"hash_5a030c886808c790") || (isdefined(level.var_b4ef4d73) && level.var_b4ef4d73))
	{
		self thread function_9d5cd9ee();
	}
	if(self is_contract_active(#"hash_507eaa1fcb5caa86") || (isdefined(level.var_b4ef4d73) && level.var_b4ef4d73))
	{
		self thread function_51db541e();
	}
}

/*
	Name: function_8968a076
	Namespace: contracts
	Checksum: 0xDD77ED0E
	Offset: 0x468
	Size: 0x6A
	Parameters: 10
	Flags: Linked
*/
function function_8968a076(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(idamage > 0)
	{
		self.var_6fd8da7 = 0;
	}
}

/*
	Name: function_74872db6
	Namespace: contracts
	Checksum: 0xAF8D9F68
	Offset: 0x4E0
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function function_74872db6()
{
	if(level.round_number == 20)
	{
		foreach(e_player in getplayers())
		{
			if(!(isdefined(e_player.var_bd1368a8) && e_player.var_bd1368a8))
			{
				e_player function_5b88297d(#"hash_672bb6ed2dd40cab", 1, #"zstandard");
			}
		}
		level notify(#"hash_786860db94bcc0f3");
	}
	if(level.round_number == 30)
	{
		foreach(e_player in getplayers())
		{
			e_player function_5b88297d(#"hash_299f40b6488b37df", 1, #"zstandard");
		}
		callback::function_50fdac80(&function_74872db6);
	}
}

/*
	Name: function_189f87c1
	Namespace: contracts
	Checksum: 0x3BBC052B
	Offset: 0x6A8
	Size: 0x2B8
	Parameters: 0
	Flags: Linked
*/
function function_189f87c1()
{
	switch(level.script)
	{
		case "zm_zodt8":
		{
			var_c5440c34 = #"hash_f680c899a8e4c85";
			break;
		}
		case "zm_towers":
		{
			var_c5440c34 = #"hash_3b61416d88d5e278";
			break;
		}
		case "zm_escape":
		{
			var_c5440c34 = #"hash_14a819778a6fccbb";
			break;
		}
		case "zm_office":
		{
			var_c5440c34 = #"hash_1d8d86a4615a816e";
			break;
		}
		case "zm_mansion":
		{
			var_c5440c34 = #"hash_747a0c756c61f799";
			break;
		}
		case "zm_red":
		{
			var_c5440c34 = #"hash_3574ca7394ce67df";
			break;
		}
		case "zm_white":
		{
			var_c5440c34 = #"hash_37d3b7cdc643e3ed";
			break;
		}
		case "zm_orange":
		{
			var_c5440c34 = #"hash_59ad299e60457948";
			break;
		}
	}
	switch(level.var_837aa533)
	{
		case "zclassic":
		{
			var_fc80b645 = #"hash_753c6b07e7f0d102";
			break;
		}
		case "ztrials":
		{
			var_fc80b645 = #"hash_2ce85363da5ddf3c";
			if(level flag::get("round_reset"))
			{
				return;
			}
			break;
		}
	}
	foreach(e_player in getplayers())
	{
		if(isdefined(var_c5440c34))
		{
			e_player function_5b88297d(var_c5440c34, 1, #"zstandard");
		}
		if(isdefined(var_fc80b645))
		{
			e_player function_5b88297d(var_fc80b645, 1);
		}
	}
}

/*
	Name: can_process_contracts
	Namespace: contracts
	Checksum: 0xA8397C28
	Offset: 0x968
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function can_process_contracts()
{
	if(getdvarint(#"hash_5f85c5979e163766", 0) == 0)
	{
		return false;
	}
	if(getdvarint(#"hash_1b141c095b69af9a", 1) == 0)
	{
		return false;
	}
	/#
		if(getdvarint(#"scr_debug_challenges", 0))
		{
			return true;
		}
	#/
	if(!level.onlinegame || (isdefined(level.var_aa2d5655) && level.var_aa2d5655))
	{
		return false;
	}
	if(util::function_5df4294() == "ztutorial")
	{
		return false;
	}
	return true;
}

/*
	Name: function_5b88297d
	Namespace: contracts
	Checksum: 0x6671410C
	Offset: 0xA58
	Size: 0x13C
	Parameters: 3
	Flags: Linked
*/
function function_5b88297d(var_38280f2f, delta = 1, var_86024473)
{
	if(!can_process_contracts() || !self is_contract_active(var_38280f2f))
	{
		return;
	}
	if(isdefined(var_86024473))
	{
		if(!isdefined(var_86024473))
		{
			var_86024473 = [];
		}
		else if(!isarray(var_86024473))
		{
			var_86024473 = array(var_86024473);
		}
		foreach(var_86603201 in var_86024473)
		{
			if(var_86603201 == util::function_5df4294())
			{
				return;
			}
		}
	}
	self function_902ef0de(var_38280f2f, delta);
}

/*
	Name: function_902ef0de
	Namespace: contracts
	Checksum: 0xE7C7EC4D
	Offset: 0xBA0
	Size: 0x364
	Parameters: 2
	Flags: Linked, Private
*/
function private function_902ef0de(var_38280f2f, delta)
{
	/#
		if(getdvarint(#"scr_contract_debug_multiplier", 0) > 0)
		{
			delta = delta * getdvarint(#"scr_contract_debug_multiplier", 1);
		}
	#/
	if(delta <= 0)
	{
		return;
	}
	target_value = self.pers[#"contracts"][var_38280f2f].target_value;
	old_progress = (isdefined(self.pers[#"contracts"][var_38280f2f].current_value) ? self.pers[#"contracts"][var_38280f2f].current_value : self.pers[#"contracts"][var_38280f2f].var_59cb904f);
	if(old_progress == target_value)
	{
		return;
	}
	new_progress = int(old_progress + delta);
	if(new_progress > target_value)
	{
		new_progress = target_value;
	}
	if(new_progress != old_progress)
	{
		self.pers[#"contracts"][var_38280f2f].current_value = new_progress;
		if(isdefined(level.var_90031a39[var_38280f2f]))
		{
			self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.var_90031a39[var_38280f2f], new_progress);
		}
	}
	if(old_progress < target_value && target_value <= new_progress)
	{
		self.pers[#"contracts"][var_38280f2f].var_be5bf249 = self.pers[#"time_played_total"];
		if(isdefined(level.var_90031a39[var_38280f2f]))
		{
			zm_stats::function_ea5b4947(0);
			self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.var_90031a39[var_38280f2f]);
		}
	}
	/#
		if(getdvarint(#"scr_contract_debug", 0) > 0)
		{
			iprintln((((function_9e72a96(var_38280f2f) + "") + new_progress) + "") + target_value);
			if(old_progress < target_value && target_value <= new_progress)
			{
				iprintln(function_9e72a96(var_38280f2f) + "");
			}
		}
	#/
}

/*
	Name: registerpower_grid_displaycontrolrobotmelee
	Namespace: contracts
	Checksum: 0x5F8F3A3F
	Offset: 0xF10
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function registerpower_grid_displaycontrolrobotmelee(slot)
{
	return function_d17bcd3c(slot);
}

/*
	Name: function_4a56b14d
	Namespace: contracts
	Checksum: 0xCD4ED3D4
	Offset: 0xF40
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_4a56b14d()
{
	if(!can_process_contracts())
	{
		return;
	}
	function_d3fba20e();
}

/*
	Name: function_dff4c02f
	Namespace: contracts
	Checksum: 0x9FBB6143
	Offset: 0xF78
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_dff4c02f()
{
	if(!can_process_contracts() || !self is_contract_active(#"hash_38b41a1f3105c462"))
	{
		return;
	}
	self.var_6fd8da7++;
	if(self.var_6fd8da7 == 100)
	{
		self function_5b88297d(#"hash_38b41a1f3105c462");
	}
}

/*
	Name: function_ac03f21e
	Namespace: contracts
	Checksum: 0x6F865AA7
	Offset: 0x1008
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_ac03f21e()
{
	if(!can_process_contracts() || !self is_contract_active(#"hash_16a10697c6afa82"))
	{
		return;
	}
	if(self.var_72d6f15d !== 2)
	{
		return;
	}
	self.var_45ce0c21++;
	if(self.var_45ce0c21 == 25)
	{
		self function_5b88297d(#"hash_16a10697c6afa82");
	}
}

/*
	Name: function_677a89c8
	Namespace: contracts
	Checksum: 0xE2831274
	Offset: 0x10A8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_677a89c8()
{
	level endon(#"hash_786860db94bcc0f3");
	self endon(#"disconnect");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"weapon_change");
		w_current = s_notify.weapon;
		if(zm_weapons::is_weapon_upgraded(w_current))
		{
			self.var_bd1368a8 = 1;
			return;
		}
	}
}

/*
	Name: function_30dc9a23
	Namespace: contracts
	Checksum: 0x77506D51
	Offset: 0x1148
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_30dc9a23()
{
	self endoncallback(&function_1729afac, #"disconnect", #"perk_vapor_lost");
	var_c16ab86f = 0;
	while(true)
	{
		level waittill(#"start_of_round");
		if(!self zm_perks::function_9a0e9d65())
		{
			var_c16ab86f = 0;
			continue;
		}
		level waittill(#"end_of_round");
		if(self zm_perks::function_9a0e9d65())
		{
			var_c16ab86f++;
		}
		else
		{
			var_c16ab86f = 0;
		}
		if(var_c16ab86f >= 5)
		{
			self function_5b88297d(#"hash_7a3b8f92688f1d73");
			return;
		}
	}
}

/*
	Name: function_1729afac
	Namespace: contracts
	Checksum: 0x5D749496
	Offset: 0x1250
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_1729afac(var_c34665fc)
{
	self endon(#"disconnect");
	if(var_c34665fc == "perk_vapor_lost")
	{
		waittillframeend();
		self thread function_30dc9a23();
	}
}

/*
	Name: function_9d5cd9ee
	Namespace: contracts
	Checksum: 0xED245FC9
	Offset: 0x12A0
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_9d5cd9ee()
{
	self endoncallback(&function_1395d508, #"disconnect", #"destroy_riotshield");
	var_c16ab86f = 0;
	while(true)
	{
		level waittill(#"start_of_round");
		if(!(isdefined(self.hasriotshield) && self.hasriotshield))
		{
			var_c16ab86f = 0;
			continue;
		}
		level waittill(#"end_of_round");
		if(isdefined(self.hasriotshield) && self.hasriotshield)
		{
			var_c16ab86f++;
		}
		else
		{
			var_c16ab86f = 0;
		}
		if(var_c16ab86f >= 10)
		{
			self function_5b88297d(#"hash_5a030c886808c790");
			return;
		}
	}
}

/*
	Name: function_1395d508
	Namespace: contracts
	Checksum: 0x6EF98560
	Offset: 0x13A8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_1395d508(var_c34665fc)
{
	self endon(#"disconnect");
	if(var_c34665fc == "destroy_riotshield")
	{
		waittillframeend();
		self thread function_9d5cd9ee();
	}
}

/*
	Name: function_51db541e
	Namespace: contracts
	Checksum: 0xE141BD4F
	Offset: 0x13F8
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_51db541e()
{
	self endon(#"disconnect");
	var_c16ab86f = 0;
	while(true)
	{
		level waittill(#"start_of_round");
		if(!isdefined(self.var_5417136))
		{
			continue;
		}
		if(!isdefined(self.var_42a6fc40))
		{
			self.var_42a6fc40 = self.var_5417136;
			var_c16ab86f = 0;
			self thread function_1d4fae71();
		}
		else
		{
			var_c16ab86f++;
		}
		if(var_c16ab86f >= 10)
		{
			self function_5b88297d(#"hash_507eaa1fcb5caa86");
			self notify(#"hash_4bf9f2755fe74a0d");
			return;
		}
	}
}

/*
	Name: function_1d4fae71
	Namespace: contracts
	Checksum: 0xDD635842
	Offset: 0x14E0
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function function_1d4fae71()
{
	self endon(#"disconnect", #"hash_4bf9f2755fe74a0d");
	while(true)
	{
		if(!isalive(self) || self.var_42a6fc40 != self.var_5417136)
		{
			self.var_42a6fc40 = undefined;
			return;
		}
		waitframe(1);
	}
}

/*
	Name: devgui_setup
	Namespace: contracts
	Checksum: 0x17E0F488
	Offset: 0x1560
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function devgui_setup()
{
	/#
		var_74757534 = "";
		wait(3);
		function_e07e542b(var_74757534, undefined);
		function_295a8005(var_74757534);
	#/
}

/*
	Name: function_295a8005
	Namespace: contracts
	Checksum: 0x28A8911E
	Offset: 0x15C0
	Size: 0x96C
	Parameters: 1
	Flags: None
*/
function function_295a8005(var_1d89ece6)
{
	/#
		var_bbd68476 = var_1d89ece6 + "";
		var_c8d599b5 = "";
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		var_86418430 = var_bbd68476 + "";
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_86418430 + "", var_c8d599b5 + "");
	#/
}

