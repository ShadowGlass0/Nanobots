local Queue = require("stdlib/utils/hash_queue")
local interface = {}

function interface.reset_mod(are_you_sure)
    local player_name = game.player and game.player.name or "script"
    if are_you_sure then
        global = {}
        MOD.on_init()
        MOD.log("Full Reset Completed by "..player_name)
    else
        MOD.log("Full reset attempted but "..player_name.." was not sure")
    end
end

function interface.reset_queue(queue)
    queue = queue or "nano_queue"
    MOD.log("Resetting "..queue, 2)
    if global[queue] then
        global[queue] = Queue.new()
        for _, player in pairs(global.players) do
            player._next_nano_tick = 0
        end
    end
end

function interface.count_queue(queue)
    queue = queue or "nano_queue"
    local a, b = Queue.count(global[queue])
    MOD.log("Queued:"..a.." Hashed:"..b, 2)
end

function interface.get_queue(queue)
    queue = queue or "nano_queue"
    if global[queue] then
        return(global.nano_queue)
    end
end

function interface.add_to_queue(queue, data, tick)
    queue = queue or "nano_queue"
    if global[queue] and tick and data and type(data) =="table" and data.action then
        Queue.insert(global[queue], data, tick)
        return true
    end
end

function interface.print_global(name)
    if name and type(name) == "string" then
        game.write_file("/Nanobots/global.lua", name.."="..serpent.block(global[name], {nocode=true, sortkeys=true, comment=false, sparse=true}))
    else
        game.write_file("/Nanobots/global.lua", serpent.block(global, {nocode=true, sortkeys=true, comment=false, sparse=true}))
    end
end

function interface.print_settings()
    local tab = {startup = {}, global = {}, user = {}}
    for _, group in pairs({"startup", "global"}) do
        for name, setting in pairs(settings[group]) do
            tab[group][name] = setting.value
        end
    end
    game.write_file("/Nanobots/settings.lua", serpent.block(tab, {nocode = true, sortkeys = true, comment = false, sparse = true}))
end
interface.console = require("stdlib/utils/console")

--Register with creative-mode for easy testing
function interface.creative_mode_register()
    if remote.interfaces["creative-mode"] and remote.interfaces["creative-mode"]["register_remote_function_to_modding_ui"] then
        remote.call("creative-mode", "register_remote_function_to_modding_ui", MOD.if_name, "print_global")
        remote.call("creative-mode", "register_remote_function_to_modding_ui", MOD.if_name, "console")
    end
end

return interface
