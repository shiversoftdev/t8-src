// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;

#namespace character;

/*
	Name: setmodelfromarray
	Namespace: character
	Checksum: 0xE0970276
	Offset: 0x98
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function setmodelfromarray(a)
{
	self setmodel(a[randomint(a.size)]);
}

/*
	Name: randomelement
	Namespace: character
	Checksum: 0x98C07C42
	Offset: 0xE0
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function randomelement(a)
{
	return a[randomint(a.size)];
}

/*
	Name: attachfromarray
	Namespace: character
	Checksum: 0x18CF8CC7
	Offset: 0x110
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function attachfromarray(a)
{
	self attach(randomelement(a), "", 1);
}

/*
	Name: newcharacter
	Namespace: character
	Checksum: 0xEE3990BF
	Offset: 0x158
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function newcharacter()
{
	self detachall();
	oldgunhand = self.anim_gunhand;
	if(!isdefined(oldgunhand))
	{
		return;
	}
	self.anim_gunhand = "none";
	self [[anim.putguninhand]](oldgunhand);
}

/*
	Name: save
	Namespace: character
	Checksum: 0x7DA24643
	Offset: 0x1C0
	Size: 0x1DC
	Parameters: 0
	Flags: None
*/
function save()
{
	info[#"gunhand"] = self.anim_gunhand;
	info[#"guninhand"] = self.anim_guninhand;
	info[#"model"] = self.model;
	info[#"hatmodel"] = self.hatmodel;
	info[#"gearmodel"] = self.gearmodel;
	if(isdefined(self.name))
	{
		info[#"name"] = self.name;
		/#
			println("", self.name);
		#/
	}
	else
	{
		/#
			println("");
		#/
	}
	attachsize = self getattachsize();
	for(i = 0; i < attachsize; i++)
	{
		info[#"attach"][i][#"model"] = self getattachmodelname(i);
		info[#"attach"][i][#"tag"] = self getattachtagname(i);
	}
	return info;
}

/*
	Name: load
	Namespace: character
	Checksum: 0x96765D83
	Offset: 0x3A8
	Size: 0x1E6
	Parameters: 1
	Flags: None
*/
function load(info)
{
	self detachall();
	self.anim_gunhand = info[#"gunhand"];
	self.anim_guninhand = info[#"guninhand"];
	self setmodel(info[#"model"]);
	self.hatmodel = info[#"hatmodel"];
	self.gearmodel = info[#"gearmodel"];
	if(isdefined(info[#"name"]))
	{
		self.name = info[#"name"];
		/#
			println("", self.name);
		#/
	}
	else
	{
		/#
			println("");
		#/
	}
	attachinfo = info[#"attach"];
	attachsize = attachinfo.size;
	for(i = 0; i < attachsize; i++)
	{
		self attach(attachinfo[i][#"model"], attachinfo[i][#"tag"]);
	}
}

/*
	Name: get_random_character
	Namespace: character
	Checksum: 0xEA2658C4
	Offset: 0x598
	Size: 0x1E2
	Parameters: 1
	Flags: None
*/
function get_random_character(amount)
{
	self_info = strtok(self.classname, "_");
	if(self_info.size <= 2)
	{
		return randomint(amount);
	}
	group = "auto";
	index = undefined;
	prefix = self_info[2];
	if(isdefined(self.script_char_index))
	{
		index = self.script_char_index;
	}
	if(isdefined(self.script_char_group))
	{
		type = "grouped";
		group = "group_" + self.script_char_group;
	}
	if(!isdefined(level.character_index_cache))
	{
		level.character_index_cache = [];
	}
	if(!isdefined(level.character_index_cache[prefix]))
	{
		level.character_index_cache[prefix] = [];
	}
	if(!isdefined(level.character_index_cache[prefix][group]))
	{
		initialize_character_group(prefix, group, amount);
	}
	if(!isdefined(index))
	{
		index = get_least_used_index(prefix, group);
		if(!isdefined(index))
		{
			index = randomint(5000);
		}
	}
	while(index >= amount)
	{
		index = index - amount;
	}
	level.character_index_cache[prefix][group][index]++;
	return index;
}

/*
	Name: get_least_used_index
	Namespace: character
	Checksum: 0x32B6E5F0
	Offset: 0x788
	Size: 0x14A
	Parameters: 2
	Flags: None
*/
function get_least_used_index(prefix, group)
{
	lowest_indices = [];
	lowest_use = level.character_index_cache[prefix][group][0];
	lowest_indices[0] = 0;
	for(i = 1; i < level.character_index_cache[prefix][group].size; i++)
	{
		if(level.character_index_cache[prefix][group][i] > lowest_use)
		{
			continue;
		}
		if(level.character_index_cache[prefix][group][i] < lowest_use)
		{
			lowest_indices = [];
			lowest_use = level.character_index_cache[prefix][group][i];
		}
		lowest_indices[lowest_indices.size] = i;
	}
	/#
		assert(lowest_indices.size, "");
	#/
	return array::random(lowest_indices);
}

/*
	Name: initialize_character_group
	Namespace: character
	Checksum: 0x5F14C833
	Offset: 0x8E0
	Size: 0x60
	Parameters: 3
	Flags: None
*/
function initialize_character_group(prefix, group, amount)
{
	for(i = 0; i < amount; i++)
	{
		level.character_index_cache[prefix][group][i] = 0;
	}
}

