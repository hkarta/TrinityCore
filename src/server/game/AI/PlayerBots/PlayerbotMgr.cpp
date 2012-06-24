/*
* Copyright (C) 2005-2012 MaNGOS <http://getmangos.com/>
* Copyright (C) 2012 Playerbot Team
* Copyright (C) 2012 MangosR2
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include "Config.h"
#include "Player.h"
#include "PlayerbotAI.h"
#include "PlayerbotMgr.h"
#include "WorldPacket.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "GossipDef.h"
#include "Language.h"
#include "WaypointMovementGenerator.h"
#include "Guild.h"
#include "GroupMgr.h"
#include "Group.h"

class LoginQueryHolder;
class CharacterHandler;

void PlayerbotMgr::SetInitialWorldSettings()
{

}

PlayerbotMgr::PlayerbotMgr(Player* const master) : m_master(master)
{
    // load config variables
	m_confMaxNumBots = sWorld->getIntConfig(PlayerbotAI_MaxNumBots);
    m_confDebugWhisper = sWorld->getBoolConfig(PlayerbotAI_DebugWhisper);
    m_confFollowDistance[0] =  sWorld->getFloatConfig(PlayerbotAI_FollowDistanceMin);
    m_confFollowDistance[1] = sWorld->getFloatConfig(PlayerbotAI_FollowDistanceMax);
    m_confCollectCombat = sWorld->getBoolConfig(PlayerbotAI_Collect_Combat);
    m_confCollectQuest = sWorld->getBoolConfig(PlayerbotAI_Collect_Quest);
    m_confCollectProfession = sWorld->getBoolConfig(PlayerbotAI_Collect_Profession);
    m_confCollectLoot = sWorld->getBoolConfig(PlayerbotAI_Collect_Loot);
    m_confCollectSkin = sWorld->getBoolConfig(PlayerbotAI_Collect_Skin);
    m_confCollectObjects = sWorld->getBoolConfig(PlayerbotAI_Collect_Objects);
    m_confCollectDistanceMax = sWorld->getIntConfig(PlayerbotAI_Collect_DistanceMax);
    gConfigSellLevelDiff = sWorld->getIntConfig(PlayerbotAI_SellAll_LevelDiff);
    if (m_confCollectDistanceMax > 100)
    {
        sLog->outError("Playerbot: PlayerbotAI.Collect.DistanceMax higher than allowed. Using 100");
        m_confCollectDistanceMax = 100;
    }
    m_confCollectDistance = sWorld->getIntConfig(PlayerbotAI_Collect_Distance);
    if (m_confCollectDistance > m_confCollectDistanceMax)
    {
        sLog->outError("Playerbot: PlayerbotAI.Collect.Distance higher than PlayerbotAI.Collect.DistanceMax. Using DistanceMax value");
        m_confCollectDistance = m_confCollectDistanceMax;
    }
}

PlayerbotMgr::~PlayerbotMgr()
{
    LogoutAllBots();
}

void PlayerbotMgr::UpdateAI(const uint32 /*p_time*/) {}

