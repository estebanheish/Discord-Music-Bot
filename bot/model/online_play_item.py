from discord import Message
from typing import Optional
from bot.model import BasePlayItem


class OnlinePlayItem(BasePlayItem):
    def __init__(
            self,
            message: Message,
            length: int,
            path: str,
            title: Optional[str] = '',
            thumbnail: Optional[str] = '',
            video_url: Optional[str] = ''
    ):
        super().__init__(message=message, length=length, path=path)
        self.title: str = title
        self.thumbnail: str = thumbnail  # URL for thumbnail.
        self.video_url: str = video_url  # Original URL for video.
