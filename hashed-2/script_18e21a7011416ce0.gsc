// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;

#namespace namespace_8f39dfb1;

/*
	Name: init
	Namespace: namespace_8f39dfb1
	Checksum: 0x38B949E4
	Offset: 0xD8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "medallion_fx", 1, 1, "int");
	namespace_ee206246::register(#"hash_637ceeb3bef1ea35", #"first_location", #"hash_3531cfab5aa57f4b", &function_fe4dc0ff, &function_3f739fed);
	namespace_ee206246::start(#"hash_637ceeb3bef1ea35");
}

/*
	Name: function_fe4dc0ff
	Namespace: namespace_8f39dfb1
	Checksum: 0xE98F48AF
	Offset: 0x198
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fe4dc0ff(var_a276c861)
{
	level endon(#"end_game");
	if(!isdefined(level.var_c5c448d))
	{
		level.var_c5c448d = 0;
	}
	level.var_c5c448d++;
	if(!var_a276c861)
	{
		function_9e3ff948();
		function_9310fe45();
	}
}

/*
	Name: function_3f739fed
	Namespace: namespace_8f39dfb1
	Checksum: 0xCB6A2CBD
	Offset: 0x218
	Size: 0x34
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3f739fed(var_a276c861, var_19e802fa)
{
	if(!var_a276c861)
	{
		if(var_19e802fa)
		{
			function_3b5f45c();
		}
	}
}

/*
	Name: function_9310fe45
	Namespace: namespace_8f39dfb1
	Checksum: 0xAB34D7E9
	Offset: 0x258
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_9310fe45()
{
	level thread zm_audio::sndmusicsystem_stopandflush();
	waitframe(1);
	level thread zm_audio::sndmusicsystem_playstate("ee_song");
}

/*
	Name: function_9e3ff948
	Namespace: namespace_8f39dfb1
	Checksum: 0xB24BDE68
	Offset: 0x2A0
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_9e3ff948()
{
	var_1a2e422e = 0;
	var_2361f0ab = struct::get_array(#"hash_ef13d6f1414e0f7", "targetname");
	foreach(var_ebacacf2 in var_2361f0ab)
	{
		if(isdefined(var_ebacacf2.script_int) && var_ebacacf2.script_int == level.var_c5c448d)
		{
			var_ebacacf2 thread function_c0862b9e();
			util::wait_network_frame();
		}
	}
	while(true)
	{
		level waittill(#"hash_71162ec98b670d92");
		var_1a2e422e++;
		if(var_1a2e422e >= 4)
		{
			break;
		}
	}
}

/*
	Name: function_c0862b9e
	Namespace: namespace_8f39dfb1
	Checksum: 0xD7CA7B8B
	Offset: 0x3D0
	Size: 0x1BE
	Parameters: 0
	Flags: Linked
*/
function function_c0862b9e()
{
	self.var_6522085c = util::spawn_model(self.model, self.origin, self.angles);
	self.var_6522085c setcandamage(1);
	self.var_6522085c.health = 1000000;
	if(isdefined(level.var_35d6e654))
	{
		self thread [[level.var_35d6e654]]();
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self.var_6522085c waittill(#"damage");
		if(!isdefined(waitresult.attacker) || !isplayer(waitresult.attacker))
		{
			continue;
		}
		if(isdefined(level.musicsystemoverride) && level.musicsystemoverride)
		{
			continue;
		}
		waitresult.attacker playsoundtoplayer(#"hash_3ffdc84cf43cae2b", waitresult.attacker);
		level notify(#"hash_71162ec98b670d92");
		break;
	}
	self.var_6522085c clientfield::set("medallion_fx", 1);
	util::wait_network_frame();
	self.var_6522085c delete();
	self.var_6522085c = undefined;
}

/*
	Name: function_3b5f45c
	Namespace: namespace_8f39dfb1
	Checksum: 0x5758A296
	Offset: 0x598
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_3b5f45c()
{
	var_2361f0ab = struct::get_array(#"hash_ef13d6f1414e0f7", "targetname");
	foreach(var_ebacacf2 in var_2361f0ab)
	{
		if(isdefined(var_ebacacf2.var_6522085c))
		{
			var_ebacacf2.var_6522085c delete();
			util::wait_network_frame();
		}
	}
}