void PlayerbotMgr::HandleMasterIncomingPacket(const WorldPacket& packet)
{
    switch (packet.GetOpcode())
    {

        case CMSG_TOGGLE_PVP:
        {
            WorldPacket p(packet);

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot)
                    continue;

                p.rpos(0);         // reset reader
                bot->GetSession()->HandleTogglePvP(p);
                if (bot->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
                    bot->GetPlayerbotAI()->SetScenarioType(PlayerbotAI::SCENARIO_PVPEASY);
                else
                    bot->GetPlayerbotAI()->SetScenarioType(PlayerbotAI::SCENARIO_PVEEASY);
            }
            return;
        }

        case CMSG_OFFER_PETITION:
        {
            WorldPacket p(packet);
            p.rpos(0);    // reset reader
            uint64 petitionGuid;
            uint64 playerGuid;
            uint32 junk;

            p >> junk;                                      // this is not petition type!
            p >> petitionGuid;                              // petition guid
            p >> playerGuid;                                // player guid

            Player* player = ObjectAccessor::FindPlayer(playerGuid);
            if (!player)
                return;

            uint32 petitionLowGuid = GUID_LOPART(petitionGuid);

            QueryResult result = CharacterDatabase.PQuery("SELECT * FROM petition_sign WHERE playerguid = '%u' AND petitionguid = '%u'", player->GetGUIDLow(), petitionLowGuid);

            if(result)
            {
               ChatHandler(m_master).PSendSysMessage("%s has already signed the petition",player->GetName());
               return;
            }

            CharacterDatabase.PExecute("INSERT INTO petition_sign (ownerguid,petitionguid, playerguid, player_account) VALUES ('%u', '%u', '%u','%u')",
            GetMaster()->GetGUIDLow(), petitionLowGuid, player->GetGUIDLow(), GetMaster()->GetSession()->GetAccountId());

            p.Initialize(SMSG_PETITION_SIGN_RESULTS, (8+8+4));
            p << petitionGuid;
            p << playerGuid;
            p << uint32(PETITION_SIGN_OK);

            // close at signer side
            GetMaster()->GetSession()->SendPacket(&p);

            return;
        }

        case MSG_RAID_READY_CHECK:
        {
            WorldPacket p(packet);

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot)
                    return;

                Group* group = bot->GetGroup();
                if (!group)
                    return;

                // DEBUG_LOG("MSG_RAID_READY_CHECK group(%u)",GetMaster()->GetGUIDLow());

				Player* const leader = ObjectAccessor::FindPlayer(group->GetLeaderGUID());
                if (!leader)
                    return;

                if (group->isRaidGroup() && bot->GetPlayerbotAI()->canObeyCommandFrom(*leader))
                {
                    p.Initialize(MSG_RAID_READY_CHECK_CONFIRM, 9);
					p << bot->GetGUID();
                    p << uint8(146);
                    group->BroadcastReadyCheck(&p);
                }
            }
            return;
        }

        case CMSG_BATTLEFIELD_PORT:
        {
            WorldPacket p(packet);
            p.rpos(0);    // reset reader
            p.hexlike();

            uint8 type;
            uint8 unk2;
            uint32 bgTypeId_;
            uint16 unk;
            uint8 action;

            p >> type >> unk2 >> bgTypeId_ >> unk >> action;

			QueryResult result = CharacterDatabase.PQuery("SELECT arena_team_member.guid FROM arena_team_member JOIN arena_team ON arena_team_member.arenateamid = arena_team.arenateamid WHERE captainguid='%u' AND type='%u'", GetMaster()->GetGUIDLow(), type);
            if (result)
            {
                do
                {
                    Field *fields = result->Fetch();
                    uint32 guid = fields[0].GetUInt32();

                    for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
                    {
                        Player* const bot = it->second;
                        if (!bot)
                            continue;

                       p.rpos(0);    // reset reader
                       if (bot->GetGUIDLow() == guid)
                           bot->GetSession()->HandleBattleFieldPortOpcode(p);
                    }

                }
                while (result->NextRow());
            }
            return;
        }

		/*
        case CMSG_LFG_JOIN:
        {
            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot)
                    continue;

                Group* group = bot->GetGroup();
                if (group)
                {
                    bool isChanged = sLFGMgr.RoleChanged(bot, bot->GetPlayerbotAI()->GetRole());
                    // DEBUG_LOG("CMSG_LFG_SET_ROLES: Group %u, Player %u, Roles: %u %s", group->GetGUID().GetCounter(), bot->GetGUID().GetCounter(), bot->GetPlayerbotAI()->GetRole(), isChanged ? "changed" : "not changed");
                    sLFGMgr.UpdateRoleCheck(group);
                }
                else
                {
                    bot->GetLFGState()->SetRoles(bot->GetPlayerbotAI()->GetRole());
                    // DEBUG_LOG("CMSG_LFG_SET_ROLES (not in group) Player %u roles %u", bot->GetGUID().GetCounter(), bot->GetPlayerbotAI()->GetRole());
                }
            }
            return;
        }

        case CMSG_LFG_PROPOSAL_RESPONSE:
        {
            WorldPacket p(packet);
            p.rpos(0);    // reset reader

            uint32 ID;                                              // Internal proposal ID
            bool   accept;                                          // Accept to join?
            p >> ID;
            p >> accept;

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot)
                    continue;

                // DEBUG_LOG("CMSG_LFG_PROPOSAL_RESULT %u proposal: %u accept: %u", bot->GetGUID().GetCounter(), ID, accept ? 1 : 0);
                //sLFGMgr.UpdateProposal(ID, bot->GetGUID(), accept); [TODO]

            }
            return;
        }*/

        case CMSG_ACTIVATETAXI:
        {
            WorldPacket p(packet);
            p.rpos(0); // reset reader

            uint64 guid;
            std::vector<uint32> nodes;
            nodes.resize(2);
            uint8 delay = 9;
            p >> guid >> nodes[0] >> nodes[1];

            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_ACTIVATETAXI from %d to %d", nodes[0], nodes[1]);

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {

                delay = delay + 3;
                Player* const bot = it->second;
                if (!bot)
                    return;

                Group* group = bot->GetGroup();
                if (!group)
                    continue;
                bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                Unit *target = ObjectAccessor::GetUnit(*bot, guid);

                bot->GetPlayerbotAI()->SetIgnoreUpdateTime(delay);

                bot->GetMotionMaster()->Clear(true);
                bot->GetMotionMaster()->MoveFollow(target, INTERACTION_DISTANCE, bot->GetOrientation());
                bot->GetPlayerbotAI()->GetTaxi(guid, nodes);
            }
            return;
        }

        case CMSG_ACTIVATETAXIEXPRESS:
        {
            WorldPacket p(packet);
            p.rpos(0); // reset reader

            uint64 guid;
            uint32 node_count;
            uint8 delay = 9;
            p >> guid >> node_count;

            std::vector<uint32> nodes;
            for (uint32 i = 0; i < node_count; ++i)
            {
                uint32 node;
                p >> node;
                nodes.push_back(node);
            }

            if (nodes.empty())
                return;

            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_ACTIVATETAXIEXPRESS from %d to %d", nodes.front(), nodes.back());

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {

                delay = delay + 3;
                Player* const bot = it->second;
                if (!bot)
                    return;
                bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                Group* group = bot->GetGroup();
                if (!group)
                    continue;
                Unit *target = ObjectAccessor::GetUnit(*bot, guid);

                bot->GetPlayerbotAI()->SetIgnoreUpdateTime(delay);

                bot->GetMotionMaster()->Clear(true);
                bot->GetMotionMaster()->MoveFollow(target, INTERACTION_DISTANCE, bot->GetOrientation());
                bot->GetPlayerbotAI()->GetTaxi(guid, nodes);
            }
            return;
        }

        case CMSG_MOVE_SPLINE_DONE:
        {
            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_MOVE_SPLINE_DONE");

            WorldPacket p(packet);
            p.rpos(0); // reset reader

            uint64 guid;                                        // used only for proper packet read
            MovementInfo movementInfo;                              // used only for proper packet read
            p.readPackGUID(guid);
			movementInfo.guid;
			/*WorldSession::ReadMovementInfo(p, &movementInfo);[TODO]

            p >> movementInfo;
            p >> Unused<uint32>();                          // unk*/

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {

                Player* const bot = it->second;
                if (!bot)
                    return;

                // in taxi flight packet received in 2 case:
                // 1) end taxi path in far (multi-node) flight
                // 2) switch from one map to other in case multi-map taxi path
                // we need process only (1)
                uint32 curDest = bot->m_taxi.GetTaxiDestination();
                if (!curDest)
                    return;

                TaxiNodesEntry const* curDestNode = sTaxiNodesStore.LookupEntry(curDest);

                // far teleport case
                if (curDestNode && curDestNode->map_id != bot->GetMapId())
                {
                    if (bot->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
                    {
                        // short preparations to continue flight
                        FlightPathMovementGenerator* flight = (FlightPathMovementGenerator *) (bot->GetMotionMaster()->top());

                        flight->Finalize(*bot);                // [NOTSURE]will reset at map landing

                        flight->SetCurrentNodeAfterTeleport();
                        TaxiPathNodeEntry const& node = flight->GetPath()[flight->GetCurrentNode()];
                        flight->SkipCurrentNode();

                        bot->TeleportTo(curDestNode->map_id, node.x, node.y, node.z, bot->GetOrientation());
                    }
                    return;
                }

                uint32 destinationnode = bot->m_taxi.NextTaxiDestination();
                if (destinationnode > 0)                                // if more destinations to go
                {
                    // current source node for next destination
                    uint32 sourcenode = bot->m_taxi.GetTaxiSource();

                    // Add to taximask middle hubs in taxicheat mode (to prevent having player with disabled taxicheat and not having back flight path)
                    if (bot->isTaxiCheater())
                        if (bot->m_taxi.SetTaximaskNode(sourcenode))
                        {
                            WorldPacket data(SMSG_NEW_TAXI_PATH, 0);
                            bot->GetSession()->SendPacket(&data);
                        }

                        // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_MOVE_SPLINE_DONE Taxi has to go from %u to %u", sourcenode, destinationnode);

                        uint32 mountDisplayId = sObjectMgr->GetTaxiMountDisplayId(sourcenode, bot->GetTeam());

                        uint32 path, cost;
                        sObjectMgr->GetTaxiPath(sourcenode, destinationnode, path, cost);

                        if (path && mountDisplayId)
                            bot->GetSession()->SendDoFlight(mountDisplayId, path, 1);          // skip start fly node
                        else
                            bot->m_taxi.ClearTaxiDestinations();    // clear problematic path and next
                }
                else
                    /* std::ostringstream out;
                    out << "Destination reached" << bot->GetName();
                    ChatHandler ch(m_master);
                    ch.SendSysMessage(out.str().c_str()); */
                    bot->m_taxi.ClearTaxiDestinations();        // Destination, clear source node
            }
            return;
        }

        // if master is logging out, log out all bots
        case CMSG_LOGOUT_REQUEST:
        {
            LogoutAllBots();
            return;
        }

        // If master inspects one of his bots, give the master useful info in chat window
        // such as inventory that can be equipped
        case CMSG_INSPECT:
        {
            WorldPacket p(packet);
            p.rpos(0); // reset reader
            uint64 guid;
            p >> guid;
            Player* const bot = GetPlayerBot(guid);
            if (bot) bot->GetPlayerbotAI()->SendNotEquipList(*bot);
            return;
        }

        // handle emotes from the master
        //case CMSG_EMOTE:
        case CMSG_TEXT_EMOTE:
        {
            WorldPacket p(packet);
            p.rpos(0); // reset reader
            uint32 emoteNum;
            p >> emoteNum;

            /* std::ostringstream out;
            out << "emote is: " << emoteNum;
            ChatHandler ch(m_master);
            ch.SendSysMessage(out.str().c_str()); */

            switch (emoteNum)
            {
                case TEXT_EMOTE_BOW:
                {
                    // Buff anyone who bows before me. Useful for players not in bot's group
                    // How do I get correct target???
                    //Player* const pPlayer = GetPlayerBot(m_master->GetSelection());
                    //if (pPlayer->GetPlayerbotAI()->GetClassAI())
                    //    pPlayer->GetPlayerbotAI()->GetClassAI()->BuffPlayer(pPlayer);
                    return;
                }
                /*
                case TEXTEMOTE_BONK:
                {
                Player* const pPlayer = GetPlayerBot(m_master->GetSelection());
                if (!pPlayer || !pPlayer->GetPlayerbotAI())
                return;
                PlayerbotAI* const pBot = pPlayer->GetPlayerbotAI();

                ChatHandler ch(m_master);
                {
                std::ostringstream out;
                out << "time(0): " << time(0)
                << " m_ignoreAIUpdatesUntilTime: " << pBot->m_ignoreAIUpdatesUntilTime;
                ch.SendSysMessage(out.str().c_str());
                }
                {
                std::ostringstream out;
                out << "m_TimeDoneEating: " << pBot->m_TimeDoneEating
                << " m_TimeDoneDrinking: " << pBot->m_TimeDoneDrinking;
                ch.SendSysMessage(out.str().c_str());
                }
                {
                std::ostringstream out;
                out << "m_CurrentlyCastingSpellId: " << pBot->m_CurrentlyCastingSpellId;
                ch.SendSysMessage(out.str().c_str());
                }
                {
                std::ostringstream out;
                out << "IsBeingTeleported() " << pBot->GetPlayer()->IsBeingTeleported();
                ch.SendSysMessage(out.str().c_str());
                }
                {
                std::ostringstream out;
                bool tradeActive = (pBot->GetPlayer()->GetTrader()) ? true : false;
                out << "tradeActive: " << tradeActive;
                ch.SendSysMessage(out.str().c_str());
                }
                {
                std::ostringstream out;
                out << "IsCharmed() " << pBot->getPlayer()->isCharmed();
                ch.SendSysMessage(out.str().c_str());
                }
                return;
                }
                */

                case TEXT_EMOTE_EAT:
                case TEXT_EMOTE_DRINK:
                {
                    for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
                    {
                        Player* const bot = it->second;
                        bot->GetPlayerbotAI()->Feast();
                    }
                    return;
                }

                // emote to attack selected target
                case TEXT_EMOTE_POINT:
                {
                    uint64 attackOnGuid = m_master->GetSelection();
                    if (attackOnGuid == 0 || attackOnGuid == NULL)
                        return;

                    Unit* thingToAttack = ObjectAccessor::GetUnit(*m_master, attackOnGuid);
                    if (!thingToAttack) return;

                    Player *bot = 0;
                    for (PlayerBotMap::iterator itr = m_playerBots.begin(); itr != m_playerBots.end(); ++itr)
                    {
                        bot = itr->second;
                        if (!bot->IsFriendlyTo(thingToAttack) && !bot->IsWithinLOSInMap(thingToAttack))
                        {
                            bot->GetPlayerbotAI()->DoTeleport(*m_master);
                            if (bot->IsWithinLOSInMap(thingToAttack))
                                bot->GetPlayerbotAI()->GetCombatTarget(thingToAttack);
                        }
                        else if (!bot->IsFriendlyTo(thingToAttack) && bot->IsWithinLOSInMap(thingToAttack))
                            bot->GetPlayerbotAI()->GetCombatTarget(thingToAttack);
                    }
                    return;
                }

                // emote to stay
                case TEXT_EMOTE_STAND:
                {
                    Player* const bot = GetPlayerBot(m_master->GetSelection());
                    if (bot)
                        bot->GetPlayerbotAI()->SetMovementOrder(PlayerbotAI::MOVEMENT_STAY);
                    else
                        for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
                        {
                            Player* const bot = it->second;
                            bot->GetPlayerbotAI()->SetMovementOrder(PlayerbotAI::MOVEMENT_STAY);
                        }
                        return;
                }

                // 324 is the followme emote (not defined in enum)
                // if master has bot selected then only bot follows, else all bots follow
                case 324:
                case TEXT_EMOTE_WAVE:
                {
					Player* const bot = GetPlayerBot(m_master->GetSelection());
                    if (bot)
                        bot->GetPlayerbotAI()->SetMovementOrder(PlayerbotAI::MOVEMENT_FOLLOW, m_master);
                    else
                        for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
                        {
                            Player* const bot = it->second;
                            bot->GetPlayerbotAI()->SetMovementOrder(PlayerbotAI::MOVEMENT_FOLLOW, m_master);
                        }
                        return;
                }
            }
            return;
        } /* EMOTE ends here */

        case CMSG_GAMEOBJ_USE: // not sure if we still need this one
        case CMSG_GAMEOBJ_REPORT_USE:
        {
            WorldPacket p(packet);
            p.rpos(0);     // reset reader
            uint64 objGUID;
            p >> objGUID;
            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                GameObject *obj = m_master->GetMap()->GetGameObject(objGUID);
                if (!obj)
                    return;

                // add other go types here, i.e.:
                // GAMEOBJECT_TYPE_CHEST - loot quest items of chest
                if (obj->GetGoType() == GAMEOBJECT_TYPE_QUESTGIVER)
                {
                    bot->GetPlayerbotAI()->TurnInQuests(obj);

                    // auto accept every available quest this NPC has
                    bot->PrepareQuestMenu(objGUID);
                    QuestMenu& questMenu = bot->PlayerTalkClass->GetQuestMenu();
                    for (uint32 iI = 0; iI < questMenu.GetMenuItemCount(); ++iI)
                    {
                        QuestMenuItem const& qItem = questMenu.GetItem(iI);
                        uint32 questID = qItem.QuestId;
                        if (!bot->GetPlayerbotAI()->AddQuest(questID, obj))
							sLog->outString("Couldn't take quest");
                    }
                }
            }
        }
        break;

        case CMSG_QUESTGIVER_HELLO:
        {
            WorldPacket p(packet);
            p.rpos(0);    // reset reader
            uint64 npcGUID;
            p >> npcGUID;
			WorldObject* pNpc;
			ObjectAccessor::GetWorldObject(*pNpc, npcGUID);
            if (!pNpc)
                return;

            // for all master's bots
            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                bot->GetPlayerbotAI()->TurnInQuests(pNpc);
            }

            return;
        }

        // if master accepts a quest, bots should also try to accept quest
        case CMSG_QUESTGIVER_ACCEPT_QUEST:
        {
            WorldPacket p(packet);
            p.rpos(0);    // reset reader
            uint64 guid;
            uint32 quest;
            uint32 unk1;
            p >> guid >> quest >> unk1;

            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_QUESTGIVER_ACCEPT_QUEST npc = %s, quest = %u, unk1 = %u", guid.GetString().c_str(), quest, unk1);

            Quest const* qInfo = sObjectMgr->GetQuestTemplate(quest);
            if (qInfo)
                for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
                {
                    Player* const bot = it->second;
                    bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                    if (bot->GetQuestStatus(quest) == QUEST_STATUS_COMPLETE)
                        bot->GetPlayerbotAI()->TellMaster("I already completed that quest.");
                    else if (!bot->CanTakeQuest(qInfo, false))
                    {
                        if (!bot->SatisfyQuestStatus(qInfo, false))
                            bot->GetPlayerbotAI()->TellMaster("I already have that quest.");
                        else
                            bot->GetPlayerbotAI()->TellMaster("I can't take that quest.");
                    }
                    else if (!bot->SatisfyQuestLog(false))
                        bot->GetPlayerbotAI()->TellMaster("My quest log is full.");
                    else if (!bot->CanAddQuest(qInfo, false))
                        bot->GetPlayerbotAI()->TellMaster("I can't take that quest because it requires that I take items, but my bags are full!");

                    else
                    {
                        p.rpos(0);         // reset reader
                        bot->GetSession()->HandleQuestgiverAcceptQuestOpcode(p);
                        bot->GetPlayerbotAI()->TellMaster("Got the quest.");

                        // build needed items if quest contains any
                        for (int i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
                            if (qInfo->RequiredItemCount[i] > 0)
                            {
                                bot->GetPlayerbotAI()->SetQuestNeedItems();
                                break;
                            }

                            // build needed creatures if quest contains any
                            for (int i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
                                if (qInfo->RequiredNpcOrGoCount[i] > 0)
                                {
                                    bot->GetPlayerbotAI()->SetQuestNeedCreatures();
                                    break;
                                }
                    }
                }
                return;
        }

        case CMSG_AREATRIGGER:
        {
            WorldPacket p(packet);

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot)
                    continue;

                if (bot->IsWithinDistInMap(GetMaster(), 50))
                {
                    p.rpos(0);         // reset reader
                    bot->GetSession()->HandleAreaTriggerOpcode(p);
                }
            }
            return;
        }

        case CMSG_QUESTGIVER_COMPLETE_QUEST:
        {
            WorldPacket p(packet);
            p.rpos(0);    // reset reader
            uint32 quest;
            uint64 npcGUID;
            p >> npcGUID >> quest;

            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_QUESTGIVER_COMPLETE_QUEST npc = %s, quest = %u", npcGUID.GetString().c_str(), quest);

            WorldObject* pNpc;
			ObjectAccessor::GetWorldObject(*pNpc, npcGUID); //[NOTSURE]
            if (!pNpc)
                return;

            // for all master's bots
            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                bot->GetPlayerbotAI()->TurnInQuests(pNpc);
            }
            return;
        }

        case CMSG_LOOT_ROLL:
        {
            WorldPacket p(packet);    //WorldPacket packet for CMSG_LOOT_ROLL, (8+4+1)
            uint64 Guid;
            uint32 itemSlot;
            uint8 rollType;
            Loot *loot = NULL;

            p.rpos(0);        //reset packet pointer
            p >> Guid;        //guid of the lootable target
            p >> itemSlot;    //loot index
            p >> rollType;    //need,greed or pass on roll

            Creature *c = m_master->GetMap()->GetCreature(Guid);
            GameObject *go = m_master->GetMap()->GetGameObject(Guid);
            if (!c)
                if (!go)
                    return;

            if (c)
                loot = &c->loot;
            else
                loot = &go->loot;

            LootItem& lootItem = loot->items[itemSlot];

            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                uint32 choice = 0;

                Player* const bot = it->second;
                if (!bot)
                    return;

                Group* group = bot->GetGroup();
                if (!group)
                    return;

                ItemTemplate const *pProto = sObjectMgr->GetItemTemplate(lootItem.itemid);
                if (!pProto)
                    return;

                if (bot->GetPlayerbotAI()->CanStore())
                {
                    if (bot->CanUseItem(pProto) == EQUIP_ERR_OK && bot->GetPlayerbotAI()->IsItemUseful(lootItem.itemid))
                        choice = 1;  // Need
                    else if (bot->HasSkill(SKILL_ENCHANTING))
                        choice = 3;  // Disenchant
                    else
                        choice = 2;  // Greed
                }
                else
                    choice = 0;  // Pass

				group->CountRollVote(bot->GetGUID(), Guid, RollVote(choice));

                switch (choice)
                {
                    case ROLL_NEED:
                        bot->GetAchievementMgr().UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED, 1);
                        break;
                    case ROLL_GREED:
                    case ROLL_DISENCHANT:
                        bot->GetAchievementMgr().UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED, 1);
                        break;
                }
            }
            return;
        }

        // Handle GOSSIP activate actions, prior to GOSSIP select menu actions
        case CMSG_GOSSIP_HELLO:
        {
            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_GOSSIP_HELLO");

            WorldPacket p(packet);    //WorldPacket packet for CMSG_GOSSIP_HELLO, (8)
            uint64 guid;
            p.rpos(0);                //reset packet pointer
            p >> guid;
            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot)
                    continue;
                bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                Creature *pCreature = bot->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_NONE);
                if (!pCreature)
                {
					sLog->outString("[PlayerbotMgr]: HandleMasterIncomingPacket - Received  CMSG_GOSSIP_HELLO %u not found or you can't interact with him.", guid);
                    continue;
                }

                GossipMenuItemsMapBounds pMenuItemBounds = sObjectMgr->GetGossipMenuItemsMapBounds(pCreature->GetCreatureTemplate()->GossipMenuId);
                for (GossipMenuItemsContainer::const_iterator itr = pMenuItemBounds.first; itr != pMenuItemBounds.second; ++itr)
                {
                    uint32 npcflags = pCreature->GetUInt32Value(UNIT_NPC_FLAGS);

                    if (!(itr->second.OptionNpcflag & npcflags))
                        continue;

                    switch (itr->second.OptionIcon)
                    {
                        case GOSSIP_OPTION_TAXIVENDOR:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_TAXIVENDOR");
                            bot->GetSession()->SendLearnNewTaxiNode(pCreature);
                            break;
                        }
                        case GOSSIP_OPTION_QUESTGIVER:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_QUESTGIVER");
                            bot->GetPlayerbotAI()->TurnInQuests(pCreature);
                            break;
                        }
                        case GOSSIP_OPTION_VENDOR:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_VENDOR");
							if (!sWorld->getBoolConfig(PlayerbotAI_SellGarbage))
                                continue;

                            // changed the SellGarbage() function to support ch.SendSysMessaage()
                            bot->GetPlayerbotAI()->SellGarbage(*bot);
                            break;
                        }
                        case GOSSIP_OPTION_STABLEPET:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_STABLEPET");
                            break;
                        }
                        case GOSSIP_OPTION_AUCTIONEER:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_AUCTIONEER");
                            break;
                        }
                        case GOSSIP_OPTION_BANKER:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_BANKER");
                            break;
                        }
                        case GOSSIP_OPTION_INNKEEPER:
                        {
                            // bot->GetPlayerbotAI()->TellMaster("PlayerbotMgr:GOSSIP_OPTION_INNKEEPER");
                            break;
                        }
                    }
                }
            }
            return;
        }

        case CMSG_SPIRIT_HEALER_ACTIVATE:
        {
            // DEBUG_LOG ("[PlayerbotMgr]: HandleMasterIncomingPacket - Received CMSG_SPIRIT_HEALER_ACTIVATE SpiritHealer is resurrecting the Player %s",m_master->GetName());
            for (PlayerBotMap::iterator itr = m_playerBots.begin(); itr != m_playerBots.end(); ++itr)
            {
                Player* const bot = itr->second;
                Group *grp = bot->GetGroup();
                if (grp)
					grp->RemoveMember(bot->GetGUID(), GROUP_REMOVEMETHOD_KICK);
            }
            return;
        }

        case CMSG_LIST_INVENTORY:
        {
			if (sWorld->getBoolConfig(PlayerbotAI_SellGarbage))
                return;

            WorldPacket p(packet);
            p.rpos(0);  // reset reader
            uint64 npcGUID;
            p >> npcGUID;
			WorldObject * object;
            Object* const pNpc = ObjectAccessor::GetObjectByTypeMask(*object, npcGUID,  TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT); // [NOTSURE]
            if (!pNpc)
                return;

            // for all master's bots
            for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); it != GetPlayerBotsEnd(); ++it)
            {
                Player* const bot = it->second;
                if (!bot->IsInMap(static_cast<WorldObject *>(pNpc)))
                {
                    bot->GetPlayerbotAI()->TellMaster("I'm too far away to sell items!");
                    continue;
                }
                else
                {
                    // changed the SellGarbage() function to support ch.SendSysMessaage()
                    bot->GetPlayerbotAI()->FollowAutoReset(*bot);
                    bot->GetPlayerbotAI()->SellGarbage(*bot);
                }
            }
            return;
        }

        /*
        case CMSG_NAME_QUERY:
        case MSG_MOVE_START_FORWARD:
        case MSG_MOVE_STOP:
        case MSG_MOVE_SET_FACING:
        case MSG_MOVE_START_STRAFE_LEFT:
        case MSG_MOVE_START_STRAFE_RIGHT:
        case MSG_MOVE_STOP_STRAFE:
        case MSG_MOVE_START_BACKWARD:
        case MSG_MOVE_HEARTBEAT:
        case CMSG_STANDSTATECHANGE:
        case CMSG_QUERY_TIME:
        case CMSG_CREATURE_QUERY:
        case CMSG_GAMEOBJECT_QUERY:
        case MSG_MOVE_JUMP:
        case MSG_MOVE_FALL_LAND:
        return;

        default:
        {
        const char* oc = LookupOpcodeName(packet.GetOpcode());
        // ChatHandler ch(m_master);
        // ch.SendSysMessage(oc);

        std::ostringstream out;
        out << "masterin: " << oc;
        sLog.outError(out.str().c_str());
        }
        */
    }
}

