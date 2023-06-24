// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_human_cover.gsc;
#using script_35598499769dbb3d;
#using script_4c5c4a64a59247a2;
#using script_4d85e8de54b02198;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace animationstatenetwork;

/*
	Name: registerdefaultnotetrackhandlerfunctions
	Namespace: animationstatenetwork
	Checksum: 0x4048DCC2
	Offset: 0x330
	Size: 0x4DC
	Parameters: 0
	Flags: AutoExec
*/
function autoexec registerdefaultnotetrackhandlerfunctions()
{
	registernotetrackhandlerfunction("fire", &notetrackfirebullet);
	registernotetrackhandlerfunction("gib_disable", &notetrackgibdisable);
	registernotetrackhandlerfunction("gib = \"head\"", &gibserverutils::gibhead);
	registernotetrackhandlerfunction("gib = \"arm_left\"", &gibserverutils::gibleftarm);
	registernotetrackhandlerfunction("gib = \"arm_right\"", &gibserverutils::gibrightarm);
	registernotetrackhandlerfunction("gib = \"leg_left\"", &gibserverutils::gibleftleg);
	registernotetrackhandlerfunction("gib = \"leg_right\"", &gibserverutils::gibrightleg);
	registernotetrackhandlerfunction("dropgun", &notetrackdropgun);
	registernotetrackhandlerfunction("gun drop", &notetrackdropgun);
	registernotetrackhandlerfunction("drop_shield", &notetrackdropshield);
	registernotetrackhandlerfunction("hide_weapon", &notetrackhideweapon);
	registernotetrackhandlerfunction("show_weapon", &notetrackshowweapon);
	registernotetrackhandlerfunction("hide_ai", &notetrackhideai);
	registernotetrackhandlerfunction("show_ai", &notetrackshowai);
	registernotetrackhandlerfunction("attach_knife", &notetrackattachknife);
	registernotetrackhandlerfunction("detach_knife", &notetrackdetachknife);
	registernotetrackhandlerfunction("grenade_throw", &notetrackgrenadethrow);
	registernotetrackhandlerfunction("start_ragdoll", &notetrackstartragdoll);
	registernotetrackhandlerfunction("ragdoll_nodeath", &notetrackstartragdollnodeath);
	registernotetrackhandlerfunction("unsync", &notetrackmeleeunsync);
	registernotetrackhandlerfunction("step1", &notetrackstaircasestep1);
	registernotetrackhandlerfunction("step2", &notetrackstaircasestep2);
	registernotetrackhandlerfunction("anim_movement = \"stop\"", &notetrackanimmovementstop);
	registerblackboardnotetrackhandler("anim_pose = \\\"stand\\\"", "_stance", "stand");
	registerblackboardnotetrackhandler("anim_pose = \\\"crouch\\\"", "_stance", "crouch");
	registerblackboardnotetrackhandler("anim_pose = \\\"prone_front\\\"", "_stance", "prone_front");
	registerblackboardnotetrackhandler("anim_pose = \\\"prone_back\\\"", "_stance", "prone_back");
	registerblackboardnotetrackhandler("anim_pose = stand", "_stance", "stand");
	registerblackboardnotetrackhandler("anim_pose = crouch", "_stance", "crouch");
	registerblackboardnotetrackhandler("anim_pose = prone_front", "_stance", "prone_front");
	registerblackboardnotetrackhandler("anim_pose = prone_back", "_stance", "prone_back");
}

