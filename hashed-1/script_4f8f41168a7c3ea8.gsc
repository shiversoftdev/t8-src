// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_fc5c8455;

/*
	Name: function_89f2df9
	Namespace: namespace_fc5c8455
	Checksum: 0x85BB1FDA
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_32658a301920c858", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fc5c8455
	Checksum: 0x9134044
	Offset: 0x158
	Size: 0x872
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_228caf5cb0610875", 1, getminbitcountfornum(4), "int", &function_a8e278b6, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_5f7eb9d1316d02a7", 1, 1, "int", &function_b2b48022, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_247e2f70c08b01f6", 1, 1, "int", &function_38caf7f2, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_f8ff865403f6655", 1, 1, "int", &function_82423f02, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_6954721e3aab6b22", 1, 2, "int", &function_aed4dc35, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_f03061885875815", 1, 1, "int", &function_4707df22, 0, 0);
	clientfield::register("toplayer", "" + #"hash_1a9944b03fae8660", 1, 1, "int", &function_beeca5c7, 0, 0);
	clientfield::register("toplayer", "" + #"hash_c79e0b124c4b75", 1, 1, "counter", &function_ffeeebf3, 0, 0);
	clientfield::register("toplayer", "" + #"hash_39d19b76b846a27f", 1, 1, "counter", &function_fcb0f78b, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_148c1ac364522c90", 1, 1, "int", &function_29cb0695, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1142930568dc278b", 1, 1, "int", &function_99930d42, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_31f39c058ef79e2", 1, 1, "counter", &function_817977d1, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3c74a33b8e1adb73", 1, 1, "counter", &function_928bef5f, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_7692067c56d8b6cc", 1, 2, "int", &function_84e77740, 0, 0);
	level._effect[#"hash_4446ff1dd0f536fe"] = #"hash_50cd5a75aebe8def";
	level._effect[#"hash_22aea05cb07dd55e"] = #"hash_51005475aee9dd56";
	level._effect[#"hash_70407be743f59f31"] = #"hash_2fcb634860aadcc5";
	level._effect[#"hash_708f71e744396284"] = #"hash_303469486103d000";
	level._effect[#"hash_65abc72310fe5534"] = #"hash_6b993f3f5e31e2b5";
	level._effect[#"hash_1553e20e5242f527"] = #"hash_ce21486cbb74ba2";
	level._effect[#"hash_d9adad5b2ead852"] = #"hash_1a2b69544013ee25";
	level._effect[#"hash_3e947fa7e9cca61e"] = #"hash_69324137a8ab8427";
	level._effect[#"hash_5a5e898738a573b3"] = #"hash_1636a510bead42c2";
	level._effect[#"hash_29ac4d67fd8a9872"] = #"hash_4a9c1f83345c624b";
	level._effect[#"hash_40c10e05964e71b5"] = #"hash_4c5e26f94f35e7fb";
	level._effect[#"hash_74ac7629ef9bc3da"] = #"hash_2529982fe72e4e4";
	level._effect[#"hash_577c7197e639a24b"] = #"hash_6ce5c811700c8c4";
	level._effect[#"hash_71cebe03a25b3339"] = #"hash_6f5790d353dd5caf";
	level._effect[#"hash_28455b81d5e86c62"] = #"hash_4d293d8817fcdc0c";
	level._effect[#"hash_54790ee0d9025900"] = #"hash_6fdfb9444067e8f4";
	level._effect[#"hash_5d3b4b76ea5885f6"] = #"hash_4835bd332e8a78c7";
	level._effect[#"hash_3932ab509a43ca38"] = #"hash_7c63ac8e5b0a88e6";
	level._effect[#"hash_707e0698b9a2b882"] = #"hash_170bbc9437bc68c9";
}

/*
	Name: function_a8e278b6
	Namespace: namespace_fc5c8455
	Checksum: 0xAAD50A6D
	Offset: 0x9D8
	Size: 0x1CA
	Parameters: 7
	Flags: Linked
*/
function function_a8e278b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_634618de))
	{
		stopfx(localclientnum, self.var_634618de);
		self.var_634618de = undefined;
	}
	switch(newval)
	{
		case 1:
		{
			self.var_634618de = util::playfxontag(localclientnum, level._effect[#"hash_4446ff1dd0f536fe"], self, "tag_origin");
			break;
		}
		case 2:
		{
			self.var_634618de = util::playfxontag(localclientnum, level._effect[#"hash_22aea05cb07dd55e"], self, "tag_origin");
			break;
		}
		case 3:
		{
			self.var_634618de = util::playfxontag(localclientnum, level._effect[#"hash_708f71e744396284"], self, "tag_origin");
			break;
		}
		case 4:
		{
			self.var_634618de = util::playfxontag(localclientnum, level._effect[#"hash_70407be743f59f31"], self, "tag_origin");
			break;
		}
	}
}

/*
	Name: function_b2b48022
	Namespace: namespace_fc5c8455
	Checksum: 0xFC5848F7
	Offset: 0xBB0
	Size: 0xF6
	Parameters: 7
	Flags: Linked
*/
function function_b2b48022(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_d96d2274))
		{
			stopfx(localclientnum, self.var_d96d2274);
			self.var_d96d2274 = undefined;
		}
		self.var_d96d2274 = util::playfxontag(localclientnum, level._effect[#"hash_65abc72310fe5534"], self, "afterlife_01");
	}
	else if(isdefined(self.var_d96d2274))
	{
		stopfx(localclientnum, self.var_d96d2274);
		self.var_d96d2274 = undefined;
	}
}

/*
	Name: function_99930d42
	Namespace: namespace_fc5c8455
	Checksum: 0xEF31B378
	Offset: 0xCB0
	Size: 0xF6
	Parameters: 7
	Flags: Linked
*/
function function_99930d42(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_55792791))
		{
			stopfx(localclientnum, self.var_55792791);
			self.var_55792791 = undefined;
		}
		self.var_55792791 = util::playfxontag(localclientnum, level._effect[#"hash_54790ee0d9025900"], self, "tag_origin");
	}
	else if(isdefined(self.var_55792791))
	{
		killfx(localclientnum, self.var_55792791);
		self.var_55792791 = undefined;
	}
}

/*
	Name: function_38caf7f2
	Namespace: namespace_fc5c8455
	Checksum: 0xE1CC75D8
	Offset: 0xDB0
	Size: 0xF6
	Parameters: 7
	Flags: Linked
*/
function function_38caf7f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_57692f88))
		{
			stopfx(localclientnum, self.var_57692f88);
			self.var_57692f88 = undefined;
		}
		self.var_57692f88 = util::playfxontag(localclientnum, level._effect[#"hash_1553e20e5242f527"], self, "tag_origin");
	}
	else if(isdefined(self.var_57692f88))
	{
		stopfx(localclientnum, self.var_57692f88);
		self.var_57692f88 = undefined;
	}
}

/*
	Name: function_82423f02
	Namespace: namespace_fc5c8455
	Checksum: 0xDBF2F258
	Offset: 0xEB0
	Size: 0xF6
	Parameters: 7
	Flags: Linked
*/
function function_82423f02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_4e35f286))
		{
			stopfx(localclientnum, self.var_4e35f286);
			self.var_4e35f286 = undefined;
		}
		self.var_4e35f286 = util::playfxontag(localclientnum, level._effect[#"hash_3e947fa7e9cca61e"], self, "tag_origin");
	}
	else if(isdefined(self.var_4e35f286))
	{
		stopfx(localclientnum, self.var_4e35f286);
		self.var_4e35f286 = undefined;
	}
}

/*
	Name: function_29cb0695
	Namespace: namespace_fc5c8455
	Checksum: 0x7A9A65F1
	Offset: 0xFB0
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_29cb0695(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_40c10e05964e71b5"], self, "tag_origin");
	}
}

/*
	Name: function_817977d1
	Namespace: namespace_fc5c8455
	Checksum: 0xB5BF0ACF
	Offset: 0x1038
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_817977d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_d9adad5b2ead852"], self, "tag_origin");
}

/*
	Name: function_beeca5c7
	Namespace: namespace_fc5c8455
	Checksum: 0xDF0DCD2C
	Offset: 0x10B8
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function function_beeca5c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_4fb0136f51fcf7", "tag_weapon");
		self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0.7);
		self thread function_f9a794dc(localclientnum);
		self thread function_eba88fd(localclientnum);
	}
	else
	{
		self notify(#"hash_4086299956cef09d");
		if(isdefined(self.var_c183198c))
		{
			self stoploopsound(self.var_c183198c);
			self.var_c183198c = undefined;
		}
		self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0);
		self function_5d482e78(#"hash_4fb0136f51fcf7", "tag_weapon");
	}
}

/*
	Name: function_ffeeebf3
	Namespace: namespace_fc5c8455
	Checksum: 0x35FFB164
	Offset: 0x1250
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function function_ffeeebf3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(!isdefined(self.var_23c215c))
	{
		self.var_23c215c = 25;
	}
	if(self.var_23c215c + 25 > 25)
	{
		self.var_23c215c = 25;
	}
	else
	{
		self.var_23c215c = self.var_23c215c + 25;
	}
	if(isdefined(self.var_fa938ed8))
	{
		self.var_fa938ed8 = 0;
	}
	self thread function_d193f583(localclientnum);
	self playrumbleonentity(localclientnum, #"hash_41507a7755099d85");
	self stoprumble(localclientnum, #"hash_3c64ae4793e47b3a");
}

/*
	Name: function_d193f583
	Namespace: namespace_fc5c8455
	Checksum: 0x332F02DE
	Offset: 0x1370
	Size: 0x11A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d193f583(localclientnum)
{
	self notify(#"hash_67dbde4a0231b582");
	self endon(#"death", #"hash_4086299956cef09d", #"hash_67dbde4a0231b582");
	if(isdefined(self.var_c183198c))
	{
		self stoploopsound(self.var_c183198c);
		self.var_c183198c = undefined;
	}
	if(!isdefined(self.var_8e748ffa))
	{
		self.var_8e748ffa = self playloopsound(#"hash_6d1e9399310efe71");
	}
	wait(2);
	if(isdefined(self.var_8e748ffa))
	{
		self stoploopsound(self.var_8e748ffa);
		self.var_8e748ffa = undefined;
	}
	self.var_c183198c = self playloopsound(#"hash_1bc434008189933f");
}

/*
	Name: function_f9a794dc
	Namespace: namespace_fc5c8455
	Checksum: 0x56F188C6
	Offset: 0x1498
	Size: 0x2F4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f9a794dc(localclientnum)
{
	self endon(#"death", #"hash_4086299956cef09d");
	level endon(#"end_game");
	self.var_23c215c = 25;
	self.var_c183198c = self playloopsound(#"hash_1bc434008189933f");
	self.var_fa938ed8 = 0;
	self.var_d9ebae63 = gettime();
	while(isdefined(self) && self.var_23c215c > 0)
	{
		n_current_time = gettime();
		var_4eb46607 = (n_current_time - self.var_d9ebae63) / 1000;
		self.var_d9ebae63 = n_current_time;
		if(self.var_fa938ed8)
		{
			self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0.016);
			self playrumbleonentity(localclientnum, #"hash_3c64ae4793e47b3a");
			self stoprumble(localclientnum, #"hash_41507a7755099d85");
		}
		else
		{
			var_7616c359 = math::linear_map(self.var_23c215c, 0, 25, 0.15, 0.7);
			self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", var_7616c359);
		}
		if(self.var_23c215c <= 5)
		{
			self.var_23c215c = self.var_23c215c - 0.5;
			if(self.var_fa938ed8)
			{
				self.var_fa938ed8 = 0;
			}
			else
			{
				self.var_fa938ed8 = 1;
			}
			wait(0.5);
		}
		else
		{
			self.var_23c215c = self.var_23c215c - var_4eb46607;
			waitframe(1);
		}
	}
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(isdefined(self.var_c183198c))
	{
		self stoploopsound(self.var_c183198c);
		self.var_c183198c = undefined;
	}
	self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0);
}

/*
	Name: function_eba88fd
	Namespace: namespace_fc5c8455
	Checksum: 0xADE822A7
	Offset: 0x1798
	Size: 0x18A
	Parameters: 1
	Flags: Linked
*/
function function_eba88fd(localclientnum)
{
	self endon(#"death", #"disconnect", #"hash_4086299956cef09d");
	if(!self util::function_50ed1561(localclientnum))
	{
		return;
	}
	while(isdefined(self.var_23c215c) && self.var_23c215c > 0)
	{
		if(isdefined(self.var_83748d31))
		{
			stopfx(localclientnum, self.var_83748d31);
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			if(viewmodelhastag(localclientnum, "tag_flash"))
			{
				self.var_83748d31 = playviewmodelfx(localclientnum, level._effect[#"hash_5d3b4b76ea5885f6"], "tag_flash");
			}
		}
		if(self.var_23c215c > 20)
		{
			wait(0.1);
		}
		else
		{
			if(self.var_23c215c > 15)
			{
				wait(0.2);
			}
			else
			{
				if(self.var_23c215c > 10)
				{
					wait(0.4);
				}
				else
				{
					if(self.var_23c215c > 5)
					{
						wait(1);
					}
					else
					{
						wait(2);
					}
				}
			}
		}
	}
}

/*
	Name: function_fcb0f78b
	Namespace: namespace_fc5c8455
	Checksum: 0xD7CCF058
	Offset: 0x1930
	Size: 0x76
	Parameters: 7
	Flags: Linked
*/
function function_fcb0f78b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_23c215c))
	{
		self.var_23c215c = self.var_23c215c - 6;
		if(self.var_23c215c < 0)
		{
			self.var_23c215c = 0;
		}
	}
}

/*
	Name: function_313e2c94
	Namespace: namespace_fc5c8455
	Checksum: 0x293FB17F
	Offset: 0x19B0
	Size: 0x176
	Parameters: 7
	Flags: None
*/
function function_313e2c94(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 2)
	{
		if(isdefined(self.var_634618de))
		{
			stopfx(localclientnum, self.var_634618de);
			self.var_634618de = undefined;
		}
		self.var_634618de = util::playfxontag(localclientnum, level._effect[#"hash_22aea05cb07dd55e"], self, "tag_origin");
	}
	else
	{
		if(newval == 1)
		{
			if(isdefined(self.var_634618de))
			{
				stopfx(localclientnum, self.var_634618de);
				self.var_634618de = undefined;
			}
			self.var_634618de = util::playfxontag(localclientnum, level._effect[#"hash_4446ff1dd0f536fe"], self, "tag_origin");
		}
		else if(isdefined(self.var_634618de))
		{
			stopfx(localclientnum, self.var_634618de);
			self.var_634618de = undefined;
		}
	}
}

/*
	Name: function_aed4dc35
	Namespace: namespace_fc5c8455
	Checksum: 0x979961BD
	Offset: 0x1B30
	Size: 0x1C2
	Parameters: 7
	Flags: Linked
*/
function function_aed4dc35(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_d8243293))
	{
		stopfx(localclientnum, self.var_d8243293);
		self.var_d8243293 = undefined;
	}
	if(isdefined(self.var_5abbf89a))
	{
		stopfx(localclientnum, self.var_5abbf89a);
		self.var_5abbf89a = undefined;
	}
	if(newval == 1)
	{
		self.var_d8243293 = util::playfxontag(localclientnum, level._effect[#"hash_74ac7629ef9bc3da"], self, "tag_origin");
		self.var_5abbf89a = util::playfxontag(localclientnum, level._effect[#"hash_71cebe03a25b3339"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		self.var_d8243293 = util::playfxontag(localclientnum, level._effect[#"hash_577c7197e639a24b"], self, "tag_origin");
		self.var_5abbf89a = util::playfxontag(localclientnum, level._effect[#"hash_28455b81d5e86c62"], self, "tag_origin");
	}
}

/*
	Name: function_4707df22
	Namespace: namespace_fc5c8455
	Checksum: 0x9176FD74
	Offset: 0x1D00
	Size: 0x144
	Parameters: 7
	Flags: Linked
*/
function function_4707df22(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_85dab00b))
	{
		stopfx(localclientnum, self.var_85dab00b);
		self.var_85dab00b = undefined;
		playfx(localclientnum, level._effect[#"hash_29ac4d67fd8a9872"], self.origin);
		playsound(localclientnum, #"hash_c9e5d07bd26090d", self.origin);
	}
	if(newval == 1)
	{
		self.var_85dab00b = util::playfxontag(localclientnum, level._effect[#"hash_5a5e898738a573b3"], self, "tag_origin");
		playsound(localclientnum, #"hash_4cd38326868832c7", self.origin);
	}
}

/*
	Name: function_84e77740
	Namespace: namespace_fc5c8455
	Checksum: 0x59D44A27
	Offset: 0x1E50
	Size: 0x156
	Parameters: 7
	Flags: Linked
*/
function function_84e77740(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_68ee9247aaae4517");
		self function_78233d29(#"hash_68ee9247aaae4517", "", "Brightness", 1);
		self function_78233d29(#"hash_68ee9247aaae4517", "", "Alpha", 1);
		self function_78233d29(#"hash_68ee9247aaae4517", "", "Tint", 1);
	}
	if(newval == 2)
	{
		self thread function_bbfe3432(localclientnum);
	}
	else
	{
		self notify(#"hash_4236253d10aeec5e");
	}
}

/*
	Name: function_bbfe3432
	Namespace: namespace_fc5c8455
	Checksum: 0x384DC8EF
	Offset: 0x1FB0
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_bbfe3432(localclientnum)
{
	self endon(#"hash_4236253d10aeec5e");
	var_be5f61d5 = 0.5;
	while(var_be5f61d5 >= (5E-07) && isdefined(self))
	{
		self function_78233d29(#"hash_68ee9247aaae4517", "", "Alpha", var_be5f61d5);
		self function_78233d29(#"hash_68ee9247aaae4517", "", "Brightness", var_be5f61d5);
		var_be5f61d5 = var_be5f61d5 / 2.5;
		wait(0.3);
	}
}

/*
	Name: function_928bef5f
	Namespace: namespace_fc5c8455
	Checksum: 0x48FB5A11
	Offset: 0x2088
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_928bef5f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_3932ab509a43ca38"], self, "tag_origin");
	playsound(localclientnum, #"hash_4cd38326868832c7", self.origin);
}

/*
	Name: function_c91db38a
	Namespace: namespace_fc5c8455
	Checksum: 0x77C09B46
	Offset: 0x2130
	Size: 0x74
	Parameters: 7
	Flags: None
*/
function function_c91db38a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_707e0698b9a2b882"], self, "tag_origin");
}

