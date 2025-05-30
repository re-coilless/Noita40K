-- Custom pathfinding moves agent to the location,
-- selects the target and enables vanilla ai with nessesary overrides to fight,
-- after target is terminated new enemy is selected or vanilla ai is disabled and pathfinding takes control

-- determine new endpoint (if no endpoint then switch to vanilla ai)
-- built path
-- navigate the pass (if threat detected then switch to vanilla ai)
-- determine target

-- build graph-map with checks for reach
-- apply dijkstra algorithm

-- use perfect cycle-like polygons with raycasts as edges to implement check-waves
-- use surface normal combined with slightly diverged raycast and compare results with line formula to check surface polygons for vertices