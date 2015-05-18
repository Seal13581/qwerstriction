/////////////////////////////////
////Warning:piece of shit code///
/////////////////////////////////
////[QWERSTRICTION] by Seal13581/
/////////////////////////////////

-- http://steamcommunity.com/sharedfiles/filedetails/?id=442284822

-- Seal13581 steam http://steamcommunity.com/id/13581/

net.Receive("QwerstriErrorMessage",function()
chat.AddText(Color(0,200,0),"[QWERSTRICTION]  ",Color(218,165,32),net.ReadString().." is banned from your group")
end)
concommand.Add("QwerStriErrorMessagehint",function()
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32)," you have reached the limit")
end)
openedtpurs=false
function qwerstriction()
if IsValid(MainWindow) then
MainWindow:SetVisible(true) openedtpurs=true  return 
end
openedtpurs=true
MainWindow=vgui.Create("DFrame")
MainWindow:SetSize(540,440)
MainWindow:SetPos(ScrW()/2-540/2,ScrH()/2-440/2)
MainWindow:MakePopup()
MainWindow:SetTitle("")
MainWindow:ShowCloseButton(false)
MainWindow:SetKeyboardInputEnabled(false)
MainWindow.Paint=function(self)
draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(50,50,50,235))
draw.DrawText("[QWERSTRICTION]","HUDSELECTIONTEXT",250,10,Color(255,255,255,255),TEXT_ALIGN_CENTER)
end
local vkladki=vgui.Create("DPropertySheet",MainWindow)
vkladki:Dock(FILL)
-- ban/list weapon VGUI elements
local Weapons = vgui.Create( "DPanel",vkladki)
vkladki:AddSheet("Weapons",Weapons,"icon16/gun.png")
local podvkladkawep=vgui.Create( "DFrame",Weapons)
podvkladkawep:Dock(FILL)
podvkladkawep:SetTitle("Ban weapons for each group")
podvkladkawep:ShowCloseButton(false)
local weps=vgui.Create("DPropertySheet",podvkladkawep)
weps:Dock(FILL)
local WepBan=vgui.Create( "DPanel",weps)
weps:AddSheet("Ban weapon",WepBan,"icon16/stop.png")
local MassWeaponBan=vgui.Create("DPanel",weps)
weps:AddSheet("Mass weapon ban",MassWeaponBan,"icon16/delete.png")
local WepList2=vgui.Create("DPanel",weps)
weps:AddSheet("Remove weapon",WepList2,"icon16/accept.png")
-- ban/list weapon VGUI elements
// settings weapons ban and remove
local Form1=vgui.Create("DTextEntry",WepBan)
Form1:SetPos(5,50)
Form1:SetSize(480,20)
    for _,i in pairs(LocalPlayer():GetWeapons())do
        if LocalPlayer():Alive() && LocalPlayer():HasWeapon(i:GetClass()) then
            Form1:SetText(LocalPlayer():GetActiveWeapon():GetClass())
        end
    end
--ulx                                       // Oh i dont know how to make function to check ulx -_-
if xgui then
Form2=vgui.Create("DComboBox",WepBan)
for k,v in pairs(xgui.data.groups) do
Form2:AddChoice(v)
end    
Form2:ChooseOption("user")
Form2:AddChoice("user")  -- i dont know why but there are not group user but sometimes it exists
else
Form2=vgui.Create("DTextEntry",WepBan)
Form2:SetText("user") 
end
Form2:SetPos(5,100)
Form2:SetSize(480,20)
--ulx
local button=vgui.Create("DButton",WepBan)
button:SetPos(175,150)
button:SetSize(100,20)
button:SetText("Ban")
WepList = vgui.Create("DListView",WepList2)
WepList:SetMultiSelect(false)
WepList:AddColumn("group")
WepList:AddColumn("weapon")
WepList:Dock(FILL)

local buttgetwep=vgui.Create("DButton",WepBan)
buttgetwep:SetPos(175,20)
buttgetwep:SetSize(100,20)
buttgetwep:SetText("Get active weapon")

