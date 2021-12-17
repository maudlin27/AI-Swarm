local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local BasePanicZone, BaseMilitaryZone, BaseEnemyZone = import('/mods/AI-Swarm/lua/AI/swarmutilities.lua').GetDangerZoneRadii()

local MaxAttackForce = 0.45                                               


local HaveLessThanTwoT2AirFactory = function( self, aiBrain )
	
	if table.getn( aiBrain:GetListOfUnits( categories.FACTORY * categories.AIR - categories.TECH1, false, true )) < 2 then
	
		return 500, true
		
	end

	
	return 0, false
	
end

local HaveLessThanTwoT3AirFactory = function( self, aiBrain )
	
	if table.getn( aiBrain:GetListOfUnits( categories.FACTORY * categories.AIR * categories.TECH3, false, true )) < 2 then
	
		return 500, true
		
	end

	
	return 0, false
	
end

BuilderGroup { BuilderGroupName = 'Swarm Air Builders',
    BuildersType = 'FactoryBuilder',

    -- ============ --
    --    TECH 1    --
    -- ============ --

    -- This Specific Builder Covers the first 6 Minutes.
    -- In Which Swarm is promised to open with a third air factory.
    -- So Due to the construct of our normal air builders.
    -- We put this in to cover our finish maybe 5 or 10 Inteceptors. 
    Builder {
        BuilderName = 'T1 Air Opening Queue',

        PlatoonTemplate = 'SwarmAIT1AirOpeningQueue',

        Priority = 500,

        BuilderConditions = {
            { UCBC, 'LessThanGameTimeSeconds', { 60 * 5 } },

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.7, 0.8 }},

            { EBC, 'GreaterThanEconStorageRatioSwarm', { 0.01, 0.10}},
        },
        BuilderType = 'Air',
    }, 

    Builder {
        BuilderName = 'Swarm-AI - T1 Air Fighter',

        PlatoonTemplate = 'T1AirFighter',

        Priority = 500,

        PriorityFunction = HaveLessThanTwoT3AirFactory,

        BuilderConditions = {
            { UCBC, 'AirStrengthRatioLessThan', { 3 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.7, 0.8 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T1 Air Bomber',

        PlatoonTemplate = 'T1AirBomber',

        Priority = 500,

        PriorityFunction = HaveLessThanTwoT2AirFactory,

        BuilderConditions = {
            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.7, 0.8 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T1 Air Gunship',

        PlatoonTemplate = 'T1Gunship',

        Priority = 500,

        PriorityFunction = HaveLessThanTwoT2AirFactory,

        BuilderConditions = {
            { MIBC, 'FactionIndex', { 3 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 

            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.7, 0.8 }},
        },
        BuilderType = 'Air',
    },

    -- ============ --
    --    TECH 2    --
    -- ============ --
    Builder {
        BuilderName = 'Swarm-AI - T2 Air Fighter/Bomber',

        PlatoonTemplate = 'T2FighterBomber',

        Priority = 500,

        PriorityFunction = HaveLessThanTwoT3AirFactory,

        BuilderConditions = {
            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.75, 1.0 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T2 Air Gunship',

        PlatoonTemplate = 'T2AirGunship',

        Priority = 500,

        PriorityFunction = HaveLessThanTwoT3AirFactory,

        BuilderConditions = {
            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.75, 1.0 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T2 Air Torpedo-Bomber',

        PlatoonTemplate = 'T2AirTorpedoBomber',

        Priority = 500,

        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtEnemySwarm', { 0 , categories.NAVAL * categories.MOBILE } },

            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.75, 1.0 }},
        },
        BuilderType = 'Air',
    },

    -- ============ --
    --    TECH 3    --
    -- ============ --

    Builder {
        BuilderName = 'Swarm-AI - T3 Air Fighter',

        PlatoonTemplate = 'T3AirFighter',

        Priority = 500,

        BuilderConditions = {
            { UCBC, 'UnitCapCheckLess', { 0.90 } },

            { UCBC, 'AirStrengthRatioLessThan', { 3 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.9, 1.1 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T3 Air Bomber',

        PlatoonTemplate = 'T3AirBomber',

        Priority = 500,
        
        BuilderConditions = {
            { UCBC, 'UnitCapCheckLess', { 0.90 } },

            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.9, 1.1 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T3 Air Gunship',

        PlatoonTemplate = 'T3AirGunship',

        Priority = 500,
        
        BuilderConditions = {
            { UCBC, 'UnitCapCheckLess', { 0.90 } },

            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.9, 1.1 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T3 Air Torpedo-Bomber',

        PlatoonTemplate = 'T3TorpedoBomber',

        Priority = 500,

        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtEnemySwarm', { 0 , categories.NAVAL * categories.MOBILE } },

            { UCBC, 'AirStrengthRatioGreaterThan', { 1.5 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.9, 1.1 }},
        },
        BuilderType = 'Air',
    },

    -- ============ --
    --   TRANSPORT  --
    -- ============ --

    Builder { BuilderName = 'S1 Air Transport - Swarm',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 510, 
        BuilderConditions = {
            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconTrendOverTimeSwarm', { 0.3, 12.0 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 1.02, 1.1 }},

            { UCBC, 'UnitCapCheckLess', { 0.95 } },

            { MIBC, 'ArmyNeedsTransports', {} },

            { MIBC, 'CanPathToCurrentEnemySwarm', { true, 'LocationType' } },

            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.AIR * categories.TRANSPORTATION} },

            { UCBC, 'PoolLessAtLocation', { 'LocationType', 1, categories.AIR * categories.TRANSPORTATION }},
        },
        BuilderType = 'Air',
    },


    Builder { BuilderName = 'S2 Air Transport - Swarm',
        PlatoonTemplate = 'T2AirTransport',
        Priority = 603,
        BuilderConditions = {
            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { EBC, 'GreaterThanEconTrendOverTimeSwarm', { 0.3, 12.0 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 1.02, 1.1 }},

            { UCBC, 'UnitCapCheckLess', { 0.95 } },

            { MIBC, 'ArmyNeedsTransports', {} },

            { MIBC, 'CanPathToCurrentEnemySwarm', { true, 'LocationType' } },

            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.AIR * categories.TRANSPORTATION} },

            { UCBC, 'PoolLessAtLocation', { 'LocationType', 1, categories.AIR * categories.TRANSPORTATION }},
        },
        BuilderType = 'Air',
    },


    Builder { BuilderName = 'S3 Air Transport - Swarm',
        PlatoonTemplate = 'T3AirTransport',
        Priority = 707,
        BuilderConditions = {
            { UCBC, 'AirStrengthRatioGreaterThan', { 1 } },

            { MIBC, 'FactionIndex', { 1 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 
            
            { EBC, 'GreaterThanEconTrendOverTimeSwarm', { 0.3, 12.0 } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 1.02, 1.1 }},

            { UCBC, 'UnitCapCheckLess', { 0.95 } },

            { MIBC, 'ArmyNeedsTransports', {} },

            { MIBC, 'CanPathToCurrentEnemySwarm', { true, 'LocationType' } },

            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.AIR * categories.TRANSPORTATION} },

            { UCBC, 'PoolLessAtLocation', { 'LocationType', 1, categories.AIR * categories.TRANSPORTATION }},
       },
        BuilderType = 'Air',
    }, 

    Builder {
        BuilderName = 'Swarm-AI - T1 Air Scout',

        PlatoonTemplate = 'T1AirScoutSwarm',

        Priority = 500,

        PriorityFunction = HaveLessThanTwoT3AirFactory,

        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.AIR * categories.SCOUT } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.7, 0.8 }},

            { SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 8, [512] = 12, [1024] = 18, [2048] = 20, [4096] = 20}, categories.AIR * categories.SCOUT}},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'Swarm-AI - T3 Air Scout',

        PlatoonTemplate = 'T3AirScout',

        Priority = 500,

        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.AIR * categories.SCOUT } },

            { EBC, 'GreaterThanEconStorageCurrentSwarm', { 200, 2000}},

            { EBC, 'GreaterThanEconEfficiencyOverTimeSwarm', { 0.9, 1.1 }},

            { SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 4, [512] = 8, [1024] = 12, [2048] = 16, [4096] = 20}, categories.AIR * categories.SCOUT}},
        },
        BuilderType = 'Air',
    },
}


