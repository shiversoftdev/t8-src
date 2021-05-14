// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace dev_shared;

/*
	Name: init
	Namespace: dev_shared
	Checksum: 0xD352ED75
	Offset: 0x78
	Size: 0x2C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function init()
{
	/#
		callback::on_localclient_connect(&function_b49b1b6b);
	#/
}

/*
	Name: function_b49b1b6b
	Namespace: dev_shared
	Checksum: 0x6F2A50F8
	Offset: 0xB0
	Size: 0x274
	Parameters: 1
	Flags: None
*/
function function_b49b1b6b(localclientnum)
{
	/#
		var_39073e7a = undefined;
		var_b49b1b6b = undefined;
		a_effects = array("", "", "");
		var_767a6d22 = 0;
		while(true)
		{
			n_dist = getdvarint(#"hash_4348ec71a8b13ef1", 0);
			var_114d05f = int(min(getdvarint(#"hash_4ead99200e3cc72c", 0), a_effects.size - 1));
			if(n_dist > 0)
			{
				if(var_114d05f != var_767a6d22 && isdefined(var_b49b1b6b))
				{
					killfx(localclientnum, var_b49b1b6b);
					var_b49b1b6b = undefined;
				}
				if(!isdefined(var_39073e7a))
				{
					var_39073e7a = util::spawn_model(localclientnum, "");
				}
				if(!isdefined(var_b49b1b6b))
				{
					var_b49b1b6b = util::playfxontag(localclientnum, a_effects[var_114d05f], var_39073e7a, "");
				}
				v_pos = getcamposbylocalclientnum(localclientnum);
				v_ang = getcamanglesbylocalclientnum(localclientnum);
				v_forward = anglestoforward(v_ang);
				var_39073e7a.origin = v_pos + v_forward * n_dist;
				var_39073e7a.angles = v_ang;
			}
			else if(isdefined(var_39073e7a))
			{
				killfx(localclientnum, var_b49b1b6b);
				var_39073e7a delete();
				var_b49b1b6b = undefined;
			}
			var_767a6d22 = var_114d05f;
			waitframe(1);
		}
	#/
}

