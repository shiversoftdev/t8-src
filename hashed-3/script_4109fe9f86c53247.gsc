// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3110b4b6b21db11f;
#using script_6021ce59143452c3;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_73718f25;

/*
	Name: function_89f2df9
	Namespace: namespace_73718f25
	Checksum: 0xF0929DE1
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6aaf245219c6f125", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_73718f25
	Checksum: 0xA38B122D
	Offset: 0x148
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_4dad05c408e466f5", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_73718f25
	Checksum: 0xF15B130D
	Offset: 0x1B0
	Size: 0x1D8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d1de6a85(var_e84d35d1)
{
	var_e9433d0 = struct::get_array(var_e84d35d1);
	/#
		assert(var_e9433d0.size, "");
	#/
	var_64e17761 = [];
	foreach(var_93154b10 in var_e9433d0)
	{
		/#
			assert(isdefined(var_93154b10.target), "");
		#/
		var_94d5ccbc = getentarray(var_93154b10.target, "targetname");
		var_64e17761 = arraycombine(var_64e17761, var_94d5ccbc, 0, 0);
	}
	level.var_64e17761 = var_64e17761;
	foreach(player in getplayers())
	{
		player thread function_68b149a2(level.var_64e17761);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_73718f25
	Checksum: 0x8D3DE43D
	Offset: 0x390
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player notify(#"hash_576884b397154a7d");
	}
}

/*
	Name: function_68b149a2
	Namespace: namespace_73718f25
	Checksum: 0xD5C669B7
	Offset: 0x428
	Size: 0x2AC
	Parameters: 1
	Flags: Linked
*/
function function_68b149a2(var_64e17761)
{
	self notify("59cd2610cddc7a0b");
	self endon("59cd2610cddc7a0b");
	level endon(#"hash_7646638df88a3656");
	self endon(#"disconnect");
	wait(12);
	while(true)
	{
		var_4cda8676 = 0;
		foreach(var_c1f5749f in var_64e17761)
		{
			if(self istouching(var_c1f5749f))
			{
				var_4cda8676 = 1;
				break;
			}
		}
		if(!var_4cda8676 && isalive(self) && !self laststand::player_is_in_laststand())
		{
			if(!isdefined(self.var_86278a02) || self.var_86278a02 === 1)
			{
				self.var_86278a02 = 0;
				self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 1);
				self allowsprint(0);
				if(self issliding())
				{
					self setstance("crouch");
				}
				self allowslide(0);
				self thread function_7d81b8c1();
			}
			wait(1);
		}
		else if(self.var_86278a02 === 0)
		{
			self.var_86278a02 = 1;
			self allowsprint(1);
			self allowslide(1);
			self thread function_d2dd1f2b();
			self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
		}
		wait(1);
		waitframe(1);
	}
}

/*
	Name: function_7d81b8c1
	Namespace: namespace_73718f25
	Checksum: 0x38A898B7
	Offset: 0x6E0
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function function_7d81b8c1()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_2580a60476ec7393");
	self notify(#"hash_56f565b20fbc0db");
	if(!isdefined(self.var_8b5609a4))
	{
		self.var_8b5609a4 = 0;
	}
	while(true)
	{
		wait(1);
		self.var_8b5609a4++;
		if(self.var_2e6aa97d === 1)
		{
			var_24e0e73d = 15;
		}
		else
		{
			var_24e0e73d = 15;
		}
		if(self.var_8b5609a4 >= (int(var_24e0e73d * 0.5)))
		{
			self thread zm_audio::create_and_play_dialog(#"freeze", #"start");
		}
		if(self.var_8b5609a4 >= var_24e0e73d)
		{
			waitframe(1);
			self thread function_202ee8fa();
			self thread zm_audio::create_and_play_dialog(#"freeze", #"frozen");
			self.var_8b5609a4 = 0;
			return;
		}
	}
}

/*
	Name: function_202ee8fa
	Namespace: namespace_73718f25
	Checksum: 0x7CDC777E
	Offset: 0x868
	Size: 0x3E4
	Parameters: 0
	Flags: Linked
*/
function function_202ee8fa()
{
	self endon_callback(&namespace_18db89ed::function_c64292f, #"death");
	self.var_7dc2d507 = 1;
	self notify(#"player_frozen");
	self namespace_18db89ed::function_bad6907c();
	self clientfield::set("" + #"hash_55543319943057f1", 1);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 1);
	var_1d3683e1 = spawn("trigger_damage", self.origin, 0, 15, 72);
	var_1d3683e1 enablelinkto();
	var_1d3683e1 linkto(self);
	self.var_1d3683e1 = var_1d3683e1;
	self thread namespace_18db89ed::function_872ec0b2(var_1d3683e1);
	if(isbot(self))
	{
		self thread namespace_18db89ed::function_8eb7b0f7();
	}
	else
	{
		self thread namespace_18db89ed::function_6cadbaff();
	}
	if(self.var_d844486 !== 1)
	{
		self thread zm_equipment::show_hint_text(#"hash_4b6950ec49c7e04c", 3);
		self.var_d844486 = 1;
	}
	self waittill(#"hash_53bfad7081c69dee");
	self playsound(#"hash_2f8c9575cb36a298");
	self.var_7dc2d507 = 0;
	self namespace_18db89ed::function_46c3bbf7();
	self clientfield::set("" + #"hash_55543319943057f1", 0);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 0);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
	waitframe(2);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);
	if(isdefined(var_1d3683e1))
	{
		var_1d3683e1 delete();
		self.var_1d3683e1 = undefined;
	}
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	waitframe(2);
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 1);
	self allowsprint(0);
	if(self issliding())
	{
		self setstance("crouch");
	}
	self allowslide(0);
	self thread function_7d81b8c1();
}

/*
	Name: function_d2dd1f2b
	Namespace: namespace_73718f25
	Checksum: 0xB17970D9
	Offset: 0xC58
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_d2dd1f2b()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_56f565b20fbc0db");
	self notify(#"hash_2580a60476ec7393");
	if(!isdefined(self.var_36a93d1) || self.var_36a93d1 == 0)
	{
		return;
	}
	while(true)
	{
		wait(1);
		self.var_36a93d1--;
		if(self.var_36a93d1 <= 0)
		{
			self.var_36a93d1 = 0;
			return;
		}
	}
}

