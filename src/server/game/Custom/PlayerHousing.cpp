#include "gamePCH.h"
#include "PlayerHousing.h"
#include <Player.h>
#include <stdio.h>
#include <time.h>
#include <list>
#include <math.h>
#include "ObjectMgr.h"

PlayerHousing PlayerHousingMgr;

PlayerHousing::PlayerHousing(void){}

int House::GetPhase(void)
{
	return owner_guid;
}

Creature* House::GetNearestCreature(Player *player, Unit *controller)
{
	Creature *result = NULL;
	float distance = 10;
	if(player->GetGUIDLow() == this->owner_guid)
	{
		HouseItemList::iterator i;
		for (i = player->playerhouse->houseItemList.begin(); i != player->playerhouse->houseItemList.end(); ++i)
		{
			HouseItem *item = *i;
			if(item->entry < 0 && item->spawned && item->type == 0)
			{
				Creature *cr = controller->FindNearestCreatureInPhase(item->entry * (-1), 5);
				if(cr)
				{
					if(controller->GetDistance(cr) < distance)
					{
						result = cr;
						distance = controller->GetDistance(cr);
					}
				}
			}
		}
	}
	return result;
}

GameObject* House::GetNearestObject(Player *player, Unit *controller)
{
	GameObject *result = NULL;
	float distance = 10;
	if(player->GetGUIDLow() == this->owner_guid)
	{
		HouseItemList::iterator i;
		for (i = player->playerhouse->houseItemList.begin(); i != player->playerhouse->houseItemList.end(); ++i)
		{
			HouseItem *item = *i;
			if(item->entry > 0 && item->spawned && item->type == 0)
			{
				GameObject *go = controller->FindNearestGameObjectInPhase(item->entry, 5);
				if(go)
				{
					if(controller->GetDistance(go) < distance)
					{
						result = go;
						distance = controller->GetDistance(go);
					}
				}
			}
		}
	}
	return result;
}

Creature* PlayerHousing::GetCreatureByLowGuid(Player *player, uint32 guid, int entry)
{
	return player->GetMap()->GetCreature(MAKE_NEW_GUID(guid, entry, HIGHGUID_UNIT));
}

GameObject* PlayerHousing::GetGoByLowGuid(Player *player, uint32 guid, int entry)
{
	return player->GetMap()->GetGameObject(MAKE_NEW_GUID(guid, entry, HIGHGUID_UNIT));
}

uint32 PlayerHousing::GetPlayerGuidByName(std::string name)
{
	QueryResult guidRes = CharacterDatabase.PQuery("SELECT `guid` FROM characters WHERE `name` = '%s' LIMIT 1", name);
	//												 0				 1       2		  3 
	if (guidRes)
	{
		do
		{
			Field *fields = guidRes->Fetch();
			return fields[0].GetUInt32();			
		}
		while (guidRes->NextRow());
	}

	return 0;
}

void PlayerHousing::GuestChange(Player *player, uint32 guid, bool allow)
{
	HouseName *name = new HouseName(player->GetName(), player->GetGUIDLow());
	AllowedHousesNames::iterator i;
	Player *guest = sObjectMgr->GetPlayerByLowGUID(guid);
	HouseName *current = NULL;

	if(guest)
	{
		guest->EditAllowedHouses(name, allow);
	}

	HouseGuests::iterator g;
	if(!allow)
	{
		HouseGuest *currentDel = NULL;
		for (g = player->playerhouse->houseGuests.begin(); g != player->playerhouse->houseGuests.end(); ++g)
		{
			HouseGuest *houseGuest = *g;
			if(houseGuest->guid == guid)
			{
				currentDel = houseGuest;
				break;
			}
		}

		if(currentDel)
		{
			player->playerhouse->houseGuests.remove(currentDel);
			CharacterDatabase.PExecute("DELETE FROM `character_guildhouses_guests` WHERE `owner` = %u AND `guest` = %u", player->GetGUIDLow(), guid);
		}
	}
	else
	{
		bool passed = true;
		for (g = player->playerhouse->houseGuests.begin(); g != player->playerhouse->houseGuests.end(); ++g)
		{
			HouseGuest *houseGuest = *g;
			if(houseGuest->guid == guid)
			{
				passed = false;
				break;
			}
		}

		if(passed)
		{
			QueryResult name = CharacterDatabase.PQuery("SELECT `name` FROM characters WHERE `guid` = %u LIMIT 1", guid);
			if (name)
			{
				do
				{
					Field *fields = name->Fetch();
					player->playerhouse->houseGuests.push_back(new HouseGuest(fields[0].GetString(), guid));
					CharacterDatabase.PExecute("REPLACE INTO `character_guildhouses_guests` (`owner`, `guest`) VALUES (%u, %u)", player->GetGUIDLow(), guid);
				}
				while (name->NextRow());
			}
		}
	}
}

