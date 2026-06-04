local terminal = "alacritty"
local menu = "hyprlauncher"

hl.exec_once("systemctl --user start hyprpolkitagent")
hl.exec_once("waybar")
hl.exec_once("hypridle")
hl.exec_once("hyprpaper")

-- monitors
hl.monitor({
  output = "DP-2",
  mode = "3840x2160",
  position = "1440x1440",
  scale = 1.5
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "3840x1440",
  position = "0x0",
  scale = 1,
  transform = 3
})

-- workspaces
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1"})
for i = 3, 10 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2"})
end

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("LIBVA_DRIVER", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
