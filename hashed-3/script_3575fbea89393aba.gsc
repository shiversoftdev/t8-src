// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5ed83e40423c3935;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_2daa33c5;

/*
	Name: function_89f2df9
	Namespace: namespace_2daa33c5
	Checksum: 0xD9BF85CC
	Offset: 0x238
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"laststand", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2daa33c5
	Checksum: 0x7B7A17A5
	Offset: 0x280
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!function_f99d2668())
	{
		return;
	}
	setdvar(#"hash_211a0d7f1fd46cfa", 0);
	wz_revive_prompt::register("wz_revive_prompt_1");
	wz_revive_prompt::register("wz_revive_prompt_2");
	wz_revive_prompt::register("wz_revive_prompt_3");
	clientfield::register("clientuimodel", "hudItems.laststand.progress", 1, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.laststand.beingRevived", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.laststand.revivingClientNum", 1, 7, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.laststand.reviveProgress", 1, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.beingFinished", 1, 1, "int", undefined, 0, 0);
	clientfield::register("allplayers", "laststand_bleed", 1, 1, "int", &laststand_bleed, 0, 0);
	level thread wait_and_set_revive_shader_constant();
}

/*
	Name: wait_and_set_revive_shader_constant
	Namespace: namespace_2daa33c5
	Checksum: 0x93751CBE
	Offset: 0x488
	Size: 0xD0
	Parameters: 0
	Flags: Linked
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

/*
	Name: laststand_bleed
	Namespace: namespace_2daa33c5
	Checksum: 0x32E2A262
	Offset: 0x560
	Size: 0x19C
	Parameters: 7
	Flags: Linked
*/
function laststand_bleed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval != oldval && newval && isplayer(self))
	{
		self util::waittill_dobj(localclientnum);
		if(isdefined(self))
		{
			character_index = self getcharacterbodytype();
			fields = getcharacterfields(character_index, currentsessionmode());
			if(isdefined(fields) && (isdefined(fields.digitalblood) ? fields.digitalblood : 0))
			{
				self.var_63796ff0 = function_239993de(localclientnum, "player/fx8_plyr_blood_drip_last_stand_oil", self, "j_spine4");
			}
			else
			{
				self.var_63796ff0 = function_239993de(localclientnum, "player/fx8_plyr_blood_drip_last_stand", self, "j_spine4");
			}
		}
	}
	else if(isdefined(self.var_63796ff0))
	{
		stopfx(localclientnum, self.var_63796ff0);
	}
}

