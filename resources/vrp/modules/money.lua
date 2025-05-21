-----------------------------------------------------------------------------------------------------------------------------------------
-- USERBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userBank(user_id,mode)
	local user_id = parseInt(user_id)
	local bankInfos = vRP.query("bank/getInfos",{ user_id = user_id, mode = mode })
	return bankInfos[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addBank(user_id,amount,mode)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("bank/addValue",{ user_id = user_id, value = amount, mode = mode })

		if vRP.userInfos[user_id] and mode == "Private" then
			vRP.userInfos[user_id]["bank"] = vRP.userInfos[user_id]["bank"] + amount
		end
		local identity = vRP.userIdentity(user_id)
		PerformHttpRequest("https://discord.com/api/webhooks/1129663575212965938/HfTyXqTS2Hcwlvs0EjwE6kwWFcP12JYrCuDkPpxXdIPxn4sy20OK57sjZDkLAjEcAzPf", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**Function: vRP.addBank**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
						{ 
							name = "💸 Valor:", 
							value = " "..amount.."",
						},
						{ 
							name = "📦 Tipo:", 
							value = "" ..mode.."",
						},
					}, 
					footer = { 
						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					thumbnail = { 
						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					color = 3092790
				}
			}
		}), { ['Content-Type'] = 'application/json' })

	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delBank(user_id,amount,mode)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("bank/remValue",{ user_id = user_id, value = amount, mode = mode })

		if vRP.userInfos[user_id] and mode == "Private" then
			vRP.userInfos[user_id]["bank"] = vRP.userInfos[user_id]["bank"] - amount

			if vRP.userInfos[user_id]["bank"] < 0 then
				vRP.userInfos[user_id]["bank"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBank(user_id)
	local user_id = parseInt(user_id)
	if vRP.userInfos[user_id] then
		return vRP.userInfos[user_id]["bank"]
	else
		local identity = vRP.userIdentity(user_id)
		if identity then
			return identity["bank"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getFines(user_id)
	local user_id = parseInt(user_id)
	local hasFines, total = exports.bank:hasFines(user_id)
	return total
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addFines(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		--vRP.execute("characters/addFines",{ id = user_id, fines = amount })

		exports.bank:createFine(user_id, 'Seguro Carro', amount)

		local identity = vRP.userIdentity(user_id)
		PerformHttpRequest("https://discord.com/api/webhooks/1129663901559169185/j7EFQQSVYK0kCwcS7fCM207Gsq-ZB4qFp6HmRpk6Gezmr0LkJBZ6kWhxyRBlTAKguInG", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**Function: vRP.addFines**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
						{ 
							name = "💸 Valor:", 
							value = " "..amount.."",
						},
					}, 
					footer = { 
						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					thumbnail = { 
						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					color = 3092790
				}
			}
		}), { ['Content-Type'] = 'application/json' })

		-- if vRP.userInfos[user_id] then
		-- 	vRP.userInfos[user_id]["fines"] = vRP.userInfos[user_id]["fines"] + amount
		-- end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delFines(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("characters/removeFines",{ id = user_id, fines = amount })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["fines"] = vRP.userInfos[user_id]["fines"] - amount

			if vRP.userInfos[user_id]["fines"] < 0 then
				vRP.userInfos[user_id]["fines"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentGems(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id] then
			if vRP.userGemstone(vRP.userInfos[user_id]["steam"]) >= amount then
				vRP.execute("accounts/removeGems",{ steam = vRP.userInfos[user_id]["steam"], gems = amount })
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentBank(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id] then
			if vRP.userInfos[user_id]["bank"] >= amount then
				vRP.delBank(user_id,amount,"Private")

				local source = vRP.userSource(user_id)
				if source then
					TriggerClientEvent("itensNotify",source,{ "pagou","dollars",parseFormat(amount),"Dólares" })
				end

				local identity = vRP.userIdentity(user_id)
				PerformHttpRequest("https://discord.com/api/webhooks/1129664177695371336/FA9_01fIYYm7i96yV_j96vRM98gZxj7P3DmaobPUSTz_8UWMC4Z7XUOJkSCv6_UL1seE", function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{     
							title = "**Function: vRP.paymentBank**",
							fields = {
								{ 
									name = "📝 Author:", 
									value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
								},
								{ 
									name = "💸 Valor:", 
									value = " "..amount.."",
								},
							}, 
							footer = { 
								text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
								icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							thumbnail = { 
								url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
							},
							color = 3092790
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentFull(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.tryGetInventoryItem(user_id,"dollars",amount,true) then
			return true
		else
			if vRP.userInfos[user_id] then
				if vRP.userInfos[user_id]["bank"] >= amount then
					vRP.delBank(user_id,amount,"Private")

					local source = vRP.userSource(user_id)
					if source then
						TriggerClientEvent("itensNotify",source,{ "pagou","dollars",parseFormat(amount),"Dólares" })
					end

					
					local identity = vRP.userIdentity(user_id)
					PerformHttpRequest("https://discord.com/api/webhooks/1129664351247274034/ASYWAUZLMI5lDABq6zwMipdbJI4kOcAypSuiDJgsDz-xNRvxsETb4eJxtnIo4lJmzwNK", function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{     
								title = "**Function: vRP.paymentFull**",
								fields = {
									{ 
										name = "📝 Author:", 
										value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
									},
									{ 
										name = "💸 Valor:", 
										value = " "..amount.."",
									},
								}, 
								footer = { 
									text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
									icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								thumbnail = { 
									url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
								},
								color = 3092790
							}
						}
					}), { ['Content-Type'] = 'application/json' })

					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.withdrawCash(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id]["bank"] >= amount then
			vRP.generateItem(user_id,"dollars",amount,true)
			vRP.delBank(user_id,amount,"Private")

			local identity = vRP.userIdentity(user_id)
			PerformHttpRequest("https://discord.com/api/webhooks/1129664928274460712/vFPCgo18Bg2_QlvmO7Hdh1-jpyBNXK51bbrXnfC97EDC4LFP0gPjJbCnhUgwWv7ZUMLT", function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{     
						title = "**Function: vRP.withdrawCash**",
						fields = {
							{ 
								name = "📝 Author:", 
								value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
							},
							{ 
								name = "💸 Valor:", 
								value = " "..amount.."",
							},
						}, 
						footer = { 
							text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
							icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						thumbnail = { 
							url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
						},
						color = 3092790
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:GETBANKMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.getBankMoney = vRP.getBank
function vRP.setBankMoney(user_id, amount)
	local dif = amount - vRP.getBank(user_id)
	vRP.execute("bank/addValue",{ user_id, value = dif, mode = 'Private' })
	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["bank"] = amount

		local identity = vRP.userIdentity(user_id)
		PerformHttpRequest("https://discord.com/api/webhooks/1129664750641496075/6SKF5AF9sPp_UQTolmQm-AqOkrXhv3W53znwH7C3MoPQAY7NxuDk8l2kugj4GLiBjXle", function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{     
					title = "**Function: vRP.setBankMoney**",
					fields = {
						{ 
							name = "📝 Author:", 
							value = "" ..identity.name.." "..identity.name2.." **#"..user_id.."** ",
						},
						{ 
							name = "💸 Valor:", 
							value = " "..amount.."",
						},
					}, 
					footer = { 
						text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
						icon_url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					thumbnail = { 
						url = "https://media.discordapp.net/attachments/1094973674437750834/1101630131610591323/512.png"
					},
					color = 3092790
				}
			}
		}), { ['Content-Type'] = 'application/json' })

	end
end