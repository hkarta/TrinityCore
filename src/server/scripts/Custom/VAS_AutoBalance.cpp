/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 1985-2010 {VAS} KalCorp  <http://vasserver.dyndns.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: VAS.AutoBalance
SD%Complete: 50
SDComment:By KalCorp and Vaughner
SDCategory: Script VAS
EndScriptData */


#include "ScriptPCH.h"
#include "Configuration/Config.h"
#include "MapManager.h"
#include "Map.h"


 float VAS_version = 1.04f;
 int VAS_Sub_version = 10;
 int Creature_Update_Timer = 60;
 int AutoInstance = 1;
 int PlayerChangeNotify = 1;
 int VasDebug = 1;
 int DebugByID = 0;
 float Config_xPlayer = 1.0f;
 float Min_D_Mod = 0.10f;
 float Min_HP_Mod = 0.20f;
 float VAS_Group_Modifer = 1.0f;
 float VAS_Damage_Modifer = 1.0f;
 float VAS_Script_Hook_VersionNeeded = 1.01f;
 float VAS_Hook_Version_Installed = 0.0f;
 bool VAS_Hook_Check = false;
 std::string VAS_AutoBalance_Color = "cffFF8000";

 struct sVASCreatureInfo
	{
		uint32 CoolDown;
		int LastPlayerCount;
		float damagemod;
	};
 static std::map<uint32, sVASCreatureInfo> VASCreatureInfo;

inline const char * const BoolToString(bool b)
{
	return b ? "true" : "false";
}

bool VAS_AutoBalance_CheckID(std::string VASCheckNameString,int VASCheckID)
	{
            std::string map_str;
            std::stringstream map_ss;
			map_ss.str(VASCheckNameString);
            while (std::getline(map_ss, map_str, ','))
            {
                std::stringstream ss2(map_str);
                int map_num = -1;
                ss2 >> map_num;
                if (map_num >= 0)
                {
					if (map_num == VASCheckID)
					return true;
                }
            }
		return false;
	}

bool VAS_AutoBalance_CheckINIMaps(std::string pMapIdString,int VASmapid)
	{
        std::string map_str;
        std::stringstream map_ss;
		map_ss.str(pMapIdString);
        while (std::getline(map_ss, map_str, ','))
        {
            std::stringstream ss2(map_str);
            int map_num = -1;
            ss2 >> map_num;
            if (map_num >= 0)
            {
				if (map_num == VASmapid)
					return true;
            }
        }
		return false;
	}

class VAS_AutoBalance_WorldScript : public WorldScript
{
    public:
        VAS_AutoBalance_WorldScript()
            : WorldScript("VAS_AutoBalance_WorldScript")
        {
        }
	
	void OnConfigLoad(bool /*reload*/)
	{
		if (Config_xPlayer <= 0)
			return;
		
		if (VasDebug >= 3)
			sLog.outString("### VAS_AutoBalance_WorldScript - OnConfigLoad"); 
	}

	void OnStartup()
	{
		if (Config_xPlayer <= 0)
			return;

		if (VasDebug >= 3)
			sLog.outString("### VAS_AutoBalance_WorldScript - OnStartup" ); 
	}

