DELETE FROM `command` WHERE `name` = 'reload locales_creature_text';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload locales_creature_text', 3, 'Syntax: .reload locales_creature_text\nReload locales_creature_text Table.');ALTER TABLE `warden_checks` ENGINE=MYISAM;
ALTER TABLE `achievement_dbc` ENGINE=MYISAM;
ALTER TABLE `creature_text` ENGINE=MYISAM;
ALTER TABLE `game_event_seasonal_questrelation` ENGINE=MYISAM;
DROP TABLE IF EXISTS `character_queststatus_seasonal`;
-- SAI for Elrodan
SET @ENTRY=18743;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY*100 AND `source_type`=9);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,5000,8000,15000,25000,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Elrodan - OOC - run script'),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,11,18744,20,0,0,0,0,0,'Elrodan - Script - Aurosalia say random'),
(@ENTRY*100,9,1,0,0,0,100,0,3000,3000,3000,3000,11,32826,0,0,0,0,0,1,0,0,0,0,0,0,0,'Elrodan - Script - cast Polymorph Cast Visual');
-- Aurosalia fix model
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=18145;
-- Aurosalia text
DELETE FROM `creature_text` WHERE `entry`=18744;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(18744,0,0, 'Stop!',1,0,100,5,0,0, 'Aurosalia'),
(18744,0,1, 'Will you stop--',1,0,100,274,0,0, 'Aurosalia'),
(18744,0,2, '',1,0,100,6,0,0, 'Aurosalia');
-- Aurosalia text
DELETE FROM `creature_text` WHERE `entry`=18744;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(18744,0,0, 'Stop!',12,1,100,5,0,0, 'Aurosalia'),
(18744,0,1, 'Will you stop--',12,1,100,6,0,0, 'Aurosalia'),
(18744,0,2, '',12,1,100,274,0,0, 'Aurosalia');
DELETE FROM `trinity_string` WHERE `entry`=175;
INSERT INTO `trinity_string` (`entry`,`content_default`) VALUES
(175, 'Liquid level: %f, ground: %f, type: %u, flags %u, status: %d.');-- Add some missing guids
SET @GUID := 42153;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+4;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES 
(@GUID,32666,530,1,1,0,0,9830.201,-7389.711,13.68803,5.532694,120,0,0,1,0,0),
(@GUID+1,32667,530,1,1,0,0,9859.044,-7406.975,13.7113,1.658063,120,0,0,1,0,0),
(@GUID+2,31144,530,1,1,0,0,9869.401,-7389.657,13.69022,3.90953755,120,0,0,1,0,0),
(@GUID+3,31144,530,1,1,0,0,9871.973,-7392.763,13.6818113,3.35103226,120,0,0,1,0,0),
(@GUID+4,31146,530,1,1,0,0,9850.529,-7395.442,13.72216,4.694936,120,0,0,1,0,0);
-- Addons
DELETE FROM `creature_addon` WHERE `guid` BETWEEN @GUID AND @GUID+4;
DELETE FROM `creature_addon` WHERE `guid`=66686;
INSERT INTO `creature_addon` (`guid`,`bytes2`,`auras`) VALUES
(@GUID,1, '7056 61573'),
(@GUID+1,1, '7056 61573'),
(@GUID+2,1, '7056 61573'),
(@GUID+3,1, '7056 61573'),
(@GUID+4,1, '7056 61573'),
(66686,1, '7056');
-- convert npc to trigger
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=18504;
-- SAI for Champion Vranesh
SET @ENTRY=18146;
UPDATE `creature` SET `position_x`=9834.044,`position_y`=-7480.845,`position_z`=14.93467 WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
UPDATE `creature_template_addon` SET `mount`=0 WHERE `entry`=@ENTRY; -- 19085
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3,@ENTRY*100+4);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- AI
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,53,0,@ENTRY,1,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On respawn - load path'),
(@ENTRY,0,1,2,40,0,100,0,7,@ENTRY,0,0,54,6000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,3,4,40,0,100,0,11,@ENTRY,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,5,6,40,0,100,0,25,@ENTRY,0,0,54,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,7,8,40,0,100,0,34,@ENTRY,0,0,54,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,9,10,40,0,100,0,50,@ENTRY,0,0,54,7000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,11,0,40,0,100,0,57,@ENTRY,0,0,54,600000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
-- Script 0
(@ENTRY*100,9,0,0,0,0,100,0,3500,3500,3500,3500,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 0 - emote bow'),
-- Script 1
(@ENTRY*100+1,9,0,0,0,0,100,0,100,100,100,100,43,0,19085,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 1 - mount horse'),
(@ENTRY*100+1,9,1,0,0,0,100,0,100,100,100,100,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 1 - say 0'),
(@ENTRY*100+1,9,2,0,0,0,100,0,100,100,100,100,5,16,0,0,0,0,0,11,16222,10,0,0,0,0,0,'Champion Vranesh - Script 1 - Silvermoon City Guardian emote bow'),
(@ENTRY*100+1,9,3,0,0,0,100,0,100,100,100,100,1,0,0,0,0,0,0,19,16222,10,0,0,0,0,0,'Champion Vranesh - Script 1 - Silvermoon City Guardian say 0'),
-- Script 2
(@ENTRY*100+2,9,0,0,0,0,100,0,3000,3000,3000,3000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 2 - say 1'),
(@ENTRY*100+2,9,1,0,0,0,100,0,100,100,100,100,5,16,0,0,0,0,0,11,16222,18,0,0,0,0,0,'Champion Vranesh - Script 2 - Silvermoon City Guardian emote bow'),
(@ENTRY*100+2,9,2,0,0,0,100,0,100,100,100,100,1,1,0,0,0,0,0,19,16222,18,0,0,0,0,0,'Champion Vranesh - Script 2 - Silvermoon City Guardian say 1'),
-- Script 3
(@ENTRY*100+3,9,0,0,0,0,100,0,3000,3000,3000,3000,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 3 - say 2'),
(@ENTRY*100+3,9,1,0,0,0,100,0,100,100,100,100,5,16,0,0,0,0,0,11,16222,30,0,0,0,0,0,'Champion Vranesh - Script 3 - Silvermoon City Guardian emote bow'),
-- Script 4
(@ENTRY*100+4,9,0,0,0,0,100,0,1000,1000,1000,1000,43,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 4 - dismount horse'),
(@ENTRY*100+4,9,1,0,0,0,100,0,1000,1000,1000,1000,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 3 - say 3');

-- NPC talk text for Champion Vranesh and Silvermoon City Guardian
DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY,16222);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'Champion Vranesh inclines his head slightly to the pair of guardians in greeting.',16,1,100,0,0,0, 'Champion Vranesh'),
(@ENTRY,1,0, 'Champion Vranesh arches a scrulpled brow at the guards. a disapproving scowl on his face',16,1,100,0,0,0, 'Champion Vranesh'),
(@ENTRY,2,0, 'Champion Vranesh glances from guard to guard.',16,1,100,0,0,0, 'Champion Vranesh'),
(@ENTRY,3,0, 'Champion Vranesh surveys the small ranger practice ground with a condescending smirk.',16,1,100,0,0,0, 'Champion Vranesh'),
(16222,0,0, 'Glory to the Sun K-- ah... Silvermoon!',12,1,100,0,0,0, 'Silvermoon City Guardian'),
(16222,1,0, 'Our lives are yours, Blood Knight.',12,1,100,0,0,0, 'Silvermoon City Guardian');

-- Pathing for Champion Vranesh
DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY,1,9834.044,-7480.845,14.93467, 'Champion Vranesh'),
(@ENTRY,2,9829.106,-7493.609,14.93653, 'Champion Vranesh'),
(@ENTRY,3,9826.172,-7516.15,19.73714, 'Champion Vranesh'),
(@ENTRY,4,9841.332,-7518.849,19.70547, 'Champion Vranesh'),
(@ENTRY,5,9845.063,-7512.885,19.68096, 'Champion Vranesh'),
(@ENTRY,6,9850.942,-7512.470,19.71548, 'Champion Vranesh'),
(@ENTRY,7,9850.934,-7513.604,19.71813, 'Champion Vranesh'), -- pause 6000
(@ENTRY,8,9872.733,-7517.256,19.75283, 'Champion Vranesh'),
(@ENTRY,9,9872.419,-7489.979,14.91272, 'Champion Vranesh'),
(@ENTRY,10,9851.401,-7490.209,14.93464, 'Champion Vranesh'),
(@ENTRY,11,9850.948,-7470.096,14.91403, 'Champion Vranesh'), -- pause 1000
(@ENTRY,12,9851.16,-7469.154,14.91319, 'Champion Vranesh'),
(@ENTRY,13,9849.688,-7442.579,13.50931, 'Champion Vranesh'),
(@ENTRY,14,9848.726,-7423.561,13.31949, 'Champion Vranesh'),
(@ENTRY,15,9816.583,-7423.817,13.30332, 'Champion Vranesh'),
(@ENTRY,16,9794.673,-7424.877,13.50989, 'Champion Vranesh'),
(@ENTRY,17,9794.48,-7442.293,14.40225, 'Champion Vranesh'),
(@ENTRY,18,9767.989,-7442.611,14.39258, 'Champion Vranesh'),
(@ENTRY,19,9767.406,-7422.982,13.35852, 'Champion Vranesh'),
(@ENTRY,20,9739.563,-7422.83,13.28878, 'Champion Vranesh'),
(@ENTRY,21,9736.46,-7440.873,13.53963, 'Champion Vranesh'),
(@ENTRY,22,9740.345,-7464.682,13.57483, 'Champion Vranesh'),
(@ENTRY,23,9746.739,-7482.594,13.55744, 'Champion Vranesh'),
(@ENTRY,24,9748.767,-7486.576,13.54981, 'Champion Vranesh'),
(@ENTRY,25,9753.25,-7486.52,13.5461, 'Champion Vranesh'), -- pause 8000
(@ENTRY,26,9720.037,-7486.478,13.52865, 'Champion Vranesh'),
(@ENTRY,27,9681.502,-7475.868,13.52783, 'Champion Vranesh'),
(@ENTRY,28,9666.59,-7479.547,13.53783, 'Champion Vranesh'),
(@ENTRY,29,9638.033,-7492.629,13.50889, 'Champion Vranesh'),
(@ENTRY,30,9620.123,-7488.486,13.53853, 'Champion Vranesh'),
(@ENTRY,31,9605.795,-7475.276,13.55774, 'Champion Vranesh'),
(@ENTRY,32,9597.921,-7460.307,13.54336, 'Champion Vranesh'),
(@ENTRY,33,9594.605,-7450.369,13.5353, 'Champion Vranesh'),
(@ENTRY,34,9592.944,-7450.381,13.53116, 'Champion Vranesh'), -- pause 8000
(@ENTRY,35,9594.605,-7450.369,13.5353, 'Champion Vranesh'),
(@ENTRY,36,9615.793,-7419.515,13.30549, 'Champion Vranesh'),
(@ENTRY,37,9654.939,-7420.383,13.29342, 'Champion Vranesh'),
(@ENTRY,38,9673.072,-7429.818,13.2933, 'Champion Vranesh'),
(@ENTRY,39,9689.373,-7431.429,13.2933, 'Champion Vranesh'),
(@ENTRY,40,9709.577,-7422.25,13.2933, 'Champion Vranesh'),
(@ENTRY,41,9722.3,-7415.217,13.39988, 'Champion Vranesh'),
(@ENTRY,42,9748.049,-7414.597,13.32135, 'Champion Vranesh'),
(@ENTRY,43,9766.792,-7413.542,13.38617, 'Champion Vranesh'),
(@ENTRY,44,9767.26,-7396.828,14.43101, 'Champion Vranesh'),
(@ENTRY,45,9793.145,-7395.393,14.3936, 'Champion Vranesh'),
(@ENTRY,46,9794.217,-7415.122,13.48684, 'Champion Vranesh'),
(@ENTRY,47,9817.575,-7415.299,13.30596, 'Champion Vranesh'),
(@ENTRY,48,9837.021,-7414.861,13.30863, 'Champion Vranesh'),
(@ENTRY,49,9848.048,-7414.794,13.31137, 'Champion Vranesh'),
(@ENTRY,50,9848.199,-7414.07,13.31068, 'Champion Vranesh'), -- pause 7000
(@ENTRY,51,9847.695,-7415.903,13.31243, 'Champion Vranesh'),
(@ENTRY,52,9848.259,-7428.576,13.33225, 'Champion Vranesh'),
(@ENTRY,53,9846.748,-7446.964,13.56501, 'Champion Vranesh'),
(@ENTRY,54,9850.373,-7465.03,14.9097, 'Champion Vranesh'),
(@ENTRY,55,9850.84,-7480.409,14.93768, 'Champion Vranesh'),
(@ENTRY,56,9840.165,-7480.267,14.92917, 'Champion Vranesh'),
(@ENTRY,57,9843.284,-7480.133,14.92655, 'Champion Vranesh'); -- pause 60000

-- SAI for Silvermoon Farstrider
SET @ENTRY=18507;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - Reset - Set Phase 1'),
(@ENTRY,0,1,2,1,1,100,0,3000,3000,5000,5000,11,36802,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Cast Spell (Phase 1)'),
(@ENTRY,0,2,0,61,1,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Set Phase 2 (Phase 1)'),
(@ENTRY,0,3,4,1,2,100,0,3000,3000,5000,5000,11,36803,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Cast Spell (Phase 2)'),
(@ENTRY,0,4,0,61,2,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Set Phase 1 (Phase 2)');
-- SAI for Silvermoon Ranger
SET @ENTRY=18147;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-64950,-64951,-64952,-64953);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-64950,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29121,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell'),
(-64951,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29121,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell'),
(-64952,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29120,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell'),
(-64953,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29122,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell');
-- Silvermoon City Guardian pathing
SET @NPC := 56902;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=9595.755,`position_y`=-7366.754,`position_z`=13.50131 WHERE `guid`=@NPC;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9595.755,-7366.754,13.50131,0,0,0,100,0),
(@PATH,2,9594.553,-7336.536,14.15131,0,0,0,100,0),
(@PATH,3,9586.897,-7325.241,14.1312,0,0,0,100,0),
(@PATH,4,9561.705,-7326.179,14.05934,0,0,0,100,0),
(@PATH,5,9519.901,-7327.064,14.12175,0,0,0,100,0),
(@PATH,6,9508.228,-7352.014,14.33403,0,0,0,100,0),
(@PATH,7,9505.697,-7394.406,14.32095,0,0,0,100,0),
(@PATH,8,9535.751,-7396.176,16.8303,0,0,0,100,0),
(@PATH,9,9564.451,-7396.184,16.84703,0,0,0,100,0),
(@PATH,10,9563.777,-7415.961,19.47212,0,0,0,100,0),
(@PATH,11,9559.149,-7418.953,19.47643,0,0,0,100,0),
(@PATH,12,9563.34,-7432.895,15.4851,0,0,0,100,0),
(@PATH,13,9564.645,-7464.229,15.51088,0,0,0,100,0),
(@PATH,14,9588.409,-7464.643,13.52051,0,0,0,100,0),
(@PATH,15,9603.896,-7430.126,13.30448,0,0,0,100,0),
(@PATH,16,9595.137,-7387.862,13.52731,0,0,0,100,0),
(@PATH,17,9572.599,-7384.971,14.39343,0,0,0,100,0),
(@PATH,18,9573.106,-7369.531,14.40827,0,0,0,100,0);
-- Coilfang Guardian

DELETE FROM `smart_scripts` WHERE `entryorguid`=21873 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(21873, 0, 0, 0, 0, 0, 0, 0, 5000, 5000, 15000, 15000, 11, 28168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - IC - Cast Arcing Smash'),
(21873, 0, 1, 0, 0, 0, 0, 0, 2000, 2000, 10000, 10000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - IC - Cast Harmstring'),
(21873, 0, 2, 0, 0, 0, 50, 0, 3000, 4000, 10000, 20000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - IC - Say 0'); -- randomly guessed timers

DELETE FROM `creature_text` WHERE `entry`=21873;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(21873, 0, 0, 'By Nazjatar''s Depths!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 1, 'Die, warmblood!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 2, 'For the Master!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 3, 'Illidan reigns!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian'),
(21873, 0, 4, 'My blood is like venom!', 12, 0, 0, 0, 0, 0, 'Coilfang Guardian');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=21873;

-- Coilfang Strider

DELETE FROM `smart_scripts` WHERE `entryorguid`=22056 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(22056, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 11, 38257, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - On Reset - Cast Panic Periodic'),
(22056, 0, 1, 0, 0, 0, 0, 0, 8000, 8000, 30000, 40000, 11, 38259, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - IC - Cast Mind Blast');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=22056;

-- Coilfang Elite

DELETE FROM `smart_scripts` WHERE `entryorguid`=22055 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(22055, 0, 0, 0, 0, 0, 0, 0, 5000, 5000, 15000, 20000, 11, 38260, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - IC - Cast Cleave'),
(22055, 0, 1, 0, 0, 0, 0, 0, 2000, 2000, 10000, 10000, 11, 38262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - IC - Cast Harmstring');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=22055;

-- Core Hound

DELETE FROM `smart_scripts` WHERE `entryorguid`=11673 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 11673*100+0 AND 11673*100+5 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(11673, 0, 0, 0, 0, 0, 0, 0, 10000, 10000, 7000, 7000, 11, 19272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - IC - Cast Lava Breath'),
(11673, 0, 1, 0, 0, 0, 0, 0, 4000, 4000, 6000, 6000, 11, 19319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - IC - Cast Vicious Bite'),
(11673, 0, 2, 0, 0, 0, 0, 0, 15000, 15000, 24000, 24000, 88, 11673*100+0, 11673*100+5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - IC - Call random script'),
(11673*100+0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19364, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 0 - Cast Ground Stomp'),
(11673*100+1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19366, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 1 - Cast Cauterizing Flames'),
(11673*100+2, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19367, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 2 - Cast Withering Heat'),
(11673*100+3, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19369, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 3 - Cast Ancient Despair'),
(11673*100+4, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19372, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 4 - Cast Ancient Hysteria'),
(11673*100+5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19365, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Core Hound - Random 5 - Cast Ancient Dread');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=11673;

-- Shadow of Aran

DELETE FROM `smart_scripts` WHERE `entryorguid`=18254 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(18254, 0, 0, 0, 0, 0, 0, 0, 1000, 1000, 5000, 5000, 11, 29978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Aran - IC - Cast Pyro Blast');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=18254;
ALTER TABLE `creature_template` ADD COLUMN `HoverHeight` FLOAT NOT NULL DEFAULT 1 AFTER `InhabitType`;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=72257;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,72257,0,0,32,0,144,0,0,0,0,'','Remove Marks of the Fallen Champion - target player');
UPDATE `gameobject_template` SET `flags`=0x32 WHERE `entry` IN (202239,202240,202238,202241,201959,202339,202338,202340);

-- Set Deathbringer's Cache spawned by default
UPDATE `gameobject` SET `spawntimesecs`=604800 WHERE `id` IN (202239,202240,202238,202241);
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_deathbringer_remove_marks';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(72257,'spell_deathbringer_remove_marks');
