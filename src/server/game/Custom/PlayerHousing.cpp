#include "gamePCH.h"
#include "PlayerHousing.h"
#include <stdio.h>
#include <time.h>
#include <list>
#include <math.h>

#define PHASE_OFFSET	200
#define LIMIT			20
#define RANGE_LIMIT		100

PlayerHousing PlayerHousingMgr;

PlayerHousing::PlayerHousing(void){}

Creature* PlayerHousing::GetCreatureByLowGuid(Player *player, uint32 guid, int entry)
{
	return player->GetMap()->GetCreature(MAKE_NEW_GUID(guid, entry, HIGHGUID_UNIT));
}

GameObject* PlayerHousing::GetGoByLowGuid(Player *player, uint32 guid, int entry)
{
	return player->GetMap()->GetGameObject(MAKE_NEW_GUID(guid, entry, HIGHGUID_UNIT));
}

bool PlayerHousing::CanEnterGuildHouse(Player *player, House *house)
{
	AllowedGuests::iterator i;
	for (i = house->allowedGuests.begin(); i != house->allowedGuests.end(); ++i)
	{
		uint32 guest = *i;
		if(guest == player->GetGUIDLow())
			return true;
	}
	return true;
}

int PlayerHousing::LoadHouses(void)
{
	int i = 0;
	//												      i     i          i    f    f    f    f    i             s
	QueryResult locations = WorldDatabase.PQuery("SELECT `id`, `faction`, `map`, `x`, `y`, `z`, `o`, `house_pack`, `desc` FROM guildhouses_base");
	//													  0		1          2    3    4    5    6    7             8
	if (locations)
	{
		do
		{
			Field *fields = locations->Fetch();
			HouseLocation * houseLoc = new HouseLocation(fields[0].GetInt32(), fields[1].GetInt32(), fields[2].GetInt32(),
				fields[3].GetFloat(), fields[4].GetFloat(), fields[5].GetFloat(), fields[6].GetFloat(), fields[7].GetInt32(),
				fields[8].GetString());

			//												  i     i      f    f    f    f    i           
			QueryResult items = WorldDatabase.PQuery("SELECT `id`, `item`, `x`, `y`, `z`, `o`, `removable` FROM guildhouses_baseitems WHERE `id` = %d", fields[0].GetInt32());
			//												  0		1      2    3    4    5    6           
			if (items)
			{
				do
				{
					Field *fields2 = items->Fetch();
					bool removable = true;
					if(fields2[6].GetInt32() == 1)
						removable = false;

					houseLoc->baseItems.push_back(new HouseBaseItem(fields2[1].GetInt32(), removable, fields2[2].GetFloat(), fields2[3].GetFloat(), fields2[4].GetFloat(), fields2[5].GetFloat()));
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

int PlayerHousing::GetItemCount(Player *player, int entry, bool onlyAvaiable)
{
	House *house = GetPlayerHouse(player->GetGUIDLow());
	if(house)
	{
		int x = 0;
		HouseItemList::iterator i;
		for (i = house->houseItemList.begin(); i != house->houseItemList.end(); ++i)
		{
			HouseItem *houseItem = *i;
			if(onlyAvaiable)
			{
				if(houseItem->entry == entry && houseItem->spawned == false)
					x++;
			}
			else if (houseItem->entry == entry)
				x++;
		}
		return x;
	}
	return 0;
}

HouseItem* PlayerHousing::GetUnusedItem(House * house, int entry)
{
	if(house)
	{
		HouseItemList::iterator i;
		for (i = house->houseItemList.begin(); i != house->houseItemList.end(); ++i)
		{
			HouseItem *houseItem = *i;
			if(houseItem->entry == entry && houseItem->spawned == false)
				return houseItem;
		}
	}

	return NULL;
}

Creature * PlayerHousing::SpawnCreature(Player *player, int entry)
{
	Creature *result = NULL;
	if(GetItemCount(player, entry) > 0)
	{
		House *house = GetPlayerHouse(player->GetGUIDLow());
		bool creature = false;
		if(entry < 0)
			creature = true;
		Map* map = player->GetMap();

		if(creature)
		{				
			Creature* creature = new Creature;
			creature->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT), map, house->owner_guid + PHASE_OFFSET, entry * (-1), 0, 0,
				house->houseTemplate->x, house->houseTemplate->y, house->houseTemplate->z, house->houseTemplate->o);
			creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), house->owner_guid + PHASE_OFFSET);
			uint32 db_guid = creature->GetDBTableGUIDLow();
			sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));
			result = creature;
		}
		GetUnusedItem(house, entry)->spawned = true;
		house->SaveHouse(player, false);
	}

	return result;
}