	void SetInitialWorldSettings()
	{	

		// Added so you can not compile without needed VAS_Script_Hooks!
		VAS_Hook_Version_Installed = sScriptMgr.VAS_Script_Hooks();

		sLog.outString("----------------------------------------------------");
		sLog.outString("  Powered by {VAS} AutoBalance v%4.2f.%u ",VAS_version,VAS_Sub_version); 
		sLog.outString("----------------------------------------------------");

		VasDebug = sConfig.GetIntDefault("VAS.AutoBalance.Debug",1);
		DebugByID = sConfig.GetIntDefault("VAS.AutoBalance.DebugByID",0);
		Creature_Update_Timer = sConfig.GetFloatDefault("VAS.AutoBalance.Creature.Update.Timer",60);
		AutoInstance = sConfig.GetIntDefault("VAS.AutoBalance.AutoInstance",1);
		PlayerChangeNotify = sConfig.GetIntDefault("VAS.AutoBalance.PlayerChangeNotify",1);
		Config_xPlayer = sConfig.GetFloatDefault("VAS.AutoBalance.XPlayer",1.0f);
		Min_D_Mod = sConfig.GetFloatDefault("Min.D.Mod",0.10f);
		Min_HP_Mod = sConfig.GetFloatDefault("Min.HP.Mod",0.20f);
		VAS_Group_Modifer = sConfig.GetFloatDefault("VAS.Group.Modifer",1.0f);
		VAS_Damage_Modifer = sConfig.GetFloatDefault("VAS.Damage.Modifer",1.0f);

		if (VAS_Hook_Version_Installed >= VAS_Script_Hook_VersionNeeded)
		{
			sLog.outString("  VAS_Script_Hooks v%4.2f Found",VAS_Hook_Version_Installed);
		}
		else
		{
			sLog.outString("  VAS_Script_Hooks v%4.2f Found",VAS_Hook_Version_Installed);
			sLog.outString("  This Mod needs %4.2f+ to run correctly!",VAS_Script_Hook_VersionNeeded);
			Config_xPlayer = 0;
		}

		if (Config_xPlayer >= 1)
		{
			sLog.outString("  xPlayer = %4.1f ", Config_xPlayer);
			sLog.outString("  AutoInstance = %u ", AutoInstance);
			sLog.outString("  PlayerChangeNotify = %u ", PlayerChangeNotify);

			sLog.outString("  Min.D.Mod = %4.2f ", Min_D_Mod);
			sLog.outString("  Min.HP.Mod = %4.2f ", Min_HP_Mod);
			sLog.outString("  VAS.Group.Modifer = %4.2f ", VAS_Group_Modifer);
			sLog.outString("  VAS.Damage.Modifer = %4.2f ", VAS_Damage_Modifer);

			sLog.outString("  VasDebug   =  %u ", VasDebug);

			// VasDebug From 0 to 4
			if (VasDebug <= 0)
			{	
				VasDebug = 0;
				sLog.outString("  VasDebug reset back to 0.  Set from 0 to 4");
			}

			if (VasDebug >= 5)
			{	
				VasDebug = 4;
				sLog.outString("  VasDebug reset back to 3.  Set from 0 to 4");
			}

			sLog.outString("  DebugByID   =  %u", DebugByID);
			sLog.outString("  Creature_Update_Timer   =  %u", Creature_Update_Timer);
			
			// Do not let Creature_Update_Timer go below 5 sec's
			if (Creature_Update_Timer <= 4)
			{	
				Creature_Update_Timer = 5;
				sLog.outString("  Creature_Update_Timer reset back to 5.  Should be lower that that!");
			}

			VAS_AutoBalance_Color = sConfig.GetStringDefault("VAS.AutoBalance.Color", "cffFF8000");
			sLog.outString("  VAS.AutoBalance.Color = %s", VAS_AutoBalance_Color.c_str());

		}
		else
			sLog.outString("  VAS Auto-Balance is Disabled  - xPlayer is set to 0 \n");

		sLog.outString("----------------------------------------------------\n");
	}

};

class VAS_AutoBalance_PlayerScript : public PlayerScript
{
    public:
        VAS_AutoBalance_PlayerScript()
            : PlayerScript("VAS_AutoBalance_PlayerScript")
        {
        }
	
	void OnLogin(Player *Player)
	{

		if (Config_xPlayer <= 0)
			return;

		if (VasDebug >= 3)
			sLog.outString("### VAS_AutoBalance_PlayerScript - OnLogin Player=%s", Player->GetName()); 

		ChatHandler chH = ChatHandler(Player);
		if (Config_xPlayer >= 1)
		{
			chH.PSendSysMessage("\n|%s----------------------------------------------------|r",VAS_AutoBalance_Color.c_str());
			chH.PSendSysMessage("|%s  Powered by {VAS}AutoBalance v%4.2f.%u |r ",VAS_AutoBalance_Color.c_str(),VAS_version,VAS_Sub_version);
		if (AutoInstance >= 1)
			chH.PSendSysMessage("|%s  Auto Instance is Active |r",VAS_AutoBalance_Color.c_str());
		else
			chH.PSendSysMessage("|%s  Set for %4.1f Players|r ",VAS_AutoBalance_Color.c_str(),Config_xPlayer);
		chH.PSendSysMessage("|%s----------------------------------------------------|r \n",VAS_AutoBalance_Color.c_str());
		}
	}
};

class VAS_AutoBalance_UnitScript : public UnitScript
{
    public:
        VAS_AutoBalance_UnitScript()
            : UnitScript("VAS_AutoBalance_UnitScript")
        {
        }
	
