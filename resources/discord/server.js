const Discord = require('discord.js')
const client = new Discord.Client({ intents: ["Guilds", "GuildMembers", "GuildPresences", "MessageContent"], partials: [Discord.Partials.Channel], failIfNotExists: false })
const config = require('./config.json')

client.on("ready", async () => {
    console.log(`^2[BOT] ^7Autenticado como: ${client.user.tag} (${client.user.id})`)

    exports("guildMemberRoleAdd", guildMemberRoleAdd)
    exports("guildMemberRoleRemove", guildMemberRoleRemove)
    exports("guildMemberGetRoles", guildMemberGetRoles)
    exports("guildMemberBooster", guildMemberBooster)
    exports("guildMemberBanAdd", guildMemberBanAdd)
    exports("guildMemberGetInfo", guildMemberGetInfo)
    exports("userGetInfo", userGetInfo)

    async function guildMemberRoleAdd(guild, member, role_id) {
        try {
            await client.guilds.cache.get(guild).members.cache.get(member).roles.add(role_id)
            return true
        } catch (error) {
            return false
        }
    }

    async function guildMemberRoleRemove(guild, member, role_id) {
        try {
            await client.guilds.cache.get(guild).members.cache.get(member).roles.remove(role_id)
            return true
        } catch (error) {
            return false
        }
    }

    async function guildMemberGetRoles(guild, member) {
        try {
            await client.guilds.cache.get(guild).members.cache.get(member).roles.cache.toJSON()
            return true
        } catch (error) {
            console.log(error)
            return false
        }
    }

    async function guildMemberBooster(guild, member) {
        return client.guilds.cache.get(guild).members.cache.get(member).roles.cache.has('1021550344263712829')
    }

    async function guildMemberBanAdd(guild, member, reason) {
        try {
            await client.guilds.cache.get(guild).members.cache.get(member).ban({ reason: reason })
            return true
        } catch (error) {
            return false
        }
    }

    async function guildMemberGetInfo(guild, member) {
        try {
            await client.guilds.cache.get(guild).members.cache.get(member).toJSON()
            return true
        } catch (error) {
            return false
        }
    }

    async function userGetInfo(user) {
        try {
            await client.users.cache.get(user).toJSON()
            return true
        } catch (error) {
            return false
        }
    }


})

client.login(config.token).catch(async err => {
    return console.log(`^8[ERROR] ^1${err}`)
})