void PlayerbotMgr::HandleMasterOutgoingPacket(const WorldPacket& /*packet*/)
{
    /*
    switch (packet.GetOpcode())
    {
    // maybe our bots should only start looting after the master loots?
    //case SMSG_LOOT_RELEASE_RESPONSE: {}
    case SMSG_NAME_QUERY_RESPONSE:
    case SMSG_MONSTER_MOVE:
    case SMSG_COMPRESSED_UPDATE_OBJECT:
    case SMSG_DESTROY_OBJECT:
    case SMSG_UPDATE_OBJECT:
    case SMSG_STANDSTATE_UPDATE:
    case MSG_MOVE_HEARTBEAT:
    case SMSG_QUERY_TIME_RESPONSE:
    case SMSG_AURA_UPDATE_ALL:
    case SMSG_CREATURE_QUERY_RESPONSE:
    case SMSG_GAMEOBJECT_QUERY_RESPONSE:
    return;
    default:
    {
    const char* oc = LookupOpcodeName(packet.GetOpcode());

    std::ostringstream out;
    out << "masterout: " << oc;
    sLog.outError(out.str().c_str());
    }
    }
    */
}

void PlayerbotMgr::LogoutAllBots()
{
    while (true)
    {
        PlayerBotMap::const_iterator itr = GetPlayerBotsBegin();
        if (itr == GetPlayerBotsEnd()) break;
        Player* bot = itr->second;
        LogoutPlayerBot(bot->GetGUID());
    }
    RemoveAllBotsFromGroup();
}

