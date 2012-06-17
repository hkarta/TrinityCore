-- Forsaken Plaguebringer SAI
SET @ENTRY  := 23760;
SET @SPELL1 := 44005; -- Shoot Plague
SET @SPELL2 := 3436;  -- Wandering Plague
SET @SPELL3 := 11978; -- Kick
SET @SPELL4 := 43333; -- Shoot Plague
UPDATE `creature_template` SET `equipment_id`=509,`AIName`= 'SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`) VALUES (@ENTRY,2);
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,4000,11000,7000,11000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0,'Forsaken Plaguebringer - Combat - Cast Shoot Plague'),
(@ENTRY,0,1,0,0,0,100,0,4000,10000,40000,50000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0,'Forsaken Plaguebringer - Combat - Cast Wandering Plague'),
(@ENTRY,0,2,0,0,0,80,0,4000,12000,12000,18000,11,@SPELL3,0,0,0,0,0,2,0,0,0,0,0,0,0,'Forsaken Plaguebringer - Combat - Cast Kick'),
(@ENTRY,0,3,0,10,0,100,0,24042,40,6000,11000,11,@SPELL4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Forsaken Plaguebringer - OOC - Cast Shoot Plague'); -- Not working correctly
-- Spell Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (43333);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,43333,0,31,3,24042,0,0,'','Spell 43333 can target Generic Trigger LAB - OLD');
-- SAI for Charles Worth
SET @NPC    := 28699;
SET @GOSSIP := 10118;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@NPC;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@NPC;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@NPC,0,0,2,62,0,100,0,@GOSSIP,3,0,0,85,59817,2,0,0,0,0,7,0,0,0,0,0,0,0, 'Charles Worth - On Gossip Select - Cast Spell Teach Wispcloak'),
(@NPC,0,1,2,62,0,100,0,@GOSSIP,5,0,0,85,59841,2,0,0,0,0,7,0,0,0,0,0,0,0, 'Charles Worth - On Gossip Select - Cast Spell Teach Deathchill Cloak'),
(@NPC,0,2,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Charles Worth - On Gossip Select - Close Gossip');
-- Add missing Gossip for Charles Worth
DELETE FROM `gossip_menu` WHERE `entry` IN (10136,10138);
DELETE FROM `gossip_menu` WHERE `entry`=14076 AND `text_id`=14076;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (10136,14072),(10138,14074),(10118,14076);
-- Add Gossip Options
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP AND `id` IN (2,3,4,5);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES 
(@GOSSIP,2,0, 'Tell me about the Wispcloak Recipe.',1,1,10136,0,0,0, ''),
(@GOSSIP,3,0, 'I am ready to learn the Wispcloak Recipe.',1,1,0,0,0,0, ''),
(@GOSSIP,4,0, 'Tell me about the Deathchill Cloak Recipe.',1,1,10138,0,0,0, ''),
(@GOSSIP,5,0, 'I am ready to learn the Deathchill Cloak Recipe.',1,1,0,0,0,0, '');
-- Add conditions for gossip text
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,14076,0,7,197,420,0,0,0,'','Only show gossip text 14076 if player has Tailoring with skill level 420');
-- Add conditions for gossip options
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,2,0,7,197,420,0,0,0,'','Only show gossip option if player has Tailoring with skill level 420'),
(15,@GOSSIP,2,0,25,56016,0,0,1,0,'','Only show gossip option if player has not learned spell 56016'),
(15,@GOSSIP,3,0,7,197,420,0,0,0,'','Only show gossip option if player has Tailoring with skill level 420 Alliance'),
(15,@GOSSIP,3,0,17,41,0,0,0,0,'','Only show gossip option if player has achievement Loremaster of Northrend Alliance'),
(15,@GOSSIP,3,1,7,197,420,0,0,0,'','Only show gossip option if player has Tailoring with skill level 420 Horde'),
(15,@GOSSIP,3,1,17,1360,0,0,0,0,'','Only show gossip option if player has achievement Loremaster of Northrend Horde'),
(15,@GOSSIP,3,0,25,56016,0,0,1,0,'','Only show gossip option if player has not learned spell 56016'),
(15,@GOSSIP,4,0,7,197,420,0,0,0,'','Only show gossip option if player has Tailoring with skill level 420'),
(15,@GOSSIP,4,0,25,56017,0,0,1,0,'','Only show gossip option if player has not learned spell 56017'),
(15,@GOSSIP,5,0,7,197,420,0,0,0,'','Only show gossip option if player has Tailoring with skill level 420'),
(15,@GOSSIP,5,0,17,1288,0,0,0,0,'','Only show gossip option if player has achievement Northrend Dungeonmaster'),
(15,@GOSSIP,5,0,25,56017,0,0,1,0,'','Only show gossip option if player has not learned spell 56017');
-- Fix Gossip for Leryssa
SET @ENTRY := 9223;
SET @TEXT1 := 12534;
SET @TEXT2 := 13481;
SET @QUEST := 11599;
DELETE FROM `gossip_menu` WHERE `entry`=@ENTRY AND `text_id`=@TEXT1;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@ENTRY,@TEXT1);
-- Add conditions for gossip text
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=@ENTRY AND `SourceEntry`=@TEXT2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@ENTRY,@TEXT2,0,8,@QUEST,0,0,0,0,'','Only show gossip text if player has completed quest 11599');
UPDATE `item_template` SET `flags` = `flags` | 2048 WHERE `entry` IN (50274,50226,50231);
UPDATE `item_template` SET `flags` = 0 WHERE `entry` IN (50274,50226,50231);
-- add missing spell to db
DELETE FROM `spell_dbc` WHERE `Id`=28782;
INSERT INTO `spell_dbc` (`Id`,`SchoolMask`,`Dispel`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`Stances`,`StancesNot`,`Targets`,`CastingTimeIndex`,`AuraInterruptFlags`,`ProcFlags`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`RangeIndex`,`StackAmount`,`EquippedItemClass`,`EquippedItemSubClassMask`,`EquippedItemInventoryTypeMask`,`Effect1`,`Effect2`,`Effect3`,`EffectDieSides1`,`EffectDieSides2`,`EffectDieSides3`,`EffectRealPointsPerLevel1`,`EffectRealPointsPerLevel2`,`EffectRealPointsPerLevel3`,`EffectBasePoints1`,`EffectBasePoints2`,`EffectBasePoints3`,`EffectMechanic1`,`EffectMechanic2`,`EffectMechanic3`,`EffectImplicitTargetA1`,`EffectImplicitTargetA2`,`EffectImplicitTargetA3`,`EffectImplicitTargetB1`,`EffectImplicitTargetB2`,`EffectImplicitTargetB3`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectRadiusIndex3`,`EffectApplyAuraName1`,`EffectApplyAuraName2`,`EffectApplyAuraName3`,`EffectAmplitude1`,`EffectAmplitude2`,`EffectAmplitude3`,`EffectMultipleValue1`,`EffectMultipleValue2`,`EffectMultipleValue3`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectMiscValue3`,`EffectTriggerSpell1`,`EffectTriggerSpell2`,`EffectTriggerSpell3`,`Comment`,`MaxTargetLevel`,`SpellFamilyName`,`SpellFamilyFlags1`,`SpellFamilyFlags2`,`MaxAffectedTargets`,`DmgClass`,`PreventionType`,`DmgMultiplier1`,`DmgMultiplier2`,`AreaGroupId`)VALUES
(28782,0,0,0,256,268435456,0,0,0,0,0,0,0,1,0,0,101,0,0,0,0,21,1,0,-1,0,0,6,6,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,12,40,0,0,0,0,0,0,0,0,127,0,0,0,0, 'Stun Self + Immune',0,0,0,0,0,0,0,1,1,0);

