from libqtile.config import Screen
from bar import create_bar

screens = [Screen(top=create_bar())]
