local M = {}

-- Dev layout (LEADER+d): nvim (top-left) | claude (top-right) / terminal (bottom, full width)
function M.dev_layout(_, pane)
	pane:split({ direction = "Bottom", size = 0.3 })
	pane:split({ direction = "Right", size = 0.3 }):send_text("claude\n")
	pane:send_text("nvim .\n")
	pane:activate()
end

return M