-- Add Stun Self + Immune aura to Snack-O-Matic IV & Vend-O-Tron D-Luxe
DELETE FROM `creature_template_addon` WHERE `entry` IN (24934,24935);
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES (24934, '28782'),(24935, '28782');
-- Remove some bad spawns in world
DELETE FROM `creature` WHERE `guid` IN (45208,45099,45075,45136,12925,12402);
DELETE FROM `creature_addon` WHERE `guid` IN (45208,45099,45075,45136,12925,12402);

-- Some missing Gossip
UPDATE `creature_template` SET `gossip_menu_id`=9054 WHERE `entry`=25021;
UPDATE `creature_template` SET `gossip_menu_id`=9056 WHERE `entry`=25022;
UPDATE `creature_template` SET `gossip_menu_id`=9057 WHERE `entry`=25023;
UPDATE `creature_template` SET `gossip_menu_id`=9054 WHERE `entry`=25024; 
UPDATE `creature_template` SET `gossip_menu_id`=9077 WHERE `entry`=25025;
DELETE FROM `gossip_menu` WHERE `entry`=9054 AND `text_id`=12243;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9054,12243);
DELETE FROM `gossip_menu` WHERE `entry`=9057 AND `text_id`=12245;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9057,12245);
DELETE FROM `gossip_menu` WHERE `entry`=9077 AND `text_id`=12275;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (9077,12275);

