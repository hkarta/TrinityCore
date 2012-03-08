#ifndef PLAYERHOUSING_H
#define PLAYERHOUSING_H
extern WorldDatabaseWorkerPool WorldDatabase;
extern CharacterDatabaseWorkerPool CharacterDatabase;

class HouseLocation
{
public:
	int id, vendor, group, next;
	std::string desc;
	HouseLocation(int id, int vendor, int group, int next, std::string desc)
	{
		this->id = id;
		this->vendor = vendor;
		this->group = group;
		this->next = next;
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
	House *parent;
	int id, type;
	uint32 guid;
	bool spawned, permanent;
	HouseItem(int id, int type, uint32 guid, bool spawned, House *parent)
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

extern PlayerHousing playerHousingMgr;

#endif