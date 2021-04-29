// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_49c434794684964a;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace gadget_vision_pulse;

/*
	Name: init_shared
	Namespace: gadget_vision_pulse
	Checksum: 0xFDD50300
	Offset: 0x170
	Size: 0x1AC
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.vision_pulse = [];
	level.var_6f74e5a9 = [];
	level.var_2e3031be = getweapon(#"gadget_vision_pulse");
	callback::on_localplayer_spawned(&on_localplayer_spawned);
	callback::on_spawned(&on_player_spawned);
	callback::on_player_corpse(&on_player_corpse);
	callback::function_17381fe(&function_17381fe);
	clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int", &vision_pulse_changed, 0, 1);
	clientfield::register("toplayer", "toggle_postfx", 1, 1, "int", &toggle_postfx, 0, 1);
	visionset_mgr::register_visionset_info("vision_pulse", 1, 12, undefined, "vision_puls_bw");
	animation::add_notetrack_func(#"hash_2b70e12a1f51ba4b", &function_ab898b2d);
}

/*
	Name: on_localplayer_spawned
	Namespace: gadget_vision_pulse
	Checksum: 0xB36C22CB
	Offset: 0x328
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	if(self function_21c0fa55())
	{
		level.vision_pulse[localclientnum] = 0;
		level.var_6f74e5a9[localclientnum] = 0;
		self.vision_pulse_owner = undefined;
		self.var_f0b8faa1 = undefined;
		self gadgetpulseresetreveal();
		self set_reveal_self(localclientnum, 0);
		self set_reveal_enemy(localclientnum, 0);
		self function_1decc613(localclientnum);
	}
	if(self function_da43934d())
	{
		self function_e9f518c7(1);
	}
}

/*
	Name: on_player_spawned
	Namespace: gadget_vision_pulse
	Checksum: 0x4B6F7532
	Offset: 0x420
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function on_player_spawned(local_client_num)
{
	if(!self hasdobj(local_client_num))
	{
		return;
	}
	self clearanim(#"hash_9b3a79721aa8a1f", 0);
	self clearanim(#"hash_650fcb95cba68c51", 0);
}

/*
	Name: on_player_corpse
	Namespace: gadget_vision_pulse
	Checksum: 0xF39E33D4
	Offset: 0x498
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function on_player_corpse(localclientnum, params)
{
	self endon(#"death");
	var_1edcbdd3 = params.player.visionpulsereveal;
	if(isdefined(var_1edcbdd3) && var_1edcbdd3)
	{
		self.visionpulsereveal = 1;
		self.var_a768b7b6 = params.player.var_a768b7b6;
		self util::waittill_dobj(localclientnum);
		self set_reveal_enemy(localclientnum, 1);
	}
}

/*
	Name: function_17381fe
	Namespace: gadget_vision_pulse
	Checksum: 0x4DDED684
	Offset: 0x560
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_17381fe(localclientnum)
{
	if(shoutcaster::is_shoutcaster(localclientnum))
	{
		localplayer = function_5c10bd79(localclientnum);
		localplayer function_ea179305(localclientnum, shoutcaster::function_2e6e4ee0(localclientnum));
	}
}

/*
	Name: function_e9f518c7
	Namespace: gadget_vision_pulse
	Checksum: 0x9A2A7B2C
	Offset: 0x5E0
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function function_e9f518c7(immediate)
{
	if(isdefined(self))
	{
		self.var_f0b8faa1 = undefined;
		if(isdefined(immediate) && immediate)
		{
			if(self postfx::function_556665f2(#"hash_5a76eaaf7f7e3de5"))
			{
				self postfx::stoppostfxbundle(#"hash_5a76eaaf7f7e3de5");
			}
			if(self postfx::function_556665f2(#"hash_1356e810590b8caf"))
			{
				self postfx::stoppostfxbundle(#"hash_1356e810590b8caf");
			}
		}
		else if(self postfx::function_556665f2(#"hash_5a76eaaf7f7e3de5"))
		{
			self postfx::exitpostfxbundle(#"hash_5a76eaaf7f7e3de5");
		}
		if(self postfx::function_556665f2(#"hash_1356e810590b8caf"))
		{
			self postfx::exitpostfxbundle(#"hash_1356e810590b8caf");
		}
		self.var_1618a13f = undefined;
	}
}

/*
	Name: function_1decc613
	Namespace: gadget_vision_pulse
	Checksum: 0x67F5A62D
	Offset: 0x730
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_1decc613(localclientnum)
{
	if(is_enabled(localclientnum))
	{
	}
	else
	{
		function_e9f518c7(1);
	}
}

/*
	Name: function_5f4276b8
	Namespace: gadget_vision_pulse
	Checksum: 0x1E24B77C
	Offset: 0x780
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_5f4276b8()
{
	self endon(#"hash_f57a252dea202", #"death");
	if(!isplayer(self))
	{
		return;
	}
	while(true)
	{
		if(self function_e2f34c3())
		{
			self clearanim(#"hash_9b3a79721aa8a1f", 0);
			self setanimknob(#"hash_650fcb95cba68c51", 1, 0, 1);
		}
		else
		{
			self clearanim(#"hash_650fcb95cba68c51", 0);
			self setanimknob(#"hash_9b3a79721aa8a1f", 1, 0, 1);
		}
		waitframe(1);
	}
}

/*
	Name: function_3e2cd736
	Namespace: gadget_vision_pulse
	Checksum: 0xD75C2C11
	Offset: 0x8B0
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_3e2cd736(local_client_num)
{
	self endon(#"hash_f57a252dea202");
	wait(0.8);
	level.vision_pulse[local_client_num] = 1;
	level notify(#"hash_7f642789ed08aae0");
}

/*
	Name: function_43c942dc
	Namespace: gadget_vision_pulse
	Checksum: 0xD01377CD
	Offset: 0x908
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_43c942dc(local_client_num)
{
	self endon(#"hash_f57a252dea202");
	wait(0.85);
	level.vision_pulse[local_client_num] = 0;
	level notify(#"hash_7f642789ed08aae0");
}

/*
	Name: function_ab898b2d
	Namespace: gadget_vision_pulse
	Checksum: 0xBA044445
	Offset: 0x960
	Size: 0x414
	Parameters: 1
	Flags: Linked
*/
function function_ab898b2d(notifystring)
{
	self endon(#"death");
	localclientnum = self.localclientnum;
	if(notifystring == "visor_down")
	{
		self thread function_5f4276b8();
		level.var_6f74e5a9[localclientnum] = 1;
	}
	else if(notifystring == "visor_up")
	{
		self clearanim(#"hash_9b3a79721aa8a1f", 0);
		self clearanim(#"hash_650fcb95cba68c51", 0);
		self notify(#"hash_f57a252dea202");
		level.var_6f74e5a9[localclientnum] = 0;
	}
	if(self function_21c0fa55())
	{
		if(notifystring == "visor_up")
		{
			function_e9f518c7();
		}
		else if(notifystring == "overlay_on")
		{
			if(!isdefined(self.var_f0b8faa1))
			{
				function_e9f518c7();
				self thread function_3e2cd736(localclientnum);
				self.var_f0b8faa1 = 1;
				self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
				self postfx::playpostfxbundle(self.var_1618a13f);
				self function_116b95e5(self.var_1618a13f, #"hash_7c1a0903a45d4d45", 0);
				self function_116b95e5(self.var_1618a13f, #"hash_51ebcff0b5d75894", 0);
				self function_116b95e5(self.var_1618a13f, #"hash_2efccfad2b32081a", 1);
				self thread function_844dbcb7(localclientnum);
				self thread function_85e399a9(localclientnum);
				self callback::on_end_game(&function_31a1aa18);
				waitframe(1);
				self.var_168d7f5c = 0;
				enemies = getplayers(localclientnum);
				foreach(enemy in enemies)
				{
					if(isdefined(enemy) && util::function_fbce7263(enemy.team, self.team))
					{
						enemy.var_1d0bc391 = 0;
					}
				}
				extraduration = 3000;
				thread util::lerp_generic(localclientnum, level.var_2e3031be.gadget_pulse_duration + extraduration, &do_vision_world_pulse_lerp_helper);
			}
		}
		else if(notifystring == "overlay_off")
		{
			self notify(#"hash_f57a252dea202");
			self thread function_43c942dc(localclientnum);
			function_e9f518c7();
			self function_f4ebfe85(localclientnum);
		}
	}
}

/*
	Name: function_f4ebfe85
	Namespace: gadget_vision_pulse
	Checksum: 0x93C11E28
	Offset: 0xD80
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_f4ebfe85(localclientnum)
{
	if(isdefined(self))
	{
		players = getplayers(localclientnum);
		foreach(enemy in players)
		{
			if(isdefined(enemy) && isalive(enemy) && util::function_fbce7263(enemy.team, self.team) && (isdefined(enemy.visionpulsereveal) && enemy.visionpulsereveal || (isdefined(enemy.var_f4f50357) && enemy.var_f4f50357)))
			{
				enemy function_5d482e78(#"hash_75f4d8048e6adb94");
				enemy function_5d482e78(#"hash_62b3e8ea5469c2f5");
				enemy function_9b51bc6(localclientnum, 0);
				enemy notify(#"hash_4512d3339b669c7");
			}
		}
	}
}

/*
	Name: function_31a1aa18
	Namespace: gadget_vision_pulse
	Checksum: 0xF106E6E4
	Offset: 0xF20
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_31a1aa18(localclientnum)
{
	local_player = function_5c10bd79(localclientnum);
	if(isdefined(local_player))
	{
		local_player function_432cfdb9(localclientnum);
	}
}

/*
	Name: function_432cfdb9
	Namespace: gadget_vision_pulse
	Checksum: 0xA2D0B5C6
	Offset: 0xF78
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_432cfdb9(localclientnum)
{
	if(isdefined(level.vision_pulse[localclientnum]) && level.vision_pulse[localclientnum])
	{
		self function_e9f518c7(1);
		self function_f4ebfe85(localclientnum);
		level.vision_pulse[localclientnum] = 0;
	}
}

/*
	Name: function_85e399a9
	Namespace: gadget_vision_pulse
	Checksum: 0xAD4B7E77
	Offset: 0x1000
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_85e399a9(localclientnum)
{
	self notify(#"hash_54f15501beb799f9");
	self endon(#"hash_54f15501beb799f9");
	self endon(#"hash_f57a252dea202");
	self waittill(#"death", #"game_ended");
	self function_432cfdb9(localclientnum);
}

/*
	Name: function_844dbcb7
	Namespace: gadget_vision_pulse
	Checksum: 0x5AF269E2
	Offset: 0x1088
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_844dbcb7(localclientnum)
{
	self notify(#"hash_72d43e802a417711");
	self endon(#"hash_72d43e802a417711");
	self endon(#"hash_7271c8549b165d47");
	wait(2);
	if(isdefined(self) && self function_da43934d())
	{
		self function_e9f518c7(1);
		self clearanim(#"hash_9b3a79721aa8a1f", 0);
		self clearanim(#"hash_650fcb95cba68c51", 0);
	}
}

/*
	Name: do_vision_world_pulse_lerp_helper
	Namespace: gadget_vision_pulse
	Checksum: 0x4F494B3E
	Offset: 0x1158
	Size: 0x274
	Parameters: 4
	Flags: Linked
*/
function do_vision_world_pulse_lerp_helper(currenttime, elapsedtime, localclientnum, duration)
{
	if(!isdefined(self))
	{
		return;
	}
	pulseduration = level.var_2e3031be.gadget_pulse_duration;
	if(elapsedtime < pulseduration * 0.1)
	{
		irisamount = elapsedtime / pulseduration * 0.1;
	}
	else if(elapsedtime < pulseduration * 0.6)
	{
		irisamount = 1 - elapsedtime / pulseduration * 0.5;
	}
	else
	{
		irisamount = 0;
	}
	pulseradius = getvisionpulseradius(localclientnum);
	pulsemaxradius = level.var_2e3031be.gadget_pulse_max_range;
	if(pulseradius > 0 && self.var_168d7f5c == 0)
	{
		self.var_168d7f5c = 1;
		playsound(localclientnum, #"hash_151b724086b2955b");
	}
	if(pulseradius > pulsemaxradius)
	{
		if(self.var_168d7f5c * pulsemaxradius < pulseradius)
		{
			self.var_168d7f5c++;
			playsound(localclientnum, #"hash_151b724086b2955b");
		}
		pulseradius = int(pulseradius) % pulsemaxradius;
	}
	if(!isdefined(self.var_1618a13f))
	{
		self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
	}
	if(self postfx::function_556665f2(self.var_1618a13f))
	{
		self function_116b95e5(self.var_1618a13f, #"hash_7c1a0903a45d4d45", pulseradius);
		self function_116b95e5(self.var_1618a13f, #"hash_51ebcff0b5d75894", irisamount);
		self function_116b95e5(self.var_1618a13f, #"hash_2efccfad2b32081a", pulsemaxradius);
	}
}

/*
	Name: vision_pulse_owner_valid
	Namespace: gadget_vision_pulse
	Checksum: 0x423B98C1
	Offset: 0x13D8
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function vision_pulse_owner_valid(owner)
{
	if(isdefined(owner) && isplayer(owner) && isalive(owner))
	{
		return 1;
	}
	return 0;
}

/*
	Name: watch_vision_pulse_owner_death
	Namespace: gadget_vision_pulse
	Checksum: 0xDFE0920B
	Offset: 0x1430
	Size: 0x1A6
	Parameters: 1
	Flags: Linked
*/
function watch_vision_pulse_owner_death(localclientnum)
{
	self endon(#"death");
	self endon(#"finished_local_pulse");
	self notify(#"watch_vision_pulse_owner_death");
	self endon(#"watch_vision_pulse_owner_death");
	owner = self.vision_pulse_owner;
	if(vision_pulse_owner_valid(owner))
	{
		owner waittill(#"death");
	}
	self notify(#"vision_pulse_owner_death");
	self function_5d482e78(#"hash_75f4d8048e6adb94");
	self function_5d482e78(#"hash_62b3e8ea5469c2f5");
	self player::function_f2ba057();
	if(self function_d2503806(#"hash_1978eff2ac047e65"))
	{
		self function_78233d29(#"hash_1978eff2ac047e65", "", #"brightness", 0);
		self function_5d482e78(#"hash_1978eff2ac047e65");
	}
	level callback::callback(#"hash_20f3ac6a6fcbcf39", localclientnum);
	self.vision_pulse_owner = undefined;
}

/*
	Name: do_vision_local_pulse
	Namespace: gadget_vision_pulse
	Checksum: 0xDA7D09BD
	Offset: 0x15E0
	Size: 0x416
	Parameters: 1
	Flags: Linked
*/
function do_vision_local_pulse()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.ProcessInstruction(ScriptOp operation, DecompilerBlock block) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 2527
   at Cerberus.Logic.Decompiler.FindForLoops() in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 1618
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 207
/*
No Output
*/

	/* ======== */

/* 
	Stack: 
*/
	/* ======== */

/* 
	Blocks: 
	Cerberus.Logic.BasicBlock at 0x15E0, end at 0x19F7
	Cerberus.Logic.TernaryBlock at 0x1784, end at 0x17B4
	Cerberus.Logic.TernaryBlock at 0x17BC, end at 0x17D0
	Cerberus.Logic.TernaryBlock at 0x17DA, end at 0x1810
	Cerberus.Logic.WhileLoop at 0x1816, end at 0x1958
	Cerberus.Logic.IfBlock at 0x183A, end at 0x184C
	Cerberus.Logic.IfBlock at 0x1852, end at 0x18BC
	Cerberus.Logic.IfBlock at 0x18CA, end at 0x18E2
	Cerberus.Logic.IfBlock at 0x18E2, end at 0x1912
	Cerberus.Logic.BasicBlock at 0x184C, end at 0x195C
	Cerberus.Logic.BasicBlock at 0x18E2, end at 0x1918
	Cerberus.Logic.BasicBlock at 0x1912, end at 0x1918
*/
	/* ======== */

}

/*
	Name: function_85790e6c
	Namespace: gadget_vision_pulse
	Checksum: 0xEB8C9D5
	Offset: 0x1A00
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_85790e6c(localclientnum)
{
	self endon(#"death", #"disconnect", #"hash_4512d3339b669c7");
	wait(1);
	self function_e9f518c7();
	self function_f4ebfe85(localclientnum);
}

/*
	Name: vision_pulse_changed
	Namespace: gadget_vision_pulse
	Checksum: 0x3512EAF4
	Offset: 0x1A80
	Size: 0x15C
	Parameters: 7
	Flags: Linked
*/
function vision_pulse_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self notify(#"hash_7271c8549b165d47");
	}
	if(newval && bnewent && bwastimejump)
	{
		self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
		self postfx::playpostfxbundle(self.var_1618a13f);
		self function_116b95e5(self.var_1618a13f, #"hash_7c1a0903a45d4d45", 0);
		self function_116b95e5(self.var_1618a13f, #"hash_51ebcff0b5d75894", 0);
		self function_116b95e5(self.var_1618a13f, #"hash_2efccfad2b32081a", 1);
	}
	else if(newval == 0)
	{
		self thread function_85790e6c(localclientnum);
	}
}

/*
	Name: toggle_postfx
	Namespace: gadget_vision_pulse
	Checksum: 0x2C22DD3F
	Offset: 0x1BE8
	Size: 0x10C
	Parameters: 7
	Flags: Linked
*/
function toggle_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(is_active(localclientnum))
	{
		if(newval)
		{
			if(isdefined(self.var_1618a13f) && self postfx::function_556665f2(self.var_1618a13f))
			{
				self postfx::stoppostfxbundle(self.var_1618a13f);
			}
		}
		else if(!isdefined(self.var_1618a13f))
		{
			self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
		}
		if(!self postfx::function_556665f2(self.var_1618a13f))
		{
			self postfx::playpostfxbundle(self.var_1618a13f);
		}
	}
}

/*
	Name: function_ea179305
	Namespace: gadget_vision_pulse
	Checksum: 0xD152B298
	Offset: 0x1D00
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_ea179305(localclientnum, enabled)
{
	if(is_enabled(localclientnum))
	{
		if(enabled)
		{
			if(!isdefined(self.var_1618a13f))
			{
				self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
			}
			if(self postfx::function_556665f2(self.var_1618a13f))
			{
				self postfx::stoppostfxbundle(self.var_1618a13f);
			}
		}
		else if(self postfx::function_556665f2(#"hash_5a76eaaf7f7e3de5"))
		{
			self postfx::stoppostfxbundle(#"hash_5a76eaaf7f7e3de5");
		}
		if(!self postfx::function_556665f2(#"hash_1356e810590b8caf"))
		{
			self.var_1618a13f = #"hash_1356e810590b8caf";
			self postfx::playpostfxbundle(self.var_1618a13f);
		}
	}
}

/*
	Name: function_9e2a452e
	Namespace: gadget_vision_pulse
	Checksum: 0x4CD4ED97
	Offset: 0x1E38
	Size: 0x390
	Parameters: 2
	Flags: Linked
*/
function function_9e2a452e(localclientnum, var_9e58fecb)
{
	self notify("55d14ddd4012cb9a");
	self endon("55d14ddd4012cb9a");
	self endon(#"death", #"disconnect", #"hash_4512d3339b669c7");
	speed = function_c505bc89(localclientnum);
	maxradius = getvisionpulsemaxradius(localclientnum);
	fadeout_duration = level.var_2e3031be.var_8e0b0827;
	jammed = 0;
	if(isplayer(self))
	{
		jammed = self clientfield::get("gps_jammer_active");
	}
	var_8ac8d61d = (isdefined(level.var_2e3031be.var_5be370e9) ? level.var_2e3031be.var_5be370e9 : 1);
	var_6f9f5fef = fadeout_duration * (jammed ? var_8ac8d61d : 1);
	var_42a54adc = var_6f9f5fef * (isdefined(level.var_2e3031be.var_a2d7b97c) ? level.var_2e3031be.var_a2d7b97c : 0.8);
	elapsedtime = 0;
	while(true)
	{
		waitframe(1);
		if(isdefined(self.visionpulsereveal) && self.visionpulsereveal)
		{
			currenttime = getservertime(localclientnum);
			elapsedtime = currenttime - self.var_a768b7b6;
			if(elapsedtime < var_42a54adc)
			{
				alpha = 1;
			}
			else if(elapsedtime < var_6f9f5fef)
			{
				alpha = 1 - elapsedtime - var_42a54adc / var_6f9f5fef - var_42a54adc;
			}
			else if(elapsedtime < fadeout_duration)
			{
				alpha = 0;
			}
			else
			{
				self.visionpulsereveal = 0;
				alpha = 0;
				if(!isdefined(self.var_1d0bc391))
				{
					self.var_1d0bc391 = 0;
				}
				self.var_1d0bc391++;
				self function_5d482e78(var_9e58fecb);
				self function_9b51bc6(localclientnum, 0);
			}
			self function_78233d29(var_9e58fecb, "", "Alpha", alpha);
			if(!isdefined(self.var_1618a13f))
			{
				self.var_1618a13f = #"hash_5a76eaaf7f7e3de5";
			}
			if(self postfx::function_556665f2(self.var_1618a13f))
			{
				self function_116b95e5(self.var_1618a13f, #"hash_37f66a8b81d64e90", 1 - alpha);
			}
		}
	}
}

/*
	Name: set_reveal_enemy
	Namespace: gadget_vision_pulse
	Checksum: 0x4B2F10F6
	Offset: 0x21D0
	Size: 0x2BE
	Parameters: 2
	Flags: Linked
*/
function set_reveal_enemy(localclientnum, on_off)
{
	if(on_off)
	{
		owner = self gadgetpulsegetowner(localclientnum);
		if(isdefined(self.insmoke) && !owner function_21c0fa55())
		{
			return;
		}
		owner thread function_85e399a9(localclientnum);
		if(isalive(owner) && (isdefined(level.gameended) && !level.gameended) && util::function_fbce7263(owner.team, self.team))
		{
			var_9e58fecb = #"hash_75f4d8048e6adb94";
			if(!owner function_21c0fa55())
			{
				var_9e58fecb = #"hash_62b3e8ea5469c2f5";
			}
			if(!(isdefined(self.var_f4f50357) && self.var_f4f50357))
			{
				self function_9b51bc6(localclientnum, 1);
				self player::function_f2ba057();
				self function_bf9d3071(var_9e58fecb);
				self thread function_9e2a452e(localclientnum, var_9e58fecb);
			}
			self function_78233d29(var_9e58fecb, "", "Alpha", 1);
			if(!owner function_21c0fa55())
			{
				self function_78233d29(var_9e58fecb, "", "Tint", 0);
				self function_78233d29(var_9e58fecb, "", "Alpha", 1);
			}
		}
	}
	else
	{
		self function_5d482e78(#"hash_75f4d8048e6adb94");
		self function_5d482e78(#"hash_62b3e8ea5469c2f5");
		self function_9b51bc6(localclientnum, 0);
		self notify(#"hash_4512d3339b669c7");
	}
}

/*
	Name: set_reveal_self
	Namespace: gadget_vision_pulse
	Checksum: 0x3EFBF8AC
	Offset: 0x2498
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function set_reveal_self(localclientnum, on_off)
{
	if(!isplayer(self))
	{
		return;
	}
	if(on_off && self function_da43934d())
	{
		self thread do_vision_local_pulse(localclientnum);
	}
	else if(!on_off)
	{
		if(self function_d2503806(#"hash_1978eff2ac047e65"))
		{
			self function_5d482e78(#"hash_1978eff2ac047e65");
		}
	}
}

/*
	Name: gadget_visionpulse_reveal
	Namespace: gadget_vision_pulse
	Checksum: 0x65D73B09
	Offset: 0x2558
	Size: 0x37E
	Parameters: 2
	Flags: None
*/
function gadget_visionpulse_reveal(localclientnum, breveal)
{
	self notify(#"gadget_visionpulse_changed");
	if(!isdefined(self.visionpulserevealself) && self function_21c0fa55())
	{
		self.visionpulserevealself = 0;
	}
	if(!isdefined(self.visionpulsereveal))
	{
		self.visionpulsereveal = 0;
	}
	if(!isdefined(self))
	{
		return;
	}
	owner = self gadgetpulsegetowner(localclientnum);
	if(owner !== self)
	{
		if(self function_21c0fa55())
		{
			if(self.visionpulserevealself != breveal || (isdefined(self.vision_pulse_owner) && isdefined(owner) && self.vision_pulse_owner != owner))
			{
				self.vision_pulse_owner = owner;
				self.visionpulserevealself = breveal;
				self set_reveal_self(localclientnum, breveal);
			}
		}
		else if(isalive(self) && self.visionpulsereveal != breveal && owner function_e9fc6a64())
		{
			if(isdefined(breveal) && breveal)
			{
				pulseradius = owner function_692b47c1(localclientnum);
				pulsemaxradius = level.var_2e3031be.gadget_pulse_max_range;
				var_168d7f5c = int(pulseradius) / int(pulsemaxradius);
				if(isdefined(self.var_1d0bc391) && self.var_1d0bc391 > 0 && self.var_1d0bc391 >= var_168d7f5c)
				{
					return;
				}
				dist = distance2d(owner.origin, self.origin);
				dist2 = dist * dist;
				radius = int(pulseradius) % pulsemaxradius;
				radius2 = radius * radius;
				if(dist2 > radius2)
				{
					return;
				}
				if(!isdefined(self.var_1d0bc391))
				{
					self.var_1d0bc391 = int(floor(var_168d7f5c) + 1);
					return;
				}
				self.var_a768b7b6 = getservertime(localclientnum);
			}
			self.visionpulsereveal = breveal;
			if(!(isdefined(breveal) && breveal))
			{
				self.var_1d0bc391 = 0;
			}
			self set_reveal_enemy(localclientnum, breveal);
		}
		else if(!(isdefined(breveal) && breveal))
		{
			self.var_1d0bc391 = 0;
		}
	}
}

/*
	Name: function_9b51bc6
	Namespace: gadget_vision_pulse
	Checksum: 0xB014A5AB
	Offset: 0x28E0
	Size: 0x22
	Parameters: 2
	Flags: Linked
*/
function function_9b51bc6(local_client_num, pulsed)
{
	self.var_f4f50357 = pulsed;
}

/*
	Name: is_active
	Namespace: gadget_vision_pulse
	Checksum: 0xA9428738
	Offset: 0x2910
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function is_active(local_client_num)
{
	return isdefined(level.vision_pulse) && (isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num]);
}

/*
	Name: is_enabled
	Namespace: gadget_vision_pulse
	Checksum: 0x940BC142
	Offset: 0x2960
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function is_enabled(local_client_num)
{
	return isdefined(level.var_6f74e5a9) && (isdefined(level.var_6f74e5a9[local_client_num]) && level.var_6f74e5a9[local_client_num]);
}

