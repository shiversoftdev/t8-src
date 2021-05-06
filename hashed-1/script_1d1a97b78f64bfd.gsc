// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6c8abe14025b47c4;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace remote_weapons;

/*
	Name: init_shared
	Namespace: remote_weapons
	Checksum: 0x87D5D22A
	Offset: 0x138
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	if(!isdefined(level.var_4249c222))
	{
		level.var_4249c222 = {};
		level.remoteweapons = [];
		level.remoteexithint = #"hash_17ed51b55d2d46e4";
		callback::on_spawned(&on_player_spawned);
	}
}

/*
	Name: on_player_spawned
	Namespace: remote_weapons
	Checksum: 0xEC64E63D
	Offset: 0x1A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self assignremotecontroltrigger();
}

/*
	Name: removeandassignnewremotecontroltrigger
	Namespace: remote_weapons
	Checksum: 0x5098BAAA
	Offset: 0x1E0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function removeandassignnewremotecontroltrigger(remotecontroltrigger)
{
	arrayremovevalue(self.activeremotecontroltriggers, remotecontroltrigger);
	self assignremotecontroltrigger(1);
}

/*
	Name: assignremotecontroltrigger
	Namespace: remote_weapons
	Checksum: 0xE7878A5D
	Offset: 0x228
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function assignremotecontroltrigger(force_new_assignment = 0)
{
	if(!isdefined(self.activeremotecontroltriggers))
	{
		self.activeremotecontroltriggers = [];
	}
	arrayremovevalue(self.activeremotecontroltriggers, undefined);
	if(!isdefined(self.remotecontroltrigger) || force_new_assignment && self.activeremotecontroltriggers.size > 0)
	{
		self.remotecontroltrigger = self.activeremotecontroltriggers[self.activeremotecontroltriggers.size - 1];
	}
	if(isdefined(self.remotecontroltrigger))
	{
		self.remotecontroltrigger.origin = self.origin;
		self.remotecontroltrigger linkto(self);
	}
}

/*
	Name: registerremoteweapon
	Namespace: remote_weapons
	Checksum: 0xF2EAE12D
	Offset: 0x310
	Size: 0xEE
	Parameters: 5
	Flags: Linked
*/
function registerremoteweapon(weaponname, hintstring, usecallback, endusecallback, hidecompassonuse = 1)
{
	/#
		assert(isdefined(level.remoteweapons));
	#/
	level.remoteweapons[weaponname] = spawnstruct();
	level.remoteweapons[weaponname].hintstring = hintstring;
	level.remoteweapons[weaponname].usecallback = usecallback;
	level.remoteweapons[weaponname].endusecallback = endusecallback;
	level.remoteweapons[weaponname].hidecompassonuse = hidecompassonuse;
}

/*
	Name: useremoteweapon
	Namespace: remote_weapons
	Checksum: 0x80FDFED5
	Offset: 0x408
	Size: 0x12C
	Parameters: 5
	Flags: Linked
*/
function useremoteweapon(weapon, weaponname, immediate, allowmanualdeactivation = 1, always_allow_ride = 0)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	weapon.remoteowner = player;
	weapon.inittime = gettime();
	weapon.remotename = weaponname;
	weapon.remoteweaponallowmanualdeactivation = allowmanualdeactivation;
	weapon thread watchremoveremotecontrolledweapon();
	if(!immediate)
	{
		weapon createremoteweapontrigger();
	}
	else
	{
		weapon thread watchownerdisconnect();
		weapon useremotecontrolweapon(allowmanualdeactivation, always_allow_ride);
	}
}

