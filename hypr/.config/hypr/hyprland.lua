local terminal = "alacritty"
local menu = "hyprlauncher"

hl.on("hyprland.start", function ()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("waybar")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("hyprpaper")
end)

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
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1"})
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1"})
for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2"})
end

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("LIBVA_DRIVER", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.config({
  general = {
    layout = "dwindle",
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
          active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
          inactive_border = "rgba(595959aa)",
    },

    resize_on_border = false,
    allow_tearing = false,
  },
  decoration = {
    rounding = 10,
    rounding_power = 2,

    -- change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    }
  },
  animations = {
    enabled = true,
  },
  input = {
    kb_layout = 'us',

    follow_mouse = 1,
    sensitivity = 0.0,
  },
  -- master = {
  --  new_status = "master"
  -- },
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} }})
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} }})
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} }})
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} }})
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} }})

local animations = {
  { leaf = "global", enabled = true, speed = 10, bezier = "default" },
  { leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" },
  { leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" },
  { leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" },
  { leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" },
  { leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" },
  { leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" },
  { leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" },
  { leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" },
  { leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" },
  { leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" },
  { leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" },
  { leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" },
  { leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" },
  { leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" },
  { leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" },
  { leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" },
}

for _, item in ipairs(animations) do
  hl.animation(item)
end

-- keybinds
local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
-- don't have a filemanager currently
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- app launcher
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

-- Move focus with mainMod + hjkl keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Swap active window
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.swap({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


