// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_3417f8d2;

/*
	Name: function_89f2df9
	Namespace: namespace_3417f8d2
	Checksum: 0x87CC0F87
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_684e9a488b07947", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_3417f8d2
	Checksum: 0xB2F8BC3D
	Offset: 0x170
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	level flag::init(#"hash_7d5f27392b7264ae");
	level flag::init(#"hash_7d5f26392b7262fb");
	level flag::init(#"hash_51ae2a56153f7f83");
	namespace_ee206246::register(#"hash_22d9cdbaac99885", #"step_1", #"hash_7b16b0c7f4445917", &function_a8fa5ac7, &function_8686db4c);
	namespace_ee206246::register(#"hash_22d9cdbaac99885", #"step_2", #"hash_7b16b1c7f4445aca", &function_ebc2f134, &function_dc7d5745);
	namespace_ee206246::register(#"hash_22d9cdbaac99885", #"step_3", #"hash_7b16b2c7f4445c7d", &function_d0d114be, &function_2beb73f6);
	namespace_ee206246::start(#"hash_22d9cdbaac99885");
}

/*
	Name: init_clientfields
	Namespace: namespace_3417f8d2
	Checksum: 0xC94D56A3
	Offset: 0x330
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_671ee63741834a25", 1, 1, "int");
}

/*
	Name: function_a8fa5ac7
	Namespace: namespace_3417f8d2
	Checksum: 0x1F35ADC0
	Offset: 0x380
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_a8fa5ac7(var_5ea5c94d)
{
	level thread setup_phone_audio();
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_7d5f27392b7264ae");
	}
}

/*
	Name: function_8686db4c
	Namespace: namespace_3417f8d2
	Checksum: 0x873526A3
	Offset: 0x3D8
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_8686db4c(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_c2e6ed5a++;
	}
	else
	{
		level.var_2363fbdb = 0;
		function_72d3152();
	}
}

/*
	Name: function_ebc2f134
	Namespace: namespace_3417f8d2
	Checksum: 0x9067ADDC
	Offset: 0x440
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_ebc2f134(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_7d5f26392b7262fb");
	}
}

/*
	Name: function_dc7d5745
	Namespace: namespace_3417f8d2
	Checksum: 0x6D33EF3
	Offset: 0x480
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_dc7d5745(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_c2e6ed5a++;
	}
	else
	{
		level.var_2363fbdb = 0;
		function_72d3152();
	}
}

/*
	Name: function_d0d114be
	Namespace: namespace_3417f8d2
	Checksum: 0x7D3A483D
	Offset: 0x4E8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_d0d114be(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level flag::wait_till(#"hash_51ae2a56153f7f83");
	}
}

/*
	Name: function_2beb73f6
	Namespace: namespace_3417f8d2
	Checksum: 0xD54A6845
	Offset: 0x528
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_2beb73f6(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level function_ccd6d7bc();
	}
	else
	{
		level function_ccd6d7bc();
	}
}

/*
	Name: setup_phone_audio
	Namespace: namespace_3417f8d2
	Checksum: 0x4DA8C7F3
	Offset: 0x588
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function setup_phone_audio()
{
	wait(1);
	level.var_2363fbdb = 0;
	level.var_c2e6ed5a = 0;
	level.var_1c33dba2 = getentarray("secret_phone_trig", "targetname");
	array::thread_all(level.var_1c33dba2, &phone_init);
}

/*
	Name: phone_init
	Namespace: namespace_3417f8d2
	Checksum: 0xE48C2454
	Offset: 0x608
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function phone_init()
{
	if(!isdefined(self))
	{
		return;
	}
	self.var_a96a7dbd = struct::get(self.target, "targetname");
	if(isdefined(self.var_a96a7dbd))
	{
		self.var_a96a7dbd scene::play("blinking");
	}
	self usetriggerrequirelookat();
	self setcursorhint("HINT_NOICON");
	self thread function_a546fd97();
}

/*
	Name: function_a546fd97
	Namespace: namespace_3417f8d2
	Checksum: 0xA3655E15
	Offset: 0x6C8
	Size: 0x17E
	Parameters: 0
	Flags: Linked
*/
function function_a546fd97()
{
	self endon(#"death");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"damage");
		var_16829d93 = s_notify.attacker aat::getaatonweapon(s_notify.weapon);
		if(isdefined(var_16829d93) && var_16829d93.name === "zm_aat_kill_o_watt")
		{
			/#
				getplayers()[0] iprintln("");
			#/
			level.var_2363fbdb = level.var_2363fbdb + 1;
			self.var_a96a7dbd scene::play("ring");
			if(level.var_2363fbdb == 3)
			{
				wait(1);
				self thread function_7dbe8985();
				wait(1);
			}
			self waittill(#"hash_3b08f8f9330c59ad");
			self.var_a96a7dbd scene::play("blinking");
			wait(1);
		}
	}
}

/*
	Name: function_7dbe8985
	Namespace: namespace_3417f8d2
	Checksum: 0xC7D24C6C
	Offset: 0x850
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_7dbe8985()
{
	if(level.var_c2e6ed5a == 0)
	{
		namespace_509a75d1::function_e308175e(#"hash_10486eedc1e9fad", self.origin);
		level flag::set(#"hash_7d5f27392b7264ae");
	}
	else if(level.var_c2e6ed5a == 1)
	{
		namespace_509a75d1::function_e308175e(#"hash_6742a63120f41d3b", self.origin);
		level flag::set(#"hash_7d5f26392b7262fb");
	}
	else
	{
		namespace_509a75d1::function_e308175e(#"hash_1678ea887d624d95", self.origin);
		level flag::set(#"hash_51ae2a56153f7f83");
	}
	level.var_c2e6ed5a = level.var_c2e6ed5a + 1;
}

/*
	Name: function_72d3152
	Namespace: namespace_3417f8d2
	Checksum: 0xE575E453
	Offset: 0x980
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_72d3152()
{
	foreach(trigger in level.var_1c33dba2)
	{
		trigger notify(#"hash_3b08f8f9330c59ad");
	}
}

/*
	Name: function_ccd6d7bc
	Namespace: namespace_3417f8d2
	Checksum: 0x2EFA22
	Offset: 0xA08
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_ccd6d7bc()
{
	foreach(trigger in level.var_1c33dba2)
	{
		trigger.var_a96a7dbd scene::play("init");
		trigger delete();
	}
}

