import asyncio

import discord
from discord import Intents

from bot import *

intents = Intents.all()
client = Bot(command_prefix='s!', intents=intents, case_insensitive=True)


async def main() -> None:
    async with client:
        await client.add_cog(BotEvents(client=client))
        await client.add_cog(BotCommands(client=client))
        client.activity = discord.Game('Under reconstruction')
        await client.start(token)


asyncio.run(main())
