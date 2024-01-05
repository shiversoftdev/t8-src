// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace jammer;

/*
	Name: init_shared
	Namespace: jammer
	Checksum: 0x3F5DFA74
	Offset: 0x128
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_578f7c6d))
	{
		level.var_578f7c6d = spawnstruct();
	}
	level.var_578f7c6d.weapon = getweapon(#"gadget_jammer");
	if(!isdefined(level.var_6d8e6535))
	{
		level.var_6d8e6535 = [];
	}
	registerclientfields();
}

/*
	Name: registerclientfields
	Namespace: jammer
	Checksum: 0x663FCB41
	Offset: 0x1C0
	Size: 0x1B4
	Parameters: 0
	Flags: Private
*/
function private registerclientfields()
{
	clientfield::register("scriptmover", "isJammed", 9000, 1, "int", &function_43a5b68a, 0, 0);
	clientfield::register("missile", "isJammed", 9000, 1, "int", &function_43a5b68a, 0, 0);
	clientfield::register("vehicle", "isJammed", 9000, 1, "int", &function_43a5b68a, 0, 0);
	clientfield::register("toplayer", "isJammed", 9000, 1, "int", &player_isjammed, 0, 1);
	clientfield::register("missile", "jammer_active", 9000, 1, "int", &jammeractive, 0, 0);
	clientfield::register("toplayer", "jammedvehpostfx", 9000, 1, "int", &function_4a82368f, 0, 1);
}

/*
	Name: jammeractive
	Namespace: jammer
	Checksum: 0xAC22788
	Offset: 0x380
	Size: 0xA4
	Parameters: 7
	Flags: None
*/
function jammeractive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.worldfx))
		{
			self.worldfx = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_disrupt_active", self, "tag_sensor_animate");
		}
		setfxteam(localclientnum, self.worldfx, self.team);
	}
}

/*
	Name: function_43a5b68a
	Namespace: jammer
	Checksum: 0x14F38C95
	Offset: 0x430
	Size: 0x180
	Parameters: 7
	Flags: None
*/
function function_43a5b68a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.weapon) || !isdefined(self.weapon.var_96850284))
	{
		return;
	}
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval == 1)
	{
		self.var_4dc44ba4 = playtagfxset(localclientnum, self.weapon.var_96850284, self);
	}
	else if(newval == 0 && oldval == 1 && isdefined(self.var_4dc44ba4))
	{
		foreach(fx in self.var_4dc44ba4)
		{
			stopfx(localclientnum, fx);
		}
	}
}

/*
	Name: player_isjammed
	Namespace: jammer
	Checksum: 0xCF00D11B
	Offset: 0x5B8
	Size: 0x1AE
	Parameters: 7
	Flags: None
*/
function player_isjammed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self) || !isplayer(self))
	{
		return;
	}
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval == 1)
	{
		self notify(#"stop_sounds");
		self postfx::playpostfxbundle(#"hash_3a2aaa69f5eeab6f");
		playsound(localclientnum, #"hash_4a43757dd4b02977");
		level.var_6d8e6535[localclientnum] = function_604c9983(localclientnum, #"hash_2be3b9789976a6b");
		self thread function_e9e14905(localclientnum);
	}
	else if(newval == 0)
	{
		self postfx::stoppostfxbundle(#"hash_3a2aaa69f5eeab6f");
		if(isdefined(level.var_6d8e6535[localclientnum]) && !bwastimejump)
		{
			playsound(localclientnum, #"hash_112352517abf5b11");
		}
		self notify(#"stop_sounds");
	}
}

/*
	Name: function_e9e14905
	Namespace: jammer
	Checksum: 0x66AA00F8
	Offset: 0x770
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_e9e14905(localclientnum)
{
	self waittill(#"death", #"stop_sounds");
	if(isdefined(level.var_6d8e6535[localclientnum]))
	{
		function_d48752e(localclientnum, level.var_6d8e6535[localclientnum]);
		level.var_6d8e6535[localclientnum] = undefined;
	}
}

/*
	Name: function_4a82368f
	Namespace: jammer
	Checksum: 0x43EB2D01
	Offset: 0x7F8
	Size: 0x9C
	Parameters: 7
	Flags: None
*/
function function_4a82368f(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self postfx::playpostfxbundle(#"hash_68b6dee9bf4fbfbe");
	}
	else if(newval == 0)
	{
		self postfx::stoppostfxbundle(#"hash_68b6dee9bf4fbfbe");
	}
}

