// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_421e0a3702e22de;
#using script_52c6c2d1a2ef1b46;
#using script_58c342edd81589fb;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_f7a40df8;

/*
	Name: preload
	Namespace: namespace_f7a40df8
	Checksum: 0x5E0B7277
	Offset: 0x2B8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level flag::init(#"hash_710c2f40baf302c8");
	level flag::init(#"hash_3a8a317fc0b5e5b0");
	level flag::init(#"hash_57d2cbf7d6c2035a");
	level flag::init(#"hash_238e5c8b416f855");
	clientfield::register("scriptmover", "soapstone_start_fx", 24000, 2, "int");
}

/*
	Name: main
	Namespace: namespace_f7a40df8
	Checksum: 0xBC561B96
	Offset: 0x378
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level scene_test_with_reachs();
}

/*
	Name: scene_test_with_reachs
	Namespace: namespace_f7a40df8
	Checksum: 0xD28BD8C0
	Offset: 0x3A0
	Size: 0x3A4
	Parameters: 0
	Flags: Linked
*/
function scene_test_with_reachs()
{
	getent("mama_bear", "targetname") hide();
	getent("papa_bear", "targetname") hide();
	var_4eed727b = getent("electro", "targetname");
	var_4eed727b hide();
	var_28f1732d = getent(var_4eed727b.target, "targetname");
	var_28f1732d hide();
	level.var_6b37a126 = struct::get(var_4eed727b.script_noteworthy, "targetname");
	level.var_6b37a126.var_4eed727b = var_4eed727b;
	level.var_6b37a126.var_28f1732d = var_28f1732d;
	level.var_9369090c = [];
	foreach(var_4eed727b in getentarray("disco", "targetname"))
	{
		var_4eed727b hide();
		var_28f1732d = getent(var_4eed727b.target, "targetname");
		var_28f1732d hide();
		var_1ca0c514 = struct::get(var_4eed727b.script_noteworthy, "targetname");
		var_1ca0c514.var_4eed727b = var_4eed727b;
		var_1ca0c514.var_28f1732d = var_28f1732d;
		if(!isdefined(level.var_9369090c))
		{
			level.var_9369090c = [];
		}
		else if(!isarray(level.var_9369090c))
		{
			level.var_9369090c = array(level.var_9369090c);
		}
		level.var_9369090c[level.var_9369090c.size] = var_1ca0c514;
	}
	level.s_soapstone = struct::get("baby_bear", "targetname");
	level.s_soapstone.is_hot = 1;
	level.s_soapstone.is_charged = 0;
	level.s_soapstone.var_4eed727b = undefined;
	level.s_soapstone.var_e15f0d15 = 0;
	level.s_soapstone.var_b6e5b65f = 2;
	level.s_soapstone.var_d143df71 = 0;
	level function_88a86ef8(3);
}

