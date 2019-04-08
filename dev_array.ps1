# Description: Boxstarter Script  
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"
choco install -y Microsoft-Hyper-V-All --source="'windowsfeatures'"

#--- Configuring Windows properties ---
#--- Windows Features ---
Set-TaskbarSmall
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
# open file explorer to "this pc"
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
# Show taskbar on all monitors
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarEnabled  -Value 1
# Show taskbar buttons on taskbar where window is open
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Enabling developer mode on the system ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

#--- Ubuntu ---
#Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
#Add-AppxPackage -Path ~/Ubuntu.appx

#-- set up folder paths
if (!(Test-Path -Path C:\Array )) {
  mkdir C:\Array
}

if (!(Test-Path -Path C:\Tools )) {
  mkdir C:\Tools
}

if (!(Test-Path -Path C:\Array\vso )) {
  mkdir C:\Array\vso
}

if (!(Test-Path -Path C:\Array\plastic )) {
  mkdir C:\Array\platic
}

if (!(Test-Path -Path C:\Array\plastic\central )) {
  mkdir C:\Array\platic\central
}

if (!(Test-Path -Path C:\Array\plastic\local )) {
  mkdir C:\Array\platic\local
}

#--- VS 2017 uwp and azure workloads + git tools ---
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Professional
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community 
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
choco install -y visualstudio2017professional --package-parameters "--add Microsoft.VisualStudio.Workload.CoreEditor --add Microsoft.VisualStudio.Workload.Azure --add Microsoft.VisualStudio.Workload.NetCoreTools --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.Net.ComponentGroup.TargetingPacks.Common --add Microsoft.Component.Azure.DataLake.Tools --add Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices --add Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.ComponentGroup.Web.CloudTools --add Microsoft.VisualStudio.Component.AppInsights.Tools --add Microsoft.VisualStudio.Component.Wcf.Tooling --add Microsoft.Net.Component.4.6.2.SDK --add Microsoft.Net.Component.4.7.SDK --add Microsoft.Net.Component.4.7.1.SDK --add Microsoft.Net.Component.4.6.2.TargetingPack --add Microsoft.Net.Component.4.7.TargetingPack --add Microsoft.Net.Component.4.7.1.TargetingPack --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools --add Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools --add Microsoft.VisualStudio.Component.Azure.Storage.AzCopy --add Microsoft.VisualStudio.Component.AspNet45 --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.Component.Azure.Waverton --add Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools --add Microsoft.VisualStudio.Component.TypeScript.2.1 --add Microsoft.VisualStudio.Component.TypeScript.2.2 --add Microsoft.VisualStudio.Component.TypeScript.2.5 --add Microsoft.VisualStudio.Component.TypeScript.2.6 --add Microsoft.VisualStudio.Component.TestTools.Core --add Microsoft.VisualStudio.Component.Git --remove Component.Redgate.SQLSearch.VSExtension --remove Component.Dotfuscator --remove Microsoft.ComponentGroup.Blend --remove Microsoft.Component.HelpViewer"
RefreshEnv

choco install chocolatey-visualstudio.extension
RefreshEnv

choco install -y KB2919355 KB2919442 KB2999226 KB3033929 KB3035131 chocolatey-windowsupdate.extension chocolatey-core.extension vcredist140 vcredist2010 vcredist2015
RefreshEnv

choco install -y git --package-parameters="'/GitOnlyOnPath /WindowsTerminal'"
RefreshEnv
# fonts
choco install -y inconsolata FiraCode
choco install -y googlechrome Firefox
RefreshEnv

choco install -y 7zip 7zip.install curl cmder  kdiff3 keepass nodejs paint.net notepadplusplus poshgit microsoft-teams jdk8
choco install -y SourceTree resharper sysinternals yarn slack
RefreshEnv

choco install -y visualstudiocode
RefreshEnv

code --install-extension aureliaeffect.aurelia
code --install-extension behzad88.aurelia
code --install-extension steoates.autoimport
code --install-extension jerryhong.autofilename
code --install-extension ms-vscode.azure-account
code --install-extension ms-azuretools.vscode-azureappservice
code --install-extension ms-vscode.azurecli
code --install-extension ms-vscode.csharp
code --install-extension fknop.vscode-npm
code --install-extension alefragnani.project-manager
code --install-extension xabikos.javascriptsnippets
code --install-extension christian-kohler.npm-intellisense
code --install-extension robertohuertasm.vscode-icons
code --install-extension eg2.tslint
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge


