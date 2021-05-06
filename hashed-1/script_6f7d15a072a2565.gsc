// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;

#namespace namespace_81c567a8;

/*
	Name: init_shared
	Namespace: namespace_81c567a8
	Checksum: 0x3E444534
	Offset: 0xA8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	registerclientfields();
}

/*
	Name: registerclientfields
	Namespace: namespace_81c567a8
	Checksum: 0x44415D71
	Offset: 0xC8
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
private function registerclientfields()
{
	if(function_f99d2668())
	{
		clientfield::register("clientuimodel", "eliminated_postfx", 12000, 1, "int", &function_c73ec9a, 0, 0);
	}
}

/*
	Name: function_c73ec9a
	Namespace: namespace_81c567a8
	Checksum: 0x3B512973
	Offset: 0x130
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_c73ec9a(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	isplaying = postfx::function_556665f2(#"hash_1e4c3120a3e08628");
	if(newval == 1)
	{
		if(!isplaying)
		{
			self codeplaypostfxbundle(#"hash_1e4c3120a3e08628");
		}
	}
	else if(newval == 0)
	{
		if(isplaying)
		{
			self postfx::stoppostfxbundle(#"hash_1e4c3120a3e08628");
		}
	}
}

