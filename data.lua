local NANO = require("config")
require("stdlib/string")
require("stdlib/table")
require("stdlib/defines/color")
require("stdlib/defines/time")

--Custom GUI's
require("prototypes/gui")

--Custom hotkeys

--Custom virtual signals
require("prototypes/signals")

--Custom Technologies
require("prototypes/technology/nano-range")
require("prototypes/technology/nano-speed")
require("prototypes/technology/nanobots")

--Modular Equipment, When inserted into an equipment grid will automaticly mark items on ground for deconstruction
require("prototypes/equipment/equipment-bot-chip-items")
require("prototypes/equipment/equipment-bot-chip-trees")
require("prototypes/equipment/equipment-bot-chip-launcher")
require("prototypes/equipment/equipment-bot-chip-nanointerface")
require("prototypes/equipment/equipment-bot-chip-feeder")
require("prototypes/equipment/belt-immunity-equipment")

--Gun, When equipped and selected will automaticly revive ghosts around it
require("prototypes/gun-nano-emitter")

--Ammo for nano guns
require("prototypes/ammo/proxies")
require("prototypes/ammo/constructors")
require("prototypes/ammo/termites")

--Roboport reprogramming interface
require("prototypes/roboport-interface")

--Sounds
require("prototypes/sounds")

if NANO.DEBUG then
    data.raw["furnace"]["stone-furnace"].max_health = 10000
    local debug_prototypes = require("stdlib/debug/prototypes")
    debug_prototypes.make_chunk_markers("Nanobots")
end
