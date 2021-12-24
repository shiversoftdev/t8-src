// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace blackboard;

/*
	Name: registervehicleblackboardattributes
	Namespace: blackboard
	Checksum: 0xE3C30A9D
	Offset: 0x68
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function registervehicleblackboardattributes()
{
	/#
		assert(isvehicle(self), "");
	#/
}

/*
	Name: bb_getspeed
	Namespace: blackboard
	Checksum: 0x508C8009
	Offset: 0xA8
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function bb_getspeed()
{
	velocity = self getvelocity();
	return length(velocity);
}

/*
	Name: bb_vehgetenemyyaw
	Namespace: blackboard
	Checksum: 0x9761DDBC
	Offset: 0xF0
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function bb_vehgetenemyyaw()
{
	enemy = self.enemy;
	if(!isdefined(enemy))
	{
		return 0;
	}
	toenemyyaw = vehgetpredictedyawtoenemy(self, 0.2);
	return toenemyyaw;
}

/*
	Name: vehgetpredictedyawtoenemy
	Namespace: blackboard
	Checksum: 0x552FDD8F
	Offset: 0x148
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function vehgetpredictedyawtoenemy(entity, lookaheadtime)
{
	if(isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime())
	{
		return entity.predictedyawtoenemy;
	}
	selfpredictedpos = entity.origin;
	moveangle = entity.angles[1] + entity getmotionangle();
	selfpredictedpos = selfpredictedpos + (((cos(moveangle), sin(moveangle), 0) * 200) * lookaheadtime);
	yaw = (vectortoangles(entity.enemy.origin - selfpredictedpos)[1]) - entity.angles[1];
	yaw = absangleclamp360(yaw);
	entity.predictedyawtoenemy = yaw;
	entity.predictedyawtoenemytime = gettime();
	return yaw;
}