/*
	Name: function_d878e1ee
	Namespace: namespace_f7a40df8
	Checksum: 0x3E37D855
	Offset: 0x750
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function function_d878e1ee(var_a276c861)
{
	namespace_6747c550::function_7df6bb60(#"hash_2fbec633e5118bab", 4);
	if(!var_a276c861)
	{
		namespace_85e029d3::function_3f9e02b8(7, #"hash_3a5a3e5c65b49526", #"hash_f90cca21dd0dd02", &function_a9c8883f);
		waitframe(1);
		namespace_85e029d3::function_d83490c5(7);
		level flag::wait_till(#"hash_710c2f40baf302c8");
		level thread function_1c744b3f();
		var_4eed727b = getent("papa_bear", "targetname");
		var_4eed727b.s_unitrigger = var_4eed727b zm_unitrigger::create("", 96);
		var_4eed727b.is_placed = 0;
		var_4eed727b thread function_9961d00();
		level thread function_557d25c1();
		var_4eed727b = getent("mama_bear", "targetname");
		var_4eed727b.s_unitrigger = var_4eed727b zm_unitrigger::create("", 96);
		var_4eed727b.is_placed = 0;
		var_4eed727b thread function_9961d00();
		level flag::wait_till(#"hash_3a8a317fc0b5e5b0");
		var_262ca6b1 = getent("porridge", "targetname");
		var_262ca6b1.s_unitrigger = var_262ca6b1 zm_unitrigger::create("", 96);
		var_262ca6b1 function_afa2f621();
	}
}

/*
	Name: function_a9c8883f
	Namespace: namespace_f7a40df8
	Checksum: 0x515D7A56
	Offset: 0x9A8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_a9c8883f()
{
	level flag::set(#"hash_710c2f40baf302c8");
}

/*
	Name: function_afa2f621
	Namespace: namespace_f7a40df8
	Checksum: 0xE52D6CC6
	Offset: 0x9D8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_afa2f621()
{
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	self playsound(#"hash_95a3e7ee778d597");
	self hide();
	s_activation.e_who namespace_3263198e::function_51b752a9("vox_fuse_get");
}

/*
	Name: function_88a86ef8
	Namespace: namespace_f7a40df8
	Checksum: 0x5175528
	Offset: 0xA70
	Size: 0x36A
	Parameters: 1
	Flags: Linked
*/
function function_88a86ef8(n_position)
{
	var_b7ba9e35 = getent("bear_claw", "targetname");
	switch(n_position)
	{
		case 0:
		{
			if(level.s_soapstone.var_d143df71 != 0)
			{
				s_position = struct::get("bear_digit_0", "targetname");
				var_b7ba9e35 rotateto(s_position.angles, 1.5, 0.25, 0.25);
				level.s_soapstone.var_d143df71 = 0;
			}
			break;
		}
		case 1:
		{
			if(level.s_soapstone.var_d143df71 != 1)
			{
				s_position = struct::get("bear_digit_1", "targetname");
				var_b7ba9e35 rotateto(s_position.angles, 1.5, 0.25, 0.25);
				level.s_soapstone.var_d143df71 = 1;
			}
			break;
		}
		case 2:
		{
			if(level.s_soapstone.var_d143df71 != 2)
			{
				s_position = struct::get("bear_digit_2", "targetname");
				var_b7ba9e35 rotateto(s_position.angles, 1.5, 0.25, 0.25);
				level.s_soapstone.var_d143df71 = 2;
			}
			break;
		}
		case 3:
		{
			if(level.s_soapstone.var_d143df71 != 3)
			{
				s_position = struct::get("bear_digit_3", "targetname");
				var_b7ba9e35 rotateto(s_position.angles, 1.5, 0.25, 0.25);
				level.s_soapstone.var_d143df71 = 3;
			}
			break;
		}
		case 4:
		{
			if(level.s_soapstone.var_d143df71 != 4)
			{
				s_position = struct::get("bear_digit_4", "targetname");
				var_b7ba9e35 rotateto(s_position.angles, 1.5, 0.25, 0.25);
				level.s_soapstone.var_d143df71 = 4;
			}
			break;
		}
	}
}