buttgetwep.DoClick=function()
for k,v in pairs(LocalPlayer():GetWeapons()) do
if LocalPlayer():Alive() && LocalPlayer():HasWeapon(v:GetClass()) then
Form1:SetText(LocalPlayer():GetActiveWeapon():GetClass())
end
end
end
-------------
button.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if Form1:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(Form1:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your weapon's name only consists of numbers") return end
if tonumber(Form2:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your group's name only consists of numbers") return end
for _,i in pairs(WepList:GetLines())do
if Form1:GetValue()==i:GetValue(2) && Form2:GetValue()==i:GetValue(1) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this weapon is already banned from this group") return end
end
RunConsoleCommand("qwerstriction_addweapon",string.lower(Form2:GetValue()),Form1:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32),"you have banned ",Color(0,255,0),Form1:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),Form2:GetValue())
QwerStrick()  
end)                                                                                                                                            
end 
-------------
WepList.OnClickLine = function(l,s)
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
s:Remove()
RunConsoleCommand("qwerstriction_deleteweapon",s:GetValue(1),s:GetValue(2))
end
local ButtonMassBanWep=vgui.Create("DButton",MassWeaponBan)
ButtonMassBanWep:SetPos(5,40)
ButtonMassBanWep:SetSize(480,40)
ButtonMassBanWep:SetText("Mass ban weapons that you have")
--ulx
if xgui then
GroupMassBans=vgui.Create("DComboBox",MassWeaponBan)
for k,v in pairs(xgui.data.groups) do
GroupMassBans:AddChoice(v)
end
GroupMassBans:ChooseOption("user")
GroupMassBans:AddChoice("user")      
else
GroupMassBans=vgui.Create("DTextEntry",MassWeaponBan)
GroupMassBans:SetText("user") 
end
GroupMassBans:SetPos(5,100)
GroupMassBans:SetSize(480,20)
--ulx
ButtonMassBanWep.DoClick=function()
if !LocalPlayer():Alive() then return end
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(GroupMassBans:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"  your group's name only consists of numbers") return end
for k,v in pairs(LocalPlayer():GetWeapons())do
RunConsoleCommand("qwerstriction_addweapon",string.lower(GroupMassBans:GetValue()),v:GetClass())
end
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32),' now check inset "Remove Weapon" ')
QwerStrick()
end)
end
// settings weapons ban and remove
-- loadout VGUI elements
local Loadout=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("Loadout",Loadout,"icon16/user.png")
local loadpanel=vgui.Create("DFrame",Loadout)
loadpanel:Dock( FILL )
loadpanel:SetTitle("Add custom loadouts for each group")
loadpanel:ShowCloseButton(false)
local loadsheet=vgui.Create("DPropertySheet",loadpanel)
loadsheet:Dock( FILL )
local loadADD=vgui.Create( "DPanel",loadsheet)
loadsheet:AddSheet("Add loadout",loadADD,"icon16/rosette.png")
local MassAddLoad=vgui.Create( "DPanel",loadsheet)
loadsheet:AddSheet("Mass add loadout",MassAddLoad,"icon16/add.png")
local loadList2=vgui.Create( "DPanel",loadsheet)
loadsheet:AddSheet("Remove loadout",loadList2,"icon16/accept.png")
local Ammotype=vgui.Create("DPanel",loadsheet)
loadsheet:AddSheet("Ammo",Ammotype,"icon16/bomb.png")
local Removeammo=vgui.Create("DPanel",loadsheet)
loadsheet:AddSheet("Remove Ammo",Removeammo,"icon16/cross.png")

-- loadout VGUI elements
-- loadout settings
local WeaponsLoad=vgui.Create("DComboBox",loadADD)
WeaponsLoad:SetPos(5,50)// 5 50
WeaponsLoad:SetSize(480,20)
if LocalPlayer():Alive() then
WeaponsLoad:ChooseOption("this weapons you are holding right now")
for k,v in pairs(LocalPlayer():GetWeapons())do
WeaponsLoad:AddChoice(v:GetClass())
end 
else WeaponsLoad:ChooseOption("ohh,looks like you are dead")
end
local buttonLoad=vgui.Create("DButton",loadADD)
buttonLoad:SetPos(155,150)
buttonLoad:SetSize(140,20)
buttonLoad:SetText("Add(refresh list)")
local buttonRem=vgui.Create("DButton",loadADD)
buttonRem:SetPos(155,180)
buttonRem:SetSize(140,20)
buttonRem:SetText("Strip weapon from yourself")
local buttonStripWeaponAll=vgui.Create("DButton",loadADD)
buttonStripWeaponAll:SetPos(155,210)
buttonStripWeaponAll:SetSize(140,20)
buttonStripWeaponAll:SetTextColor(Color(200,0,0))
buttonStripWeaponAll:SetText("Strip all")
buttonStripWeaponAll.DoClick=function()
if !LocalPlayer():Alive() then return end
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
for k,v in pairs(LocalPlayer():GetWeapons()) do
RunConsoleCommand("qwerstriction_stripweapon",v:GetClass())
end
WeaponsLoad:Clear()
end
buttonRem.DoClick=function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
local errVar="this weapons you are holding right now"
if WeaponsLoad:GetValue()==errVar then return end
RunConsoleCommand("qwerstriction_stripweapon",WeaponsLoad:GetValue() )
WeaponsLoad:Clear()
timer.Simple(0.1,function()
for k,v in pairs(LocalPlayer():GetWeapons())do
WeaponsLoad:AddChoice(v:GetClass())
end 
end)
end
--ulx
if xgui then
LoadGroups=vgui.Create("DComboBox",loadADD)
for k,v in pairs(xgui.data.groups) do
LoadGroups:AddChoice(v)
end     
LoadGroups:ChooseOption("user")
LoadGroups:AddChoice("user") 
else
LoadGroups=vgui.Create("DTextEntry",loadADD)
LoadGroups:SetText("user") 
end
LoadGroups:SetPos(5,100)
LoadGroups:SetSize(480,20)
--ulx
buttonLoad.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(LoadGroups:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your group's name only consists of numbers") return end
if tonumber(WeaponsLoad:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your weapon's name only consists of numbers") return end
if WeaponsLoad:GetValue()=="" then
WeaponsLoad:Clear()
timer.Simple(0.1,function()
for k,v in pairs(LocalPlayer():GetWeapons())do
WeaponsLoad:AddChoice(v:GetClass()) 
end 
end)
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if !LocalPlayer():Alive() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"you must be alive!") return end
local errVar="this weapons you are holding right now"
if WeaponsLoad:GetValue()==errVar then return end
for _,v in pairs(defalist:GetLines()) do
if WeaponsLoad:GetValue()==v:GetValue(2) && LoadGroups:GetValue()==v:GetValue(1) then 
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this weapon is already in then loadout for this group") return end
end
RunConsoleCommand("qwerstriction_addloadout",string.lower(LoadGroups:GetValue()),WeaponsLoad:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32),"you have added "..WeaponsLoad:GetValue().." for loadout for group "..LoadGroups:GetValue())
QwerStrick()
end)
end
defalist=vgui.Create( "DListView",loadList2)
defalist:SetMultiSelect( false )
defalist:AddColumn( "group" )
defalist:AddColumn( "weapon" )
defalist:Dock( FILL )
defalist.OnClickLine = function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_deleteloadout",s:GetValue(1),s:GetValue(2))
end
local buttonInsertAll=vgui.Create("DButton",MassAddLoad)
buttonInsertAll:SetPos(5,40)
buttonInsertAll:SetSize(480,40)
buttonInsertAll:SetText("Mass add weapons that you have")//////
--ulx
if xgui then
LoadGroupsMassBan=vgui.Create("DComboBox",MassAddLoad)
for k,v in pairs(xgui.data.groups) do
LoadGroupsMassBan:AddChoice(v)
end
LoadGroupsMassBan:ChooseOption("user")
LoadGroupsMassBan:AddChoice("user")
else
LoadGroupsMassBan=vgui.Create("DTextEntry",MassAddLoad)
LoadGroupsMassBan:SetText("user") 
end
LoadGroupsMassBan:SetPos(5,100)
LoadGroupsMassBan:SetSize(480,20)
--ulx
buttonInsertAll.DoClick=function()
if !LocalPlayer():Alive() then return end
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(LoadGroupsMassBan:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your group's name only consists of numbers") return end
for k,v in pairs(LocalPlayer():GetWeapons())do
if !LocalPlayer():HasWeapon(v:GetClass()) then return end
RunConsoleCommand("qwerstriction_addloadout",string.lower(LoadGroupsMassBan:GetValue()),v:GetClass())
end   
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32),' now check insent "Remove Loadout"')
QwerStrick()
end)
end

