local BaseInteractionExtSetContourOriginal = BaseInteractionExt.set_contour

function BaseInteractionExt:set_contour(color, opacity)
	if self._unit:carry_data() then 
		-- log("Setting contour for carry: " .. self._unit:carry_data():carry_id())

		if self._unit:carry_data():carry_id() == "person" then
			tweak_data.contour.interactable.bodybag = Vector3(1, 0, 1) -- Purple

			if color ~= "selected_color" then
				color = "bodybag"
			end
		end
	end

	BaseInteractionExtSetContourOriginal(self, color, opacity)
end