void PlayerbotMgr::Stay()
{
    for (PlayerBotMap::const_iterator itr = GetPlayerBotsBegin(); itr != GetPlayerBotsEnd(); ++itr)
    {
        Player* bot = itr->second;
        bot->GetMotionMaster()->Clear();
    }
}

// Playerbot mod: logs out a Playerbot.
void PlayerbotMgr::LogoutPlayerBot(uint64 guid)
{
    Player* bot = GetPlayerBot(guid);
    if (bot)
    {
        WorldSession * botWorldSessionPtr = bot->GetSession();
        m_playerBots.erase(guid);    // deletes bot player ptr inside this WorldSession PlayerBotMap
        botWorldSessionPtr->LogoutPlayer(true); // this will delete the bot Player object and PlayerbotAI object
        delete botWorldSessionPtr;  // finally delete the bot's WorldSession
    }
}

// Playerbot mod: Gets a player bot Player object for this WorldSession master
Player* PlayerbotMgr::GetPlayerBot(uint64 playerGuid) const
{
    PlayerBotMap::const_iterator it = m_playerBots.find(playerGuid);
    return (it == m_playerBots.end()) ? 0 : it->second;
}

void PlayerbotMgr::OnBotLogin(Player * const bot)
{
    bot->SetMap(sMapMgr->CreateMap(bot->GetMapId(), bot));
    // give the bot some AI, object is owned by the player class
    PlayerbotAI* ai = new PlayerbotAI(this, bot);
    bot->SetPlayerbotAI(ai);

    // tell the world session that they now manage this new bot
    m_playerBots[bot->GetGUID()] = bot;

    // if bot is in a group and master is not in group then
    // have bot leave their group
    if (bot->GetGroup() &&
        (m_master->GetGroup() == NULL ||
        m_master->GetGroup()->IsMember(bot->GetGUID()) == false))
        bot->RemoveFromGroup();

    // sometimes master can lose leadership, pass leadership to master check
    const uint64 masterGuid = m_master->GetGUID();
    if (m_master->GetGroup() &&
        !m_master->GetGroup()->IsLeader(masterGuid))
        // But only do so if one of the master's bots is leader
        for (PlayerBotMap::const_iterator itr = GetPlayerBotsBegin(); itr != GetPlayerBotsEnd(); itr++)
        {
            Player* bot = itr->second;
            if (m_master->GetGroup()->IsLeader(bot->GetGUID()))
            {
                m_master->GetGroup()->ChangeLeader(masterGuid);
                break;
            }
        }
}

