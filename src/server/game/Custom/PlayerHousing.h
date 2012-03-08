#ifndef PLAYERHOUSING_H
#define PLAYERHOUSING_H
extern WorldDatabaseWorkerPool WorldDatabase;
extern CharacterDatabaseWorkerPool CharacterDatabase;

class HouseBaseItem
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

class HouseLocation
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
};

typedef std::list<HouseLocation *> HouseLocationList;

class PlayerHousing
{
public:
	HouseLocationList houseLocationList;
	PlayerHousing(void);
	int LoadHouses(void);
	HouseLocation GetHouseLocation(Player *player);
	void LoadPlayerHouse(Player *player);

	bool PurchaseHouse(int id);
};

class HouseItem
{
public:
	Player *parent;
	int id, type;
	uint32 guid;
	bool spawned, permanent;
	HouseItem(int id, int type, uint32 guid, bool spawned, Player *parent)
	{
		this->id = id;
		this->guid = guid;
		this->type = type;
		this->spawned = spawned;
		this->parent = parent;
	}
	std::string GetName(void);
	void MoveToPosition(void);
	void Despawn(void);
};

typedef std::list<HouseItem *> HouseItemList;

class House
{
public:
	Player * owner;
	int currentAction;
	HouseItemList houseItemList;
	void TeleportToHouse(void);
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