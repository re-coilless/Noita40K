--https://developer.roblox.com/en-us/recipes/dijkstra-s-algorithm
local function Dijkstra(start, finish, nodes)
	-- Create a closed and open set
	local open = {}
	local closed = {}
 
	-- Attach data to all nodes without modifying them
	local data = {}
	for _, node in pairs(nodes) do
		data[node] = {
			distance = math.huge,
			previous = nil
		}
	end
 
	-- The start node has a distance of 0 and starts in the open set
	open[start] = true
	data[start].distance = 0
 
	while true do
		-- Pick the nearest open node
		local best = nil
		for node in pairs(open) do
			if not best or data[o].distance < data[best].distance then
				best = o
			end
		end
 
		--at the finish - stop looking
		if best == finish then break end
 
		--all nodes traversed - finish not found! No connection between start and finish
		if not best then return end
 
		--calculate a new score for each neighbour
		for _, neighbor in ipairs(best:neighbors()) do
			--provided it's not already in the closed set
			if not closed[neighbor] then
				local newdist = data[best].distance + best:distanceTo(neighbor)
				if newdist < data[neighbor].distance then
					data[neighbor].distance = newdist
					data[neighbor].previous = best
					open[neighbor] = true -- add newly discovered node to set of open nodes
				end
			end
		end
 
		--move the node to the closed set
		closed[best] = true
		open[best] = nil
	end
 
	--walk backwards to reconstruct the path
	local path = {}
	local at = finish
	while at ~= start do
		table.insert(path, 0, at)
		at = data[at].previous
	end
 
	return path
end

--https://searchcode.com/codesearch/view/28464168/
local tinsert = table.insert;

local Object = getClass("Object");

local _inf = 1/0;

local Dijkstra = class("Dijkstra", Object, 
{
	points = nil,
	graph = nil,
});

function Dijkstra:initialize()
	self.points = {};
	self.graph = {};
end

function Dijkstra:add(p)
	tinsert(self.points, p);
	self.graph[p] = {};
end

function Dijkstra:clear()
	self.points = {};
	self.graph = {};
end

function Dijkstra:dist(sp, ep, dist)
	assert(self.graph[sp]~=nil);
	assert(ep~=nil);
	self.graph[sp][ep] = dist;
end

function Dijkstra:emit(start, distfunc)
	local point_count = #self.points;
	local dist = {};
	local queue = {};
	local road = {};
	
	distfunc = distfunc or function (pv, v)
		return self.graph[pv][v] or 0;
	end
	
	-- ?????
	for i, v in pairs(self.points) do
		dist[v]=_inf;
	end
	dist[start]=0;
	
	-- ?????
	for i, v in pairs(self.points) do
		queue[i] = v;
	end
	
	local queue_count = point_count;
	local function find_min_dist()
		local min = _inf;
		local idx = nil;
		for i, v in pairs(queue) do
			if dist[v] < min then
				min = dist[v];
				idx = i;
			end
		end
		return idx;
	end
	
	while queue_count > 0 do
		local pi = find_min_dist();
		if pi==nil then
			-- ??????
			break;
		end
		local pv = queue[pi];
		
		queue[pi] = nil;
		queue_count = queue_count - 1;
	
		for i, v in pairs(self.points) do
			local rv = distfunc(pv,v);
			if rv>0 and dist[v]>dist[pv]+rv then
				dist[v] = dist[pv]+rv;
				road[v] = pv;
			end
		end
	end
	
	return dist, road;
end

function Dijkstra:path(p, goal)
	local i = goal
	local t = { i }
	while p[i] do
		tinsert(t, 1, p[i])
		i = p[i]
	end
	return t
end

function Dijkstra:getPath(sp, ep, distfunc)
	local _, t = self:emit(sp, distfunc);
	return self:path(t, ep);
end

return Dijkstra;