bool PlayerHousing::CanEnterGuildHouse(Player *player, House *house)
{
	if(player->GetGUIDLow() == house->owner_guid)
		return true;
	HouseGuests::iterator i;
	for (i = house->houseGuests.begin(); i != house->houseGuests.end(); ++i)
	{
		HouseGuest *guest = *i;
		if(guest->guid == player->GetGUIDLow())
			return true;
	}
	return false;
}

int PlayerHousing::LoadVendorItems(void)
{
	int i = 0;
	//int purchaseable, int icon, int entry, std::string desc
	//												 i				 i       i        s
	QueryResult items = WorldDatabase.PQuery("SELECT `purchaseable`, `icon`, `entry`, `desc` FROM guildhouses_purchaseables");
	//												 0				 1       2		  3 
	if (items)
	{
		do
		{
			Field *fields = items->Fetch();
			this->vendorItemList.push_back(new VendorHouseItem(fields[0].GetInt32(), fields[1].GetInt32(), fields[2].GetInt32(), fields[3].GetString()));
			i++;
		}
		while (items->NextRow());
	}

	return i;
}

void House::AddItem(Player *player, int id)
{
	CharacterDatabase.DirectPExecute("INSERT INTO character_guildhouses_items (`owner`, `guid`, `entry`, `spawned`, `type`) VALUES (%u, 0, %d, 0, 0)", this->owner_guid, id);
	QueryResult items = CharacterDatabase.PQuery("SELECT LAST_INSERT_ID()");
	if (items)
	{
		do
		{
			Field *fields = items->Fetch();
			houseItemList.push_back(new HouseItem(id, 0, 0, false, fields[0].GetUInt32()));
		}
		while (items->NextRow());
	}
}

VendorHouseItem* PlayerHousing::GetVendorItem(int id, bool byPurchaseable)
{
	VendorHouseItem *result = NULL;
	VendorHouseItemList::iterator i;
	for (i = vendorItemList.begin(); i != vendorItemList.end(); ++i)
	{
		VendorHouseItem *item = *i;
		if(byPurchaseable)
		{
			if(item->purchaseable == id)
				return item;
		}
		else
		{
			if(item->entry == id)
				return item;
		}
	}
	return result;
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
		bool isCreature = false;
		if(entry < 0)
			isCreature = true;
		Map* map = player->GetMap();

		if(isCreature)
		{				
			Creature* creature = new Creature;
			creature->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT), map, player->GetPhaseMaskForSpawn(), entry * (-1), 0, 0, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation());
			creature->house = house->GetPhase();
			creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());
			uint32 db_guid = creature->GetDBTableGUIDLow();
			creature->LoadCreatureFromDB(db_guid, map);
			sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));


			HouseItem *spawning = GetUnusedItem(house, entry);
			spawning->spawned = true;
			spawning->guid = db_guid;

			CharacterDatabase.PExecute("UPDATE character_guildhouses_items SET `spawned` = 1, `guid` = %u WHERE `owner` = %u AND `id` = %u", 
				spawning->guid, player->GetGUIDLow(), spawning->id);
		}

		house->SaveHouse(player, false);
	}

	return result;
}

