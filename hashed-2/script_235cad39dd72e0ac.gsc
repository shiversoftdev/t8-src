// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;

#namespace namespace_65dba40e;

/*
	Name: function_89f2df9
	Namespace: namespace_65dba40e
	Checksum: 0x40973CBF
	Offset: 0x160
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_20e082d89ccb3c", &__init__, &__main__, undefined);
}

#namespace namespace_698343df;

/*
	Name: __constructor
	Namespace: namespace_698343df
	Checksum: 0x80F724D1
	Offset: 0x1B0
	Size: 0x4
	Parameters: 0
	Flags: Linked, 8, 128
*/
function __constructor()
{
}

/*
	Name: __destructor
	Namespace: namespace_698343df
	Checksum: 0x80F724D1
	Offset: 0x1C0
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_65dba40e;

/*
	Name: function_698343df
	Namespace: namespace_65dba40e
	Checksum: 0xD20C2082
	Offset: 0x1D0
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_698343df()
{
	classes.var_698343df[0] = spawnstruct();
	classes.var_698343df[0].__vtable[913321084] = &namespace_698343df::__destructor;
	classes.var_698343df[0].__vtable[674154906] = &namespace_698343df::__constructor;
}

/*
	Name: __init__
	Namespace: namespace_65dba40e
	Checksum: 0x5B471977
	Offset: 0x260
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(4), "int", &function_dcc24343, 0, 0);
	clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(8), "int", &function_6bcf2a61, 0, 0);
}

/*
	Name: __main__
	Namespace: namespace_65dba40e
	Checksum: 0x606EB934
	Offset: 0x320
	Size: 0x11C
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	function_15dea507(1, "zm_aoe_spear", "zm_aoe_spear");
	function_15dea507(2, "zm_aoe_spear_small", "zm_aoe_spear_small");
	function_15dea507(3, "zm_aoe_spear_big", "zm_aoe_spear_big");
	function_15dea507(4, "zm_aoe_strafe_storm", "zm_aoe_strafe_storm");
	function_15dea507(5, "zm_aoe_chaos_bolt", "zm_aoe_chaos_bolt");
	function_15dea507(6, "zm_aoe_chaos_bolt_2", "zm_aoe_chaos_bolt_2");
	function_15dea507(7, "zm_aoe_chaos_bolt_annihilate", "zm_aoe_chaos_bolt_annihilate");
}

/*
	Name: function_e969e75
	Namespace: namespace_65dba40e
	Checksum: 0x43A774DF
	Offset: 0x448
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e969e75(var_2fb5df20)
{
	/#
		assert(isdefined(level.var_400ae143));
	#/
	if(!isdefined(level.var_400ae143))
	{
		level.var_400ae143 = [];
	}
	foreach(var_46f1b5eb in level.var_400ae143)
	{
		/#
			assert(isdefined(var_46f1b5eb.var_2fb5df20));
		#/
		if(var_46f1b5eb.var_2fb5df20 == var_2fb5df20)
		{
			return var_46f1b5eb;
		}
	}
	return undefined;
}

/*
	Name: function_15dea507
	Namespace: namespace_65dba40e
	Checksum: 0xF7181C5F
	Offset: 0x540
	Size: 0x246
	Parameters: 3
	Flags: Linked
*/
function function_15dea507(var_2fb5df20, type, var_5ff737c1)
{
	/#
		assert(isdefined(var_5ff737c1));
	#/
	var_6ec6e01 = getscriptbundle(var_5ff737c1);
	if(!isdefined(var_6ec6e01))
	{
		return;
	}
	if(!isdefined(level.var_400ae143))
	{
		level.var_400ae143 = [];
	}
	arraykeys = getarraykeys(level.var_400ae143);
	/#
		assert(!isinarray(arraykeys, hash(type)));
	#/
	object = new var_698343df();
	[[ object ]]->__constructor();
	var_46f1b5eb = object;
	level.var_400ae143[type] = var_46f1b5eb;
	var_46f1b5eb.startfx = var_6ec6e01.start_effect;
	var_46f1b5eb.var_d2da0b88 = var_6ec6e01.end_effect;
	var_46f1b5eb.loopfx = var_6ec6e01.var_102fffc4;
	var_46f1b5eb.startsound = var_6ec6e01.var_e41627fe;
	var_46f1b5eb.var_7404e5a0 = var_6ec6e01.var_99ec7d60;
	var_46f1b5eb.loopsound = var_6ec6e01.var_1ee49376;
	var_46f1b5eb.var_fbd0f7e5 = var_6ec6e01.var_fbd0f7e5;
	var_46f1b5eb.var_d791c45 = var_6ec6e01.var_d791c45;
	var_46f1b5eb.var_a8609f98 = var_6ec6e01.var_a8609f98;
	var_46f1b5eb.earthquakescale = var_6ec6e01.earthquakescale;
	var_46f1b5eb.var_e4c85a5f = var_6ec6e01.var_e4c85a5f;
	var_46f1b5eb.effectradius = var_6ec6e01.effectradius;
	var_46f1b5eb.var_2fb5df20 = var_2fb5df20;
}

