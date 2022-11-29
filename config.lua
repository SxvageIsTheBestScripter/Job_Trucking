Config = {}
-- The amount of money the player will recieve.
Config.Pay = 750

-- Set the truck models that a player can use for the job
Config.TruckModel = {
    'phantom',
}

-- Set the location of the blip where the depot location is
Config.BlipLocation = { x = 346.05, y = 3407.15,  z = 35.5 }

-- Set the location where you want the depot to be
Config.DepotLocation = { x = 334.67, y = 3411.53,  z = 36.65,  h = 292.12 }

-- Set all the posible locations for the trailers to spawn at
Config.TrailerLocations = {
    { x = 167.69,  y = 2756.53,  z = 43.39, h = 239.22 }, -- Small warehouse on Joshua Rd (4014)
    { x = 648.13, y = 2763.6, z = 41.97, h = 184.53 }, -- Harmony Suburban (4020)
    { x = 302.3, y = 2833.88, z = 43.45, h = 305.92 }, -- Harmony Cement Factory (4014)
    { x = 1374.99, y = 3611.88,  z = 34.89,  h = 199.46 }, -- Ace Liquor (3026)
    { x = 2327.29, y = 3138.91, z = 48.17, h = 79.8 }, -- Cat-Claw Ave Recycling Center (3048)
    { x = 2672.65, y = 3517.07, z = 52.71, h = 333.39 }, -- YouTool (3052)
    { x = 2895.51, y = 4381.8, z = 50.38, h = 287.41 }, -- Union Grain Supply Inc (2050)
    { x = 1714.21, y = 4807.46, z = 41.8, h = 101.8 } -- Wonderama Arcade (2010)
}

-- Set all the posible locations for the trailers to be devilveres to
Config.Destinations = {
    { x = -3169.63, y = 1102.37, z = 20.74 }, -- Chumash Plaza (5033)
    { x = 31.54, y = 6287.21, z = 31.24 }, -- Cluckin Bell Factory (1021)
    { x = -360.2, y = 6073.27, z = 31.5 }, -- Paleto Bay Market (1036)
    { x = 3640.62, y = 3766.41, z = 28.52 }, -- Humane Labs (2060)  
    { x = 2525.09, y = 2625.93, z = 37.94 }, -- Rex's Diner (3056)
    { x = 2790.15, y = 1408.84, z = 24.44 }, -- Palmer-Taylor Power Station (3063)
    { x = 2551.89, y = 438.54, z = 108.45 }, -- Route 15 Gas Station (7355)
    { x = -1664.99, y = 3121.59, z = 31.72 }, -- Fort Zancudo (5005)
    { x = 1531.33, y = 784.24, z = 77.44 }, -- LS Freeway (7357)
    { x = 789.08, y = 1289.67, z =  360.3}, -- Mt Haan Dr (5025)
    { x = 974.03, y = 3.9, z = 81.04 }, -- Casino (7292) 
    { x = -2030.78, y = -262.44, z = 23.39 }, -- The Jetty Hotel (7009)
    { x = -2962.85, y = 60.93, z =  11.61 }, -- Pacific Bluffs Country Club (5062)
    { x = -802.16, y = 5409.08, z = 33.86 } -- GOH Paleto Forest (1083)
}

-- Set all the posible trailers the player can get to transport to the destination
Config.TrailerModels = {
    'docktrailer',
    'tr4',
    'trailers',
    'trailers2',
    'trailers3',
    'trailers4',
    'trailerlogs',
    'tanker',
    'tanker2'
}
