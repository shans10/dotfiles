from libqtile.config import Group, Match

groups = [
    Group(name="1", label="1"),
    Group(name="2", label="2"),
    Group(name="3", label="3"),
    Group(name="4", label="4", matches=[Match(wm_class="firefox")]),
    Group(name="5", label="5"),
    Group(name="6", label="6"),
    Group(
        name="7",
        label="7",
        matches=[Match(wm_class="discord"), Match(wm_class="TelegramDesktop")],
    ),
    Group(name="8", label="8", matches=[Match(title="Spotify")]),
    Group(name="9", label="9"),
]
