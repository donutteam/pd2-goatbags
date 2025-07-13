local PlayerManagerServerDropCarryOriginal = PlayerManager.server_drop_carry
local PlayerManagerSyncCarryDataOriginal = PlayerManager.sync_carry_data

-- Handle contour reset for bodybags
function PlayerManager:bc_reset_contour(unit, carry_id)
	if unit and carry_id then
		log("Resetting contour for carry: " .. carry_id)
		if carry_id == "person" then
			tweak_data.contour.interactable.bodybag = Vector3(1, 0, 1) -- Purple
			unit:interaction():set_contour("bodybag", 1)
		end
	end
end


-- Hook into the original server_drop_carry method to reset contour
function PlayerManager:server_drop_carry(carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, rotation, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer)
	local unit = PlayerManagerServerDropCarryOriginal(
		self,
		carry_id,
		carry_multiplier,
		dye_initiated,
		has_dye_pack,
		dye_value_multiplier,
		position,
		rotation,
		dir,
		throw_distance_multiplier_upgrade_level,
		zipline_unit,
		peer
	)

	self:bc_reset_contour(unit, carry_id)

	return unit
end

-- Hook into the original sync_carry_data method to reset contour
function PlayerManager:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit)
	PlayerManagerSyncCarryDataOriginal(
		self,
		unit,
		carry_id,
		carry_multiplier,
		dye_initiated,
		has_dye_pack,
		dye_value_multiplier,
		position,
		dir,
		throw_distance_multiplier_upgrade_level,
		zipline_unit
	)

	self:bc_reset_contour(unit, carry_id)

	return unit
end