-- Zeppelin: <The Thundercaller> "Durotar to Tirisfal Glades"
DELETE FROM `creature_transport` WHERE `transport_entry`=164871;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,164871,15214,7.005304,-7.647912,-16.11262,2.897247,0), -- Invisible Stalker
(2,164871,24934,-4.516505,-13.11248,-22.59472,1.53589,0), -- Snack-O-Matic IV
(3,164871,24935,-6.37827,-13.18376,-22.59391,4.712389,0), -- Vend-O-Tron D-Luxe
(4,164871,25070,-9.407872,-8.023982,-17.15783,3.176499,0), -- Chief Officer Coppernut <The Thundercaller>
(5,164871,25071,7.248865,-5.480326,-17.68592,4.817109,432), -- Crewman Rusthammer <The Thundercaller>
(6,164871,25072,8.008065,-10.71344,-17.67366,1.169371,432), -- Crewman Quickfix <The Thundercaller>
(7,164871,25074,5.023749,-7.69781,-17.78876,5.986479,432), -- Crewman Sparkfly <The Thundercaller>
(8,164871,25075,-8.875813,-11.40282,-22.5883,6.248279,0), -- Zeppelin Controls
(9,164871,25075,-3.307774,-9.474165,-23.69589,1.553343,0), -- Zeppelin Controls
(10,164871,25075,4.482075,-13.40077,-23.59003,1.623156,0), -- Zeppelin Controls
(11,164871,25075,-3.314179,-6.128806,-23.69835,4.677482,0), -- Zeppelin Controls
(12,164871,25075,4.362147,-2.254167,-23.59002,4.712389,0), -- Zeppelin Controls
(13,164871,25075,-4.161887,-7.687522,-23.69754,0,0), -- Zeppelin Controls
(14,164871,25075,11.74357,-10.44521,-24.21887,6.161012,0), -- Zeppelin Controls
(15,164871,25075,10.82609,-12.18536,-23.48949,3.176499,0), -- Zeppelin Controls
(16,164871,25075,10.70341,-3.505423,-23.49001,3.246312,0), -- Zeppelin Controls
(17,164871,25076,-2.727229,-7.772857,-23.69677,1.553343,432), -- Navigator Fairweather <The Thundercaller>
(18,164871,25077,-19.68856,-8.170582,-14.37648,3.176499,0), -- Sky-Captain Cloudkicker <The Thundercaller>
(19,164871,25079,-5.1094,-11.14663,-17.60601,4.485496,0), -- Deathguard Fowles <The Thundercaller>
(20,164871,25083,-5.212496,-4.927022,-17.5966,1.43117,0), -- Deathguard Lawson <The Thundercaller>
(21,164871,25171,-8.703286,-11.40788,-22.58871,0.03490658,0); -- Invisible Stalker (Scale x0.5)
-- gameobject 21680 -6.905273,-4.876801,-17.51628,5.911792 Rotation: 0,0,0.9850225,0.1724255

