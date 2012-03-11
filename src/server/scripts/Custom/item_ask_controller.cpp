#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "../../game/Custom/PlayerHousing.h"

class ItemUse_item_ask_controller : public ItemScript
{
    public:

        ItemUse_item_ask_controller()
            : ItemScript("item_ask_controller")
        {
        }

        bool OnUse(Player *player, Item *item, SpellCastTargets const& /*targets*/)
        {
			if(!player->isInCombat() && !player->InArena())
			{
				HouseLocation *location = PlayerHousingMgr.GetCurrentHouseArea(player);
				if(location)
				{
				//	Creature *c = player->GetNearCre
				}
				else if(player->house)
				{
					player->house->TeleportToHouse(player);
				}
			}

			return false;
        }
};

void AddSC_example_misc()
{
    new ItemUse_item_ask_controller();
}