// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_hero_weapon.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_weap_tricannon;

/*
	Name: __init__system__
	Namespace: zm_weap_tricannon
	Checksum: 0x5C794A04
	Offset: 0x170
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_tricannon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_tricannon
	Checksum: 0xD53C7177
	Offset: 0x1B8
	Size: 0x22A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "water_tricannon_slow_fx", 1, 1, "int", &function_4c32ce00, 0, 0);
	clientfield::register("allplayers", "fire_tricannon_muzzle_fx", 1, 1, "counter", &function_af90fb8c, 0, 0);
	clientfield::register("allplayers", "water_tricannon_muzzle_fx", 1, 1, "counter", &function_39fb4ba9, 0, 0);
	level._effect[#"hash_1e93bf218f76b41a"] = #"hash_237782fa4c26f2f7";
	level._effect[#"hash_1e8cb3218f708108"] = #"hash_237076fa4c20bfe5";
	level._effect[#"hash_4b54be230d4f57e9"] = #"hash_78e90b082a3146ee";
	level._effect[#"hash_4b5aca230d53d7fb"] = #"hash_78e1ff082a2b13dc";
	level._effect[#"hash_506a28609ce7aaaa"] = #"hash_4a9c1296a695eb99";
	level._effect[#"hash_720e50199e045f64"] = #"hash_59e8f46ce39259a3";
	level._effect[#"hash_48c846b3b589b3f9"] = #"hash_50b3c0e6e329fec0";
}

/*
	Name: function_4c32ce00
	Namespace: zm_weap_tricannon
	Checksum: 0xD5EB2F20
	Offset: 0x3F0
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_4c32ce00(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrenderoverridebundle("rob_tricannon_character_ice");
	}
	else
	{
		self stoprenderoverridebundle("rob_tricannon_character_ice");
	}
}

/*
	Name: function_af90fb8c
	Namespace: zm_weap_tricannon
	Checksum: 0x2EA973A5
	Offset: 0x480
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function function_af90fb8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			while(isalive(self))
			{
				s_result = undefined;
				s_result = self waittill(#"notetrack", #"death");
				if(s_result.notetrack === "fire" || s_result.notetrack === "rechamber")
				{
					playviewmodelfx(localclientnum, level._effect[#"hash_48c846b3b589b3f9"], "tag_flash2");
					break;
				}
			}
		}
	}
}

/*
	Name: function_39fb4ba9
	Namespace: zm_weap_tricannon
	Checksum: 0x532AF67E
	Offset: 0x5A8
	Size: 0x1A4
	Parameters: 7
	Flags: Linked
*/
function function_39fb4ba9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(self.weapon === getweapon(#"ww_tricannon_water_t8_upgraded"))
		{
			b_packed = 1;
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			if(b_packed === 1)
			{
				playviewmodelfx(localclientnum, level._effect[#"hash_506a28609ce7aaaa"], "tag_flash");
			}
			else
			{
				playviewmodelfx(localclientnum, level._effect[#"hash_4b54be230d4f57e9"], "tag_flash");
			}
		}
		else
		{
			if(b_packed === 1)
			{
				util::playfxontag(localclientnum, level._effect[#"hash_720e50199e045f64"], self, "tag_flash");
			}
			else
			{
				util::playfxontag(localclientnum, level._effect[#"hash_4b5aca230d53d7fb"], self, "tag_flash");
			}
		}
	}
}

