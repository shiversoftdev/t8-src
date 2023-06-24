// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_ix_scarlett;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_scarlett
	Checksum: 0x9ED606B6
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_scarlett", &__init__, undefined, #"character_unlock_ix_scarlett_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_scarlett
	Checksum: 0x7F140F0C
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"ix_scarlett_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_ix_scarlett
	Checksum: 0xE90B9813
	Offset: 0x118
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::function_c55a0479(&function_fcd28111);
	}
}

/*
	Name: function_fcd28111
	Namespace: character_unlock_ix_scarlett
	Checksum: 0x16AB845A
	Offset: 0x158
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_fcd28111(params)
{
	if(!isdefined(params.activator))
	{
		return;
	}
	activator = params.activator;
	if(!isplayer(activator))
	{
		return;
	}
	if(!activator character_unlock::function_f0406288(#"ix_scarlett_unlock"))
	{
		return;
	}
	if(self.stash_type === 1)
	{
		activator character_unlock::function_c8beca5e(#"ix_scarlett_unlock", #"hash_74fceff1a255277d", 1);
	}
}