-- ===================================================-======================================================== --
--                                          Air Scouts Formbuilder                                              --
-- ===================================================-======================================================== --
BuilderGroup { BuilderGroupName = 'Swarm Air Scout Formers',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'Swarm Former Scout T1',
        PlatoonTemplate = 'T1AirScoutFormSwarm',
        InstanceCount = 8,
        Priority = 900,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.SCOUT } },
        },
        LocationType = 'LocationType',
        BuilderType = 'Any',
    },
    Builder {
    BuilderName = 'Swarm Former Scout T3',
        PlatoonTemplate = 'T3AirScoutFormSwarm',
        InstanceCount = 8,
        Priority = 910,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.SCOUT } },
        },
        LocationType = 'LocationType',
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'Swarm Former Scout Patrol DMZ T1',
        PlatoonTemplate = 'T1AirScoutFormSwarm',
        InstanceCount = 2,
        Priority = 900,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.SCOUT } },
        },
        BuilderData = {
            Patrol = true,
            PatrolTime = 600,
            --MilitaryArea = 'BaseDMZArea',
        },
        LocationType = 'LocationType',
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'Swarm Former Scout Patrol DMZ T3',
        PlatoonTemplate = 'T3AirScoutFormSwarm',
        InstanceCount = 2,
        Priority = 900,
        BuilderData = {
            Patrol = true,
            PatrolTime = 600,
            --MilitaryArea = 'BaseDMZArea',
        },
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.SCOUT } },
        },
        LocationType = 'LocationType',
        BuilderType = 'Any',
    },
}

