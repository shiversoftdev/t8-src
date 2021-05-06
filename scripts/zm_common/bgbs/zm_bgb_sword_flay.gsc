// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_bgb_sword_flay;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_sword_flay
	Checksum: 0x2E48123F
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_sword_flay", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_sword_flay
	Checksum: 0xF36034D9
	Offset: 0xE8
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_sword_flay", "time", 60, &enable, &disable, undefined);
	bgb::function_430970f6(#"zm_bgb_sword_flay", &actor_damage_override);
	bgb::function_cc303f91(#"zm_bgb_sword_flay", &vehicle_damage_override);
}

/*
	Name: enable
	Namespace: zm_bgb_sword_flay
	Checksum: 0x80F724D1
	Offset: 0x1C8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function enable()
{
}

/*
	Name: disable
	Namespace: zm_bgb_sword_flay
	Checksum: 0x80F724D1
	Offset: 0x1D8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

/*
	Name: actor_damage_override
	Namespace: zm_bgb_sword_flay
	Checksum: 0x48A60F12
	Offset: 0x1E8
	Size: 0x12E
	Parameters: 12
	Flags: Linked
*/
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath === "MOD_MELEE" && weapon != level.weaponnone)
	{
		if(isalive(self))
		{
			switch(self.var_6f84b820)
			{
				case "popcorn":
				case "basic":
				case "enhanced":
				{
					damage = self.health + damage * 5;
					break;
				}
				default:
				{
					damage = damage * 5;
					break;
				}
			}
		}
	}
	return damage;
}

/*
	Name: vehicle_damage_override
	Namespace: zm_bgb_sword_flay
	Checksum: 0x5988B8C7
	Offset: 0x320
	Size: 0xA0
	Parameters: 15
	Flags: Linked
*/
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(smeansofdeath === "MOD_MELEE")
	{
		idamage = idamage * 5;
	}
	return idamage;
}

