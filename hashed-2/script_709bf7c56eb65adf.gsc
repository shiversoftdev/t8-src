// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_240ef62ff60b2694;
#using scripts\core_common\aat_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\util.csc;
#using scripts\zm_common\zm_audio.csc;
#using scripts\zm_common\zm_bgb.csc;
#using scripts\zm_common\zm_equipment.csc;
#using scripts\zm_common\zm_magicbox.csc;
#using scripts\zm_common\zm_score.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_2ba51478;

/*
	Name: function_89f2df9
	Namespace: namespace_2ba51478
	Checksum: 0x311BB2D
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1f11cdc1b149b62b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2ba51478
	Checksum: 0xCA82CDEE
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		if(!isdemoplaying())
		{
			callback::on_localplayer_spawned(&on_localplayer_spawned);
		}
	#/
}

/*
	Name: on_localplayer_spawned
	Namespace: namespace_2ba51478
	Checksum: 0x2DF0B8D6
	Offset: 0x1A8
	Size: 0x1FE
	Parameters: 1
	Flags: None
*/
function on_localplayer_spawned(localclientnum)
{
	self.class_num = 0;
	if(isplayer(self))
	{
		self.class_num = function_cc90c352(localclientnum);
	}
	self.loadout = [];
	var_cd6fae8c = self function_2dfb9150(localclientnum, "primarygrenade");
	self.loadout[#"lethal"] = getunlockableiteminfofromindex(var_cd6fae8c, 1);
	var_9aeb4447 = self function_2dfb9150(localclientnum, "primary");
	self.loadout[#"primary"] = getunlockableiteminfofromindex(var_9aeb4447, 1);
	self.loadout[#"perks"] = [];
	for(i = 1; i <= 4; i++)
	{
		var_96861ec8 = self function_2dfb9150(localclientnum, "specialty" + i);
		self.loadout[#"perks"][i] = getunlockableiteminfofromindex(var_96861ec8, 3);
	}
	self.loadout[#"hero"] = self function_439b009a(localclientnum, "herogadget");
}

/*
	Name: function_622d8349
	Namespace: namespace_2ba51478
	Checksum: 0x1003D3E0
	Offset: 0x3B0
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_622d8349(localclientnum)
{
	level endon(#"demo_jump");
	while(!self function_22e5ebee(localclientnum))
	{
		waitframe(1);
	}
}

/*
	Name: function_2dfb9150
	Namespace: namespace_2ba51478
	Checksum: 0xCCC93D89
	Offset: 0x400
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function function_2dfb9150(localclientnum, slot)
{
	if(!isplayer(self))
	{
		return undefined;
	}
	if(!isdefined(self.class_num))
	{
		self.class_num = function_cc90c352(localclientnum);
	}
	if(!isdefined(self.class_num))
	{
		self.class_num = 0;
	}
	return self getloadoutitem(localclientnum, self.class_num, slot);
}

/*
	Name: function_439b009a
	Namespace: namespace_2ba51478
	Checksum: 0x801F5CE5
	Offset: 0x4A0
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function function_439b009a(localclientnum, slot)
{
	if(!isplayer(self))
	{
		return undefined;
	}
	if(!isdefined(self.class_num))
	{
		self.class_num = function_cc90c352(localclientnum);
	}
	if(!isdefined(self.class_num))
	{
		self.class_num = 0;
	}
	return self getloadoutweapon(localclientnum, self.class_num, slot);
}

