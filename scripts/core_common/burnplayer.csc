// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace burnplayer;

/*
	Name: function_89f2df9
	Namespace: burnplayer
	Checksum: 0x7CC68C0F
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"burnplayer", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: burnplayer
	Checksum: 0xF161DDB7
	Offset: 0x158
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "burn", 1, 1, "int", &burning_callback, 0, 1);
	clientfield::register("playercorpse", "burned_effect", 1, 1, "int", &burning_corpse_callback, 0, 1);
	loadeffects();
	callback::on_localplayer_spawned(&on_localplayer_spawned);
	callback::on_localclient_connect(&on_local_client_connect);
}

/*
	Name: loadeffects
	Namespace: burnplayer
	Checksum: 0x4BFB0CA4
	Offset: 0x248
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function loadeffects()
{
	level.burntags = [];
}

/*
	Name: on_local_client_connect
	Namespace: burnplayer
	Checksum: 0x7E073BBB
	Offset: 0x268
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function on_local_client_connect(localclientnum)
{
}

/*
	Name: on_localplayer_spawned
	Namespace: burnplayer
	Checksum: 0xD0D0CE5
	Offset: 0x280
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	if(self function_21c0fa55() && self clientfield::get("burn") == 0)
	{
		self postfx::stoppostfxbundle("pstfx_burn_loop");
	}
}

/*
	Name: burning_callback
	Namespace: burnplayer
	Checksum: 0x5B1856F1
	Offset: 0x2F8
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function burning_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_a6cb96f(localclientnum);
		self function_adae7d84(localclientnum);
	}
	else
	{
		self function_8227cec3(localclientnum);
		self function_68a11df6(localclientnum);
	}
}

/*
	Name: burning_corpse_callback
	Namespace: burnplayer
	Checksum: 0x54BD2557
	Offset: 0x3A8
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function burning_corpse_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self set_corpse_burning(localclientnum);
	}
	else
	{
		self function_8227cec3(localclientnum);
		self function_68a11df6(localclientnum);
	}
}

/*
	Name: set_corpse_burning
	Namespace: burnplayer
	Checksum: 0x1936403E
	Offset: 0x440
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_corpse_burning(localclientnum)
{
	self thread _burnbody(localclientnum, 1);
}

/*
	Name: function_8227cec3
	Namespace: burnplayer
	Checksum: 0x7D2E7A42
	Offset: 0x478
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_8227cec3(localclientnum)
{
	if(self function_21c0fa55())
	{
		self postfx::stoppostfxbundle("pstfx_burn_loop");
		self playsound(0, #"hash_41520794c2fd8aa");
	}
}

/*
	Name: function_68a11df6
	Namespace: burnplayer
	Checksum: 0x162A21E
	Offset: 0x4E8
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_68a11df6(localclientnum)
{
	self notify(#"burn_off");
}

/*
	Name: function_a6cb96f
	Namespace: burnplayer
	Checksum: 0x301DCE57
	Offset: 0x510
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_a6cb96f(localclientnum)
{
	if(self function_21c0fa55() && !isthirdperson(localclientnum) && !self isremotecontrolling(localclientnum))
	{
		self thread burn_on_postfx();
	}
}

/*
	Name: function_adae7d84
	Namespace: burnplayer
	Checksum: 0xB12FF0A8
	Offset: 0x590
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_adae7d84(localclientnum)
{
	if(!self function_21c0fa55() || isthirdperson(localclientnum))
	{
		self thread _burnbody(localclientnum);
	}
}

/*
	Name: burn_on_postfx
	Namespace: burnplayer
	Checksum: 0xE45B3D6F
	Offset: 0x5F0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function burn_on_postfx()
{
	self endon(#"burn_off");
	self endon(#"death");
	self notify(#"burn_on_postfx");
	self endon(#"burn_on_postfx");
	self playsound(0, #"hash_791f349cb716e078");
	self thread postfx::playpostfxbundle(#"pstfx_burn_loop");
}

/*
	Name: _burntag
	Namespace: burnplayer
	Checksum: 0xB01534F1
	Offset: 0x690
	Size: 0x9C
	Parameters: 3
	Flags: Linked, Private
*/
private function _burntag(localclientnum, tag, postfix)
{
	if(isdefined(self) && self hasdobj(localclientnum))
	{
		fxname = ("burn_" + tag) + postfix;
		if(isdefined(level._effect[fxname]))
		{
			return util::playfxontag(localclientnum, level._effect[fxname], self, tag);
		}
	}
}

/*
	Name: _burntagson
	Namespace: burnplayer
	Checksum: 0x7E246FDA
	Offset: 0x738
	Size: 0x1B4
	Parameters: 3
	Flags: Linked, Private
*/
private function _burntagson(localclientnum, tags, var_71742e03)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self endon(#"burn_off");
	self notify(#"burn_tags_on");
	self endon(#"burn_tags_on");
	if(var_71742e03)
	{
		self util::waittill_dobj(localclientnum);
		activefx = playtagfxset(localclientnum, "weapon_hero_molotov_fire_3p", self);
	}
	else
	{
		activefx = [];
		for(i = 0; i < tags.size; i++)
		{
			activefx[activefx.size] = self _burntag(localclientnum, tags[i], "_loop");
		}
	}
	playsound(0, #"chr_ignite", self.origin);
	burnsound = self playloopsound(#"chr_burn_loop_overlay", 0.5);
	self thread _burntagswatchend(localclientnum, activefx, burnsound);
	self thread _burntagswatchclear(localclientnum, activefx, burnsound);
}

/*
	Name: _burnbody
	Namespace: burnplayer
	Checksum: 0x65C83E85
	Offset: 0x8F8
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
private function _burnbody(localclientnum, var_71742e03 = 0)
{
	self endon(#"death");
	self thread _burntagson(localclientnum, level.burntags, var_71742e03);
}

/*
	Name: _burntagswatchend
	Namespace: burnplayer
	Checksum: 0x41882148
	Offset: 0x960
	Size: 0xF0
	Parameters: 3
	Flags: Linked, Private
*/
private function _burntagswatchend(localclientnum, fxarray, burnsound)
{
	self waittill(#"burn_off", #"death");
	if(isdefined(self) && isdefined(burnsound))
	{
		self stoploopsound(burnsound, 1);
	}
	if(isdefined(fxarray))
	{
		foreach(fx in fxarray)
		{
			stopfx(localclientnum, fx);
		}
	}
}

/*
	Name: _burntagswatchclear
	Namespace: burnplayer
	Checksum: 0x7EE5D735
	Offset: 0xA58
	Size: 0xD8
	Parameters: 3
	Flags: Linked, Private
*/
private function _burntagswatchclear(localclientnum, fxarray, burnsound)
{
	self endon(#"burn_off");
	self waittill(#"death");
	if(isdefined(burnsound))
	{
		stopsound(burnsound);
	}
	if(isdefined(fxarray))
	{
		foreach(fx in fxarray)
		{
			stopfx(localclientnum, fx);
		}
	}
}

