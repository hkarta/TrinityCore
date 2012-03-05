#include "gamePCH.h"
#include "AllowedAreas.h"
#include "Player.h"
#include <stdio.h>
#include <time.h>
#include <list>
#include <math.h>

AllowedAreas AllowedAreasMgr;

AllowedAreas::AllowedAreas(void)
{
}


AllowedAreas::~AllowedAreas(void)
{
}

int AllowedAreas::LoadAreas(void)
{
	int i = 0;
	QueryResult result = WorldDatabase.PQuery("SELECT map_id, x, y, z, distance FROM _AllowedAreas");
	//												  0		   1  2  3  4   
	if (result)
	{
		do
		{
			Field *fields = result->Fetch();
			int area_id = fields[0].GetInt32();
			float x = fields[1].GetFloat();
			float y = fields[2].GetFloat();
			float z = fields[3].GetFloat();
			int distance = fields[4].GetInt32();
			allowedAreas.push_back(new AllowedArea(area_id, x, y, z, distance));
			i++;
		}
    	while (result->NextRow());
	}

	return i;
}

bool AllowedAreas::HasAccessToArea(Player *p)
{
	if(p->isGameMaster())
		return true;

	AllowedAreasList::iterator i;
	for (i = allowedAreas.begin(); i != allowedAreas.end(); ++i)
	{
		AllowedArea *allowedArea = *i;
		if(allowedArea->IsWithinArea(p))
			return true;
	}


	return false;
}


LastPosition::LastPosition(void)
{
	map_id = -1;
	x = 0;
	y = 0;
	z = 0;
	o = 0;
}

LastPosition::LastPosition(int map_id, float x, float y, float z, float o)
{
	this->map_id = map_id;
	this->x = x;
	this->y = y;
	this->z = z;
	this->o = o;
}

AllowedArea::AllowedArea(int map_id, float x, float y, float z, int distance)
{
	this->map_id = map_id;
	this->x = x;
	this->y = y;
	this->z = z;
	this->distance = distance;
}

bool AllowedArea::IsWithinArea(Player *p)
{
	if(p->GetMapId() == map_id)
	{
		//Sqrt((x1-x2)^2+(y1-y2)^2)
		float px = p->GetPositionX();
		float py = p->GetPositionY();
		float pz = p->GetPositionZ();

		if(sqrt((x-px)*(x-px)+(y-py)*(y-py)) < distance)
		{
			//sLog->outString(">> Distance: %u, from z: %u", sqrt((x-px)*(x-px)+(y-py)*(y-py))), sqrt((z-pz)*(z-pz));
			if(sqrt((z-pz)*(z-pz)) < distance)
				return true;
		}
	}

	return false;
}
