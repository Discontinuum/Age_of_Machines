local colors = { ---blue = args.ge_blue ,
		 numbers = '#f5e6c1' ,
		 detail_dark = '#a69275' ,
		 red = '#fa8c50',
		 gray = '#808080' }


local function production(side, resource)
	local var_name = resource .. "_factory"
	local len = wml.variables[var_name .. ".length"]
	local prod = 0
	for i=0,(len - 1) do
		local factory = wml.variables[var_name .. "[".. i .."]"]
		if wesnoth.map.get_owner(factory) == side then
			prod = prod + factory[resource]
		end
	end
	return prod
end

function wesnoth.interface.game_display.metal()
	-- Display for the viewing side, not the current side
	local viewing_side = wesnoth.interface.get_viewing_side()

	local side_proxy = wesnoth.sides[viewing_side]
	local mtl = side_proxy["variables"]["metal_reserve"] or 0
	local str = mtl .. " (+" .. production (viewing_side, "metal") .. ")"
	--if (viewing_side ~= wesnoth.current.side) then
	--	str = "<span color='" .. colors.gray .. "'>" .. str .. "</span>"
	--end

	return { { 'element', {
		text = str,
		tooltip = "The side's metal reserve"
	} } }

end

function wesnoth.interface.game_display.coal()
	-- Display for the viewing side, not the current side
	local viewing_side = wesnoth.interface.get_viewing_side()

	local mtl = wml["variables"]["coal_reserve" .. viewing_side] or 0
	local str = mtl .. " (+" .. production (viewing_side, "coal") .. ")"
	--if (viewing_side ~= wesnoth.current.side) then
	--	str = "<span color='" .. colors.gray .. "'>" .. str .. "</span>"
	--end

	return { { 'element', {
		text = str,
		tooltip = "The side's coal reserve"
	} } }

end
