#include "gamePCH.h"
#include "PlayerHousing.h"
#include <stdio.h>
#include <time.h>
#include <list>
#include <math.h>

PlayerHousing PlayerHousingMgr;

PlayerHousing::PlayerHousing(void){}

int PlayerHousing::LoadHouses(void)
{
	int i = 0;
	//												      i     i          i    f    f    f    f    i             s
	QueryResult locations = WorldDatabase.PQuery("SELECT `id`, `faction`, `map` `x`, `y`, `z`, `o`, `house_pack`, `desc` FROM guildhouses_base");
	//													  0		1          2    3    4    5    6    7             8
	if (locations)
	{
		do
		{
			Field *fields = locations->Fetch();
			HouseLocation * houseLoc = new HouseLocation(fields[0].GetInt32(), fields[1].GetInt32(), fields[2].GetInt32(),
				fields[3].GetFloat(), fields[4].GetFloat(), fields[5].GetFloat(), fields[6].GetFloat(), fields[7].GetInt32(),
				fields[3].GetString());

			//												  i     i      f    f    f    f    i           
			QueryResult items = WorldDatabase.PQuery("SELECT `id`, `item`, `x`, `y`, `z`, `o`, `removable` FROM guildhouses_baseitems WHERE `id` = %d", fields[0].GetInt32());
			//												  0		1      2    3    4    5    6           
			if (items)
			{
				do
				{
					fields = items->Fetch();
					bool removable = true;
					if(fields[6].GetInt32() == 1)
						removable = false;

					houseLoc->baseItems.push_back(new HouseBaseItem(fields[1].GetInt32(), removable, fields[2].GetFloat(), fields[3].GetFloat(), fields[4].GetFloat(), fields[5].GetFloat()));
				}
    			while (items->NextRow());
			}

			houseLocationList.push_back(houseLoc);
			i++;
		}
    	while (locations->NextRow());
	}

	return i;
}

House* PlayerHousing::GetPlayerHouse(uint32 guid)
{
	HouseList::iterator i;
	for (i = houseList.begin(); i != houseList.end(); ++i)
	{
		House *house = *i;
		if(house->owner_guid == guid)
			return house;
	}

	QueryResult ph = CharacterDatabase.PQuery("SELECT `id` FROM character_guildhouses WHERE guid = %u", guid);
	if (ph)
	{
		do
		{
			Field *fields = ph->Fetch();
			int id = fields[0].GetInt32();

			HouseLocation *location;
			HouseLocationList::iterator j;
			for (j = houseLocationList.begin(); j != houseLocationList.end(); ++j)
			{
				HouseLocation *houseLocation = *j;
				if(houseLocation->id == id)
					location = houseLocation;
			}

			House *result = new House(guid, location);

			QueryResult guests = CharacterDatabase.PQuery("SELECT `guest` FROM character_guildhouses WHERE owner = %u", guid);
			if (guests)
			{
				do
				{
					fields = guests->Fetch();
					result->allowedGuests.push_back(fields[0].GetUInt32());
				}
				while (guests->NextRow());
			}

			QueryResult items = CharacterDatabase.PQuery("SELECT `entry`, `type`, `guid`, `spawned` FROM character_guildhouses_items WHERE owner = %u", guid);
			if (items)
			{
				do
				{
					fields = items->Fetch();
					bool spawned = false;
					if(fields[3].GetInt32() == 1)
						spawned = true;

					result->houseItemList.push_back(new HouseItem(fields[0].GetInt32(), fields[1].GetInt32(), fields[2].GetUInt32(), spawned));
				}
				while (items->NextRow());
			}

			houseList.push_back(result);
			return result;
		}
		while (ph->NextRow());
	}

	return NULL;
}

void PlayerHousing::EnterGuildHouse(Player *player, uint32 guid)
{
}