/*
	Name: notetrackanimmovementstop
	Namespace: animationstatenetwork
	Checksum: 0x3E4D3297
	Offset: 0x818
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackanimmovementstop(entity)
{
	if(entity haspath())
	{
		entity pathmode("move delayed", 1, randomfloatrange(2, 4));
	}
}

/*
	Name: notetrackstaircasestep1
	Namespace: animationstatenetwork
	Checksum: 0xA8AC4F65
	Offset: 0x888
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackstaircasestep1(entity)
{
	numsteps = entity getblackboardattribute("_staircase_num_steps");
	numsteps++;
	entity setblackboardattribute("_staircase_num_steps", numsteps);
}

/*
	Name: notetrackstaircasestep2
	Namespace: animationstatenetwork
	Checksum: 0x704A9FBC
	Offset: 0x8F0
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackstaircasestep2(entity)
{
	numsteps = entity getblackboardattribute("_staircase_num_steps");
	numsteps = numsteps + 2;
	entity setblackboardattribute("_staircase_num_steps", numsteps);
}

/*
	Name: notetrackdropguninternal
	Namespace: animationstatenetwork
	Checksum: 0xB80ADABB
	Offset: 0x960
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackdropguninternal(entity)
{
	if(!isdefined(entity.weapon) || entity.weapon === level.weaponnone)
	{
		return;
	}
	if(isdefined(entity.ai) && (isdefined(entity.ai.var_7c61677c) && entity.ai.var_7c61677c))
	{
		if(isalive(entity))
		{
			return;
		}
	}
	entity.lastweapon = entity.weapon;
	primaryweapon = entity.primaryweapon;
	secondaryweapon = entity.secondaryweapon;
	entity thread shared::dropaiweapon();
}

/*
	Name: notetrackattachknife
	Namespace: animationstatenetwork
	Checksum: 0x8F3F8DEE
	Offset: 0xA60
	Size: 0x62
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackattachknife(entity)
{
	if(!(isdefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife))
	{
		entity attach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
		entity._ai_melee_attachedknife = 1;
	}
}

/*
	Name: notetrackdetachknife
	Namespace: animationstatenetwork
	Checksum: 0xB795C619
	Offset: 0xAD0
	Size: 0x62
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackdetachknife(entity)
{
	if(isdefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife)
	{
		entity detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
		entity._ai_melee_attachedknife = 0;
	}
}

/*
	Name: notetrackhideweapon
	Namespace: animationstatenetwork
	Checksum: 0xCD9DD06F
	Offset: 0xB40
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackhideweapon(entity)
{
	entity ai::gun_remove();
}

/*
	Name: notetrackshowweapon
	Namespace: animationstatenetwork
	Checksum: 0x955C6E73
	Offset: 0xB70
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackshowweapon(entity)
{
	entity ai::gun_recall();
}

/*
	Name: notetrackhideai
	Namespace: animationstatenetwork
	Checksum: 0x18993492
	Offset: 0xBA0
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackhideai(entity)
{
	entity hide();
}

/*
	Name: notetrackshowai
	Namespace: animationstatenetwork
	Checksum: 0x2C7378C9
	Offset: 0xBD0
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackshowai(entity)
{
	entity show();
}

/*
	Name: notetrackstartragdoll
	Namespace: animationstatenetwork
	Checksum: 0x515A52C4
	Offset: 0xC00
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackstartragdoll(entity)
{
	if(isactor(entity) && entity isinscriptedstate())
	{
		entity.overrideactordamage = undefined;
		entity.allowdeath = 1;
		entity.skipdeath = 1;
		entity kill();
	}
	notetrackdropguninternal(entity);
	entity startragdoll();
}

/*
	Name: _delayedragdoll
	Namespace: animationstatenetwork
	Checksum: 0x958B0975
	Offset: 0xCB8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function _delayedragdoll(entity)
{
	wait(0.25);
	if(isdefined(entity) && !entity isragdoll())
	{
		entity startragdoll();
	}
}

/*
	Name: notetrackstartragdollnodeath
	Namespace: animationstatenetwork
	Checksum: 0xED1AE924
	Offset: 0xD10
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function notetrackstartragdollnodeath(entity)
{
	if(isdefined(entity._ai_melee_opponent))
	{
		entity._ai_melee_opponent unlink();
	}
	entity thread _delayedragdoll(entity);
}

/*
	Name: notetrackfirebullet
	Namespace: animationstatenetwork
	Checksum: 0xB09A64DF
	Offset: 0xD68
	Size: 0x148
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackfirebullet(animationentity)
{
	if(isactor(animationentity) && animationentity isinscriptedstate())
	{
		if(animationentity.weapon != level.weaponnone)
		{
			animationentity notify(#"about_to_shoot");
			startpos = animationentity gettagorigin("tag_flash");
			endpos = startpos + vectorscale(animationentity getweaponforwarddir(), 100);
			magicbullet(animationentity.weapon, startpos, endpos, animationentity);
			animationentity notify(#"shoot");
			if(!isdefined(animationentity.ai.bulletsinclip))
			{
				animationentity.ai.bulletsinclip = 0;
			}
			else
			{
				animationentity.ai.bulletsinclip--;
			}
		}
	}
}

/*
	Name: notetrackdropgun
	Namespace: animationstatenetwork
	Checksum: 0x6ADFE170
	Offset: 0xEB8
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackdropgun(animationentity)
{
	notetrackdropguninternal(animationentity);
}

/*
	Name: notetrackdropshield
	Namespace: animationstatenetwork
	Checksum: 0x86B49CEF
	Offset: 0xEE8
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackdropshield(animationentity)
{
	aiutility::dropriotshield(animationentity);
}

/*
	Name: notetrackgrenadethrow
	Namespace: animationstatenetwork
	Checksum: 0x55F32B60
	Offset: 0xF18
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackgrenadethrow(animationentity)
{
	if(archetype_human_cover::shouldthrowgrenadeatcovercondition(animationentity, 1))
	{
		animationentity grenadethrow();
	}
	else if(isdefined(animationentity.grenadethrowposition))
	{
		arm_offset = archetype_human_cover::temp_get_arm_offset(animationentity, animationentity.grenadethrowposition);
		throw_vel = animationentity canthrowgrenadepos(arm_offset, animationentity.grenadethrowposition);
		if(isdefined(throw_vel))
		{
			animationentity grenadethrow();
		}
	}
}

/*
	Name: notetrackmeleeunsync
	Namespace: animationstatenetwork
	Checksum: 0xD5DC8E65
	Offset: 0xFE8
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackmeleeunsync(animationentity)
{
	if(isdefined(animationentity) && isdefined(animationentity.enemy))
	{
		if(isdefined(animationentity.enemy._ai_melee_markeddead) && animationentity.enemy._ai_melee_markeddead)
		{
			animationentity unlink();
		}
	}
}

/*
	Name: notetrackgibdisable
	Namespace: animationstatenetwork
	Checksum: 0x37C65A0F
	Offset: 0x1060
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private notetrackgibdisable(animationentity)
{
	if(animationentity ai::has_behavior_attribute("can_gib"))
	{
		animationentity ai::set_behavior_attribute("can_gib", 0);
	}
}

