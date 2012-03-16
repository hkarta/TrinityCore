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
	uint32 guid, id;
	bool spawned, permanent;

	HouseItem(int entry, int type, uint32 guid, bool spawned, uint32 id)
	{
		this->entry = entry;
		this->guid = guid;
		this->type = type;
		this->spawned = spawned;
		this->id = id;
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


class HouseGuest
{
public:
	std::string name;
	uint32 guid;
	HouseGuest(std::string name, uint32 guid)
	{
		this->name = name;
		this->guid = guid;
	}

	bool operator < (HouseGuest* rhs)
	{
		return name.compare(rhs->name);
	}
};

typedef std::list<HouseGuest *> HouseGuests;

class House // partial
{
public:
	uint32 owner_guid;
	HouseItemList houseItemList;
	HouseLocation * houseTemplate;
	HouseGuests houseGuests;

	House(uint32 owner_guid, HouseLocation * houseTemplate)
	{
		this->owner_guid = owner_guid;
		this->houseTemplate = houseTemplate;
	}
	
	void SaveHouse(Player* player, bool fresh); // done
	void TeleportToHouse(Player *player); // done
	void AddItem(Player *player, int id);
	void AddGuest(uint32 guid); // todo
	void RemoveGuest(uint32 guid); // todo
	GameObject* GetNearestObject(Player *player, Unit *controller);
	Creature* GetNearestCreature(Player *player, Unit *controller);
	int GetPhase(void);
};

class VendorHouseItem
{
public:
	int purchaseable, icon, entry;
	std::string desc;
	VendorHouseItem(int purchaseable, int icon, int entry, std::string desc)
	{
		this->purchaseable = purchaseable;
		this->icon = icon;
		this->entry = entry;
		this->desc = desc;
	}
};

class HouseName
{
public:
	std::string name;
	uint32 guid;
	HouseName(std::string name, uint32 guid)
	{
		this->name = name;
		this->guid = guid;
	}

	bool operator < (HouseName* rhs)
	{
		return name.compare(rhs->name);
	}
};

typedef std::list<HouseName *> AllowedHousesNames;
typedef std::list<HouseLocation *> HouseLocationList;
typedef std::list<VendorHouseItem *> VendorHouseItemList;
typedef std::list<House *> HouseList;

class PlayerHousing
{
public:
	HouseLocationList houseLocationList;
	bool CanEnterGuildHouse(Player *player, House *house); //done
	void GuestChange(Player *player, uint32 guid, bool allow);
	void EnterGuildHouse(Player *player, uint32 guid); // done
	int GetItemCount(Player *player, int entry, bool onlyAvaiable = true); // done
	HouseItem* GetUnusedItem(House * house, int entry); // done
	Creature *SpawnCreature(Player *player, int entry); // done
	GameObject *SpawnGameObject(Player *player, int entry); // done
	void RemoveCreature(Player *player, Creature *creature);
	void RemoveGameObject(Player *player, GameObject *gameobject);
	Creature *GetCreatureByLowGuid(Player *player, uint32 guid, int entry); // done
	//Creature *GetNearestCreature(int id, Player *player);
	GameObject* GetGoByLowGuid(Player *player, uint32 guid, int entry); // done
	HouseLocation* GetCurrentHouseArea(Player *player); // done
	HouseList houseList;
	VendorHouseItem* GetVendorItem(int id, bool byPurchaseable);
	VendorHouseItemList vendorItemList;
	PlayerHousing(void); // done
	int LoadHouses(void); // done
	int LoadVendorItems(void); // done
	void LoadAllowedHouses(Player *player); // done
	House* GetPlayerHouse(uint32 guid); // done
	House* CreateHouse(Player *p, int id); // done
	uint32 GetPlayerGuidByName(std::string name);

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