#ifndef PLAYERHOUSING_H
#define PLAYERHOUSING_H
extern WorldDatabaseWorkerPool WorldDatabase;
extern CharacterDatabaseWorkerPool CharacterDatabase;

class HouseBaseItem // DONE
{
public:
	int item;
	bool removable;
	float x, y, z, o;
	HouseBaseItem(int item, bool removable, float x, float y, float z, float o)
	{
		this->item = item;
		this->removable = removable;
		this->x = x;
		this->z = z;
		this->o = o;
		this->y = y;
	}
};

typedef std::list<HouseBaseItem *> HouseBaseItemList;

class HouseItem // partial
{
public:
	int entry, type;
	uint32 guid;
	bool spawned, permanent;
	HouseItem(int entry, int type, uint32 guid, bool spawned)
	{
		this->entry = entry;
		this->guid = guid;
		this->type = type;
		this->spawned = spawned;
	}
	std::string GetName(void); // todo
	void MoveToPosition(void); // todo
	void Despawn(void); // todo
	// todo - something like get unit pointer
};

class HouseLocation // DONE
{
public:
	int id, faction, map, house_pack;
	float x, y, z, o;
	std::string desc;
	HouseBaseItemList baseItems;

	HouseLocation(int id, int faction, int map, float x, float y, float z, float o, int house_pack, std::string desc)
	{
		this->id = id;
		this->faction = faction;
		this->map = map;
		this->x = x;
		this->y = y;
		this->z = z;
		this->o = o;
		this->desc = desc;
	}

	float GetDistance(Player *player); // done
};

typedef std::list<HouseItem *> HouseItemList;
typedef std::list<uint32> AllowedGuests;

class House // partial
{
public:
	uint32 owner_guid;
	HouseItemList houseItemList;
	HouseLocation * houseTemplate;
	AllowedGuests allowedGuests;

	House(uint32 owner_guid, HouseLocation * houseTemplate)
	{
		this->owner_guid = owner_guid;
		this->houseTemplate = houseTemplate;
	}
	
	void SaveHouse(Player* player, bool fresh); // done
	void TeleportToHouse(Player *player); // done
	void AddGuest(uint32 guid); // todo
	void RemoveGuest(uint32 guid); // todo
};

typedef std::list<HouseLocation *> HouseLocationList;
typedef std::list<House *> HouseList;

class PlayerHousing
{
public:
	HouseLocationList houseLocationList;
	bool CanEnterGuildHouse(Player *player, House *house); //done
	void EnterGuildHouse(Player *player, uint32 guid); // done
	int GetItemCount(Player *player, int entry, bool onlyAvaiable = true); // done
	HouseItem* GetUnusedItem(House * house, int entry); // done
	Creature *SpawnCreature(Player *player, int entry); // done
	GameObject *SpawnGameObject(Player *player, int entry); // done
	Creature *GetCreatureByLowGuid(Player *player, uint32 guid, int entry); // done
	GameObject* GetGoByLowGuid(Player *player, uint32 guid, int entry); // done
	HouseLocation* GetCurrentHouseArea(Player *player); // done

	HouseList houseList;
	PlayerHousing(void); // done
	int LoadHouses(void); // done
	House* GetPlayerHouse(uint32 guid); // done
	House* CreateHouse(Player *p, int id); // done
	// House DestroyHouse(Player *p);
};

class GuildhouseWorker
{
	Creature *spawner;
	Creature *citem;
	GameObject *gitem;

	GuildhouseWorker(Creature *spawner, Creature *citem, GameObject *gitem)
	{
		this->spawner = spawner;
		this->citem =citem;
		this->gitem = gitem;
	}
};

extern PlayerHousing PlayerHousingMgr;

#endif