void PlayerHousing::RemoveCreature(Player *player, Creature *creature)
{
	if(player->playerhouse && creature)
	{
		CharacterDatabase.PExecute("UPDATE character_guildhouses_items SET `spawned` = 0, `guid` = 0 WHERE `owner` = %u AND `guid` = %u", 
			player->GetGUIDLow(), creature->GetGUIDLow());

		HouseItemList::iterator j;
		for (j = player->playerhouse->houseItemList.begin(); j != player->playerhouse->houseItemList.end(); ++j)
		{
			HouseItem *item = *j;
			if(item->guid == creature->GetGUIDLow())
			{
				item->spawned = false;
				item->guid = 0;
			}
		}

		creature->CombatStop();
		creature->DeleteFromDB();
		creature->AddObjectToRemoveList();
	}
}

void PlayerHousing::RemoveGameObject(Player *player, GameObject *gameobject)
{
	if(player->playerhouse && gameobject)
	{
		CharacterDatabase.PExecute("UPDATE character_guildhouses_items SET `spawned` = 0, `guid` = 0 WHERE `owner` = %u AND `guid` = %u", 
			player->GetGUIDLow(), gameobject->GetGUIDLow());

		HouseItemList::iterator j;
		for (j = player->playerhouse->houseItemList.begin(); j != player->playerhouse->houseItemList.end(); ++j)
		{
			HouseItem *item = *j;
			if(item->guid == gameobject->GetGUIDLow())
			{
				item->spawned = false;
				item->guid = 0;
			}
		}

		gameobject->SetRespawnTime(0);  
		gameobject->Delete();
		gameobject->DeleteFromDB();
	}
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
			object->Create(guidLow, entry, map, player->GetPhaseMaskForSpawn(), player->GetPositionX(), 
				player->GetPositionY(), player->GetPositionZ(), player->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY);
			object->house = player->playerhouse->GetPhase();
			object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());
			object->LoadGameObjectFromDB(guidLow, map);
			sObjectMgr->AddGameobjectToGrid(guidLow, sObjectMgr->GetGOData(guidLow));
			result = object;

			HouseItem *spawning = GetUnusedItem(house, entry);
			spawning->spawned = true;
			spawning->guid = guidLow;

			CharacterDatabase.PExecute("UPDATE character_guildhouses_items SET `spawned` = 1, `guid` = %u WHERE `owner` = %u AND `id` = %u", 
				spawning->guid, player->GetGUIDLow(), spawning->id);
		}

		house->SaveHouse(player, false);
	}

	return result;
}