-- ===================================================-======================================================== --
--                                          Air Formbuilder                                                     --
-- ===================================================-======================================================== --

BuilderGroup { BuilderGroupName = 'Swarm Air Formers',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'Swarm Fighter Intercept 3 5',
        PlatoonTemplate = 'Swarm Fighter Intercept 3 5',
        PlatoonAddBehaviors = { 'AirUnitRefit' },                      
        Priority = 160,                                                        
        InstanceCount = 3,                                                  
        BuilderData = {
            SearchRadius = 64,                                   
            GetTargetsFromBase = true,                                          
            AttackEnemyStrength = 150,                                                                            
            AggressiveMove = true,       
            IgnorePathing = false,                                      
            TargetSearchCategory = categories.MOBILE * categories.AIR - categories.SCOUT, 
            MoveToCategories = {                                           
                categories.MOBILE * categories.EXPERIMENTAL,
                categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS,
                categories.MOBILE * categories.AIR * categories.BOMBER,
                categories.MOBILE * categories.AIR * categories.GROUNDATTACK,
                categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.HIGHALTAIR,
                categories.MOBILE * categories.AIR,
            },
        },
        BuilderConditions = {                                                  
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.ENGINEER } },
        },
        BuilderType = 'Any',                                                   
    },

    Builder {
        BuilderName = 'Swarm Fighter Intercept 10',
        PlatoonTemplate = 'Swarm Fighter Intercept 10',
        PlatoonAddBehaviors = { 'AirUnitRefit' },                      
        Priority = 159,                                                        
        InstanceCount = 2,                                                
        BuilderData = {
            SearchRadius = 64,                                   
            GetTargetsFromBase = true,                                          
            AttackEnemyStrength = 120,                                                                              
            AggressiveMove = true,    
            IgnorePathing = false,                                         
            TargetSearchCategory = categories.MOBILE * categories.AIR - categories.SCOUT, 
            MoveToCategories = {                                           
                categories.MOBILE * categories.EXPERIMENTAL,
                categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS,
                categories.MOBILE * categories.AIR * categories.BOMBER,
                categories.MOBILE * categories.AIR * categories.GROUNDATTACK,
                categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.HIGHALTAIR,
                categories.MOBILE * categories.AIR,
            },
        },
        BuilderConditions = {                     
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 10, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.ENGINEER } },                             
        },
        BuilderType = 'Any',                                                   
    },
    Builder {
        BuilderName = 'Swarm Fighter Intercept 20',
        PlatoonTemplate = 'Swarm Fighter Intercept 20',
        PlatoonAddBehaviors = { 'AirUnitRefit' },                               
        Priority = 158,                                                        
        InstanceCount = 1,                                                     
        BuilderData = {
            SearchRadius = 128,                                  
            GetTargetsFromBase = true,                                         
            AttackEnemyStrength = 120,                                                                                  
            AggressiveMove = true,  
            IgnorePathing = false,                                          
            TargetSearchCategory = categories.MOBILE * categories.AIR - categories.SCOUT, 
            MoveToCategories = {                                              
                categories.MOBILE * categories.EXPERIMENTAL,
                categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS,
                categories.MOBILE * categories.AIR * categories.BOMBER,
                categories.MOBILE * categories.AIR * categories.GROUNDATTACK,
                categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.HIGHALTAIR,
                categories.MOBILE * categories.AIR,
            },
        },
        BuilderConditions = {         
            { UCBC, 'AirStrengthRatioGreaterThan', { 1.3 } },

            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 20, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.ENGINEER } },    
        },
        BuilderType = 'Any',                                                   
    },
    Builder {
        BuilderName = 'Swarm Fighter Intercept 30 50',
        PlatoonTemplate = 'Swarm Fighter Intercept 30 50',
        PlatoonAddBehaviors = { 'AirUnitRefit' },                          
        Priority = 157,                                                         
        InstanceCount = 1,                                                      
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                          
            AttackEnemyStrength = 120,                                                                                   
            AggressiveMove = true,      
            IgnorePathing = false,                                      
            TargetSearchCategory = categories.MOBILE * categories.AIR - categories.SCOUT, 
            MoveToCategories = {                                               
                categories.MOBILE * categories.EXPERIMENTAL,
                categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS,
                categories.MOBILE * categories.AIR * categories.BOMBER,
                categories.MOBILE * categories.AIR * categories.GROUNDATTACK,
                categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.HIGHALTAIR,
                categories.MOBILE * categories.AIR,
            },
        },
        BuilderConditions = {           
            { UCBC, 'AirStrengthRatioGreaterThan', { 1.5 } },

            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 40, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.ENGINEER } },                                          
        },
        BuilderType = 'Any',                                                  
    },

    Builder {
        BuilderName = 'Swarm Panic AntiBomber',
        PlatoonTemplate = 'Swarm Fighter Intercept 1 2',
        PlatoonAddBehaviors = { 'AirUnitRefit' },                               
        Priority = 102,                                                          
        InstanceCount = 2,                                                    
        BuilderData = {
            SearchRadius = 64,                                    
            GetTargetsFromBase = true,                                      
            AggressiveMove = true,                                             
            AttackEnemyStrength = 500,                                      
            IgnorePathing = true,                                           
            TargetSearchCategory = categories.MOBILE * categories.AIR * categories.BOMBER, 
            MoveToCategories = {                                                
                categories.MOBILE * categories.AIR * categories.BOMBER,
                categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS,
                categories.MOBILE * categories.AIR * categories.ANTIAIR,
                categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.HIGHALTAIR,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Gunship Defensive',                                  
        PlatoonTemplate = 'Swarm Gunship Small',                          
        Priority = 75,                                                          
        InstanceCount = 4,                                                    
        BuilderData = {
            SearchRadius = 128,                                       
            GetTargetsFromBase = true,                                         
            AggressiveMove = true,                                             
            AttackEnemyStrength = 300,                                    
            IgnorePathing = false,                                               
            TargetSearchCategory = categories.MOBILE + categories.STRUCTURE - categories.SCOUT,                         
            MoveToCategories = {               
                categories.COMMAND,  
                categories.SUBCOMMANDER, 
                categories.EXPERIMENTAL,                                 
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.INDIRECTFIRE,
                categories.MOBILE * categories.LAND * categories.DIRECTFIRE,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
            },
            WeaponTargetCategories = {     
                categories.COMMAND,  
                categories.SUBCOMMANDER,     
                categories.EXPERIMENTAL,                                  
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.INDIRECTFIRE,
                categories.MOBILE * categories.LAND * categories.DIRECTFIRE,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
                
            },
        },
        BuilderConditions = {                                                   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.AIR * categories.GROUNDATTACK - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Gunship Local',                                  
        PlatoonTemplate = 'Swarm Gunship Big',                          
        Priority = 75,                                                          
        InstanceCount = 4,                                                    
        BuilderData = {
            SearchRadius = 256,                                       
            GetTargetsFromBase = true,                                         
            AggressiveMove = true,                                             
            AttackEnemyStrength = 150,                                    
            IgnorePathing = false,                                               
            TargetSearchCategory = categories.MOBILE + categories.STRUCTURE - categories.SCOUT,                         
            MoveToCategories = {               
                categories.COMMAND,  
                categories.SUBCOMMANDER, 
                categories.EXPERIMENTAL,                                 
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.INDIRECTFIRE,
                categories.MOBILE * categories.LAND * categories.DIRECTFIRE,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
            },
            WeaponTargetCategories = {     
                categories.COMMAND,  
                categories.SUBCOMMANDER,     
                categories.EXPERIMENTAL,                                  
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.INDIRECTFIRE,
                categories.MOBILE * categories.LAND * categories.DIRECTFIRE,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
                
            },
        },
        BuilderConditions = {                                                   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.AIR * categories.GROUNDATTACK - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Bomber/Gunship Defensive',                                 
        PlatoonTemplate = 'AntiGround Bomber/Gunship Small',                           
        PlatoonAddBehaviors = { 'AirUnitRefit' },                             
        Priority = 100,                                                        
        InstanceCount = 4,                                                
        BuilderData = {
            SearchRadius = 128,                                    
            GetTargetsFromBase = true,                                          
            AggressiveMove = true,                                              
            AttackEnemyStrength = 300,                                    
            IgnorePathing = false,                                               
            TargetSearchCategory = categories.MOBILE,       
            MoveToCategories = {                            
                categories.COMMAND,           
                categories.SUBCOMMANDER,  
                categories.EXPERIMENTAL,        
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.INDIRECTFIRE,
                categories.MOBILE * categories.LAND * categories.DIRECTFIRE,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
            },
            WeaponTargetCategories = {    
                categories.COMMAND,                                   
                categories.ANTIAIR,
                categories.COMMAND,
                categories.MOBILE,
            },
        },
        BuilderConditions = {   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) } },                                                
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Bomber/Gunship Local',                                 
        PlatoonTemplate = 'AntiGround Bomber/Gunship Big',                           
        PlatoonAddBehaviors = { 'AirUnitRefit' },                             
        Priority = 100,                                                        
        InstanceCount = 4,                                                
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                          
            AggressiveMove = true,                                              
            AttackEnemyStrength = 150,                                    
            IgnorePathing = false,                                               
            TargetSearchCategory = categories.MOBILE,       
            MoveToCategories = {                            
                categories.COMMAND,  
                categories.SUBCOMMANDER,    
                categories.EXPERIMENTAL,                
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.INDIRECTFIRE,
                categories.MOBILE * categories.LAND * categories.DIRECTFIRE,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
            },
            WeaponTargetCategories = {    
                categories.COMMAND,                                   
                categories.ANTIAIR,
                categories.COMMAND,
                categories.MOBILE,
            },
        },
        BuilderConditions = {   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) } },                                                
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Bomber Economic',                                  
        PlatoonTemplate = 'Swarm Bomber Big',                          
        Priority = 75,                                                          
        InstanceCount = 4,                                                    
        BuilderData = {
            SearchRadius = 256,                                       
            GetTargetsFromBase = true,                                         
            AggressiveMove = true,                                             
            AttackEnemyStrength = 80,                                    
            IgnorePathing = false,                                               
            TargetSearchCategory = categories.MOBILE + categories.STRUCTURE - categories.SCOUT,                         
            MoveToCategories = {                                              
                categories.MASSPRODUCTION + categories.MASSEXTRACTION, 
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.ECONOMIC,
                categories.SHIELD,
                categories.ANTIAIR,
                categories.ALLUNITS,
            },
            WeaponTargetCategories = {                                          
                categories.MASSPRODUCTION + categories.MASSEXTRACTION, 
                categories.STRUCTURE * categories.ENERGYPRODUCTION,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.AIR * categories.BOMBER - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Bomber/Gunship Engineer',                                 
        PlatoonTemplate = 'AntiGround Bomber/Gunship Small',                           
        PlatoonAddBehaviors = { 'AirUnitRefit' },                             
        Priority = 101,                                                       
        InstanceCount = 4,                                                 
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                         
            AggressiveMove = true,                                             
            AttackEnemyStrength = 60,                                    
            IgnorePathing = false,                                               
            TargetSearchCategory = categories.MOBILE + categories.STRUCTURE - categories.SCOUT,    
            MoveToCategories = {    
                categories.ENGINEER,
                categories.COMMAND,        
                categories.MASSPRODUCTION + categories.MASSEXTRACTION,    
                categories.ECONOMIC,                                
                categories.EXPERIMENTAL,
                categories.SHIELD,
                categories.ANTIAIR,
                categories.MOBILE,
            },
            WeaponTargetCategories = {                                         
                categories.ENGINEER,
                categories.COMMAND,        
                categories.MASSPRODUCTION + categories.MASSEXTRACTION,                                    
                categories.EXPERIMENTAL,
                categories.MOBILE,
            },
        },
        BuilderConditions = {      
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) - categories.ENGINEER } },                                          
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Bomber/Gunship Unprotected Economic',                            
        PlatoonTemplate = 'AntiGround Bomber/Gunship Small',                          
        Priority = 70,                                                   
        InstanceCount = 3,                                                  
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                      
            AggressiveMove = true,                                        
            AttackEnemyStrength = 0,                                         
            IgnorePathing = false,                                             
            TargetSearchCategory = categories.STRUCTURE + categories.ENGINEER - categories.STATIONASSISTPOD,                 
            MoveToCategories = {  
                categories.ENGINEER,                                              
                categories.MASSEXTRACTION,
                categories.ECONOMIC,  
                categories.SHIELD,
                categories.ANTIAIR,
                categories.ALLUNITS,
            },
            WeaponTargetCategories = {                                          
                categories.MASSEXTRACTION,
                categories.COMMAND,
                categories.ENGINEER - categories.STATIONASSISTPOD,
                categories.SHIELD,
                categories.ANTIAIR,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                   
    },

    Builder {
        BuilderName = 'Swarm T3 Bomber Anti-Mass 1 2',                            
        PlatoonTemplate = 'Swarm T3 Bomber Intercept 1 2',                          
        Priority = 70,                                                   
        InstanceCount = 2,                                                  
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                      
            AggressiveMove = true,                                        
            AttackEnemyStrength = 100,                                         
            IgnorePathing = true,                                             
            TargetSearchCategory = categories.MASSEXTRACTION + categories.COMMAND - categories.TECH1 - categories.STATIONASSISTPOD,                 
            MoveToCategories = {                                              
                categories.MASSEXTRACTION - categories.TECH1,
                categories.ENERGYPRODUCTION - categories.TECH1,
                categories.FACTORY - categories.TECH1,
                categories.ALLUNITS - categories.TECH1,
            },
            WeaponTargetCategories = {                                          
                categories.MASSEXTRACTION,
                categories.COMMAND,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.BOMBER * categories.TECH3 - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                   
    },

    Builder {
        BuilderName = 'Swarm T3 Bomber Snipe 5 10',                            
        PlatoonTemplate = 'Swarm T3 Bomber Intercept 5 10',                          
        Priority = 70,                                                   
        InstanceCount = 1,                                                  
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                      
            AggressiveMove = true,                                        
            AttackEnemyStrength = 100,                                         
            IgnorePathing = true,                                             
            TargetSearchCategory = categories.COMMAND + categories.MASSEXTRACTION - categories.TECH1 - categories.STATIONASSISTPOD,                 
            MoveToCategories = {                                              
                categories.COMMAND,
                categories.SUBCOMMANDER,
                categories.MASSEXTRACTION - categories.TECH1,
                categories.ENERGYPRODUCTION - categories.TECH1,
                categories.FACTORY - categories.TECH1,
                categories.ALLUNITS - categories.TECH1,
            },
            WeaponTargetCategories = {                                          
                categories.MASSEXTRACTION,
                categories.COMMAND,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 10, categories.MOBILE * categories.AIR * categories.BOMBER * categories.TECH3 - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                   
    },

    Builder {
        BuilderName = 'Swarm T3 Bomber Snipe 15 30',                            
        PlatoonTemplate = 'Swarm T3 Bomber Intercept 15 30',                          
        Priority = 70,                                                   
        InstanceCount = 1,                                                  
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = true,                                      
            AggressiveMove = true,                                        
            AttackEnemyStrength = 100,                                         
            IgnorePathing = true,                                             
            TargetSearchCategory = categories.COMMAND + categories.MASSEXTRACTION - categories.TECH1 - categories.STATIONASSISTPOD,                 
            MoveToCategories = {                                              
                categories.COMMAND,
                categories.SUBCOMMANDER,
                categories.MASSEXTRACTION - categories.TECH1,
                categories.ENERGYPRODUCTION - categories.TECH1,
                categories.FACTORY - categories.TECH1,
                categories.ALLUNITS - categories.TECH1,
            },
            WeaponTargetCategories = {                                          
                categories.MASSEXTRACTION,
                categories.COMMAND,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 15, categories.MOBILE * categories.AIR * categories.BOMBER * categories.TECH3 - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                                   
    },
    
    Builder {
        BuilderName = 'Swarm PANIC AntiSea TorpedoBomber',                      
        PlatoonTemplate = 'S123-TorpedoBomber 1 100',
        Priority = 90,                                                       
        InstanceCount = 2,                                           
        BuilderData = {
            SearchRadius = 128,                                     
            GetTargetsFromBase = true,                                     
            AggressiveMove = true,                                              
            AttackEnemyStrength = 300,                          
            IgnorePathing = true,                                             
            TargetSearchCategory = categories.STRUCTURE + categories.MOBILE,  
            MoveToCategories = {                                                
                categories.MOBILE * categories.NAVAL * categories.EXPERIMENTAL,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {        
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.AIR * categories.ANTINAVY - categories.ENGINEER } },                                      
        },
        BuilderType = 'Any',                                                    
    },

    Builder {
        BuilderName = 'Swarm Military AntiSea TorpedoBomber',                  
        PlatoonTemplate = 'S123-TorpedoBomber 1 100',
        Priority = 80,                                                 
        InstanceCount = 3,                                            
        BuilderData = {
            SearchRadius = 256,                                 
            GetTargetsFromBase = false,                         
            AggressiveMove = true,                                      
            AttackEnemyStrength = 150,                                          
            IgnorePathing = true,                                           
            TargetSearchCategory = categories.STRUCTURE + categories.MOBILE,    
            MoveToCategories = {                                              
                categories.MOBILE * categories.NAVAL * categories.EXPERIMENTAL,
                categories.MOBILE * categories.NAVAL * categories.ANTIAIR,
                categories.MOBILE * categories.LAND * categories.EXPERIMENTAL,
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.ANTIAIR,
                categories.MOBILE,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                                   
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 10, categories.MOBILE * categories.AIR * categories.ANTINAVY - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',                                           
    },

    Builder {
        BuilderName = 'Swarm Enemy AntiStructure TorpedoBomber',
        PlatoonTemplate = 'S123-TorpedoBomber 1 100',
        Priority = 70,
        InstanceCount = 2,
        BuilderData = {
            SearchRadius = 256,                                    
            GetTargetsFromBase = false,                                   
            AggressiveMove = true,                                
            AttackEnemyStrength = 150,                                        
            IgnorePathing = true,                                           
            TargetSearchCategory = categories.STRUCTURE + categories.MOBILE,
            MoveToCategories = {                                             
                categories.MOBILE * categories.NAVAL * categories.EXPERIMENTAL,
                categories.MOBILE * categories.NAVAL * categories.ANTIAIR,
                categories.STRUCTURE * categories.NAVAL * categories.FACTORY,
                categories.MOBILE * categories.NAVAL * categories.DEFENSE,
                categories.MOBILE * categories.LAND * categories.EXPERIMENTAL,
                categories.MOBILE * categories.LAND * categories.ANTIAIR,
                categories.ANTIAIR,
                categories.MOBILE,
                categories.ALLUNITS,
            },
        },
        BuilderConditions = {                                      
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.AIR * categories.ANTINAVY - categories.ENGINEER } }, 
        },
        BuilderType = 'Any',
    },
}