### PSReadLine Options ###
set-psreadlineoption -predictionsource history


### User Aliases ###
# Force Remove file/folder
function rmf([string]$name)
{
	Remove-Item -Force -Recurse $name
}

# Open File Explorer in Current Directory
function explore { explorer.exe . }

# Import Developer Powershell Module into current session
function devps { Import-Module 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/Common7/Tools/Microsoft.VisualStudio.DevShell.dll'; Enter-VsDevShell 15b862ee }


### MODULES ###
# Show Colors in ls command
Import-Module Get-ChildItemColor

# Starship Prompt
$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
$ENV:STARSHIP_DISTRO = "者"
Invoke-Expression (&starship init powershell)

# Zoxide(z utility to change directory)
#Invoke-Expression (& {
#    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
#    (zoxide init --hook $hook powershell) -join "`n"
#})

# Load Current Directory to Path
# $env:path ="$($env:path);."
