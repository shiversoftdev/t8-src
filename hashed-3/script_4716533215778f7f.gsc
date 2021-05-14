// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_f9df92f;

/*
	Name: preload
	Namespace: namespace_f9df92f
	Checksum: 0xDD20AF3F
	Offset: 0xC0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	init_clientfields();
	level thread function_7a324b77();
}

/*
	Name: main
	Namespace: namespace_f9df92f
	Checksum: 0x80F724D1
	Offset: 0xF8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: init_clientfields
	Namespace: namespace_f9df92f
	Checksum: 0x31894AA6
	Offset: 0x108
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_12114abc7407913b", 24000, 1, "counter", &function_30ed45c9, 0, 0);
	clientfield::register("toplayer", "" + #"hash_5e38e846ce88405b", 24000, 1, "counter", &function_48a634b7, 0, 0);
}

/*
	Name: function_30ed45c9
	Namespace: namespace_f9df92f
	Checksum: 0x8F529CF6
	Offset: 0x1C8
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_30ed45c9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_34d554b44dfcb81d");
		playsound(localclientnum, #"hash_750bc40787e0e29f", (0, 0, 0));
	}
}

/*
	Name: function_48a634b7
	Namespace: namespace_f9df92f
	Checksum: 0xD7CFA717
	Offset: 0x260
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_48a634b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_34d551b44dfcb304");
		playsound(localclientnum, #"hash_750bc50787e0e452", (0, 0, 0));
	}
}

/*
	Name: function_7a324b77
	Namespace: namespace_f9df92f
	Checksum: 0x5F6E41F0
	Offset: 0x2F8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_7a324b77()
{
	t_pareidolia = getent(0, "t_pareidolia", "targetname");
	waitresult = undefined;
	waitresult = t_pareidolia waittill(#"trigger");
	playsound(0, #"mus_pareidolia", (-7053, -24906, 222));
}

