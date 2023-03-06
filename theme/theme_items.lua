local colors = { ---blue = args.ge_blue ,
		 numbers = '#f5e6c1' ,
		 detail_dark = '#a69275' ,
		 red = '#fa8c50',
		 gray = '#808080' }

---------------
-- Metal
---------------


function wesnoth.interface.game_display.metal()
	-- Display research points for the viewing side, not the current side
	local viewing_side = wesnoth.interface.get_viewing_side()

	-- Find the existing research points of the side
	local side_proxy = wesnoth.sides[viewing_side]
	local mtl = side_proxy["variables"]["metal_reserve"] or 0
	local str = mtl --research_points .. ' RP (+' .. rp_production .. ')'
	if (viewing_side ~= wesnoth.current.side) then
		str = "<span color='" .. colors.gray .. "'>" .. str .. "</span>"
	end

	return { { 'element', {
		text = str,
		tooltip = "The side's metal reserve"
	} } }

end
