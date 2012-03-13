#include "ScriptPCH.h"
#include <cstring>
#include "../../game/Custom/PlayerHousing.h"

enum eEnums
{

};


class object_house_controler : public CreatureScript
{
    public:

        object_house_controler()
            : CreatureScript("object_house_controler")
        {
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus(); //DATABASE_SLOT_OFFSET
			if(player->house)
			{
				if(player->GetPhaseMask() == player->house->GetPhase())
				{
					if(uiAction == GOSSIP_ACTION_INFO_DEF + 1)
					{
						GameObject *object = player->house->GetNearestObject(player);
						if(object)
						{
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, object->GetName(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
							player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "filler", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
						}
					}
				}
			}
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
            return true;
		}
};

void AddSC_object_house_controler()
{
    new object_house_controler();
}