/*
	Name: watchforhack
	Namespace: remote_weapons
	Checksum: 0x642739E7
	Offset: 0x540
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function watchforhack()
{
	weapon = self;
	weapon endon(#"death");
	waitresult = undefined;
	waitresult = weapon waittill(#"killstreak_hacked");
	if(isdefined(weapon.remoteweaponallowmanualdeactivation) && weapon.remoteweaponallowmanualdeactivation)
	{
		weapon thread watchremotecontroldeactivate();
	}
	weapon.remoteowner = waitresult.hacker;
}

/*
	Name: function_31a1aa18
	Namespace: remote_weapons
	Checksum: 0xFA229EED
	Offset: 0x5E8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_31a1aa18()
{
	weapon = self;
	weapon endremotecontrolweaponuse(0, 1);
}

/*
	Name: watchremoveremotecontrolledweapon
	Namespace: remote_weapons
	Checksum: 0xD563AFC7
	Offset: 0x620
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function watchremoveremotecontrolledweapon()
{
	weapon = self;
	weapon endon(#"remote_weapon_end");
	waitresult = undefined;
	waitresult = weapon waittill(#"death", #"remote_weapon_shutdown");
	if(weapon.watch_remote_weapon_death === 1 && isdefined(waitresult._notify) && waitresult._notify == "remote_weapon_shutdown")
	{
		weapon notify(#"hash_59b25025ce93a142");
		weapon waittill(#"death");
	}
	weapon endremotecontrolweaponuse(0);
	while(isdefined(weapon))
	{
		waitframe(1);
	}
}

/*
	Name: createremoteweapontrigger
	Namespace: remote_weapons
	Checksum: 0x3830B118
	Offset: 0x720
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function createremoteweapontrigger()
{
	weapon = self;
	player = weapon.remoteowner;
	if(isdefined(weapon.usetrigger))
	{
		weapon.usetrigger delete();
	}
	weapon.usetrigger = spawn("trigger_radius_use", player.origin, 0, 32, 32);
	weapon.usetrigger enablelinkto();
	weapon.usetrigger linkto(player);
	weapon.usetrigger sethintlowpriority(1);
	weapon.usetrigger setcursorhint("HINT_NOICON");
	if(isdefined(level.remoteweapons[weapon.remotename]))
	{
		weapon.usetrigger sethintstring(level.remoteweapons[weapon.remotename].hintstring);
	}
	weapon.usetrigger setteamfortrigger(player.team);
	weapon.usetrigger.team = player.team;
	player clientclaimtrigger(weapon.usetrigger);
	player.remotecontroltrigger = weapon.usetrigger;
	player.activeremotecontroltriggers[player.activeremotecontroltriggers.size] = weapon.usetrigger;
	weapon.usetrigger.claimedby = player;
	weapon thread watchweapondeath();
	weapon thread watchownerdisconnect();
	weapon thread watchremotetriggeruse();
	weapon thread watchremotetriggerdisable();
}

/*
	Name: watchweapondeath
	Namespace: remote_weapons
	Checksum: 0xF19AD7FF
	Offset: 0x9A8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function watchweapondeath()
{
	weapon = self;
	weapon.usetrigger endon(#"death");
	weapon waittill(#"death", #"remote_weapon_end");
	if(isdefined(weapon.remoteowner))
	{
		weapon.remoteowner removeandassignnewremotecontroltrigger(weapon.usetrigger);
	}
	weapon.usetrigger delete();
}

/*
	Name: watchownerdisconnect
	Namespace: remote_weapons
	Checksum: 0x40D77A4F
	Offset: 0xA60
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function watchownerdisconnect()
{
	weapon = self;
	weapon endon(#"remote_weapon_end", #"remote_weapon_shutdown");
	if(isdefined(weapon.usetrigger))
	{
		weapon.usetrigger endon(#"death");
	}
	weapon.remoteowner waittill(#"joined_team", #"disconnect", #"joined_spectators");
	endremotecontrolweaponuse(0);
	if(isdefined(weapon) && isdefined(weapon.usetrigger))
	{
		weapon.usetrigger delete();
	}
}

/*
	Name: watchremotetriggerdisable
	Namespace: remote_weapons
	Checksum: 0x80F96690
	Offset: 0xB68
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function watchremotetriggerdisable()
{
	weapon = self;
	weapon endon(#"remote_weapon_end", #"remote_weapon_shutdown");
	weapon.usetrigger endon(#"death");
	weapon.remoteowner endon(#"disconnect");
	while(true)
	{
		weapon.usetrigger triggerenable(!weapon.remoteowner iswallrunning());
		wait(0.1);
	}
}

/*
	Name: allowremotestart
	Namespace: remote_weapons
	Checksum: 0x6965BCE7
	Offset: 0xC30
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function allowremotestart(var_59d2c24b)
{
	player = self;
	if(isdefined(var_59d2c24b) && var_59d2c24b || player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && (!(isdefined(player.carryobject) && (isdefined(player.carryobject.disallowremotecontrol) && player.carryobject.disallowremotecontrol))))
	{
		return 1;
	}
	return 0;
}

/*
	Name: watchremotetriggeruse
	Namespace: remote_weapons
	Checksum: 0xC2F8483F
	Offset: 0xD18
	Size: 0x228
	Parameters: 0
	Flags: Linked
*/
function watchremotetriggeruse()
{
	weapon = self;
	weapon endon(#"death", #"remote_weapon_end");
	if(isbot(weapon.remoteowner))
	{
		return;
	}
	while(true)
	{
		res = undefined;
		res = weapon.usetrigger waittill(#"trigger", #"death");
		if(res._notify == "death")
		{
			return;
		}
		if(weapon.remoteowner isusingoffhand() || weapon.remoteowner iswallrunning() || (weapon.remoteowner util::isusingremote() && weapon.remoteowner.usingremote !== weapon.remotename))
		{
			continue;
		}
		if(isdefined(weapon.hackertrigger) && isdefined(weapon.hackertrigger.progressbar))
		{
			if(weapon.remotename == "killstreak_remote_turret")
			{
				weapon.remoteowner iprintlnbold(#"hash_7b4c84d5307fea60");
			}
			continue;
		}
		if(weapon.remoteowner allowremotestart())
		{
			var_48096e05 = gettime() - (isdefined(weapon.lastusetime) ? weapon.lastusetime : 0);
			if(var_48096e05 > 700)
			{
				useremotecontrolweapon();
			}
		}
	}
}

/*
	Name: useremotecontrolweapon
	Namespace: remote_weapons
	Checksum: 0x18368C86
	Offset: 0xF48
	Size: 0x4A8
	Parameters: 2
	Flags: Linked
*/
function useremotecontrolweapon(allowmanualdeactivation = 1, always_allow_ride = 0)
{
	self endon(#"death");
	weapon = self;
	/#
		assert(isdefined(weapon.remoteowner));
	#/
	weapon.control_initiated = 1;
	weapon.endremotecontrolweapon = 0;
	weapon.remoteowner endon(#"disconnect", #"joined_team");
	weapon.remoteowner disableoffhandweapons();
	weapon.remoteowner disableweaponcycling();
	weapon.remoteowner.dofutz = 0;
	if(!isdefined(weapon.disableremoteweaponswitch))
	{
		remoteweapon = getweapon(#"killstreak_remote");
		weapon.remoteowner giveweapon(remoteweapon);
		weapon.remoteowner switchtoweapon(remoteweapon);
		if(always_allow_ride)
		{
			weapon.remoteowner waittill(#"weapon_change", #"death");
		}
		else
		{
			waitresult = undefined;
			waitresult = weapon.remoteowner waittill(#"weapon_change");
			newweapon = waitresult.weapon;
		}
	}
	if(isdefined(newweapon))
	{
		if(newweapon != remoteweapon || (weapon.remoteowner util::isusingremote() && weapon.remoteowner.usingremote !== weapon.remotename))
		{
			weapon.remoteowner killstreaks::clear_using_remote(1, 1);
			return;
		}
	}
	weapon callback::function_d8abfc3d(#"on_end_game", &function_31a1aa18);
	weapon.var_57446df7 = 1;
	weapon.remoteowner thread killstreaks::watch_for_remove_remote_weapon();
	weapon.remoteowner util::setusingremote(weapon.remotename);
	weapon.remoteowner val::set(#"useremotecontrolweapon", "freezecontrols");
	weapon.remoteowner thread function_4db75132(weapon);
	result = weapon.remoteowner killstreaks::init_ride_killstreak(weapon.remotename, always_allow_ride);
	if(result != "success")
	{
		if(result != "disconnect")
		{
			weapon.remoteowner killstreaks::clear_using_remote();
			weapon thread resetcontrolinitiateduponownerrespawn();
		}
	}
	else
	{
		weapon.controlled = 1;
		weapon.killcament = self;
		weapon notify(#"remote_start");
		if(allowmanualdeactivation)
		{
			weapon thread watchremotecontroldeactivate();
		}
		weapon.remoteowner thread [[level.remoteweapons[weapon.remotename].usecallback]](weapon);
		if(level.remoteweapons[weapon.remotename].hidecompassonuse)
		{
			weapon.remoteowner killstreaks::hide_compass();
		}
	}
	weapon notify(#"hash_356f1aec5e4ecabf");
}

/*
	Name: function_4db75132
	Namespace: remote_weapons
	Checksum: 0xE4485D34
	Offset: 0x13F8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_4db75132(weapon)
{
	weapon waittill(#"death", #"hash_356f1aec5e4ecabf");
	if(isdefined(self))
	{
		self val::reset(#"useremotecontrolweapon", "freezecontrols");
	}
}

/*
	Name: resetcontrolinitiateduponownerrespawn
	Namespace: remote_weapons
	Checksum: 0x8B2B2D86
	Offset: 0x1468
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function resetcontrolinitiateduponownerrespawn()
{
	self endon(#"death");
	self.remoteowner waittill(#"spawned");
	self.control_initiated = 0;
}

/*
	Name: watchremotecontroldeactivate
	Namespace: remote_weapons
	Checksum: 0x3F87B03E
	Offset: 0x14B0
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function watchremotecontroldeactivate()
{
	self notify(#"watchremotecontroldeactivate_remoteweapons");
	self endon(#"watchremotecontroldeactivate_remoteweapons");
	weapon = self;
	weapon endon(#"remote_weapon_end", #"death");
	weapon.remoteowner endon(#"disconnect");
	while(weapon.remoteowner usebuttonpressed())
	{
		waitframe(1);
	}
	while(true)
	{
		timeused = 0;
		while(weapon.remoteowner usebuttonpressed())
		{
			timeused = timeused + 0.05;
			if(timeused > 0.25)
			{
				weapon thread endremotecontrolweaponuse(1);
				weapon.lastusetime = gettime();
				return;
			}
			waitframe(1);
		}
		waitframe(1);
	}
}

/*
	Name: endremotecontrolweaponuse
	Namespace: remote_weapons
	Checksum: 0x87987E5A
	Offset: 0x15F0
	Size: 0x540
	Parameters: 2
	Flags: Linked
*/
function endremotecontrolweaponuse()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildExpression(ScriptOp startOp) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 1185
   at Cerberus.Logic.Decompiler.ProcessInstruction(ScriptOp operation, DecompilerBlock block) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 2343
   at Cerberus.Logic.Decompiler.DecompileBlock(DecompilerBlock decompilerBlock, Int32 tabs) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 998
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 222
/*
function endremotecontrolweaponuse(exitrequestedbyowner, gameended)
{
	weapon = self;
	if(!isdefined(weapon) || (isdefined(weapon.endremotecontrolweapon) && weapon.endremotecontrolweapon))
	{
		return;
	}
	weapon.endremotecontrolweapon = 1;

*/

	/* ======== */

/* 
	Stack: 
*/
	/* ======== */

/* 
	Blocks: 
	Cerberus.Logic.BasicBlock at 0x15F0, end at 0x1B31
	Cerberus.Logic.IfBlock at 0x1628, end at 0x1656
	Cerberus.Logic.WhileLoop at 0x16A8, end at 0x171E
	Cerberus.Logic.IfBlock at 0x1722, end at 0x172C
	Cerberus.Logic.IfBlock at 0x172C, end at 0x1902
	Cerberus.Logic.IfBlock at 0x1748, end at 0x1766
	Cerberus.Logic.IfBlock at 0x1774, end at 0x17EC
	Cerberus.Logic.IfBlock at 0x17B0, end at 0x17E8
	Cerberus.Logic.ElseIfBlock at 0x17EC, end at 0x186C
	Cerberus.Logic.TernaryBlock at 0x183C, end at 0x1860
	Cerberus.Logic.IfBlock at 0x186C, end at 0x1902
	Cerberus.Logic.IfBlock at 0x18A2, end at 0x18C2
	Cerberus.Logic.IfBlock at 0x1902, end at 0x1946
	Cerberus.Logic.IfBlock at 0x1946, end at 0x1A3A
	Cerberus.Logic.IfBlock at 0x195C, end at 0x1A3A
	Cerberus.Logic.IfBlock at 0x196E, end at 0x19EA
	Cerberus.Logic.IfBlock at 0x1992, end at 0x19C2
	Cerberus.Logic.IfBlock at 0x19EA, end at 0x1A3A
	Cerberus.Logic.IfBlock at 0x1A3A, end at 0x1B2E
	Cerberus.Logic.IfBlock at 0x1A42, end at 0x1A92
	Cerberus.Logic.IfBlock at 0x1AAC, end at 0x1ADA
	Cerberus.Logic.IfBlock at 0x1ADA, end at 0x1B2E
*/
	/* ======== */

}

/*
	Name: fadetoblackandbackin
	Namespace: remote_weapons
	Checksum: 0xDD4407FD
	Offset: 0x1B38
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function fadetoblackandbackin()
{
	self endon(#"disconnect");
	lui::screen_fade_out(0.1);
	self destroyhud();
	waitframe(1);
	self notify(#"fade2black");
	lui::screen_fade_in(0.2);
}

/*
	Name: stunstaticfx
	Namespace: remote_weapons
	Checksum: 0x8849A456
	Offset: 0x1BC0
	Size: 0x70
	Parameters: 1
	Flags: None
*/
function stunstaticfx(duration)
{
	self endon(#"remove_remote_weapon");
	wait(duration - 0.5);
	time = duration - 0.5;
	while(time < duration)
	{
		waitframe(1);
		time = time + 0.05;
	}
}

/*
	Name: destroyhud
	Namespace: remote_weapons
	Checksum: 0x36146895
	Offset: 0x1C38
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function destroyhud()
{
	if(isdefined(self))
	{
		self notify(#"stop_signal_failure");
		self.flashingsignalfailure = 0;
		self clientfield::set_to_player("static_postfx", 0);
		self destroyremotehud();
		self util::clientnotify("nofutz");
	}
}

/*
	Name: destroyremotehud
	Namespace: remote_weapons
	Checksum: 0xC33F393D
	Offset: 0x1CC8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function destroyremotehud()
{
	self useservervisionset(0);
	self setinfraredvision(0);
}

/*
	Name: set_static
	Namespace: remote_weapons
	Checksum: 0x5057DB3A
	Offset: 0x1D08
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function set_static(val)
{
	owner = self.owner;
	if(val)
	{
		if(isdefined(owner) && owner.usingvehicle && isdefined(owner.viewlockedentity) && owner.viewlockedentity == self)
		{
			owner clientfield::set_to_player("static_postfx", 1);
		}
	}
	else if(isdefined(owner))
	{
		owner function_3c9e877a();
	}
}

/*
	Name: function_3c9e877a
	Namespace: remote_weapons
	Checksum: 0x9B787B9E
	Offset: 0x1DC0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_3c9e877a()
{
	self clientfield::set_to_player("static_postfx", 0);
}

/*
	Name: do_static_fx
	Namespace: remote_weapons
	Checksum: 0x3D530F72
	Offset: 0x1DF0
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function do_static_fx()
{
	self set_static(1);
	owner = self.owner;
	wait(2);
	if(isdefined(owner))
	{
		owner function_3c9e877a();
	}
	if(isdefined(self))
	{
		self notify(#"static_fx_done");
	}
}

