// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_330e1a53a92b38cc;
#using script_3b8f43c68572f06;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace laststand;

/*
	Name: __init__system__
	Namespace: laststand
	Checksum: 0xAFDB1CF4
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"laststand", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: laststand
	Checksum: 0xC7AA274F
	Offset: 0x2D0
	Size: 0x23C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	revive_hud::register("revive_hud");
	mp_revive_prompt::register("mp_revive_prompt_1");
	mp_revive_prompt::register("mp_revive_prompt_2");
	mp_revive_prompt::register("mp_revive_prompt_3");
	mp_revive_prompt::register("mp_revive_prompt_4");
	clientfield::register("clientuimodel", "hudItems.laststand.progress", 1, 5, "float", &function_e71af9c9, 0, 0);
	clientfield::register("clientuimodel", "hudItems.laststand.beingRevived", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.laststand.revivingClientNum", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.laststand.reviveProgress", 1, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "EnemyTeamLastLivesData.numPlayersDowned", 1, 3, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "PlayerTeamLastLivesData.numPlayersDowned", 1, 3, "int", undefined, 0, 0);
	clientfield::register("allplayers", "laststand_bleed", 1, 1, "int", &laststand_bleed, 0, 0);
	level thread wait_and_set_revive_shader_constant();
}

/*
	Name: function_e71af9c9
	Namespace: laststand
	Checksum: 0x5304E534
	Offset: 0x518
	Size: 0x1CC
	Parameters: 7
	Flags: None
*/
function function_e71af9c9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_5c10bd79(localclientnum);
	if(newval)
	{
		if(!self postfx::function_556665f2("pstfx_drowning"))
		{
			self postfx::playpostfxbundle("pstfx_drowning");
			value = 0.99;
			self postfx::function_c8b5f318("pstfx_drowning", #"outer radius", value);
			self postfx::function_c8b5f318("pstfx_drowning", #"inner radius", value - 0.3);
			self postfx::function_c8b5f318("pstfx_drowning", #"opacity", 1);
		}
		if(newval > 0.5)
		{
			if(oldval == 0)
			{
				oldval = newval;
				newval = oldval - 0.05;
			}
			player thread function_8960f852(oldval, newval);
		}
	}
	else if(self postfx::function_556665f2("pstfx_drowning"))
	{
		postfx::stoppostfxbundle("pstfx_drowning");
	}
}

/*
	Name: laststand_bleed
	Namespace: laststand
	Checksum: 0x9F92E6A6
	Offset: 0x6F0
	Size: 0xFE
	Parameters: 7
	Flags: None
*/
function laststand_bleed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death", #"hash_7698972484f247e8");
	if(newval != oldval && newval)
	{
		self util::waittill_dobj(localclientnum);
		self.var_63796ff0 = function_239993de(localclientnum, "player/fx8_plyr_blood_drip_last_stand", self, "j_spine4");
	}
	else
	{
		if(isdefined(self.var_63796ff0))
		{
			stopfx(localclientnum, self.var_63796ff0);
		}
		self notify(#"hash_7698972484f247e8");
	}
}

/*
	Name: function_8960f852
	Namespace: laststand
	Checksum: 0x4433BF29
	Offset: 0x7F8
	Size: 0xE8
	Parameters: 2
	Flags: None
*/
function function_8960f852(oldval, newval)
{
	self endon(#"death");
	duration = 1;
	while(duration > 0)
	{
		value = oldval - (oldval - newval) * (1 - duration);
		duration = duration - 0.1;
		self postfx::function_c8b5f318("pstfx_drowning", #"outer radius", value);
		self postfx::function_c8b5f318("pstfx_drowning", #"inner radius", value - 0.8);
		wait(0.1);
	}
}

/*
	Name: wait_and_set_revive_shader_constant
	Namespace: laststand
	Checksum: 0xF6FD96A6
	Offset: 0x8E8
	Size: 0xD0
	Parameters: 0
	Flags: None
*/
function wait_and_set_revive_shader_constant()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"notetrack");
		localclientnum = waitresult.localclientnum;
		if(waitresult.notetrack == "revive_shader_constant")
		{
			player = function_5c10bd79(localclientnum);
			player mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(localclientnum) / 1000);
		}
	}
}