/*
	Name: function_476d4cb5
	Namespace: namespace_f7a40df8
	Checksum: 0x7FBD134A
	Offset: 0xDE8
	Size: 0x340
	Parameters: 0
	Flags: Linked
*/
function function_476d4cb5()
{
	level endon(#"hash_341a7cd7ac11b979");
	level endon(#"hash_3a8a317fc0b5e5b0");
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	if(!level.s_soapstone.is_charged)
	{
		self.var_4eed727b setmodel("p8_zm_ora_soapstone_01");
		self.var_4eed727b clientfield::set("soapstone_start_fx", 0);
		if(level.s_soapstone.var_b6e5b65f == 2)
		{
			self.var_28f1732d setmodel("p8_zm_ora_soapstone_01");
			self.var_28f1732d clientfield::set("soapstone_start_fx", 0);
		}
	}
	else
	{
		if(level.s_soapstone.is_hot)
		{
			self.var_4eed727b setmodel("p8_zm_ora_soapstone_01_hot");
			self.var_4eed727b clientfield::set("soapstone_start_fx", 2);
			if(level.s_soapstone.var_b6e5b65f == 2)
			{
				self.var_28f1732d setmodel("p8_zm_ora_soapstone_01_hot");
				self.var_28f1732d clientfield::set("soapstone_start_fx", 2);
			}
		}
		else
		{
			self.var_4eed727b setmodel("p8_zm_ora_soapstone_01_cold");
			self.var_4eed727b clientfield::set("soapstone_start_fx", 1);
			if(level.s_soapstone.var_b6e5b65f == 2)
			{
				self.var_28f1732d setmodel("p8_zm_ora_soapstone_01_cold");
				self.var_28f1732d clientfield::set("soapstone_start_fx", 1);
			}
		}
	}
	self.var_4eed727b show();
	self.var_4eed727b playsound(#"hash_16631d7fd4c4e599");
	if(level.s_soapstone.var_b6e5b65f == 2)
	{
		self.var_28f1732d show();
	}
	level.s_soapstone.s_placement = self;
	self thread function_b4ad839e();
	level notify(#"hash_341a7cd7ac11b979");
}

/*
	Name: function_b4ad839e
	Namespace: namespace_f7a40df8
	Checksum: 0xDCE68ABF
	Offset: 0x1130
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_b4ad839e()
{
	level endon(#"hash_3a8a317fc0b5e5b0");
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	self.var_4eed727b clientfield::set("soapstone_start_fx", 0);
	self.var_4eed727b playsound(#"hash_5f8cb5b7320b0002");
	self.var_4eed727b hide();
	if(level.s_soapstone.var_b6e5b65f == 2)
	{
		self.var_28f1732d clientfield::set("soapstone_start_fx", 0);
		self.var_28f1732d hide();
	}
	level.s_soapstone.s_placement = undefined;
	level notify(#"hash_3e843e8fbb4920ef");
}

/*
	Name: function_1c744b3f
	Namespace: namespace_f7a40df8
	Checksum: 0xAF4085D8
	Offset: 0x1250
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_1c744b3f()
{
	level endon(#"hash_3a8a317fc0b5e5b0");
	foreach(s_soapstone in level.var_9369090c)
	{
		s_soapstone.s_unitrigger = s_soapstone zm_unitrigger::create("", 128);
	}
	while(true)
	{
		foreach(s_soapstone in level.var_9369090c)
		{
			s_soapstone thread function_476d4cb5();
		}
		level waittill(#"hash_3e843e8fbb4920ef");
	}
	foreach(s_soapstone in level.var_9369090c)
	{
		s_soapstone zm_unitrigger::unregister_unitrigger(s_soapstone.s_unitrigger);
	}
}

/*
	Name: function_557d25c1
	Namespace: namespace_f7a40df8
	Checksum: 0x1F094063
	Offset: 0x1408
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_557d25c1()
{
	level endon(#"hash_3a8a317fc0b5e5b0");
	level.var_6b37a126.s_unitrigger = level.var_6b37a126 zm_unitrigger::create("", 128);
	while(true)
	{
		level.var_6b37a126 thread function_2b438f6f();
		level waittill(#"hash_3e843e8fbb4920ef");
	}
	level.var_6b37a126 zm_unitrigger::unregister_unitrigger(level.var_6b37a126.s_unitrigger);
}

/*
	Name: function_2b438f6f
	Namespace: namespace_f7a40df8
	Checksum: 0x590AC6EE
	Offset: 0x14C8
	Size: 0x350
	Parameters: 0
	Flags: Linked
*/
function function_2b438f6f()
{
	level endon(#"hash_3a8a317fc0b5e5b0");
	level endon(#"hash_341a7cd7ac11b979");
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	if(!level.s_soapstone.is_charged)
	{
		self.var_4eed727b setmodel("p8_zm_ora_soapstone_01");
		self.var_4eed727b clientfield::set("soapstone_start_fx", 0);
		if(level.s_soapstone.var_b6e5b65f == 2)
		{
			self.var_28f1732d setmodel("p8_zm_ora_soapstone_01");
			self.var_28f1732d clientfield::set("soapstone_start_fx", 0);
		}
	}
	else
	{
		if(level.s_soapstone.is_hot)
		{
			self.var_4eed727b setmodel("p8_zm_ora_soapstone_01_hot");
			self.var_4eed727b clientfield::set("soapstone_start_fx", 2);
			if(level.s_soapstone.var_b6e5b65f == 2)
			{
				self.var_28f1732d setmodel("p8_zm_ora_soapstone_01_hot");
				self.var_28f1732d clientfield::set("soapstone_start_fx", 2);
			}
		}
		else
		{
			self.var_4eed727b setmodel("p8_zm_ora_soapstone_01_cold");
			self.var_4eed727b clientfield::set("soapstone_start_fx", 1);
			if(level.s_soapstone.var_b6e5b65f == 2)
			{
				self.var_28f1732d setmodel("p8_zm_ora_soapstone_01_cold");
				self.var_28f1732d clientfield::set("soapstone_start_fx", 1);
			}
		}
	}
	self.var_4eed727b show();
	self.var_4eed727b playsound(#"hash_16631d7fd4c4e599");
	if(level.s_soapstone.var_b6e5b65f == 2)
	{
		self.var_28f1732d show();
	}
	level.s_soapstone.s_placement = self;
	level.s_soapstone.var_e15f0d15 = 0;
	self thread function_a9511f0f();
	level notify(#"hash_341a7cd7ac11b979");
}

/*
	Name: function_a9511f0f
	Namespace: namespace_f7a40df8
	Checksum: 0x23F001F4
	Offset: 0x1820
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_a9511f0f()
{
	level endon(#"hash_3a8a317fc0b5e5b0");
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	self.var_4eed727b clientfield::set("soapstone_start_fx", 0);
	self.var_4eed727b playsound(#"hash_5f8cb5b7320b0002");
	self.var_4eed727b hide();
	if(level.s_soapstone.var_b6e5b65f == 2)
	{
		self.var_28f1732d clientfield::set("soapstone_start_fx", 0);
		self.var_28f1732d hide();
	}
	level.s_soapstone.s_placement = undefined;
	level notify(#"hash_3e843e8fbb4920ef");
}

/*
	Name: function_9961d00
	Namespace: namespace_f7a40df8
	Checksum: 0x61A494FD
	Offset: 0x1940
	Size: 0x54E
	Parameters: 0
	Flags: Linked
*/
function function_9961d00()
{
	level endon(#"hash_3a8a317fc0b5e5b0");
	while(!self.is_placed)
	{
		s_activation = undefined;
		s_activation = self waittill(#"trigger_activated");
		switch(level.s_soapstone.var_d143df71)
		{
			case 0:
			{
				if(level.s_soapstone.is_charged && !level.s_soapstone.is_hot)
				{
					self setmodel("p8_zm_ora_soapstone_01_cold");
					self show();
					level function_88a86ef8(2);
					self playsound(#"hash_7605be4297c1ed23");
					level.s_soapstone.var_b6e5b65f = level.s_soapstone.var_b6e5b65f - 1;
					self.is_placed = 1;
					level flag::clear(#"hash_57d2cbf7d6c2035a");
					level flag::set(#"hash_3a8a317fc0b5e5b0");
				}
				else
				{
					s_activation.e_who namespace_3263198e::function_51b752a9("vox_soap_stones_insert_room_temp", -1, 1, 0);
				}
				break;
			}
			case 3:
			{
				if(level.s_soapstone.is_charged && !level.s_soapstone.is_hot)
				{
					self setmodel("p8_zm_ora_soapstone_01_cold");
					self show();
					level function_88a86ef8(4);
					self playsound(#"hash_7605be4297c1ed23");
					level.s_soapstone.var_b6e5b65f = level.s_soapstone.var_b6e5b65f - 1;
					self.is_placed = 1;
					level flag::set(#"hash_238e5c8b416f855");
				}
				else
				{
					if(level.s_soapstone.is_charged && level.s_soapstone.is_hot)
					{
						self setmodel("p8_zm_ora_soapstone_01_hot");
						self show();
						level function_88a86ef8(0);
						self playsound(#"hash_69b229acb5e3a598");
						level.s_soapstone.var_b6e5b65f = level.s_soapstone.var_b6e5b65f - 1;
						self.is_placed = 1;
						level flag::set(#"hash_57d2cbf7d6c2035a");
					}
					else
					{
						s_activation.e_who namespace_3263198e::function_51b752a9("vox_soap_stones_insert_room_temp", -1, 1, 0);
					}
				}
				break;
			}
			case 4:
			{
				if(level.s_soapstone.is_charged && level.s_soapstone.is_hot)
				{
					self setmodel("p8_zm_ora_soapstone_01_hot");
					self show();
					level function_88a86ef8(2);
					self playsound(#"hash_69b229acb5e3a598");
					level.s_soapstone.var_b6e5b65f = level.s_soapstone.var_b6e5b65f - 1;
					self.is_placed = 1;
					level flag::clear(#"hash_238e5c8b416f855");
					level flag::set(#"hash_3a8a317fc0b5e5b0");
				}
				else
				{
					s_activation.e_who namespace_3263198e::function_51b752a9("vox_soap_stones_insert_room_temp", -1, 1, 0);
				}
				break;
			}
		}
	}
}

/*
	Name: function_9ee4c8c3
	Namespace: namespace_f7a40df8
	Checksum: 0x60453A4D
	Offset: 0x1E98
	Size: 0x24C
	Parameters: 2
	Flags: Linked
*/
function function_9ee4c8c3(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		level flag::set(#"hash_3a8a317fc0b5e5b0");
		getent("mama_bear", "targetname") show();
		getent("papa_bear", "targetname") show();
		var_4eed727b = getent("electro", "targetname");
		var_4eed727b hide();
		var_28f1732d = getent(var_4eed727b.target, "targetname");
		var_28f1732d hide();
		foreach(var_4eed727b in getentarray("disco", "targetname"))
		{
			var_4eed727b hide();
			var_28f1732d = getent(var_4eed727b.target, "targetname");
			var_28f1732d hide();
		}
		level function_88a86ef8(2);
		level flag::clear(#"hash_57d2cbf7d6c2035a");
		level flag::clear(#"hash_238e5c8b416f855");
	}
}