-- Zeppelin: <The Zephyr> "Durotar to Thunder Bluff"
DELETE FROM `creature_transport` WHERE `transport_entry`=190549;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,190549,3084,-4.83257,-4.312334,-17.63218,1.623156,0), -- Bluffwatcher
(2,190549,3084,-5.206744,-11.34318,-17.61012,4.712389,0), -- Bluffwatcher
(3,190549,24934,10.32099,-3.573514,-23.49413,3.176499,0), -- Snack-O-Matic IV
(4,190549,24935,10.2871,-12.02722,-23.49424,3.106686,0), -- Vend-O-Tron D-Luxe
(5,190549,25075,-3.396398,-7.905448,-23.69672,6.248279,0), -- Zeppelin Controls
(6,190549,34715,-9.183155,-7.775729,-17.21699,3.281219,0), -- Sky-Captain "Dusty" Blastnut <The Zephyr>
(7,190549,34717,-13.67017,-12.40177,-15.98756,4.590216,0), -- Crewman Pipewrench <The Zephyr>
(8,190549,34718,13.74505,-5.128461,-24.04518,0.1396263,207), -- Crewman Deadbolt <The Zephyr>
(9,190549,34719,7.623085,-5.025319,-17.67015,4.921828,28), -- Crewman Grit <The Zephyr>
(10,190549,34721,-0.919197,-6.164221,-23.67286,3.577925,0), -- Chief Officer Ograh <The Zephyr>
(11,190549,34723,-17.47968,-5.606984,-14.92807,3.228859,0), -- Watcher Tolwe <The Zephyr>
(12,190549,34730,-2.166869,-7.854215,-23.6919,3.385939,0); -- Navigator Zippik <The Zephyr>

-- Zeppelin: <The Iron Eagle> "Durotar to Stranglethorn Val"
DELETE FROM `creature_transport` WHERE `transport_entry`=175080;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,175080,24924,-1.207598,-9.948863,-23.67485,0.1570796,0), -- Sky-Captain Bomblast <The Iron Eagle>
(2,175080,24926,-10.3057,-12.10524,-16.96907,5.927236,0), -- Chief Officer Brassbolt <The Iron Eagle> <PATHING>
(3,175080,24927,-1.874165,-7.847112,-23.68718,3.385939,0), -- Navigator Sparksizzle <The Iron Eagle>
(4,175080,24929,9.083008,-4.964111,-23.59211,1.594056,0), -- Crewman Crosswire <The Iron Eagle>
(5,175080,24930,-17.0083,-7.874878,-15.18782,3.141593,0), -- Crewman Gazzlegear <The Iron Eagle>
(6,175080,24931,7.884921,-11.15133,-17.76227,4.90483,432), --  Crewman Fastwrench <The Iron Eagle> <PATHING>
(7,175080,24934,9.209188,-3.503923,-23.51212,3.124139,0), -- Snack-O-Matic IV
(8,175080,24935,9.554915,-12.02288,-23.50588,3.124139,0), -- Vend-O-Tron D-Luxe
(9,175080,25075,-2.705565,-7.845885,-23.6967,0.03490658,0), -- Zeppelin Controls
(10,175080,25080,-4.910018,-4.742365,-17.61534,1.605703,0), -- Grunt Umgor
(11,175080,25081,-4.939394,-10.80493,-17.61089,4.712389,0); -- Grunt Ounda

-- Zeppelin: <The Mighty Wind> "Durotar to Borean Tundra"
DELETE FROM `creature_transport` WHERE `transport_entry`=186238;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,186238,25075,9.44542,-7.849475,-16.60061,0.05235988,0), -- Zeppelin Controls
(2,186238,31720,-16.56853,-5.083331,-15.94212,1.989675,0), -- Crewman Shubbscoop <The Mighty Wind>
(3,186238,31723,-10.75516,-12.81286,-16.77452,4.537856,0), -- Crewman Barrowswizzle <The Mighty Wind>
(4,186238,31724,5.77627,-2.004689,-17.72185,1.64061,0), -- Crewman Paltertop <The Mighty Wind>
(5,186238,31725,10.69841,-7.821921,-16.60061,3.281219,0), -- Sky-Captain LaFontaine <The Mighty Wind>
(6,186238,31726,-3.453068,-13.78959,-17.61107,1.43117,0), -- Grunt Gritch
(7,186238,31727,-3.383076,-1.913925,-17.6198,4.729842,0); -- Grunt Grikee

-- Ship: <Northspear> "Wetlands to Howling Fjord"
DELETE FROM `creature_transport` WHERE `transport_entry`=181688;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,181688,31759,-9.170654,-9.222412,9.44523,4.339638,0), -- Sailor Jansen <Northspear>
(2,181688,31760,-24.34204,-1.495605,11.79066,4.531185,0), -- Sailor Berg <Northspear>
(3,181688,31761,17.25,3.982666,9.827404,1.127068,0), -- Sailor Davies <Northspear>
(4,181688,31762,34.08345,-0.002845,19.79711,3.124139,0), -- Navigator Marcus <Northspear>
(5,181688,31763,30.11512,-5.088479,19.32816,3.089233,0), -- Captain John Brookman <Northspear>
(6,181688,31764,26.07068,2.057755,19.32802,3.001966,0); -- First Mate Kacy Dishon <Northspear>

