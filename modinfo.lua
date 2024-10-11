name = "Don't attack beefalo"
description = ""
author = "Dollgirl"
version = "0.02"
forumthread = ""
api_version_dst = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true
all_clients_require_mod = false
client_only_mod = true

folder_name = folder_name or "Don't attack beefalo"
if not folder_name:find("workshop-") then
    name = name.." -dev"
end

local function BuildNumConfig(start_num, end_num, step)
    local num_table = {}
    local iterator = 1
    for i = start_num, end_num, step do
        num_table[iterator] = {description = i, data = i}
        iterator = iterator + 1
    end
    return num_table
end