void PlayerHousing::LoadAllowedHouses(Player *player)
{
	player->allowedHouses.clear();
	QueryResult allowedhouses = CharacterDatabase.PQuery("SELECT DISTINCT `owner`, `name` FROM `character_guildhouses_guests` LEFT JOIN `characters` ON `owner` = `guid` WHERE `guest` = %u", player->GetGUIDLow());
	if (allowedhouses)
	{
		do
		{
			Field *fields = allowedhouses->Fetch();
			player->allowedHouses.push_back(new HouseName(fields[1].GetString(), fields[0].GetUInt32()));
		}
		while (allowedhouses->NextRow());
	}
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

			QueryResult guests = CharacterDatabase.PQuery("SELECT `guest`, `name` FROM character_guildhouses_guests LEFT JOIN characters ON `guest` = `guid` WHERE `owner` = %u", guid);
			if (guests)
			{
				do
				{
					fields = guests->Fetch();
					result->houseGuests.push_back(new HouseGuest(fields[1].GetString(), fields[0].GetUInt32()));
				}
				while (guests->NextRow());
			}

			QueryResult items = CharacterDatabase.PQuery("SELECT `entry`, `type`, `guid`, `spawned`, `id` FROM character_guildhouses_items WHERE owner = %u", guid);
			if (items)
			{
				do
				{
					fields = items->Fetch();
					bool spawned = false;
					if(fields[3].GetInt32() == 1)
						spawned = true;

					result->houseItemList.push_back(new HouseItem(fields[0].GetInt32(), fields[1].GetInt32(), fields[2].GetUInt32(), spawned, fields[4].GetUInt32()));
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
		this->houseList.push_back(house);
		player->playerhouse = house;
	}

	return house;
}

void PlayerHousing::EnterGuildHouse(Player *player, uint32 guid)
{
	House *house = GetPlayerHouse(player->GetGUIDLow());
	if(CanEnterGuildHouse(player, house))
	{
		house->TeleportToHouse(player);
		player->house = guid;
		player->SaveToDB();
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

HouseLocation* PlayerHousing::GetCurrentHouseArea(uint32 mapid, float x, float y, float z, float orientation)
{
	float lastDist = (float)RANGE_LIMIT + 1;

	HouseLocation *result = NULL;
	HouseLocationList::iterator i;
	for (i = houseLocationList.begin(); i != houseLocationList.end(); ++i)
	{
		HouseLocation *houseLoc = *i;
		if(int(mapid) == houseLoc->map)
		{
			float dist = sqrt(pow(x-houseLoc->x, 2)+pow(y-houseLoc->y, 2));
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
		CharacterDatabase.PExecute("DELETE FROM character_guildhouses_items WHERE `owner` = %u AND `type` = 1;", this->owner_guid);

		HouseBaseItemList::iterator j;
		for (j = this->houseTemplate->baseItems.begin(); j != this->houseTemplate->baseItems.end(); ++j)
		{
			HouseBaseItem *baseItem = *j;

			bool creature = false;
			if(baseItem->item < 0)
				creature = true;
			Map* map = player->GetMap();
			int id = 0;	 
			uint32 guid = 0;

			if(creature)
			{				
				Creature* creature = new Creature;
				creature->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_UNIT), map, player->GetPhaseMaskForSpawn(), baseItem->item * (-1), 0, 0, baseItem->x, baseItem->y, baseItem->z, baseItem->o);
				creature->house = player->GetGUIDLow();;
				creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());
				guid = creature->GetDBTableGUIDLow();
				creature->LoadCreatureFromDB(guid, map);
				sObjectMgr->AddCreatureToGrid(guid, sObjectMgr->GetCreatureData(guid));
			}
			else
			{
				GameObject* object = new GameObject;
				guid = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);
				object->Create(guid, baseItem->item, map, player->GetPhaseMaskForSpawn(), baseItem->x, 
				baseItem->y, baseItem->z, baseItem->o, 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY);
				object->house = player->GetGUIDLow();
				object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());
				object->LoadGameObjectFromDB(guid, map);
				sObjectMgr->AddGameobjectToGrid(guid, sObjectMgr->GetGOData(guid));
			}

			CharacterDatabase.PExecute("INSERT INTO character_guildhouses_items (`owner`, `guid`, `entry`, `spawned`, `type`) VALUES (%u, %u, %d, 1, 1)", this->owner_guid,
				guid, baseItem->item);
		}

		/*
		HouseItemList::iterator i;
		for (i = this->houseItemList.begin(); i != this->houseItemList.end(); ++i)
		{
			HouseItem *houseItem = *i;
			CharacterDatabase.PExecute("INSERT INTO character_guildhouses_items (`owner`, `guid`, `entry`, `spawned`) VALUES (%u, %u, %d, %d)", this->owner_guid,
				houseItem->guid, houseItem->entry, houseItem->spawned);
		}*/
	}

/*	CharacterDatabase.PExecute("DELETE FROM character_guildhouses_items WHERE `owner` = %u", this->owner_guid);
	HouseItemList::iterator i;
	for (i = this->houseItemList.begin(); i != this->houseItemList.end(); ++i)
	{
		HouseItem *houseItem = *i;
		CharacterDatabase.PExecute("INSERT INTO character_guildhouses_items (`owner`, `guid`, `object_id`, `spawned`) VALUES (%u, %u, %d, %d)", this->owner_guid,
			houseItem->guid, houseItem->entry, houseItem->spawned);
	}*/
}