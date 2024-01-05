// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace status_effect_blind;

/*
	Name: __init__system__
	Namespace: status_effect_blind
	Checksum: 0xA1320E63
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_blind", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_blind
	Checksum: 0x694235FA
	Offset: 0xF0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::register_status_effect_callback_apply(1, &blind_apply);
	status_effect::function_5bae5120(1, &function_8a261309);
	status_effect::function_6f4eaf88(getstatuseffect("blind"));
}

/*
	Name: blind_apply
	Namespace: status_effect_blind
	Checksum: 0xDA9A5E75
	Offset: 0x168
	Size: 0x242
	Parameters: 3
	Flags: Linked
*/
function blind_apply(var_756fda07, weapon, applicant)
{
	self.owner.flashendtime = gettime() + var_756fda07.var_77449e9;
	self.owner.lastflashedby = applicant;
	if(self.owner == applicant)
	{
		return;
	}
	var_c94d654b = applicant getentitynumber();
	if(!isdefined(self.owner.var_b68518ab))
	{
		self.owner.var_b68518ab = [];
	}
	blindarray = self.owner.var_b68518ab;
	if(!isdefined(blindarray[var_c94d654b]))
	{
		blindarray[var_c94d654b] = 0;
	}
	if(isdefined(blindarray[var_c94d654b]) && (blindarray[var_c94d654b] + 3000) < gettime())
	{
		if(isdefined(weapon) && weapon == getweapon(#"hash_3f62a872201cd1ce"))
		{
			if(isdefined(level.playgadgetsuccess))
			{
				self.owner.var_ef9b6f0b = 1;
				level notify(#"hash_ac034f4f7553641");
				applicant.var_a467e27f = (isdefined(applicant.var_a467e27f) ? applicant.var_a467e27f : 0) + 1;
				if(isdefined(level.var_ac6052e9))
				{
					var_9194a036 = [[level.var_ac6052e9]]("swatGrenadeSuccessLineCount", 0);
				}
				if(applicant.var_a467e27f == (isdefined(var_9194a036) ? var_9194a036 : 0))
				{
					applicant thread [[level.playgadgetsuccess]](getweapon(#"hash_3f62a872201cd1ce"), undefined, self.owner, undefined);
				}
			}
		}
		blindarray[var_c94d654b] = gettime();
	}
}

/*
	Name: function_8a261309
	Namespace: status_effect_blind
	Checksum: 0x2232AF16
	Offset: 0x3B8
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8a261309()
{
	if(isdefined(self.owner) && isdefined(self.owner.lastflashedby) && isdefined(self.owner.lastflashedby.var_a467e27f))
	{
		self.owner.lastflashedby.var_a467e27f = 0;
	}
	if(isdefined(self.owner))
	{
		self.owner.var_ef9b6f0b = 0;
	}
}

