script_author('deffix | Denis_Mansory')
require 'lib.moonloader'
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampRegisterChatCommand('sms', 
    function(args)
        if args then
            if args:match('^%d+ .+') then
                local id, text = args:match('(%d+) (.+)')
                if #text > 70 then
                    local text_70 = text:sub(1, 70)
                    sampSendChat('/sms ' .. id .. ' ' .. text_70 .. '...')
                    local next_text = text:sub(71, #text)
                    sampSendChat('/sms ' .. id .. ' ...' .. next_text)
                else
                    sampSendChat('/sms ' .. id .. ' ' .. text)
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