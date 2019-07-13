local discord = "http://discord.gg/ZAWwHeK"
Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(599683279100182538)
		SetDiscordRichPresenceAsset('namelesslogo')
        SetDiscordRichPresenceAssetText('Nameless Roleplay')
		SetRichPresence(discord)
		Citizen.Wait(60000)
	end
end)
