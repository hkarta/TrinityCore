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
		this->x = y;
		this->z = z;
		this->o = o;
		this->y = y;
	}
};

typedef std::list<HouseBaseItem *> HouseBaseItemList;

class HouseItem // NOT LOADED YET
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
	std::string GetName(void);
	void MoveToPosition(void);
	void Despawn(void);
};

class HouseLocation // DONE
{
public:
	int id, faction, map, house_pack;
	float x, y, z, o;
	std::string desc;
	HouseBaseItemList baseItems;
	bool IsItemFixed(HouseItem*);

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
};

typedef std::list<HouseItem *> HouseItemList;
typedef std::list<uint32> AllowedGuests;

class House
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
	bool TeleportToHouse(void);
};

typedef std::list<HouseLocation *> HouseLocationList;
typedef std::list<House *> HouseList;

class PlayerHousing
{
public:
	HouseLocationList houseLocationList;
	HouseList houseList;
	PlayerHousing(void);
	int LoadHouses(void);
	House* GetPlayerHouse(uint32 guid);
	House* CreateHouse(Player *p, int id);
	// House DestroyHouse(Player *p);

	bool PurchaseHouse(int id);
};

class GuildhouseWorker
{
	Creature *spawner;
	Unit *item;
	//Gameobject *shield;

	GuildhouseWorker(Creature *spawner, Unit *item/*, Gameobject *shield*/)
	{
		this->spawner = spawner;
		this->item = item;
		//this->shield = shield;
	}
};

extern PlayerHousing PlayerHousingMgr;

#endif