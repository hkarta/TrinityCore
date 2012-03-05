#pragma once
#include "ItemPrototype.h"
#include "Player.h"

extern WorldDatabaseWorkerPool WorldDatabase;
extern CharacterDatabaseWorkerPool CharacterDatabase;

class AllowedItem
{
public:
	AllowedItem(int, int, int, int, std::string, int);
	int itemClass, subClass, inventoryType, displayId, itemLevel, sheath;
	std::string description;
};

typedef std::list<AllowedItem *> AllowedItemList;

class ItemLoader
{
public:
	ItemLoader(void);
	ItemLoader(Player *owner);
	~ItemLoader(void);
	void SwapCustomItem(int entry);
	bool ValidateItemInSlot(int slot, bool);
	std::string GetItemInSlotName(int slot);
	AllowedItem* GetAllowedItemFromItem(Item *item, int displayid);
	int GetEntryForAllowedItem(AllowedItem*, Item*);
	int GetOriginalId(Item *i);
	int  perpage, invtype, page;
	Item* GetItemInSlot(int slot);

	void LoadAvaiableDisplayIds();
	uint32 lastRefresh;
	uint32 refreshTime;
	AllowedItemList allowedItemList;
private:
	Player *owner;
};

/*
EQUIPMENT_SLOT_HEAD         = 0,
    EQUIPMENT_SLOT_SHOULDERS    = 2,
    EQUIPMENT_SLOT_BODY         = 3,
    EQUIPMENT_SLOT_CHEST        = 4,
    EQUIPMENT_SLOT_WAIST        = 5,
    EQUIPMENT_SLOT_LEGS         = 6,
    EQUIPMENT_SLOT_FEET         = 7,
    EQUIPMENT_SLOT_WRISTS       = 8,
    EQUIPMENT_SLOT_HANDS        = 9,
    EQUIPMENT_SLOT_BACK         = 14,
    EQUIPMENT_SLOT_MAINHAND     = 15,
    EQUIPMENT_SLOT_OFFHAND      = 16,
    EQUIPMENT_SLOT_RANGED       = 17,
*/