void PlayerbotMgr::RemoveAllBotsFromGroup()
{
    for (PlayerBotMap::const_iterator it = GetPlayerBotsBegin(); m_master->GetGroup() && it != GetPlayerBotsEnd(); ++it)
    {
        Player* const bot = it->second;
        if (bot->IsInSameGroupWith(m_master))
            m_master->GetGroup()->RemoveMember(bot->GetGUID(), GROUP_REMOVEMETHOD_DEFAULT);
    }
}

void Creature::LoadBotMenu(Player *pPlayer)
{

    if (pPlayer->GetPlayerbotAI()) return;
    uint64 guid = pPlayer->GetGUID();
	uint32 accountId = sObjectMgr->GetPlayerAccountIdByGUID(guid);
    QueryResult result = CharacterDatabase.PQuery("SELECT guid, name FROM characters WHERE account='%d'", accountId);
    do
    {
        Field *fields = result->Fetch();
        uint64 guidlo = uint64(fields[0].GetUInt64());
        std::string name = fields[1].GetString();
        std::string word = "";

        if ((guid == uint64()) || (guid == guidlo))
        {
            //not found or himself
        }
        else
        {
            // if(sConfig.GetBoolDefault("PlayerbotAI.DisableBots", false)) return;
            // create the manager if it doesn't already exist
            if (!pPlayer->GetPlayerbotMgr())
                pPlayer->SetPlayerbotMgr(new PlayerbotMgr(pPlayer));
            if (pPlayer->GetPlayerbotMgr()->GetPlayerBot(guidlo) == NULL) // add (if not already in game)
            {
                word += "Recruit ";
                word += name;
                word += " as a Bot.";
                pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(0, (uint8) 9, word, guidlo, GOSSIP_OPTION_BOT, word, false); //[NOTSURE]
            }
            else if (pPlayer->GetPlayerbotMgr()->GetPlayerBot(guidlo) != NULL) // remove (if in game)
            {
                word += "Dismiss ";
                word += name;
                word += " from duty.";
                pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(0, (uint8) 0, word, guidlo, GOSSIP_OPTION_BOT, word, false);
            }
        }
    }
    while (result->NextRow());
}

