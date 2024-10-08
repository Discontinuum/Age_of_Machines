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

function wesnoth.interface.game_display.gold()
	-- Display for the viewing side, not the current side
	local viewing_side = wesnoth.interface.get_viewing_side()

	local side_proxy = wesnoth.sides[viewing_side]
	local val = side_proxy.gold or 0
	local income = side_proxy.net_income or 0
	local sign = "+"
	if income < 0 then
		sign = ""
	end
	local str = val .. " (" .. sign .. income .. ")"

	return { { 'element', {
		text = str,
		tooltip = "<b>Gold</b>: "..val.."\n<b>Income</b>: ".. sign .. income .. "\nWith gold you buy new units and pay upkeep for units on the board. To increase your income, capture villages."

	} } }

end

function wesnoth.interface.game_display.income()
	-- Display for the viewing side, not the current side
	local viewing_side = wesnoth.interface.get_viewing_side()

	local side_proxy = wesnoth.sides[viewing_side]
	local val = side_proxy["variables"]["economy"] or 0
	local prod = production (viewing_side, "economy")
	local str = val .. " (+" .. prod .. ")"
	--if (viewing_side ~= wesnoth.current.side) then
	--	str = "<span color='" .. colors.gray .. "'>" .. str .. "</span>"
	--end

	return { { 'element', {
		text = str,
		tooltip = "<b>economy</b>: "..val.."\n<b>economy production</b>: +" .. prod .. "\neconomy is needed for most of attacks. To get more economy, capture economy factories"

	} } }

end

function wesnoth.interface.game_display.expenses()
	-- Display for the viewing side, not the current side
	local viewing_side = wesnoth.interface.get_viewing_side()

	local side_proxy = wesnoth.sides[viewing_side]
	local val = side_proxy["variables"]["coal_reserve"] or 0
	local prod = production (viewing_side, "coal")
	local str = val .. " (+" .. prod .. ")"

	return { { 'element', {
		text = str,
		tooltip = "<b>Coal</b>: "..val.."\n<b>Coal production</b>: +" .. prod .. "\nCoal is needed for machines to be able to move. To get more coal, capture coal factories"
	} } }

end
