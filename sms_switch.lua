script_author('deffix | Denis_Mansory')
require 'lib.moonloader'
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampRegisterChatCommand('sms', 
    function(args)
        if args then
            if args:match('.+ .+') then 
                local id, text = args:match('^(.+) (.+)')
                local function find_player_part_nick(part)
                    local search = -1
                    for i = 0, sampGetMaxPlayerId(false) do
                        if sampIsPlayerConnected(i) then
                            if sampGetPlayerNickname(i):lower():find('^' .. part:lower()) and not sampIsPlayerNpc(i) then
                                search = i
                                break
                            end
                        end
                    end
                    return search
                end
                if not id:find('%d+') and id:match('%S+') then
                    id = find_player_part_nick(id)
                end
                local max_len = 110 - (20 + #sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))):gsub("%[.+%]", ""))
                if #text <= max_len then
                    sampSendChat('/sms ' .. id .. ' ' .. text)
                else
                    local parts = {}
                    local pos = 1
                    local part = text:sub(pos, pos + max_len - 1)
                    table.insert(parts, part)
                    pos = pos + max_len
                    while pos <= #text do
                        local part_len = (#text - pos + 1 > max_len) and max_len or #text - pos + 1
                        part = text:sub(pos, pos + part_len - 1)
                        table.insert(parts, part)
                        pos = pos + part_len
                    end
                    if #parts > 1 then
                        sampSendChat('/sms ' .. id .. ' ' .. parts[1] .. '...')
                    else
                        sampSendChat('/sms ' .. id .. ' ' .. parts[1])
                    end
                    for i = 2, #parts do
                        local add_to_next = (i == #parts) and "" or "..."
                        sampSendChat('/sms ' .. id .. ' ' .. parts[i] .. add_to_next)
                    end
                end
            else
                sampAddChatMessage('{FF66FF}[sms_switch]: {FFFFFF}Вы не ввели сообщение или не указали айди, кому хотите отправить смс!', -1)
            end
        else
            sampAddChatMessage('{FF66FF}[sms_switch]: {FFFFFF}Вы не ввели сообщение или не указали айди, кому хотите отправить смс!', -1)
        end
    end)
    while true do
        wait(0)
    end
end