void Player::skill(std::list<uint32>& m_spellsToLearn)
{
    for (SkillStatusMap::const_iterator itr = mSkillStatus.begin(); itr != mSkillStatus.end(); ++itr)
    {
        if (itr->second.uState == SKILL_DELETED)
            continue;

        uint32 pskill = itr->first;

        m_spellsToLearn.push_back(pskill);
    }
}

void Player::MakeTalentGlyphLink(std::ostringstream &out)
{
    // |cff4e96f7|Htalent:1396:4|h[Unleashed Fury]|h|r
    // |cff66bbff|Hglyph:23:460|h[Glyph of Fortitude]|h|r

    if (m_specsCount)
        // loop through all specs (only 1 for now)
        for (uint32 specIdx = 0; specIdx < m_specsCount; ++specIdx)
        {
            // find class talent tabs (all players have 3 talent tabs)
            uint32 const* talentTabIds = GetTalentTabPages(getClass());

            out << "\n" << "Active Talents ";

            for (uint32 i = 0; i < 3; ++i)
            {
                uint32 talentTabId = talentTabIds[i];
                for (PlayerTalentMap::iterator iter = m_talents[specIdx]->begin(); iter != m_talents[specIdx]->end(); ++iter)
                {
					uint32 talentEntry = (*iter).first;
                    PlayerTalent *talent = (*iter).second;

                    if (talent->state == PLAYERSPELL_REMOVED)
                        continue;

                    // skip another tab talents
					if (talent->spec != talentTabId) //[NOTSURE]
                        continue;

                    TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentEntry);

					SpellEntry const* spell_entry = sSpellStore.LookupEntry(talentEntry); // [NOTSURE] at all

					out << "|cff4e96f7|Htalent:" << spell_entry->SpellName << ":" << talentInfo->RankID
                        << " |h[" << spell_entry->SpellName[GetSession()->GetSessionDbcLocale()] << "]|h|r";
                }
            }

            uint32 freepoints = 0;

            out << " Unspent points : ";

            if ((freepoints = GetFreeTalentPoints()) > 0)
                out << "|h|cff00ff00" << freepoints << "|h|r";
            else
                out << "|h|cffff0000" << freepoints << "|h|r";

            out << "\n" << "Active Glyphs ";
            // GlyphProperties.dbc
            for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
            {
				GlyphPropertiesEntry const*glyph = sGlyphPropertiesStore.LookupEntry(m_Glyphs[specIdx][i]);
                if (!glyph)
                    continue;

                SpellEntry const* spell_entry = sSpellStore.LookupEntry(glyph->SpellId);

                out << "|cff66bbff|Hglyph:" << GetGlyphSlot(i) << ":" << m_Glyphs[specIdx][i]
                    << " |h[" << spell_entry->SpellName[GetSession()->GetSessionDbcLocale()] << "]|h|r";

            }
        }
}

