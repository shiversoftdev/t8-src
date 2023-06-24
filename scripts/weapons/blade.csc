// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace blade;

/*
	Name: __init__system__
	Namespace: blade
	Checksum: 0x61BB8363
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"blade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: blade
	Checksum: 0xCABBB4B1
	Offset: 0x188
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localplayer_spawned(&function_e79ccfd8);
	callback::function_f77ced93(&function_f77ced93);
	callback::on_melee(&melee_event);
}

/*
	Name: function_f77ced93
	Namespace: blade
	Checksum: 0x4F7D1910
	Offset: 0x1F8
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(params)
{
	if(self == level || !isplayer(self))
	{
		return;
	}
	localclientnum = params.localclientnum;
	weapon = self function_d2c2b168();
	if(weapon.name == #"sig_blade")
	{
		localplayer = function_5c10bd79(localclientnum);
		if(self == localplayer)
		{
			function_c0c566d4(localclientnum);
		}
		else if(localplayer util::isenemyplayer(self))
		{
			handle = self playloopsound("gdt_spectre_blade_loop");
			self thread function_c980da51(handle);
		}
	}
}

/*
	Name: function_c980da51
	Namespace: blade
	Checksum: 0x6140FC33
	Offset: 0x328
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_c980da51(handle)
{
	self notify("79130178ae681449");
	self endon("79130178ae681449");
	self endon(#"death");
	self waittill(#"weapon_change");
	self stoploopsound(handle);
}

/*
	Name: function_c0c566d4
	Namespace: blade
	Checksum: 0x9292F946
	Offset: 0x398
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_c0c566d4(localclientnum)
{
	self notify("1904df9d4730174b");
	self endon("1904df9d4730174b");
	self endon(#"death");
	self.lunge_rumble = 0;
	while(true)
	{
		if(function_c5afdb1b(localclientnum) && !self.lunge_rumble)
		{
			self playrumblelooponentity(localclientnum, "blade_lunge_loop");
			self.lunge_rumble = 1;
		}
		else if(!function_c5afdb1b(localclientnum) && self.lunge_rumble)
		{
			self stoprumble(localclientnum, "blade_lunge_loop");
			self.lunge_rumble = 0;
		}
		waitframe(1);
	}
}

/*
	Name: melee_event
	Namespace: blade
	Checksum: 0x1A915E33
	Offset: 0x498
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function melee_event(eventstruct)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	if(eventstruct.weapon.name != #"sig_blade")
	{
		return;
	}
	if(!isdefined(eventstruct.victim))
	{
		return;
	}
	if(!isplayer(eventstruct.victim))
	{
		return;
	}
	if(eventstruct.victim == self)
	{
		return;
	}
	self play_blood(eventstruct.localclientnum);
}

/*
	Name: function_e79ccfd8
	Namespace: blade
	Checksum: 0x11EE6D84
	Offset: 0x560
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e79ccfd8(localclientnum)
{
	stop_postfx(localclientnum);
}

/*
	Name: stop_postfx
	Namespace: blade
	Checksum: 0xC3F9FCD9
	Offset: 0x590
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function stop_postfx(localclientnum)
{
	if(function_148ccc79(localclientnum, #"hash_4bc228d5f3bcffe5"))
	{
		codestoppostfxbundlelocal(localclientnum, #"hash_4bc228d5f3bcffe5");
	}
}

/*
	Name: play_blood
	Namespace: blade
	Checksum: 0x8E552AD9
	Offset: 0x5E8
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function play_blood(localclientnum)
{
	if(!isdefined(self.var_2ba49f48))
	{
		self.var_2ba49f48 = spawnstruct();
		self.var_2ba49f48.var_dcb0fc42 = 0;
		function_a837926b(localclientnum, #"hash_4bc228d5f3bcffe5");
		function_4238734d(localclientnum, #"hash_4bc228d5f3bcffe5", "Screen Radius Inner", 256);
		function_4238734d(localclientnum, #"hash_4bc228d5f3bcffe5", "Screen Radius Outer", 512);
		function_4238734d(localclientnum, #"hash_4bc228d5f3bcffe5", "Seed Offset", 0);
		function_4238734d(localclientnum, #"hash_4bc228d5f3bcffe5", "Opacity", 1);
	}
	else if(isdefined(self.var_2ba49f48.blendout) && self.var_2ba49f48.blendout)
	{
		return;
	}
	if(self.var_2ba49f48.var_dcb0fc42 <= 20)
	{
		self.var_2ba49f48.var_dcb0fc42++;
	}
	var_61187e1e = 1 - (self.var_2ba49f48.var_dcb0fc42 * 0.05);
	function_4238734d(localclientnum, #"hash_4bc228d5f3bcffe5", "Sprite Count Squash", var_61187e1e);
	self thread watch_timeout(localclientnum);
}

/*
	Name: watch_timeout
	Namespace: blade
	Checksum: 0xB14C49F5
	Offset: 0x7D8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function watch_timeout(localclientnum)
{
	self notify("33717749f8cb9ab");
	self endon("33717749f8cb9ab");
	self endon(#"death");
	wait(0.5);
	self.var_2ba49f48.blendout = 1;
	util::lerp_generic(localclientnum, 375, &function_2789edf8);
	self.var_2ba49f48 = undefined;
	stop_postfx(localclientnum);
}

/*
	Name: function_2789edf8
	Namespace: blade
	Checksum: 0x63AA44E8
	Offset: 0x880
	Size: 0x7C
	Parameters: 4
	Flags: Linked
*/
function function_2789edf8(currenttime, elapsedtime, localclientnum, duration)
{
	percent = 1;
	if(duration > 0)
	{
		percent = 1 - (elapsedtime / duration);
	}
	function_4238734d(localclientnum, #"hash_4bc228d5f3bcffe5", "Opacity", percent);
}