local ammotypesst={
{name="AR2 combineball",ammo="AR2AltFire"},
{name="AR2 ammo",ammo="AR2"},
{name="Pistol",ammo="Pistol"},
{name="Magnum357",ammo="357"},
{name="Smg1",ammo="SMG1"},
{name="Smg1 grenades",ammo="SMG1_Grenade"},
{name="Shotgun",ammo="Buckshot"},
{name="Crossbow",ammo="XBowBolt"},
{name="Frag",ammo="Grenade"},
{name="RPG",ammo="RPG_Round"},
{name="S.L.A.M",ammo="slam"}
}

local DboxAmmo=vgui.Create("DComboBox",Ammotype)
DboxAmmo:SetPos(5,50)
DboxAmmo:SetSize(480,20)

for k,v in pairs(ammotypesst)do
DboxAmmo:AddChoice(v.name)
end

local AmmoUserDbox=vgui.Create("DTextEntry",Ammotype)
AmmoUserDbox:SetText("13581") 
AmmoUserDbox:SetPos(5,100)
AmmoUserDbox:SetSize(480,20)

local AmmoButton=vgui.Create("DButton",Ammotype)
AmmoButton:SetPos(155,180)
AmmoButton:SetSize(140,20)
AmmoButton:SetText("Set ammo")
AmmoButton.DoClick=function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if !tonumber(AmmoUserDbox:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,12)," only numbers") return end
if AmmoUserDbox:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,12)," empty box") return end
if DboxAmmo:GetValue()=="" then 
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,12)," empty box") return end
for k,v in pairs(ammotypesst)do
if v.name==DboxAmmo:GetValue() then 
RunConsoleCommand("qwerstriction_ammo",v.ammo,AmmoUserDbox:GetValue())
end
end
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,12),"Now there are additionally "..AmmoUserDbox:GetValue().." ammo for "..DboxAmmo:GetValue())
QwerStrick()
end                                                                                                                                                                                             

local RemoveAmmoList=vgui.Create("DListView",Removeammo)
RemoveAmmoList:SetMultiSelect( false )
RemoveAmmoList:AddColumn( "ammo" )
RemoveAmmoList:AddColumn( "number" )
RemoveAmmoList:Dock( FILL )


RemoveAmmoList.OnClickLine = function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removeammo",s:GetValue(1),s:GetValue(2))
end