void Player::chompAndTrim(std::string& str)
{
    while (str.length() > 0)
    {
        char lc = str[str.length() - 1];
        if (lc == '\r' || lc == '\n' || lc == ' ' || lc == '"' || lc == '\'')
            str = str.substr(0, str.length() - 1);
        else
            break;
        while (str.length() > 0)
        {
            char lc = str[0];
            if (lc == ' ' || lc == '"' || lc == '\'')
                str = str.substr(1, str.length() - 1);
            else
                break;
        }
    }
}

bool Player::getNextQuestId(const std::string& pString, unsigned int& pStartPos, unsigned int& pId)
{
    bool result = false;
    unsigned int i;
    for (i = pStartPos; i < pString.size(); ++i)
    {
        if (pString[i] == ',')
            break;
    }
    if (i > pStartPos)
    {
        std::string idString = pString.substr(pStartPos, i - pStartPos);
        pStartPos = i + 1;
        chompAndTrim(idString);
        pId = atoi(idString.c_str());
        result = true;
    }
    return(result);
}

bool Player::requiredQuests(const char* pQuestIdString)
{
    if (pQuestIdString != NULL)
    {
        unsigned int pos = 0;
        unsigned int id;
        std::string confString(pQuestIdString);
        chompAndTrim(confString);
        while (getNextQuestId(confString, pos, id))
        {
            QuestStatus status = GetQuestStatus(id);
            if (status == QUEST_STATUS_COMPLETE)
                return true;
        }
    }
    return false;
}

void Player::UpdateMail()
{
    // save money,items and mail to prevent cheating
    SQLTransaction trans = CharacterDatabase.BeginTransaction();
	this->SaveGoldToDB(trans);
    this->SaveInventoryAndGoldToDB(trans);
    this->_SaveMail(trans);
    CharacterDatabase.CommitTransaction(trans);
}

//See MainSpec enum in PlayerbotAI.h for details on class return values
uint32 Player::GetSpec()
{
    uint32 row = 0, spec = 0;

    //Iterate through the 3 talent trees
    for (uint32 i = 0; i < 3; ++i)
    {
        for (PlayerTalentMap::iterator iter = m_talents[m_activeSpec]->begin(); iter != m_talents[m_activeSpec]->end(); ++iter)
        {
			uint32 talentEntry = (*iter).first;
            PlayerTalent *talent = (*iter).second;
            if (row == 0 && spec == 0)
				spec = talent->spec; //[GUESS]

			TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentEntry);

            //If current talent is deeper into a tree, that is our new max talent
            if (talentInfo->Row > row) {
                row = talentInfo->Row;

                //Set the tree the deepest talent is on
                spec = talentInfo->TalentTab;
            }
        }
    }

    //Return the tree with the deepest talent
    return spec;
}