	uint32 DealDamage(Unit* AttackerUnit, Unit *pVictim,uint32 damage,DamageEffectType damagetype)
	{
		if (Config_xPlayer <= 0)
			return damage;


		if (AttackerUnit->GetMap()->IsDungeon() && pVictim->GetMap()->IsDungeon())
			if (AttackerUnit->GetTypeId() != TYPEID_PLAYER) 
			{
				if (VasDebug >= 3)
					sLog.outString("### VAS_AutoBalance_UnitScript - VAS_Unit_DealDamage Attacker=%s Victim=%s Start Damage=%u",AttackerUnit->GetName(),pVictim->GetName(),damage);
				damage = VAS_Modifer_DealDamage(AttackerUnit,damage);
				if (VasDebug >= 3)
					sLog.outString("### VAS_AutoBalance_UnitScript - VAS_Unit_DealDamage Attacker=%s Victim=%s End Damage=%u",AttackerUnit->GetName(),pVictim->GetName(),damage);
			}
			return damage;
	}

	void CalculateSpellDamageTaken(SpellNonMeleeDamage *damageInfo, int32 damage, SpellEntry const *spellInfo, WeaponAttackType attackType, bool crit)
	{
		if (Config_xPlayer <= 0)
			return;
		
		if (damageInfo->attacker->GetMap()->IsDungeon() && damageInfo->target->GetMap()->IsDungeon() || damageInfo->attacker->GetMap()->IsBattleground() && damageInfo->target->GetMap()->IsBattleground())
			if (damageInfo->attacker->GetTypeId() != TYPEID_PLAYER) 
			{
				if (VasDebug >= 3)
					sLog.outString("### VAS_AutoBalance_UnitScript - CalculateSpellDamageTaken Attacker=%s Victim=%s Start Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);

				if (damageInfo->attacker->isHunterPet() || damageInfo->attacker->isPet() || damageInfo->attacker->isSummon() || damageInfo->attacker->IsControlledByPlayer())
					return;

				float damagemod = VASCreatureInfo[damageInfo->attacker->GetGUID()].damagemod; 
				if (damagemod <= 0)
					damagemod =1.0f;
				
				damageInfo->damage *= damagemod;

				if (VasDebug >= 3)
					sLog.outString("### VAS_AutoBalance_UnitScript - CalculateSpellDamageTaken Attacker=%s Victim=%s End Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);
			}
			return;
	}

	void CalculateMeleeDamage(Unit *pVictim, uint32 damage, CalcDamageInfo *damageInfo, WeaponAttackType attackType)
	{
		if (Config_xPlayer <= 0)
			return;

		if (damageInfo->attacker->GetMap()->IsDungeon() && damageInfo->target->GetMap()->IsDungeon() || damageInfo->attacker->GetMap()->IsBattleground() && damageInfo->target->GetMap()->IsBattleground())
			if (damageInfo->attacker->GetTypeId() != TYPEID_PLAYER) 
			{
				if (VasDebug >= 3)
					sLog.outString("### VAS_AutoBalance_UnitScript - CalculateMeleeDamage Attacker=%s Victim=%s Start Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);

				if (damageInfo->attacker->isHunterPet() || damageInfo->attacker->isPet() || damageInfo->attacker->isSummon() || damageInfo->attacker->IsControlledByPlayer())
					return;

				float damagemod = VASCreatureInfo[damageInfo->attacker->GetGUID()].damagemod; 
				if (damagemod <= 0)
					damagemod =1.0f;
				
				damageInfo->damage *= damagemod;

				if (VasDebug >= 3)
					sLog.outString("### VAS_AutoBalance_UnitScript - CalculateMeleeDamage Attacker=%s Victim=%s End Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);
			}
			return;
	}

	uint32 VAS_Modifer_DealDamage(Unit* AttackerUnit,uint32 damage)
	{

	if (AttackerUnit->isHunterPet() || AttackerUnit->isPet() || AttackerUnit->isSummon() || AttackerUnit->IsControlledByPlayer())
		return damage;

	float damagemod = VASCreatureInfo[AttackerUnit->GetGUID()].damagemod; 

	if (damagemod <= 0)
		damagemod =1.0f;

	return damage*damagemod;

	}

};


class VAS_AutoBalance_AllMapScript : public AllMapScript
{
    public:
        VAS_AutoBalance_AllMapScript()
            : AllMapScript("VAS_AutoBalance_AllMapScript")
        {
        }

	void OnPlayerEnterAll(Map* map, Player* player)
	{
		if (Config_xPlayer <= 0)
			return;

		int VasMapID = player->GetMapId();
		int VAS_PlayersInMap = map->GetPlayersCountExceptGMs();
		Difficulty VAS_MAPDifficulty = player->GetDifficulty(map);
		ChatHandler chH = ChatHandler(player);
		
		bool IsHeroic = player->GetMap()->IsHeroic();
		bool IsRaid = player->GetMap()->IsRaid();
		bool IsRegularDifficulty = player->GetMap()->IsRegularDifficulty();
		bool IsRaidOrHeroicDungeon = player->GetMap()->IsRaidOrHeroicDungeon();
		bool IsNonRaidDungeon = player->GetMap()->IsNonRaidDungeon();

		std::string sMapDifficulty="N/A";

		if (!player->GetMap()->IsDungeon())
        switch(player->GetDifficulty(player->GetMap()->IsHeroic()))
        {
		case REGULAR_DIFFICULTY:
            sMapDifficulty="REGULAR_DIFFICULTY";
			break;
		sMapDifficulty="N/A";
		}

		if (player->GetMap()->IsDungeon())
        switch(player->GetDungeonDifficulty())
        {
		case DUNGEON_DIFFICULTY_NORMAL:
            sMapDifficulty="DUNGEON_DIFFICULTY_NORMAL";
			break;
		case DUNGEON_DIFFICULTY_HEROIC:
            sMapDifficulty="DUNGEON_DIFFICULTY_HEROIC";
			break;
		case DUNGEON_DIFFICULTY_EPIC:
            sMapDifficulty="DUNGEON_DIFFICULTY_EPIC";
			break;
		sMapDifficulty="N/A";
		}

		if (player->GetMap()->IsRaid())
        switch(player->GetRaidDifficulty())
        {
        case RAID_DIFFICULTY_10MAN_NORMAL:
            sMapDifficulty="RAID_DIFFICULTY_10MAN_NORMAL";
			break;
        case RAID_DIFFICULTY_25MAN_NORMAL:
            sMapDifficulty="RAID_DIFFICULTY_25MAN_NORMAL";
			break;
        case RAID_DIFFICULTY_10MAN_HEROIC:
            sMapDifficulty="RAID_DIFFICULTY_10MAN_HEROIC";
			break;
        case RAID_DIFFICULTY_25MAN_HEROIC:
            sMapDifficulty="RAID_DIFFICULTY_25MAN_HEROIC";
			break;
		sMapDifficulty="N/A";
		}

		uint32 maxPlayers = ((InstanceMap*)sMapMgr.FindMap(player->GetMapId(), player->GetInstanceId()))->GetMaxPlayers();

		if (VasDebug >= 2)
		{
			sLog.outString("----------------------------------------------------");
			sLog.outString("## VAS_AutoBalance_AllMapScript - OnPlayerEnterAll");  
			sLog.outString("## For InsatanceID %u",map->GetInstanceId()); 
			sLog.outString("## IsDungeon= %u",map->GetEntry()->IsDungeon()); 
			sLog.outString("## For Map %u",VasMapID); 
			sLog.outString("## PlayersInMap %u",VAS_PlayersInMap);
			sLog.outString("## MapDifficulty %s",sMapDifficulty.c_str());
			sLog.outString("## pDifficulty %u",uint32(player->GetDifficulty(player->GetMap()->IsHeroic())));
			sLog.outString("## pGetDungeonDifficulty %u",uint32(player->GetDungeonDifficulty()));
			sLog.outString("## pGetRaidDifficulty %u",uint32(player->GetRaidDifficulty()));
			sLog.outString("## maxPlayers %u",maxPlayers);
			sLog.outString("## IsHeroic=%s IsRaid=%s IsRegularDifficulty=%s IsRaidOrHeroicDungeon=%s IsNonRaidDungeon=%s",BoolToString(IsHeroic),BoolToString(IsRaid),BoolToString(IsRegularDifficulty),BoolToString(IsRaidOrHeroicDungeon),BoolToString(IsNonRaidDungeon));
			sLog.outString("----------------------------------------------------\n");
		}

		if (PlayerChangeNotify >= 1)
			if ((map->GetEntry()->IsDungeon()) && !player->isGameMaster() )
			{
				Map::PlayerList const &PlayerList = map->GetPlayers();
				if (!PlayerList.isEmpty())
					for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
						if (Player* pPlr = itr->getSource())
						{ 
							ChatHandler chH = ChatHandler(pPlr);
							chH.PSendSysMessage("|cffFF0000 [VAS-AutoBalance]|r|%s %s entered the Instance %s.|r \n|%s                                   Auto setting player count to %u |r",VAS_AutoBalance_Color.c_str(),player->GetName(),map->GetMapName(),VAS_AutoBalance_Color.c_str(),VAS_PlayersInMap);
						}
			}

	}

	void OnPlayerLeaveAll(Map* map, Player* player)
	{ 
		if (Config_xPlayer <= 0)
			return;

		if (VasDebug >= 3)
			sLog.outString("#### VAS_AutoBalance_AllMapScript - OnPlayerLeaveAll map=%s player=%S", map->GetMapName(),player->GetName()); 

		int VasMapID = player->GetMapId();
		int VAS_PlayersInMap = map->GetPlayersCountExceptGMs();
		Difficulty VAS_MAPDifficulty = player->GetDifficulty(map);
	
		if (VAS_PlayersInMap >= 1)
			VAS_PlayersInMap -= 1;
		
		if (VAS_PlayersInMap >=1)
		{
			ChatHandler chH = ChatHandler(player);

			if (VasDebug >= 2)
			{
				sLog.outString("----------------------------------------------------");
				sLog.outString("## VAS_AutoBalance_AllMapScript - OnPlayerLeaveAll");  
				sLog.outString("## For InsatanceID %u",map->GetInstanceId()); 
				sLog.outString("## IsDungeon= %u",map->GetEntry()->IsDungeon()); 
				sLog.outString("## For Map %u",VasMapID); 
				sLog.outString("## PlayersInMap %u",VAS_PlayersInMap);
				sLog.outString("----------------------------------------------------\n");
			}
	
			if (PlayerChangeNotify >= 1)
				if ((map->GetEntry()->IsDungeon()) && !player->isGameMaster() )
				{
					Map::PlayerList const &PlayerList = map->GetPlayers();
					if (!PlayerList.isEmpty())
						for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
							if (Player* pPlr = itr->getSource())
							{ 
								ChatHandler chH = ChatHandler(pPlr);
								chH.PSendSysMessage("|cffFF0000 [VAS-AutoBalance]|r|%s %s left the Instance %s.|r \n|%s                                   Auto setting player count to %u |r",VAS_AutoBalance_Color.c_str(),player->GetName(),map->GetMapName(),VAS_AutoBalance_Color.c_str(),VAS_PlayersInMap);
							}
				}
		}	
	}
};

class VAS_AutoBalance_WorldMapScript : public WorldMapScript
{
    public:
        VAS_AutoBalance_WorldMapScript()
            : WorldMapScript("VAS_AutoBalance_WorldMapScript",0)
        {
        }

	void OnPlayerEnter(Map* map, Player* player)
	{
		if (Config_xPlayer <= 0)
			return;

		if (VasDebug >= 3)
			sLog.outString("### VAS_AutoBalance_WorldMapScript - OnPlayerEnter Map=%s player=%s",map->GetMapName(),player->GetName()); 
	}

	void OnPlayerLeave(Map* map, Player* player)
	{
		if (Config_xPlayer <= 0)
			return;

		if (VasDebug >= 3)
			sLog.outString("### VAS_AutoBalance_WorldMapScript - OnPlayerLeave Map=%s player=%s",map->GetMapName(),player->GetName()); 
	}
};


class VAS_AutoBalance_AllCreatureScript : public AllCreatureScript
{
    public:
        VAS_AutoBalance_AllCreatureScript()
            : AllCreatureScript("VAS_AutoBalance_AllCreatureScript")
        {
        }


	void Creature_SelectLevel(const CreatureInfo *cinfo, Creature* creature)
	{
		if (Config_xPlayer <= 0)
			return;

		if (creature->GetMap()->IsDungeon()) 
		{
			VAS_Modifer_Health_Mana(creature);
			if (VasDebug >= 4)
				sLog.outString("### VAS_AutoBalance_VASScript - VAS_Creature_SelectLevel InstanceID=%u   Creature=%s",creature->GetInstanceId(),cinfo->Name);
		}
	}

	void OnAllCreatureUpdate(Creature* creature, uint32 diff)
	{
		if (Config_xPlayer <= 0)
			return;

		if (VASCreatureInfo[creature->GetGUID()].CoolDown <= diff)
			{
				VASCreatureInfo[creature->GetGUID()].CoolDown = 0;
				if (creature->GetMap()->IsDungeon() || creature->GetMap()->IsBattleground())
					VAS_Modifer_Health_Mana(creature);
				VASCreatureInfo[creature->GetGUID()].CoolDown = Creature_Update_Timer * IN_MILLISECONDS;
			 }
			else
				VASCreatureInfo[creature->GetGUID()].CoolDown -= diff;
	}

	void VAS_Modifer_Health_Mana(Creature* creature)
	{
   
	Player* cplayer ;

	float Xplayer = Config_xPlayer;
	if (Xplayer <= 0)
		return;

	if (creature->isHunterPet() || creature->isPet() || creature->isSummon() || creature->IsControlledByPlayer())
		return;

	uint32 PlayersInCreaturesInstance = 0;
	Map::PlayerList const &PlayerList = creature->GetMap()->GetPlayers();
	if (!PlayerList.isEmpty())
		for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
			if (Player* pPlr = itr->getSource())
				if ((pPlr->GetInstanceId() == creature->GetInstanceId()) && !pPlr->isGameMaster())
				{
					PlayersInCreaturesInstance += 1;
					cplayer = pPlr;
				}

	if (AutoInstance >= 1)
	{
		Xplayer = PlayersInCreaturesInstance;
		VASCreatureInfo[creature->GetGUID()].LastPlayerCount = Xplayer;
		if (Xplayer <= 0)
			return;
	}

	CreatureInfo const *cinfo = creature->GetCreatureInfo();
	int VASEntry = cinfo->Entry;

	uint8 level = creature->getLevel();
    CreatureBaseStats const* stats = sObjectMgr.GetCreatureBaseStats(level, cinfo->unit_class);
	
	float healthmod = 1.0f;
    uint32 basehp = stats->GenerateHealth(cinfo);
    uint32 VASbasehp = (basehp * healthmod);
	
	float VAShealthmod = healthmod;
	float VAS_Modifer = 1.0;
	float VAS_Modifer2 = 1.0;
	int VasMapID = creature->GetMapId();
	bool VAS_Changed = false;
	Min_D_Mod = 0.10f;
	Min_HP_Mod = 0.30f;
	//VAS_Group_Modifer = 1.0f;
	//VAS_Damage_Modifer = 1.0f;
	char *const VASName = cinfo->Name;

		//   VAS SOLO  - By MobID			
		if (VAS_AutoBalance_CheckID(sConfig.GetStringDefault("VAS.AutoBalance.40.Name", ""),VASEntry) && ( (40-Xplayer) > 0 ))			
			{VAS_Modifer =40;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - NPC ID=%u Found in VAS-AutoBalance.40.Name",VasMapID);			
			VAS_Changed = true;}
		if (VAS_AutoBalance_CheckID(sConfig.GetStringDefault("VAS.AutoBalance.25.Name", ""),VASEntry) && ( (25-Xplayer) > 0 ))			
			{VAS_Modifer = 25;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - NPC ID=%u Found in VAS-AutoBalance.25.Name",VasMapID);		
			VAS_Changed = true;}
		if (VAS_AutoBalance_CheckID(sConfig.GetStringDefault("VAS.AutoBalance.20.Name", ""),VASEntry) && ( (20-Xplayer) > 0 ))			
			{VAS_Modifer = 20;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - NPC ID=%u Found in VAS-AutoBalance.20.Name",VasMapID);	
			VAS_Changed = true;}
		if (VAS_AutoBalance_CheckID(sConfig.GetStringDefault("VAS.AutoBalance.10.Name", ""),VASEntry) && ( (10-Xplayer) > 0 ))			
			{VAS_Modifer = 10;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - NPC ID=%u Found in VAS-AutoBalance.10.Name",VasMapID);				
			VAS_Changed = true;}
		if (VAS_AutoBalance_CheckID(sConfig.GetStringDefault("VAS.AutoBalance.5.Name", ""),VASEntry) && ( (5-Xplayer) > 0 ))			
			{VAS_Modifer = 5;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - NPC ID=%u Found in VAS-AutoBalance.5.Name",VasMapID);				
			VAS_Changed = true;}
		if (VAS_AutoBalance_CheckID(sConfig.GetStringDefault("VAS.AutoBalance.2.Name", ""),VASEntry) && ( (2-Xplayer) > 0 ))			
			{VAS_Modifer = 2;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - NPC ID=%u Found in VAS-AutoBalance.2.Name",VasMapID);				
			VAS_Changed = true;}
			
		//   VAS SOLO  - Map 0,1 and 530 ( World Mobs )				
		if ((VasMapID == 0 || VasMapID == 1 || VasMapID == 530 ) && (basehp*healthmod) > 200001)
			{VAS_Modifer = 40;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - Map 0,1,530 and HP > 200000 setting to 40 group");				
			VAS_Changed = true;}		
		if ((VasMapID == 0 || VasMapID == 1 || VasMapID == 530 ) && (basehp*healthmod) > 140001 && (basehp*healthmod) <= 200000)
			{VAS_Modifer = 25;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - Map 0,1,530 and HP > 140001 & < 200000 setting to 25 group");			
			VAS_Changed = true;}					
		if ((VasMapID == 0 || VasMapID == 1 || VasMapID == 530 ) && (basehp*healthmod) > 100001 && (basehp*healthmod) <= 140000)
			{VAS_Modifer = 20;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - Map 0,1,530 and HP > 100001 & < 140000 setting to 20 group");			
			VAS_Changed = true;}			
		if ((VasMapID == 0 || VasMapID == 1 || VasMapID == 530 ) && (basehp*healthmod) > 40001 && (basehp*healthmod) <= 100000)
			{VAS_Modifer = 10;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - Map 0,1,530 and HP > 40001 & < 100000 setting to 10 group");				
			VAS_Changed = true;}
		if ((VasMapID == 0 || VasMapID == 1 || VasMapID == 530 ) && (basehp*healthmod) > 20001 && (basehp*healthmod) <= 40000)
			{VAS_Modifer = 5;
			if ((VasDebug >= 3) && (DebugByID == VASEntry))
				sLog.outString("### VAS-AutoBalance - Map 0,1,530 and HP > 20001 & < 40000 setting to 5 group");				
			VAS_Changed = true;}

	//   VAS SOLO  - Everything else!	
	if (!VAS_Changed)
		{
		if ( ((basehp*healthmod)) >= 20001 && ((basehp*healthmod)) <= 30000 && ( (2-Xplayer) > 0 ))
			VAS_Modifer = 2;
		if ( ((basehp*healthmod)) >= 30001 && ((basehp*healthmod)) <= 40000 && ( (3-Xplayer) > 0 ))
			VAS_Modifer = 3;
		if ( ((basehp*healthmod)) >= 40001 && ((basehp*healthmod)) <= 50000 && ( (4-Xplayer) > 0 ))
			VAS_Modifer = 4;
		if ( ((basehp*healthmod)) >= 50001 && ((basehp*healthmod)) <= 60000 && ( (5-Xplayer) > 0 ))
			VAS_Modifer =5;
		if ( ((basehp*healthmod)) >= 60001 && ((basehp*healthmod)) <= 70000 && ( (6-Xplayer) > 0 ))
			VAS_Modifer = 6;		
		if ( ((basehp*healthmod)) >= 70001 && ((basehp*healthmod)) <= 80000 && ( (7-Xplayer) > 0 ))
			VAS_Modifer = 7;	
		if ( ((basehp*healthmod)) >= 80001 && ((basehp*healthmod)) <= 90000 && ( (8-Xplayer) > 0 )) 
			VAS_Modifer = 8;
		if ( ((basehp*healthmod)) >= 90001 && ((basehp*healthmod)) <= 100000 && ( (9-Xplayer) > 0 )) 
			VAS_Modifer = 9;			
		if ( ((basehp*healthmod)) >= 100001 && ( (10-Xplayer) > 0 ) )
			VAS_Modifer = 10;

		if ((VasDebug >= 3) && (DebugByID == VASEntry))
			sLog.outString("### VAS-AutoBalance - Not Found in Maps or by ID setting Modifer to %f by Base HP",VAS_Modifer);	
		}

		bool IsDungeon = creature->GetMap()->IsDungeon();
		bool IsHeroic = creature->GetMap()->IsHeroic();
		bool IsRaid = creature->GetMap()->IsRaid();
		bool IsRegularDifficulty = creature->GetMap()->IsRegularDifficulty();
		bool IsRaidOrHeroicDungeon = creature->GetMap()->IsRaidOrHeroicDungeon();
		bool IsNonRaidDungeon = creature->GetMap()->IsNonRaidDungeon();

		std::string sMapDifficulty="N/A";

		uint32 MaxPlayers = 5;

		if (IsDungeon)
		{
			VAS_Modifer = ((InstanceMap*)sMapMgr.FindMap(creature->GetMapId(), creature->GetInstanceId()))->GetMaxPlayers();
			MaxPlayers = VAS_Modifer;

			switch(cplayer->GetDungeonDifficulty())
			{
			case DUNGEON_DIFFICULTY_NORMAL:
			 sMapDifficulty="DUNGEON_DIFFICULTY_NORMAL";
				Min_HP_Mod *= 0.75;
				Min_D_Mod *= 0.75;
				break;
			case DUNGEON_DIFFICULTY_HEROIC:
				sMapDifficulty="DUNGEON_DIFFICULTY_HEROIC";
				break;
			case DUNGEON_DIFFICULTY_EPIC:
				sMapDifficulty="DUNGEON_DIFFICULTY_EPIC";
				break;
			}

			if (IsRaid)
			switch(cplayer->GetRaidDifficulty())
			{
			case RAID_DIFFICULTY_10MAN_NORMAL:
				sMapDifficulty="RAID_DIFFICULTY_10MAN_NORMAL";
				Min_HP_Mod *= 0.75;
				Min_D_Mod *= 0.75;
				break;
			case RAID_DIFFICULTY_25MAN_NORMAL:
				sMapDifficulty="RAID_DIFFICULTY_25MAN_NORMAL";
				Min_HP_Mod *= 0.75;
				Min_D_Mod *= 0.75;
				break;
			case RAID_DIFFICULTY_10MAN_HEROIC:
				sMapDifficulty="RAID_DIFFICULTY_10MAN_HEROIC";
				break;
			case RAID_DIFFICULTY_25MAN_HEROIC:
				sMapDifficulty="RAID_DIFFICULTY_25MAN_HEROIC";
				break;
			}

		}
		else
			switch(cplayer->GetDifficulty(creature->GetMap()->IsHeroic()))
			{
			case REGULAR_DIFFICULTY:
				sMapDifficulty="REGULAR_DIFFICULTY";
				break;
			}

		VAS_Modifer2 = VAS_Modifer;
		VAS_Modifer *= VAS_Group_Modifer;
			
		if 	(VAS_Modifer <= 0)
			VAS_Modifer = 1;
		
		healthmod = ((1/VAS_Modifer) * Xplayer);	

		// Can not be lower then Min_D_Mod 
		if ( healthmod <= Min_HP_Mod ) 
			healthmod = Min_HP_Mod;

		//  Allow more then normal ? 
		if (healthmod >= 1.0 )
			healthmod =1.0f;	

	uint32 health = uint32(basehp * healthmod);

		if (health <= 0)
		{
		if ((VasDebug >= 1) )
			sLog.outString("# ERROR VAS-AutoBalance - Mob=%s Health %u <=0 setting to 1",health,VASName);
				health =1;	
		}
	
		if ((VasDebug >= 2) && (DebugByID == VASEntry))
			if ( VASbasehp != health)
				{
					sLog.outString("## VAS-AutoBalance MobID=%u VasMapID=%u VASName=%s  GUID=%u  PlayersInCreaturesInstance=%u",VASEntry,VasMapID, VASName,creature->GetGUID(),PlayersInCreaturesInstance);
					sLog.outString("## VAS-AutoBalance sMapDifficulty=%s Health=%u / %u Xplayer=%4.2f   healthmod=%4.2f / %4.2f  VAS_Modifer=%4.2f  VAS_Group_Modifer=%4.2f",sMapDifficulty.c_str(),VASbasehp,health,Xplayer,VAShealthmod,healthmod,VAS_Modifer,VAS_Group_Modifer);
					sLog.outString("## VAS-AutoBalance maxPlayers=%u IsHeroic=%s IsRaid=%s IsRegularDifficulty=%s IsRaidOrHeroicDungeon=%s IsNonRaidDungeon=%s",MaxPlayers,BoolToString(IsHeroic),BoolToString(IsRaid),BoolToString(IsRegularDifficulty),BoolToString(IsRaidOrHeroicDungeon),BoolToString(IsNonRaidDungeon));
				}
	
    creature->SetCreateHealth(health);
    creature->SetMaxHealth(health);
    if (health > VASbasehp)
		creature->SetHealth(health);
    creature->ResetPlayerDamageReq();

    uint32 mana = stats->GenerateMana(cinfo);
	uint32 vasmana = mana;
	
	if (Xplayer >= 1)
		{
		mana = ((mana/VAS_Modifer) * Xplayer);	
		if ((VasDebug >= 2) && (DebugByID == VASEntry))
			if ( VASbasehp != health)
				sLog.outString("## VAS-AutoBalance mana %u / %u",vasmana,mana);
		}
		
    creature->SetCreateMana(mana);
    creature->SetMaxPower(POWER_MANA, mana);
    creature->SetPower(POWER_MANA, mana);
    creature->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)health);
    creature->SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)mana);

	VAS_Modifer2 *= VAS_Damage_Modifer;
	float damagemod =  ((1/VAS_Modifer2) * Xplayer);

	// Can not be less then Min_D_Mod 
	if ( damagemod <= Min_D_Mod ) 
		damagemod = Min_D_Mod;

	//  Allow more then normal ? 
	if (damagemod >= 1.0 )
		damagemod =1.0f;

	VASCreatureInfo[creature->GetGUID()].damagemod = damagemod;
	}
};

void AddSC_VAS_AutoBalance()
{
	new VAS_AutoBalance_WorldScript;
	new VAS_AutoBalance_PlayerScript;
	new VAS_AutoBalance_UnitScript;
//	new VAS_AutoBalance_CreatureScript;
	new VAS_AutoBalance_AllCreatureScript;
	new VAS_AutoBalance_AllMapScript;
	new VAS_AutoBalance_WorldMapScript;
//	new VAS_AutoBalance_InstanceMapScript;
//	new VAS_AutoBalance_BattlegroundMapScript;
}