/*
	Name: function_dcc24343
	Namespace: namespace_65dba40e
	Checksum: 0xFE437BA8
	Offset: 0x790
	Size: 0x3FC
	Parameters: 7
	Flags: Linked, Private
*/
private function function_dcc24343(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!isdefined(self.var_2fb5df20))
	{
		return;
	}
	player = function_5c10bd79(localclientnum);
	var_12cdcde0 = self.origin;
	distsq = distancesquared(player.origin, var_12cdcde0);
	var_46f1b5eb = function_e969e75(self.var_2fb5df20);
	if(!isdefined(var_46f1b5eb))
	{
		return;
	}
	if(newval == 1)
	{
		if(isdefined(var_46f1b5eb.startfx))
		{
			playfx(localclientnum, var_46f1b5eb.startfx, self.origin, (0, 0, 1));
		}
		if(isdefined(var_46f1b5eb.startsound))
		{
			playsound(localclientnum, var_46f1b5eb.startsound, self.origin);
		}
		if(isdefined(var_46f1b5eb.effectradius) && distsq <= var_46f1b5eb.effectradius * var_46f1b5eb.effectradius)
		{
			if(isdefined(var_46f1b5eb.earthquakescale))
			{
				earthquake(localclientnum, var_46f1b5eb.earthquakescale, var_46f1b5eb.var_e4c85a5f, self.origin, var_46f1b5eb.effectradius);
			}
			if(isdefined(var_46f1b5eb.var_fbd0f7e5))
			{
				function_36e4ebd4(localclientnum, var_46f1b5eb.var_fbd0f7e5);
			}
		}
	}
	else if(newval == 2)
	{
		if(isdefined(var_46f1b5eb.loopfx))
		{
			self.var_40907d55 = playfx(localclientnum, var_46f1b5eb.loopfx, self.origin, (0, 0, 1));
		}
		if(isdefined(var_46f1b5eb.loopsound))
		{
			self.var_e0952422 = self playloopsound(var_46f1b5eb.loopsound);
		}
	}
	else if(newval == 3 || newval == 4)
	{
		if(isdefined(self.var_40907d55))
		{
			stopfx(localclientnum, self.var_40907d55);
		}
		if(isdefined(self.var_e0952422))
		{
			self stoploopsound(self.var_e0952422);
			self.var_e0952422 = undefined;
		}
		if(isdefined(var_46f1b5eb.var_d2da0b88))
		{
			playfx(localclientnum, var_46f1b5eb.var_d2da0b88, self.origin, (0, 0, 1));
		}
		if(isdefined(var_46f1b5eb.var_7404e5a0))
		{
			playsound(localclientnum, var_46f1b5eb.var_7404e5a0, self.origin);
		}
		if(isdefined(var_46f1b5eb.effectradius) && distsq <= var_46f1b5eb.effectradius * var_46f1b5eb.effectradius)
		{
			if(isdefined(var_46f1b5eb.var_fbd0f7e5))
			{
				function_36e4ebd4(localclientnum, var_46f1b5eb.var_d791c45);
			}
		}
	}
}

/*
	Name: function_6bcf2a61
	Namespace: namespace_65dba40e
	Checksum: 0x51145609
	Offset: 0xB98
	Size: 0x4A
	Parameters: 7
	Flags: Linked, Private
*/
private function function_6bcf2a61(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.var_2fb5df20 = newval;
}