-- loadout settings
-- Entities VGUI elements
local banentities=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("Entities",banentities,"icon16/bricks.png")
local entPanels=vgui.Create("DFrame",banentities)
entPanels:Dock( FILL )
entPanels:SetTitle("Ban entities from Q menu")
entPanels:ShowCloseButton(false)
local EntsList=vgui.Create("DPropertySheet",entPanels)
EntsList:Dock( FILL )
local BanEnt=vgui.Create("DPanel",EntsList)
EntsList:AddSheet("Ban entity",BanEnt,"icon16/stop.png")
local EntsLists=vgui.Create("DPanel",EntsList)
EntsList:AddSheet("Remove entity",EntsLists,"icon16/accept.png")
-- Entities VGUI elements
-- Entities Settings
local banentityb=vgui.Create("DButton",BanEnt)
banentityb:SetText("ban entity")
banentityb:SetPos(175,150)
banentityb:SetSize(100,20)
local banentity=vgui.Create("DTextEntry",BanEnt)
banentity:SetPos(5,50)
banentity:SetSize(480,20)
--ulx
if xgui then
entitygroup=vgui.Create("DComboBox",BanEnt)
for k,v in pairs(xgui.data.groups) do
entitygroup:AddChoice(v)
end      
entitygroup:ChooseOption("user")
entitygroup:AddChoice("user")
else
entitygroup=vgui.Create("DTextEntry",BanEnt)
entitygroup:SetText("user") 
end
entitygroup:SetPos(5,100)
entitygroup:SetSize(480,20)
--ulx
banentityb.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if banentity:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if !LocalPlayer():IsSuperAdmin() then 
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(banentity:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your entiti's name only consists of numbers") return end
if tonumber(entitygroup:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"your group's name only consists of numbers") return end
for k,v in pairs(entlist:GetLines())do
if banentity:GetValue()==v:GetValue(2) && entitygroup:GetValue()==v:GetValue(1) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this entity is alredy banned for this group") return end
end
RunConsoleCommand("qwerstriction_banentity",string.lower(entitygroup:GetValue()),banentity:GetValue())
QwerStrick()
chat.AddText(Color(0,255,0),"[QWERSTRICTION] ",Color(218,165,32)," you have banned ",banentity:GetValue().." for group ",entitygroup:GetValue())
end)
end
entlist=vgui.Create("DListView",EntsLists)
entlist:SetMultiSelect( false )
entlist:AddColumn( "group" )
entlist:AddColumn( "entity" )
entlist:Dock( FILL )
entlist.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_deleteentity",s:GetValue(1),s:GetValue(2))
end
-- Entities Settings
-- ToolGun VGUI
local toolgunSheet=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("Toolgun",toolgunSheet,"icon16/controller.png")
local toolgunPanel=vgui.Create("DFrame",toolgunSheet)
toolgunPanel:Dock( FILL )
toolgunPanel:SetTitle("Ban tools for each groups")
toolgunPanel:ShowCloseButton(false)
local SheetTool=vgui.Create("DPropertySheet",toolgunPanel)
SheetTool:Dock( FILL )
local BanTool=vgui.Create("DPanel",SheetTool)
SheetTool:AddSheet("Ban tool",BanTool,"icon16/stop.png")
local RemoveTool=vgui.Create("DPanel",SheetTool)
SheetTool:AddSheet("Remove tool",RemoveTool,"icon16/accept.png")
-- ToolGun VGUI
-- Settings Toolgun
local BunToolgunButton=vgui.Create("DButton",BanTool)
BunToolgunButton:SetText("ban tool")
BunToolgunButton:SetPos(175,150)
BunToolgunButton:SetSize(100,20)
--ulx
if xgui then
tooluser=vgui.Create("DComboBox",BanTool)
for k,v in pairs(xgui.data.groups) do
tooluser:AddChoice(v)
end 
tooluser:ChooseOption("user")
tooluser:AddChoice("user")     
else
tooluser=vgui.Create("DTextEntry",BanTool)
tooluser:SetText("user") 
end
tooluser:SetPos(5,100)
tooluser:SetSize(480,20)
--ulx
local toolBanit=vgui.Create("DTextEntry",BanTool)
toolBanit:SetPos(5,50)
toolBanit:SetSize(480,20)
toolremovelist = vgui.Create( "DListView",RemoveTool)
toolremovelist:SetMultiSelect( false )
toolremovelist:AddColumn( "group" )
toolremovelist:AddColumn( "tool" )
toolremovelist:Dock( FILL )
local KnowTool=vgui.Create("Button",BanTool)
KnowTool:SetPos(175,20)
KnowTool:SetText("tool name")
KnowTool:SetSize(100,20)
KnowTool.DoClick=function()
RunConsoleCommand("qwerstriction_toolgunknow")
if LocalPlayer():GetNWString("KnowWhatTool")=="know" then
LocalPlayer():SetNWString("KnowWhatTool","false")else
LocalPlayer():SetNWString("KnowWhatTool","know")
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32),"now click on the ground with your toolgun")
end
end
BunToolgunButton.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if toolBanit:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if tonumber(toolBanit:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," your tool's name only consists of numbers") return end
if tonumber(tooluser:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"your group's name only consists of numbers") return end
for k,v in pairs(toolremovelist:GetLines())do
if toolBanit:GetValue()==v:GetValue(2) && tooluser:GetValue()==v:GetValue(1) then
print(v:GetValue(2))
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this tool is already in the ban for this group") return end
end
RunConsoleCommand("qwerstriction_bantool",string.lower(tooluser:GetValue()),toolBanit:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32)," you have banned "..toolBanit:GetValue().." for group "..tooluser:GetValue())
QwerStrick()
end)
end
toolremovelist.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removetoolgun",s:GetValue(1),s:GetValue(2))
end
-- Settings Toolgun
-- NPC VGUI
local npcsh=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("NPC",npcsh,"icon16/monkey.png")
local podvkladkanpc=vgui.Create("DFrame",npcsh)
podvkladkanpc:Dock( FILL )
podvkladkanpc:SetTitle("Set limit of npc for each group")
podvkladkanpc:ShowCloseButton(false)
local NpcVnytri=vgui.Create("DPropertySheet",podvkladkanpc)
NpcVnytri:Dock(FILL)
local BanNumberNPC=vgui.Create("DPanel",NpcVnytri)
NpcVnytri:AddSheet("Set limit",BanNumberNPC,"icon16/stop.png")
local BanClassNpc=vgui.Create("DPanel",NpcVnytri)
NpcVnytri:AddSheet("Ban class",BanClassNpc,"icon16/delete.png")
local NumberList=vgui.Create("DPanel",NpcVnytri)
NpcVnytri:AddSheet("Remove limit",NumberList,"icon16/add.png")
local numberlistclass=vgui.Create("DPanel",NpcVnytri)
NpcVnytri:AddSheet("Remove class",numberlistclass,"icon16/accept.png")
-- NPC VGUI
-- NPC Settings 
--ulx
if xgui then
npcUser=vgui.Create("DComboBox",BanNumberNPC)
for k,v in pairs(xgui.data.groups) do
npcUser:AddChoice(v)
end   
npcUser:ChooseOption("user")
npcUser:AddChoice("user")   
else
npcUser=vgui.Create("DTextEntry",BanNumberNPC)
npcUser:SetText("user") 
end
npcUser:SetPos(5,100)
npcUser:SetSize(480,20)
--ulx
--ulx
if xgui then
npcUserClass=vgui.Create("DComboBox",BanClassNpc)
npcUserClass:ChooseOption("user")
for k,v in pairs(xgui.data.groups) do
npcUserClass:AddChoice(v)
end
npcUserClass:AddChoice("user")     
else
npcUserClass=vgui.Create("DTextEntry",BanClassNpc)
npcUserClass:SetText("user") 
end
npcUserClass:SetPos(5,100)
npcUserClass:SetSize(480,20)
--ulx
local npcNumber=vgui.Create("DTextEntry",BanNumberNPC)
npcNumber:SetPos(5,50)
npcNumber:SetSize(480,20)
local buttonnpc=vgui.Create("DButton",BanNumberNPC)
buttonnpc:SetPos(175,150)
buttonnpc:SetSize(100,20)
buttonnpc:SetText("Set")
local banclassnpc=vgui.Create("DTextEntry",BanClassNpc)
banclassnpc:SetPos(5,50)
banclassnpc:SetSize(480,20)
local bannpcclassbut=vgui.Create("DButton",BanClassNpc)
bannpcclassbut:SetPos(175,150)
bannpcclassbut:SetSize(100,20)
bannpcclassbut:SetText("Ban")
buttonnpc.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if !tonumber(npcNumber:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if tonumber(npcUser:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
RunConsoleCommand("qwerstriction_npcnumber",string.lower(npcUser:GetValue()),npcNumber:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32)," max npcs for "..npcUser:GetValue().." is "..npcNumber:GetValue())
QwerStrick()
end)
end
local ClassNpcList=vgui.Create("DListView",numberlistclass)
ClassNpcList:SetMultiSelect( false )
ClassNpcList:AddColumn("group")
ClassNpcList:AddColumn("class")
ClassNpcList:Dock( FILL )
bannpcclassbut.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(banclassnpc:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if banclassnpc:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if tonumber(npcUserClass:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
for k,v in pairs(ClassNpcList:GetLines())do
if npcUserClass:GetValue()==v:GetValue(1) && banclassnpc:GetValue()==v:GetValue(2) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this NPC is already banned for this group") return end
end
RunConsoleCommand("qwerstriction_npcbanclass",string.lower(npcUserClass:GetValue()),banclassnpc:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32), " you have banned ",banclassnpc:GetValue()," for group ",npcUserClass:GetValue())
QwerStrick()
end)
end
local NpcList=vgui.Create( "DListView",NumberList)
NpcList:SetMultiSelect( false )
NpcList:AddColumn("group")
NpcList:AddColumn("number")
NpcList:Dock( FILL )
NpcList.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removenpcnum",s:GetValue(1),s:GetValue(2))
end
ClassNpcList.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removenpcclass",s:GetValue(1),s:GetValue(2))
end
-- NPC Settings
-- Props VGUI
local props1=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("Props",props1,"icon16/application_view_detail.png")
local podvkladkaprops=vgui.Create("DFrame",props1)
podvkladkaprops:Dock( FILL )
podvkladkaprops:SetTitle("Set limit of props for each group")
podvkladkaprops:ShowCloseButton(false)
local PropsVnytri=vgui.Create("DPropertySheet",podvkladkaprops)
PropsVnytri:Dock(FILL)
local BanNumberProp=vgui.Create("DPanel",PropsVnytri)
PropsVnytri:AddSheet("Set limit",BanNumberProp,"icon16/stop.png")
local BanClassProp=vgui.Create("DPanel",PropsVnytri)
PropsVnytri:AddSheet("Ban model",BanClassProp,"icon16/delete.png")
local NumberListProp=vgui.Create("DPanel",PropsVnytri)
PropsVnytri:AddSheet("Remove limit",NumberListProp,"icon16/accept.png")
local PropsModels=vgui.Create("DPanel",PropsVnytri)
PropsVnytri:AddSheet("Remove model",PropsModels,"icon16/add.png")
-- Props VGUI
-- Props Settings
--ulx
if xgui then
PropNumberUser=vgui.Create("DComboBox",BanNumberProp)
for k,v in pairs(xgui.data.groups) do
PropNumberUser:AddChoice(v)
end  
PropNumberUser:ChooseOption("user")
PropNumberUser:AddChoice("user")    
else
PropNumberUser=vgui.Create("DTextEntry",BanNumberProp)
PropNumberUser:SetText("user") 
end
PropNumberUser:SetPos(5,100)
PropNumberUser:SetSize(480,20)
--ulx
--ulx
if xgui then
PropUserClass=vgui.Create("DComboBox",BanClassProp)
for k,v in pairs(xgui.data.groups) do
PropUserClass:AddChoice(v)
end      
PropUserClass:ChooseOption("user")
PropUserClass:AddChoice("user")
else
PropUserClass=vgui.Create("DTextEntry",BanClassProp)
PropUserClass:SetText("user") 
end
PropUserClass:SetPos(5,100)
PropUserClass:SetSize(480,20)
--ulx
local PropNumber=vgui.Create("DTextEntry",BanNumberProp)
PropNumber:SetPos(5,50)
PropNumber:SetSize(480,20)
--buttonprop  --banmodprop
local buttonpropnumber=vgui.Create("DButton",BanNumberProp)
buttonpropnumber:SetPos(175,150)
buttonpropnumber:SetSize(100,20)
buttonpropnumber:SetText("Set")
local banmodprop=vgui.Create("DTextEntry",BanClassProp)
banmodprop:SetPos(5,50)
banmodprop:SetSize(480,20)
local banmodpropbut=vgui.Create("DButton",BanClassProp)
banmodpropbut:SetPos(175,150)
banmodpropbut:SetSize(100,20)
banmodpropbut:SetText("Ban")
buttonpropnumber.DoClick=function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if !tonumber(PropNumber:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if tonumber(PropNumberUser:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
RunConsoleCommand("qwerstriction_bannumberprop",string.lower(PropNumberUser:GetValue()),PropNumber:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32)," max props for "..PropNumberUser:GetValue().." is "..PropNumber:GetValue())
QwerStrick()
end
local PropModelsAndGroups=vgui.Create( "DListView",PropsModels)
PropModelsAndGroups:SetMultiSelect( false )
PropModelsAndGroups:AddColumn("group")
PropModelsAndGroups:AddColumn("model")
PropModelsAndGroups:Dock( FILL )
banmodpropbut.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(banmodprop:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if banmodprop:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if tonumber(PropUserClass:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
if !string.find(banmodprop:GetValue(),".mdl") then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," .mdl need for models")  
return end
for k,v in pairs(PropModelsAndGroups:GetLines())do
if PropUserClass:GetValue()==v:GetValue(1) && banmodprop:GetValue()==v:GetValue(2) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this prop is already banned for this group") return end
end
RunConsoleCommand("qwerstriction_banpropmodel",string.lower(PropUserClass:GetValue()),banmodprop:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32), " you have banned ",banmodprop:GetValue()," model for group ",PropUserClass:GetValue())
QwerStrick()
end)
end                                                                                                                                                                                                 
local PropCountList=vgui.Create( "DListView",NumberListProp)                  
PropCountList:SetMultiSelect( false )
PropCountList:AddColumn("group")
PropCountList:AddColumn("number")
PropCountList:Dock( FILL )
PropCountList.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removepropnumber",s:GetValue(1),s:GetValue(2))
end
PropModelsAndGroups.OnClickLine=function(l,s)
if !LocalPlayer():IsAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removemodelprop",s:GetValue(1),s:GetValue(2))
end
-- Props Settings
-- Ragdolls Vgui
local Ragdolls=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("Ragdoll",Ragdolls,"icon16/emoticon_smile.png")
local RagdollDframe=vgui.Create("DFrame",Ragdolls)
RagdollDframe:Dock( FILL )
RagdollDframe:SetTitle("Set limit of ragdolls for each group")
RagdollDframe:ShowCloseButton(false)
local RagdollPrptprpr=vgui.Create("DPropertySheet",RagdollDframe)
RagdollPrptprpr:Dock(FILL)
local BanNumberRagdoll=vgui.Create("DPanel",RagdollPrptprpr)
RagdollPrptprpr:AddSheet("Set limit",BanNumberRagdoll,"icon16/stop.png")
local BanModelRagdoll=vgui.Create("DPanel",RagdollPrptprpr)
RagdollPrptprpr:AddSheet("Ban model",BanModelRagdoll,"icon16/delete.png")
local NumberListRagdoll=vgui.Create("DPanel",RagdollPrptprpr)
RagdollPrptprpr:AddSheet("Remove limit",NumberListRagdoll,"icon16/accept.png")
local RagdollModels=vgui.Create("DPanel",RagdollPrptprpr)
RagdollPrptprpr:AddSheet("Remove model",RagdollModels,"icon16/add.png")
-- Ragdolls Vgui
-- Ragdoll Settings
--ulx
if xgui then
UserRagdollBan=vgui.Create("DComboBox",BanNumberRagdoll)
for k,v in pairs(xgui.data.groups) do
UserRagdollBan:AddChoice(v)
end 
UserRagdollBan:ChooseOption("user")
UserRagdollBan:AddChoice("user")     
else
UserRagdollBan=vgui.Create("DTextEntry",BanNumberRagdoll)
UserRagdollBan:SetText("user") 
end
UserRagdollBan:SetPos(5,100)
UserRagdollBan:SetSize(480,20)
--ulx
if xgui then
BanUserModelag=vgui.Create("DComboBox",BanModelRagdoll)
for k,v in pairs(xgui.data.groups) do
BanUserModelag:AddChoice(v)
end  
BanUserModelag:ChooseOption("user")
BanUserModelag:AddChoice("user")    
else
BanUserModelag=vgui.Create("DTextEntry",BanModelRagdoll)
BanUserModelag:SetText("user") 
end
BanUserModelag:SetPos(5,100)
BanUserModelag:SetSize(480,20)
--ulx
local RagdollListNumber=vgui.Create( "DListView",NumberListRagdoll)
RagdollListNumber:SetMultiSelect( false )
RagdollListNumber:AddColumn("group")
RagdollListNumber:AddColumn("number")
RagdollListNumber:Dock( FILL )
local RagdollListModel=vgui.Create( "DListView",RagdollModels)
RagdollListModel:SetMultiSelect( false )
RagdollListModel:AddColumn("group")
RagdollListModel:AddColumn("model")
RagdollListModel:Dock( FILL )
local RagdollNumber=vgui.Create("DTextEntry",BanNumberRagdoll)
RagdollNumber:SetPos(5,50)
RagdollNumber:SetSize(480,20)
--buttonprop  --banmodprop
local buttonragdollnumber=vgui.Create("DButton",BanNumberRagdoll)
buttonragdollnumber:SetPos(175,150)
buttonragdollnumber:SetSize(100,20)
buttonragdollnumber:SetText("Set")
local RagdollModel=vgui.Create("DTextEntry",BanModelRagdoll)
RagdollModel:SetPos(5,50)
RagdollModel:SetSize(480,20)
local buttonragdollmodel=vgui.Create("DButton",BanModelRagdoll)
buttonragdollmodel:SetPos(175,150)
buttonragdollmodel:SetSize(100,20)
buttonragdollmodel:SetText("ban")
buttonragdollnumber.DoClick=function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if !tonumber(RagdollNumber:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if tonumber(UserRagdollBan:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
RunConsoleCommand("qwerstriction_addnumberragdoll",string.lower(UserRagdollBan:GetValue()),RagdollNumber:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32)," max ragdolls for "..UserRagdollBan:GetValue().." is "..RagdollNumber:GetValue())
QwerStrick()
end
----------
buttonragdollmodel.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(RagdollModel:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if RagdollModel:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if !string.find(RagdollModel:GetValue(),".mdl") then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," .mdl need for models") return end
if tonumber(BanUserModelag:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
for k,v in pairs(RagdollListModel:GetLines())do
if BanUserModelag:GetValue()==v:GetValue(1) && RagdollModel:GetValue()==v:GetValue(2) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this ragdoll is already banned for this group") return end
end
RunConsoleCommand("qwerstriction_addmodelragdoll",string.lower(BanUserModelag:GetValue()),RagdollModel:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32), " you have banned ",RagdollModel:GetValue()," ragdoll for group ",BanUserModelag:GetValue())
QwerStrick()
end)                                                                                                                       
end 
RagdollListNumber.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removenumberragdoll",s:GetValue(1),s:GetValue(2))
end
RagdollListModel.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removemodelragdoll",s:GetValue(1),s:GetValue(2))
end
-- Ragdoll Settings
-- Vehicles Vgui
local Cars=vgui.Create("DPanel",vkladki)
vkladki:AddSheet("Vehicles",Cars,"icon16/car.png")
local CarDframe=vgui.Create("DFrame",Cars)
CarDframe:Dock( FILL )
CarDframe:SetTitle("Set limit of vehicles for each group")
CarDframe:ShowCloseButton(false)
local CarProper=vgui.Create("DPropertySheet",CarDframe)
CarProper:Dock(FILL)
local SetLimitCarNumber=vgui.Create("DPanel",CarProper)
CarProper:AddSheet("Set limit",SetLimitCarNumber,"icon16/stop.png")
local BanModelCar=vgui.Create("DPanel",CarProper)
CarProper:AddSheet("Ban class",BanModelCar,"icon16/delete.png")
local ListNumberCar=vgui.Create("DPanel",CarProper)
CarProper:AddSheet("Remove limit",ListNumberCar,"icon16/accept.png")
local ListModelCars=vgui.Create("DPanel",CarProper)
CarProper:AddSheet("Remove class",ListModelCars,"icon16/add.png")
-- Vehicles Vgui
-- Vehicles Settings
--ulx
if xgui then
GroupBanNumberCar=vgui.Create("DComboBox",SetLimitCarNumber)
for k,v in pairs(xgui.data.groups) do
GroupBanNumberCar:AddChoice(v)
end  
GroupBanNumberCar:ChooseOption("user")   
GroupBanNumberCar:AddChoice("user")
else
GroupBanNumberCar=vgui.Create("DTextEntry",SetLimitCarNumber)
GroupBanNumberCar:SetText("user") 
end
GroupBanNumberCar:SetPos(5,100)
GroupBanNumberCar:SetSize(480,20)
--ulx
local ListofNumberCars=vgui.Create( "DListView",ListNumberCar)
ListofNumberCars:SetMultiSelect( false )
ListofNumberCars:AddColumn("group")
ListofNumberCars:AddColumn("number")
ListofNumberCars:Dock( FILL )
local ListofModelsCars=vgui.Create( "DListView",ListModelCars)
ListofModelsCars:SetMultiSelect( false )
ListofModelsCars:AddColumn("group")
ListofModelsCars:AddColumn("model")
ListofModelsCars:Dock( FILL )
local NumberCartxt=vgui.Create("DTextEntry",SetLimitCarNumber)
NumberCartxt:SetPos(5,50)
NumberCartxt:SetSize(480,20)
local buttoncarnumber=vgui.Create("DButton",SetLimitCarNumber)
buttoncarnumber:SetPos(175,150)
buttoncarnumber:SetSize(100,20)
buttoncarnumber:SetText("Set")
buttoncarnumber.DoClick=function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if !tonumber(NumberCartxt:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if tonumber(GroupBanNumberCar:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
RunConsoleCommand("qwerstriction_addnumbercar",string.lower(GroupBanNumberCar:GetValue()),NumberCartxt:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32)," max vehicles for "..GroupBanNumberCar:GetValue().." is "..NumberCartxt:GetValue())
QwerStrick()                                                                                                                           
end
--ulx
if xgui then
GroupBanModelCar=vgui.Create("DComboBox",BanModelCar)
for k,v in pairs(xgui.data.groups) do
GroupBanModelCar:AddChoice(v)
end  
GroupBanModelCar:ChooseOption("user")
GroupBanModelCar:AddChoice("user")    
else
GroupBanModelCar=vgui.Create("DTextEntry",BanModelCar)
GroupBanModelCar:SetText("user") 
end
GroupBanModelCar:SetPos(5,100)
GroupBanModelCar:SetSize(480,20)
--ulx
local ModelCartxt=vgui.Create("DTextEntry",BanModelCar)
ModelCartxt:SetPos(5,50)
ModelCartxt:SetSize(480,20)
local buttoncarmodel=vgui.Create("DButton",BanModelCar)
buttoncarmodel:SetPos(175,150)
buttoncarmodel:SetSize(100,20)
buttoncarmodel:SetText("Ban")
buttoncarmodel.DoClick=function()
QwerStrick()
timer.Simple(0.1,function()
if !LocalPlayer():IsSuperAdmin() then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," you are not superadmin") return end
if tonumber(ModelCartxt:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," only numbers") return end
if ModelCartxt:GetValue()=="" then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," empty box") return end
if tonumber(GroupBanModelCar:GetValue()) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32),"Your group's name only consists of numbers") return end
for k,v in pairs(ListofModelsCars:GetLines())do
if GroupBanModelCar:GetValue()==v:GetValue(1) && ModelCartxt:GetValue()==v:GetValue(2) then
chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," this vehicle is already banned for this group") return end
end
RunConsoleCommand("qwerstriction_addmodelvehicle",string.lower(GroupBanModelCar:GetValue()),ModelCartxt:GetValue())
chat.AddText(Color(0,200,0),"[QWERSTRICTION] ",Color(218,165,32), " you have banned ",ModelCartxt:GetValue()," for group ",GroupBanModelCar:GetValue())
QwerStrick()
end)
end
ListofNumberCars.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removenumbervehicle",s:GetValue(1),s:GetValue(2))
end
ListofModelsCars.OnClickLine=function(l,s)
if !LocalPlayer():IsSuperAdmin() then return end
s:Remove()
RunConsoleCommand("qwerstriction_removemodelvehicle",s:GetValue(1),s:GetValue(2))
end
-- Vehicles Settings
function QwerStrick()
if !LocalPlayer():IsSuperAdmin() then return end
NpcList:Clear()
toolremovelist:Clear()
WepList:Clear()
defalist:Clear()
entlist:Clear()
ClassNpcList:Clear()
PropCountList:Clear()
PropModelsAndGroups:Clear()
RagdollListNumber:Clear()
RagdollListModel:Clear()
ListofNumberCars:Clear()
ListofModelsCars:Clear()
RemoveAmmoList:Clear()
RunConsoleCommand("qwerstriction_refresh")
net.Receive("SendQwerstriTables",function()
local weptab=net.ReadTable()
local LoadoutTableList=net.ReadTable()
local EntitiTableList=net.ReadTable()
local ToolTableList=net.ReadTable()
local NpcTableList=net.ReadTable()
local PropsListNumber=net.ReadTable()
local RagdollModelAndNumber=net.ReadTable()
local VehicleItems=net.ReadTable()
local AmmoTypesTable=net.ReadTable()
-----------------------------------------------------
for group1,wep1 in pairs(weptab)do
for i=1,#wep1 do
WepList:AddLine(group1,wep1[i])
end
end
-----------------------------------------------------
-----------------------------------------------------
    for group2,loadout in pairs(LoadoutTableList) do
        for i=1,#loadout do
            defalist:AddLine(group2,loadout[i])
        end
    end
-----------------------------------------------------
-----------------------------------------------------
    for group3,ent in pairs(EntitiTableList) do
        for i=1,#ent do
            entlist:AddLine(group3,ent[i])
        end
    end
-----------------------------------------------------
-----------------------------------------------------
    for group4,tools in pairs(ToolTableList) do
        for i=1,#tools do
            toolremovelist:AddLine(group4,tools[i])
        end
    end
-----------------------------------------------------
-----------------------------------------------------
    for group5,npcnum in pairs(NpcTableList) do
            if npcnum.number then
            NpcList:AddLine(group5,npcnum.number[1])
            end
            
            if npcnum.npc then
            
            for i=1,#npcnum.npc do
             ClassNpcList:AddLine(group5,npcnum.npc[i])
            end
            end
     end
-----------------------------------------------------
-----------------------------------------------------
    for group6,props in pairs(PropsListNumber)do
        if props.number then
        PropCountList:AddLine(group6,props.number[1])
        end
        
        if props.model then
        for i=1,#props.model do
        PropModelsAndGroups:AddLine(group6,props.model[i])
        end
        end 
    end
-----------------------------------------------------
for group7,ragdoll in pairs(RagdollModelAndNumber) do
	                           if ragdoll.number then
	   	                           RagdollListNumber:AddLine(group7,ragdoll.number[1])
	                           end
	                           if ragdoll.model then
	   	                           for i=1,#ragdoll.model do
	   	   	                           RagdollListModel:AddLine(group7,ragdoll.model[i])
	   	                           end
	                           end    
end
-----------------------------------------------------
    for group8,vh in pairs(VehicleItems) do
        if vh.number then
            ListofNumberCars:AddLine(group8,vh.number[1])
        end                  
        if vh.model then
            for i=1,#vh.model do
                ListofModelsCars:AddLine(group8,vh.model[i])
            end
        end
    end
-----------------------------------------------------
    for ammo,numberammo in pairs(AmmoTypesTable) do
        if numberammo.number then
            RemoveAmmoList:AddLine(ammo,numberammo.number[1])
        end
    end
-----------------------------------------------------        

end) 
end 
local ButtonRefresh=vgui.Create("DImageButton",MainWindow)
ButtonRefresh:SetSize(16,16)
ButtonRefresh:SetImage("icon16/arrow_refresh.png")
ButtonRefresh:SetPos(485,4)
local CloseButtonWindow=vgui.Create("DImageButton",MainWindow)
CloseButtonWindow:SetSize(16,16)
CloseButtonWindow:SetImage("icon16/cancel.png")
CloseButtonWindow:SetPos(510,4)
MainWindow.Close = function() MainWindow:SetVisible(false) end
CloseButtonWindow.DoClick=function()
MainWindow:Close()
openedtpurs=false
end
ButtonRefresh.DoClick=function()
QwerStrick()
end
local function LooseFocus(panel)
MainWindow:SetKeyboardInputEnabled(false)
end
hook.Add("OnTextEntryLoseFocus","GetFokus",LooseFocus)
local function GetFocus(panel)
MainWindow:SetKeyboardInputEnabled(true)
end
hook.Add("OnTextEntryGetFocus","GetFocus",GetFocus)
QwerStrick()
end
concommand.Add("qwerstriction",function()
if openedtpurs==true then
MainWindow:SetVisible(false)
openedtpurs=false return
end
qwerstriction() 
end)