npm install -g aurelia-cli
npm install -g autorest
npm install -g bower
npm install -g dts
npm install -g yo generator-aspnet generator-docker
npm install -g gulp gulp-cli gulp-notify
npm install -g grunt grunt-cli
npm install -g jspm
npm install -g npm-windows-upgrade
npm install -g semistandard
npm install -g ts-node
npm install -g swagger-cli
npm install -g typescript
npm install -g typings
npm install -g selenium-standalone

#-- set up folder paths
if (!(Test-Path -Path C:\Temp )) {
  mkdir C:\Temp
}

# set up vscode settings
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/vscode-keybindings.json" -OutFile "$env:APPDATA/Code/User/keybindings.json"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/vscode-settings.json" -OutFile "$env:APPDATA/Code/User/settings.json"

# set up vs studio base settings (basically fonts and files binds)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/array-base-VS.vssettings" -OutFile "C:/Temp/User/array-base-VS.vssettings"

# setup Cmder
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/Scripts/LSPadded.ps1" -OutFile "C:/tools/cmder/config/Scripts/LSPadded.ps1"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/Scripts/New-CommandWrapper.ps1" -OutFile "C:/tools/cmder/config/Scripts/New-CommandWrapper.ps1"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/Scripts/Write-Color-LS.ps1" -OutFile "C:/tools/cmder/config/Scripts/Write-Color-LS.ps1"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/ConEmu.xml" -OutFile "C:/tools/cmder/config/ConEmu.xml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/settings" -OutFile "C:/tools/cmder/config/settings"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/user-ConEmu.xml" -OutFile "C:/tools/cmder/config/user-ConEmu.xml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/user-profile.ps1" -OutFile "C:/tools/cmder/config/user-profile.ps1"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/Write-Color-LS.ps1" -OutFile "C:/tools/cmder/config/Write-Color-LS.ps1"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/cmder-configs/vendor-profile.ps1" -OutFile "C:/tools/cmder/vendor/profile.ps1"

# setup git
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/array-analytics/windows-dev-box-setup-scripts/master/gitsettings/.gitconfig" -OutFile "$env:USERPROFILE/.gitconfig"


#need to figure out how to install vsix
# https://marketplace.visualstudio.com/items?itemName=MadsKristensen.ASPNETCoreTemplatePack20173
# https://marketplace.visualstudio.com/items?itemName=MadsKristensen.WebExtensionPack2017
# https://marketplace.visualstudio.com/items?itemName=MadsKristensen.TrailingWhitespaceVisualizer
# https://marketplace.visualstudio.com/items?itemName=MadsKristensen.NPMTaskRunner
# https://marketplace.visualstudio.com/items?itemName=MadsKristensen.ignore
# https://marketplace.visualstudio.com/items?itemName=VisualStudioProductTeam.ProductivityPowerPack2017
# and this: http://mike-ward.net/vscoloroutput/



# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0



#--- Remove windows "features"
# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# BubbleWitch
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage
Get-AppxPackage flaregamesGmbH.RoyalRevolt2 | Remove-AppxPackage

Get-AppxPackage *FarmVille2CountryEscape* | Remove-AppxPackage
Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *MSPaint* | Remove-AppxPackage
Get-AppxPackage *Netflix* | Remove-AppxPackage
Get-AppxPackage *photos* | Remove-AppxPackage
Get-AppxPackage *PandoraMediaInc* | Remove-AppxPackage
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxOneSmartGlass* | Remove-AppxPackage
Get-AppxPackage *xboxapp* | Remove-AppxPackage
# Zune Music, Movies & TV
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
# March of Empires
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage
# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
# Disney Magic Kingdom
Get-AppxPackage *DisneyMagicKingdom* | Remove-AppxPackage

# Hidden City: Hidden Object Adventure
Get-AppxPackage *HiddenCityMysteryofShadows* | Remove-AppxPackage




# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
  New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# WiFi Sense: HotSpot Sharing: Disable
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
  New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0


# install the temp settings
devenv /ResetSettings "C:/Temp/User/array-base-VS.vssettings"

#install templates for dotnetnew
dotnet new --install "Microsoft.AspNetCore.SpaTemplates"
dotnet new --install "Microsoft.DotNet.Web.Spa.ProjectTemplates"
dotnet new --install "IdentityServer4.Templates"
dotnet new --install "Boilerplate.Templates"
dotnet new --install "Microsoft.AspNetCore.Blazor.Templates"
dotnet new --install "MadsKristensen.AspNetCore.Web.Templates::*"

# this requires interaction
choco install notepadreplacer

Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx

RefreshEnv
Ubuntu1804 install --root
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y


#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