GameObject * PlayerHousing::SpawnGameObject(Player *player, int entry)
{
	GameObject *result = NULL;
	if(GetItemCount(player, entry) > 0)
	{
		House *house = GetPlayerHouse(player->GetGUIDLow());
		bool creature = false;
		if(entry < 0)
			creature = true;
		Map* map = player->GetMap();

		if(!creature)
		{				
			GameObject* object = new GameObject;
			uint32 guidLow = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);
			object->Create(guidLow, entry, map, house->owner_guid + PHASE_OFFSET, house->houseTemplate->x, 
				house->houseTemplate->y, house->houseTemplate->z, house->houseTemplate->o, 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY);
			object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), house->owner_guid + PHASE_OFFSET);
			object->LoadGameObjectFromDB(guidLow, map);
			sObjectMgr->AddGameobjectToGrid(guidLow, sObjectMgr->GetGOData(guidLow));
			result = object;
		}
		GetUnusedItem(house, entry)->spawned = true;
		house->SaveHouse(player, false);
	}

	return result;
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

			QueryResult guests = CharacterDatabase.PQuery("SELECT `guest` FROM character_guildhouses_guests WHERE owner = %u", guid);
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

House* PlayerHousing::CreateHouse(Player *player, int id)
{
	House *house = GetPlayerHouse(player->GetGUIDLow());
	if(!house)
	{
		HouseLocation *location;
		HouseLocationList::iterator j;
		for (j = houseLocationList.begin(); j != houseLocationList.end(); ++j)
		{
			HouseLocation *houseLocation = *j;
			if(houseLocation->id == id)
				location = houseLocation;
		}

		house = new House(player->GetGUIDLow(), location);
		house->SaveHouse(player, true);
		player->house = house;
	}

	return house;
}

void PlayerHousing::EnterGuildHouse(Player *player, uint32 guid)
{
	House *house = GetPlayerHouse(player->GetGUIDLow());
	if(CanEnterGuildHouse(player, house))
	{
		house->TeleportToHouse(player);
		player->lasthouse = guid;
	}
	else
	{
		// todo remove item // PHASE_OFFSET
	}
}

HouseLocation* PlayerHousing::GetCurrentHouseArea(Player *player)
{
	float lastDist = (float)RANGE_LIMIT + 1;
	HouseLocation *result = NULL;
	HouseLocationList::iterator i;
	for (i = houseLocationList.begin(); i != houseLocationList.end(); ++i)
	{
		HouseLocation *houseLoc = *i;
		float dist = houseLoc->GetDistance(player);
		if(dist != -1)
		{
			if(dist < lastDist)
			{
				lastDist = dist;
				result = houseLoc;
			}
		}
	}

	return result;
}

float HouseLocation::GetDistance(Player *player)
{
	float result = -1;

	if(player->GetMapId() == map)
	{
		float px = player->GetPositionX();
		float py = player->GetPositionY();
		float cx = x;
		float cy = y;
		float distance = sqrt((cx-px)*(cx-px)+(cy-py)*(cy-py));

		if(distance < RANGE_LIMIT)
		{
		   result = distance;
		}
	}

	return result;
}

void House::TeleportToHouse(Player *player)
{
	player->TeleportTo(this->houseTemplate->map, this->houseTemplate->x, this->houseTemplate->y, this->houseTemplate->z, this->houseTemplate->o);
	player->SetPhaseMask(this->owner_guid + PHASE_OFFSET, true);
}

void House::SaveHouse(Player *player, bool fresh)
{
	if(fresh)
	{
		CharacterDatabase.PExecute("REPLACE INTO character_guildhouses VALUES (%u, %d)", this->owner_guid, this->houseTemplate->id);
		HouseBaseItemList::iterator j;
		for (j = this->houseTemplate->baseItems.begin(); j != this->houseTemplate->baseItems.end(); ++j)
		{
			HouseBaseItem *baseItem = *j;

			bool creature = false;
			if(baseItem->item < 0)
				creature = true;
			Map* map = player->GetMap();
				 
			if(creature)
			{				
				sLog->outString(">> Spawning creature: %d", baseItem->item * (-1));
				Creature* creature = new Creature;
				creature->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT), map, this->owner_guid + PHASE_OFFSET, baseItem->item * (-1), 0, 0,
					baseItem->x, baseItem->y, baseItem->z, baseItem->o);
				creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), this->owner_guid + PHASE_OFFSET);
				uint32 db_guid = creature->GetDBTableGUIDLow();
				sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));
			}
			else
			{
				sLog->outString(">> Spawning gameobject: %d", baseItem->item);
				GameObject* object = new GameObject;
				uint32 guidLow = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);
				object->Create(guidLow, baseItem->item, map, this->owner_guid + PHASE_OFFSET, baseItem->x, baseItem->y, baseItem->z, baseItem->o, 
					0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY);
				object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), this->owner_guid + PHASE_OFFSET);
				object->LoadGameObjectFromDB(guidLow, map);
				sObjectMgr->AddGameobjectToGrid(guidLow, sObjectMgr->GetGOData(guidLow));
			}
		}
	}

	CharacterDatabase.PExecute("DELETE FROM character_guildhouses_items WHERE `owner` = %u", this->owner_guid);
	HouseItemList::iterator i;
	for (i = this->houseItemList.begin(); i != this->houseItemList.end(); ++i)
	{
		HouseItem *houseItem = *i;
		CharacterDatabase.PExecute("INSERT INTO character_guildhouses_items (`owner`, `guid`, `object_id`, `spawned`) VALUES (%u, %u, %d, %d)", this->owner_guid,
			houseItem->guid, houseItem->entry, houseItem->spawned);
	}
}