-- Ship: <The Kraken> "Stormwind to Borean Tundra"
DELETE FROM `creature_transport` WHERE `transport_entry`=190536;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,190536,31788,27.59511,-2.344238,19.32811,3.228859,0), -- Captain Constance <The Kraken>
(2,190536,31789,28.09979,5.993899,19.32799,3.647738,0), -- First Mate Fitzgerald <The Kraken>
(3,190536,31790,34.22358,0.067648,19.76266,3.071779,0), -- Navigator Meyer <The Kraken>
(4,190536,31791,0.919363,8.75723,9.436611,1.256637,0), -- Sailor Dawning <The Kraken>
(5,190536,31792,-4.766113,0.09985352,9.36669,4.834562,0), -- Sailor Picardo <The Kraken>
(6,190536,31793,17.146,-3.921387,9.813052,5.497081,0); -- Sailor Phillips <The Kraken>

-- Ship: <Feathermoon Ferry> "Feralas to Feathermoon Stronghold"
DELETE FROM `creature_transport` WHERE `transport_entry`=177233;
INSERT INTO `creature_transport` (`guid`,`transport_entry`,`npc_entry`,`TransOffsetX`,`TransOffsetY`,`TransOffsetZ`,`TransOffsetO`,`emote`) VALUES
(1,177233,3681,-38.64771,-0.071194,6.08577,0.06981317,0), -- Wisp
(2,177233,3681,29.56227,0.119925,24.45391,0.08726646,0), -- Wisp
(3,177233,25019,12.80499,-7.601957,6.105068,2.9147,0), -- Merchant Felagunne <Feathermoon Ferry>
(4,177233,25020,12.95386,7.333937,6.131125,3.281219,0), -- Galley Chief Alunwea <Feathermoon Ferry>
(5,177233,25021,-21.41735,-2.833596,4.391686,6.248279,0), -- Mariner Moonblade <Feathermoon Ferry>
(6,177233,25022,20.86332,-1.285908,11.80898,2.949606,0), -- Mariner Stillwake <Feathermoon Ferry>
(7,177233,25023,-36.76907,0.169367,5.975922,3.176499,0), -- Mariner Everwatch <Feathermoon Ferry>
(8,177233,25024,-21.65951,3.22012,4.402726,0.1396263,0), -- Mariner Softsong <Feathermoon Ferry>
(9,177233,25025,31.13095,-0.454317,16.73282,2.96706,0); -- Captain Idrilae <Feathermoon Ferry>
UPDATE `spell_bonus_data` SET `direct_bonus`=0.571 WHERE `entry`=51505;
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=36725; -- Nerub'ar Broodkeeper

DELETE FROM `creature` WHERE `guid` IN (200939,200949,200956,201106,201127,201170);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`MovementType`) VALUES
(200939,36725,631,15,1,-210.3750,2202.675,75.09233,0.13962630,7200,0,0), -- Nerub'ar Broodkeeper
(200949,36725,631,15,1,-220.3819,2177.068,81.70050,0.85521130,7200,0,0), -- Nerub'ar Broodkeeper
(200956,36725,631,15,1,-216.4861,2245.405,81.70050,5.18362800,7200,0,0), -- Nerub'ar Broodkeeper
(201106,36725,631,15,1,-211.2899,2219.420,75.09233,0.15707960,7200,0,0), -- Nerub'ar Broodkeeper
(201127,36725,631,15,1,-249.8542,2219.672,86.27979,5.95157300,7200,0,0), -- Nerub'ar Broodkeeper
(201170,36725,631,15,1,-250.6129,2203.800,86.27979,0.03490658,7200,0,0); -- Nerub'ar Broodkeeper