bool ChatHandler::HandlePlayerbotCommand(const char* args)
{
    if (!(m_session->GetSecurity() > SEC_PLAYER))
		if (sWorld->getBoolConfig(PlayerbotAI_DisableBots))
        {
            PSendSysMessage("|cffff0000Playerbot system is currently disabled!");
            SetSentErrorMessage(true);
            return false;
        }

        if (!m_session)
        {
            PSendSysMessage("|cffff0000You may only add bots from an active session");
            SetSentErrorMessage(true);
            return false;
        }

        if (!*args)
        {
            PSendSysMessage("|cffff0000usage: add PLAYERNAME  or  remove PLAYERNAME");
            SetSentErrorMessage(true);
            return false;
        }

        char *cmd = strtok ((char *) args, " ");
        char *charname = strtok (NULL, " ");
        if (!cmd || !charname)
        {
            PSendSysMessage("|cffff0000usage: add PLAYERNAME  or  remove PLAYERNAME");
            SetSentErrorMessage(true);
            return false;
        }

        std::string cmdStr = cmd;
        std::string charnameStr = charname;

        if (!normalizePlayerName(charnameStr))
            return false;

        uint64 guid = sObjectMgr->GetPlayerGUIDByName(charnameStr.c_str());
        if (guid == uint64() || (guid == m_session->GetPlayer()->GetGUID()))
        {
            SendSysMessage(LANG_PLAYER_NOT_FOUND);
            SetSentErrorMessage(true);
            return false;
        }

        uint32 accountId = sObjectMgr->GetPlayerAccountIdByGUID(guid);
        if (accountId != m_session->GetAccountId())
        {
            PSendSysMessage("|cffff0000You may only add bots from the same account.");
            SetSentErrorMessage(true);
            return false;
        }

        // create the playerbot manager if it doesn't already exist
        PlayerbotMgr* mgr = m_session->GetPlayer()->GetPlayerbotMgr();
        if (!mgr)
        {
            mgr = new PlayerbotMgr(m_session->GetPlayer());
            m_session->GetPlayer()->SetPlayerbotMgr(mgr);
        }

        QueryResult resultchar = CharacterDatabase.PQuery("SELECT COUNT(*) FROM characters WHERE online = '1' AND account = '%u'", m_session->GetAccountId());
        if (resultchar)
        {
            Field *fields = resultchar->Fetch();
            int acctcharcount = fields[0].GetUInt32();
			int maxnum = sWorld->getIntConfig(PlayerbotAI_MaxNumBots);
            if (!(m_session->GetSecurity() > SEC_PLAYER))
                if (acctcharcount > maxnum && (cmdStr == "add" || cmdStr == "login"))
                {
                    PSendSysMessage("|cffff0000You cannot summon anymore bots.(Current Max: |cffffffff%u)", maxnum);
                    SetSentErrorMessage(true);
                    return false;
                }
        }

        QueryResult resultlvl = CharacterDatabase.PQuery("SELECT level,name FROM characters WHERE guid = '%u'", GUID_LOPART(guid));
        if (resultlvl)
        {
            Field *fields = resultlvl->Fetch();
            int charlvl = fields[0].GetUInt32();
            int maxlvl = sWorld->getIntConfig(PlayerbotAI_RestrictBotLevel);
            if (!(m_session->GetSecurity() > SEC_PLAYER))
                if (charlvl > maxlvl)
                {
                    PSendSysMessage("|cffff0000You cannot summon |cffffffff[%s]|cffff0000, it's level is too high.(Current Max:lvl |cffffffff%u)", fields[1].GetString(), maxlvl);
                    SetSentErrorMessage(true);
                    return false;
                }
        }
        // end of gmconfig patch
        if (cmdStr == "add" || cmdStr == "login")
        {
            if (mgr->GetPlayerBot(guid))
            {
                PSendSysMessage("Bot already exists in world.");
                SetSentErrorMessage(true);
                return false;
            }
            CharacterDatabase.DirectPExecute("UPDATE characters SET online = 1 WHERE guid = '%u'", GUID_LOPART(guid));
            mgr->AddPlayerBot(guid);
            PSendSysMessage("Bot added successfully.");
        }
        else if (cmdStr == "remove" || cmdStr == "logout")
        {
            if (!mgr->GetPlayerBot(guid))
            {
                PSendSysMessage("|cffff0000Bot can not be removed because bot does not exist in world.");
                SetSentErrorMessage(true);
                return false;
            }
            CharacterDatabase.DirectPExecute("UPDATE characters SET online = 0 WHERE guid = '%u'", GUID_LOPART(guid));
            mgr->LogoutPlayerBot(guid);
            PSendSysMessage("Bot removed successfully.");
        }
        else if (cmdStr == "co" || cmdStr == "combatorder")
        {
            Unit *target = NULL;
            char *orderChar = strtok(NULL, " ");
            if (!orderChar)
            {
                PSendSysMessage("|cffff0000Syntax error:|cffffffff .bot co <botName> <order=reset|tank|assist|heal|protect> [targetPlayer]");
                SetSentErrorMessage(true);
                return false;
            }
            std::string orderStr = orderChar;
            if (orderStr == "protect" || orderStr == "assist")
            {
                char *targetChar = strtok(NULL, " ");
                uint64 targetGUID = m_session->GetPlayer()->GetSelection();
                if (!targetChar && !targetGUID)
                {
                    PSendSysMessage("|cffff0000Combat orders protect and assist expect a target either by selection or by giving target player in command string!");
                    SetSentErrorMessage(true);
                    return false;
                }
                if (targetChar)
                {
                    std::string targetStr = targetChar;
                    uint64 targ_guid = sObjectMgr->GetPlayerGUIDByName(targetStr.c_str());

                    targetGUID = targ_guid;
                }
                target = ObjectAccessor::GetUnit(*m_session->GetPlayer(), targetGUID);
                if (!target)
                {
                    PSendSysMessage("|cffff0000Invalid target for combat order protect or assist!");
                    SetSentErrorMessage(true);
                    return false;
                }
            }
            if (mgr->GetPlayerBot(guid) == NULL)
            {
                PSendSysMessage("|cffff0000Bot can not receive combat order because bot does not exist in world.");
                SetSentErrorMessage(true);
                return false;
            }
            QueryResult resultlvl = CharacterDatabase.PQuery("SELECT guid FROM playerbot_saved_data WHERE guid = '%u'", guid);
            if (resultlvl)
                CharacterDatabase.DirectPExecute("INSERT INTO playerbot_saved_data (guid,bot_primary_order,bot_secondary_order,primary_target,secondary_target,pname,sname) VALUES ('%u',0,0,0,0,'','')", guid);
            mgr->GetPlayerBot(guid)->GetPlayerbotAI()->SetCombatOrderByStr(orderStr, target);
        }
        return true;
}