DELETE FROM `creature_addon` WHERE `guid` IN (200912,200934,200939,200949,200956,201106,201127,201170);
INSERT INTO `creature_addon` (`guid`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(200912,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(200934,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(200939,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(200949,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(200956,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(201106,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(201127,0,0x3000000,0x1,''), -- Nerub'ar Broodkeeper
(201170,0,0x3000000,0x1,''); -- Nerub'ar Broodkeeper
-- Zeppelin: <The Zephyr> "Durotar to Thunder Bluff"
SET @GUID := 43468;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+11;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES 
(@GUID,3084,647,1,1,0,0,-4.83257,-4.312334,-17.63218,1.623156,180,0,0,1,0,0), -- Bluffwatcher
(@GUID+1,3084,647,1,1,0,0,-5.206744,-11.34318,-17.61012,4.712389,180,0,0,1,0,0), -- Bluffwatcher
(@GUID+2,24934,647,1,1,0,0,10.32099,-3.573514,-23.49413,3.176499,180,0,0,1,0,0), -- Snack-O-Matic IV
(@GUID+3,24935,647,1,1,0,0,10.2871,-12.02722,-23.49424,3.106686,180,0,0,1,0,0), -- Vend-O-Tron D-Luxe
(@GUID+4,25075,647,1,1,0,0,-3.396398,-7.905448,-23.69672,6.248279,180,0,0,1,0,0), -- Zeppelin Controls
(@GUID+5,34715,647,1,1,0,0,-9.183155,-7.775729,-17.21699,3.281219,180,0,0,1,0,0), -- Sky-Captain "Dusty" Blastnut <The Zephyr>
(@GUID+6,34717,647,1,1,0,0,-13.67017,-12.40177,-15.98756,4.590216,180,0,0,1,0,2), -- Crewman Pipewrench <The Zephyr>
(@GUID+7,34718,647,1,1,0,0,13.74505,-5.128461,-24.04518,0.1396263,180,0,0,1,0,0), -- Crewman Deadbolt <The Zephyr>
(@GUID+8,34719,647,1,1,0,0,7.623085,-5.025319,-17.67015,4.921828,180,0,0,1,0,0), -- Crewman Grit <The Zephyr>
(@GUID+9,34721,647,1,1,0,0,-0.919197,-6.164221,-23.67286,3.577925,180,0,0,1,0,0), -- Chief Officer Ograh <The Zephyr>
(@GUID+10,34723,647,1,1,0,0,-17.47968,-5.606984,-14.92807,3.228859,180,0,0,1,0,0), -- Watcher Tolwe <The Zephyr>
(@GUID+11,34730,647,1,1,0,0,-2.166869,-7.854215,-23.6919,3.385939,180,0,0,1,0,0); -- Navigator Zippik <The Zephyr>
DELETE FROM `creature_template_addon` WHERE `entry` IN (34718,34719);
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`bytes2`,`emote`) VALUES
(34718,3,1,0),(34719,0,1,133);
-- Pathing for Crewman Pipewrench <The Zephyr> Entry: 34717
SET @NPC := @GUID+6;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,1,69, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-13.66992,-12.40186,-16.09792,4.590216,26000,0,0,100,0),
(@PATH,2,-14.49512,-9.873911,-15.99125,0,0,0,0,100,0),
(@PATH,3,-14.49512,-6.373911,-15.99125,0,0,0,0,100,0),
(@PATH,4,-14.31525,-3.41333,-15.88589,0,24000,0,0,100,0);
-- Zeppelin: <The Zephyr> SAI
SET @ENTRY  := 190549;
UPDATE `gameobject_template` SET `AIName`= 'SmartGameObjectAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,71,0,100,0,21868,0,0,0,80,@ENTRY*100  ,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeppelin: <The Zephyr> - Event Dock Orgrimmar - Run Script'),
(@ENTRY,1,1,0,71,0,100,0,21869,0,0,0,80,@ENTRY*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeppelin: <The Zephyr> - Event Leave Orgrimmar - Run Script'),
(@ENTRY,1,2,0,71,0,100,0,21870,0,0,0,80,@ENTRY*100+2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeppelin: <The Zephyr> - Event Dock Thunder Bluff - Run Script'),
(@ENTRY,1,3,0,71,0,100,0,21871,0,0,0,80,@ENTRY*100+3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Zeppelin: <The Zephyr> - Event Leave Thunder Bluff - Run Script'),
-- Script 0
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,19,34715,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Sky-Captain Blastnut Say 0'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh Say 1'),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,19,34765,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Zelli Hotnozzle Say 0'),
(@ENTRY*100,9,3,0,0,0,100,0,3000,3000,0,0,5,5,0,0,0,0,0,19,34715,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Sky-Captain Blastnut emote'),
(@ENTRY*100,9,4,0,0,0,100,0,1000,1000,0,0,5,25,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh emote'),
-- Script 1
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,19,34715,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Sky-Captain Blastnut Say 1'),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh Say 0'),
(@ENTRY*100+1,9,2,0,0,0,100,0,4000,4000,0,0,5,25,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh emote'),
-- Script 2
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,2,0,0,0,0,0,19,34715,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Sky-Captain Blastnut Say 2'),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh Say 1'),
(@ENTRY*100+2,9,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,19,34766,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Krendle Bigpockets Say 0'),
(@ENTRY*100+2,9,3,0,0,0,100,0,3000,3000,0,0,5,5,0,0,0,0,0,19,34715,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Sky-Captain Blastnut emote'),
(@ENTRY*100+2,9,4,0,0,0,100,0,1000,1000,0,0,5,25,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh emote'),
-- Script 3
(@ENTRY*100+3,9,0,0,0,0,100,0,0,0,0,0,1,3,0,0,0,0,0,19,34715,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Sky-Captain Blastnut Say 3'),
(@ENTRY*100+3,9,1,0,0,0,100,0,0,0,0,0,1,2,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh Say 2'),
(@ENTRY*100+3,9,2,0,0,0,100,0,4000,4000,0,0,5,25,0,0,0,0,0,19,34721,100,0,0,0,0,0,'Zeppelin: <The Zephyr> - Script Dock Orgrimmar - Chief Officer Ograh emote');
-- Watcher Tolwe <The Zephyr> SAI
SET @ENTRY  := 34723;
UPDATE `creature_template` SET `AIName`= 'SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,60000,120000,60000,120000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Watcher Tolwe <The Zephyr> - OOC - Say Random');
-- Text for Watcher Tolwe, Sky-Captain Blastnut, Chief Officer Ograh, Krendle Bigpockets, & Zelli Hotnozzle
DELETE FROM `creature_text` WHERE `entry` IN (34723,34715,34721,34766,34765);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(34723,0,0,'Dat cloud look like da Warchief.',12,1,100,25,0,0,'Watcher Tolwe - Random'),
(34723,0,1,'Dere be a bug.',12,1,100,25,0,0,'Watcher Tolwe - Random'),
(34723,0,2,'Ware da ship! A harpy! ...wait, dat be another bird.',12,1,100,25,0,0,'Watcher Tolwe - Random'),
(34723,0,3,'Dere be a bird!',12,1,100,25,0,0,'Watcher Tolwe - Random'),
(34715,0,0,'And there''s Orgrimmar, huge and menacing like always. Take a quick break, boys, then it''s back to the Bluff!',12,1,100,1,0,0,'Sky-Captain Blastnut - Dock at Orgrimmar'), -- wait 3 sec do emote 5
(34715,1,0,'Next stop, Thunder Bluff',12,1,100,5,0,0,'Sky-Captain Blastnut - Leave for Thunder Bluff'),
(34715,2,0,'Watch your step! Don''t want you becoming a smudge down there. Welcome to Thunder Bluff!',12,1,100,1,0,0,'Sky-Captain Blastnut - Dock at Thunder Bluff'), -- wait 3 sec do emote 5
(34715,3,0,'Okay, boys, let''s get this baby over to Orgrimmar!',12,1,100,25,0,0,'Sky-Captain Blastnut - Leave for Orgrimmar'),
(34721,0,0,'Move it, Zippik! We don''t have all day!',12,1,100,5,0,0,'Chief Officer Ograh - Leave for Thunder Bluff'),
(34721,1,0,'Careful. CAREFUL! Did I feel a shudder? You''re going to knock that tower down, oaf!',12,1,100,5,0,0,'Chief Officer Ograh - Dock at Thunder Bluff'), -- wait 4 sec do emote 25
(34721,2,0,'We''re behind schedule! Turn this tub east! EAST!',12,1,100,5,0,0,'Chief Officer Ograh - Leave for Orgrimmar'),
(34766,0,0,'Step right up! The zeppelin to Orgrimmar has arrived! All aboard to Durotar!',14,0,100,22,0,11804,'Krendle Bigpockets - Dock at Thunder Bluff'),
(34765,0,0,'The zeppelin to Thunder Bluff has arrived! All aboard for a smooth ride across the Barrens!',14,0,100,22,0,11804,'Zelli Hotnozzle - Dock at Orgrimmar');
