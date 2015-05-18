/////////////////////////////////
////Warning:piece of shit code///
/////////////////////////////////
////[QWERSTRICTION] by Seal13581/
/////////////////////////////////

-- http://steamcommunity.com/sharedfiles/filedetails/?id=442284822

-- Seal13581 steam http://steamcommunity.com/id/13581/

util.AddNetworkString("SendQwerstriTables")
util.AddNetworkString("QwerstriErrorMessage")
concommand.Add("qwerstriction_refresh",function(p)
if !p:IsSuperAdmin() then return end
if !file.IsDir("qwerstriction","DATA") then
file.CreateDir("qwerstriction")
end
net.Start("SendQwerstriTables")
--weapon ban
if !file.Exists("qwerstriction/weapon.txt","DATA") then 
file.Write("qwerstriction/weapon.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/weapon.txt","DATA")))
--loadout
if !file.Exists("qwerstriction/loadout.txt","DATA") then
file.Write("qwerstriction/loadout.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/loadout.txt","DATA")))
--entities 
if !file.Exists("qwerstriction/entity.txt","DATA") then
file.Write("qwerstriction/entity.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/entity.txt","DATA")))
-- toolgun --toolgun
if !file.Exists("qwerstriction/toolgun.txt","DATA") then
file.Write("qwerstriction/toolgun.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/toolgun.txt","DATA")))
-- npc
if !file.Exists("qwerstriction/npc.txt","DATA") then
file.Write("qwerstriction/npc.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/npc.txt","DATA")))
-- prop
if !file.Exists("qwerstriction/props.txt","DATA") then
file.Write("qwerstriction/props.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/props.txt","DATA")))
-- ragdoll
if !file.Exists("qwerstriction/ragdoll.txt","DATA") then
file.Write("qwerstriction/ragdoll.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/ragdoll.txt","DATA")))
-- vehicle
if !file.Exists("qwerstriction/vehicle.txt","DATA") then
file.Write("qwerstriction/vehicle.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/vehicle.txt","DATA")))
-- AmmoTypes
if !file.Exists("qwerstriction/ammo.txt","DATA") then
file.Write("qwerstriction/ammo.txt")
end
net.WriteTable(util.KeyValuesToTable(file.Read("qwerstriction/ammo.txt","DATA")))
net.Send(p)
end)
-----------------------------------------------------------------------------------------///
local function GetTable(element)                                                         ///
    if file.Exists("qwerstriction/"..element..".txt","DATA") then                        ///
        return util.KeyValuesToTable(file.Read("qwerstriction/"..element..".txt","DATA"))/// 
    end                                                                                  ///
end                                                                                      ///
-----------------------------------------------------------------------------------------///
--------------------------Ban Weapon and Remove Weapon-----------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_addweapon",function(p,c,arg)                               ///
if !p:IsSuperAdmin() or  not arg[1] or not arg[2] or tonumber(arg[1]) or                 ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl = GetTable("weapon")                                                           ///
    if not tbl[arg[1]] then                                                              ///
        tbl[arg[1]] = {}                                                                 ///
    end                                                                                  ///
    if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end  ///
    file.Write("qwerstriction/weapon.txt",util.TableToKeyValues(tbl))                    ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_deleteweapon",function(p,c,arg)                            ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl=GetTable("weapon")                                                             ///
    if  tbl[arg[1]] then                                                                 ///
    if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2])   ///
	end                                                                                  ///
    file.Write("qwerstriction/weapon.txt",util.TableToKeyValues(tbl))                    ///
    end                                                                                  ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function CheckPlyWep(ply,class)                                                    ///
if !file.Exists("qwerstriction/weapon.txt","DATA") then return end                       ///
local g=util.KeyValuesToTable(file.Read("qwerstriction/weapon.txt","DATA"))              ///                                          
    for n,s in pairs(g)do                                                                ///
        for i=1,#s do                                                                    ///
            if ply:IsUserGroup(n) && class==(s[i]) then                                  ///
	                                          net.Start("QwerstriErrorMessage")          ///
                net.WriteString(class)                                                   ///
                net.Send(ply)  return false                                              ///
            end                                                                          ///
        end                                                                              ///
    end                                                                                  ///
end                                                                                      ///
hook.Add("PlayerGiveSWEP","RejjectWeapon",CheckPlyWep)                                   ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function Checkabyz()                                                               ///
if !file.Exists("qwerstriction/weapon.txt","DATA") then return end                       ///
local List=util.KeyValuesToTable(file.Read("qwerstriction/weapon.txt","DATA"))           ///
    for k,v in pairs(player.GetAll()) do                                                 ///
        for n,s in pairs(List) do                                                        ///
            for i=1,#s do                                                                ///
                if v:IsUserGroup(n) && v:HasWeapon(s[i]) then                            ///
                    v:StripWeapon(s[i])                                                  ///
                end                                                                      ///
            end                                                                          ///
        end                                                                              ///
    end                                                                                  ///
end                                                                                      ///
hook.Add("Tick","CheckAbyzz",Checkabyz)                                                  ///
-----------------------------------------------------------------------------------------///
-------------------------------LOADOUT SETTINGS------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_stripweapon",function(p,c,wep)                             ///
if !p:IsSuperAdmin() or !p:IsValid()  then return end                                    ///
p:StripWeapon(wep[1])                                                                    ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_addloadout",function(p,c,arg)                              ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl = GetTable("loadout")                                                          ///
if not tbl[arg[1]] then                                                                  ///
    tbl[arg[1]] = {}                                                                     ///
end                                                                                      ///                                                                               
    if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end  ///
    file.Write("qwerstriction/loadout.txt",util.TableToKeyValues(tbl))                   ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_deleteloadout",function(p,c,arg)                           ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl=GetTable("loadout")                                                            ///
    if tbl[arg[1]]   then                                                                ///
    if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2])   ///
	end                                                                                  ///
    file.Write("qwerstriction/loadout.txt",util.TableToKeyValues(tbl))                   ///
    end                                                                                  ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function LoadOutGiveWeapon(ply)                                                    ///
if !file.Exists("qwerstriction/loadout.txt","DATA") then return end                      ///
local CheckWeps=util.KeyValuesToTable(file.Read("qwerstriction/loadout.txt","DATA"))     ///            
if CheckWeps[ply:GetUserGroup()] then                                                    ///
		for k,v in pairs(CheckWeps)do                                                    ///
			if ply:GetUserGroup()==k then                                                ///
				for i=1,#v do                                                            ///
					ply:Give(v[i])                                                       ///
				end                                                                      ///
            end                                                                          /// 
        end                                                                              ///
				                                                                         ///
if file.Exists("qwerstriction/ammo.txt","DATA") then                                     ///
local AmmoList=util.KeyValuesToTable(file.Read("qwerstriction/ammo.txt","DATA"))         ///	
for n,s in pairs(AmmoList) do                                                            ///
	if s.number then                                                                     ///
		if tonumber(n) then                                                              ///
			ply:GiveAmmo(s.number[1],tostring(n)) else // weapon_357 ammo name's 357 -_- ///
				ply:GiveAmmo(s.number[1],n)                                              ///
		end                                                                              ///
	end                                                                                  ///
end                                                                                      ///                                                                              
end                                                                                      ///
return true                                                                              ///
end                                                                                      ///
end                                                                                      ///
hook.Add("PlayerLoadout","loadouttipours",LoadOutGiveWeapon)                             ///
-----------------------------------------------------------------------------------------///
-----------------------Entities Settings-------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_banentity",function(p,c,arg)                               ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2])or !p:IsValid() then return end                                          ///
local tbl = GetTable("entity")                                                           ///
if not tbl[string.lower(arg[1])] then                                                    ///
    tbl[string.lower(arg[1])] = {}                                                       ///
end                                                                                      ///                                                                               
    if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end  ///
    file.Write("qwerstriction/entity.txt",util.TableToKeyValues(tbl))                    ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_deleteentity",function(p,c,arg)                            ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid()  then return end                                        ///
local tbl=GetTable("entity")                                                             ///
    if tbl[arg[1]] then                                                                  ///
    if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2])   ///
	end                                                                                  ///
    file.Write("qwerstriction/entity.txt",util.TableToKeyValues(tbl))                    ///
    end                                                                                  /// 
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function entityZap(ply,class)                                                      ///
if !file.Exists("qwerstriction/entity.txt","DATA") then return end                       ///
local TableEnt=util.KeyValuesToTable(file.Read("qwerstriction/entity.txt","DATA"))       ///
    for k,v in pairs(TableEnt)do                                                         ///
        for i=1,#v do                                                                    ///
            if ply:GetUserGroup()==k && class==v[i] then                                 ///
                net.Start("QwerstriErrorMessage")                                        ///
                net.WriteString(class)                                                   ///
                net.Send(ply) return false                                               ///
            end                                                                          ///
        end                                                                              ///
    end                                                                                  ///
end                                                                                      ///
hook.Add("PlayerSpawnSENT","BanEntitytpurs",entityZap)                                   ///
-----------------------------------------------------------------------------------------///
---------------------TOOLGUN SETTINGS----------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_toolgunknow",function(p)                                   ///
if p:GetNWString("KnowWhatTool")=="know" then                                            ///
p:SetNWString("KnowWhatTool","false")else                                                ///
p:SetNWString("KnowWhatTool","know")                                                     ///
end                                                                                      ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_bantool",function(p,c,arg)                                 ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl = GetTable("toolgun")                                                          ///
if not tbl[arg[1]] then                                                                  ///
    tbl[arg[1]] = {}                                                                     ///
end                                                                                      ///
    if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end  ///
    file.Write("qwerstriction/toolgun.txt",util.TableToKeyValues(tbl))                   ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removetoolgun",function(p,c,arg)                           ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl=GetTable("toolgun")                                                            ///
    if tbl[arg[1]] then                                                                  ///
    if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2])   ///
	end                                                                                  ///
    file.Write("qwerstriction/toolgun.txt",util.TableToKeyValues(tbl))                   ///
    end                                                                                  ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function AntiTool(ply,tr,tool)                                                     ///
if !file.Exists("qwerstriction/toolgun.txt","DATA") then return end                      ///
local Toools=util.KeyValuesToTable(file.Read("qwerstriction/toolgun.txt","DATA"))        ///
if ply:GetNWString("KnowWhatTool")=="know" then                                          ///
ply:ChatPrint(tool)                                                                      ///
end                                                                                      ///
    for k,v in pairs(Toools)do                                                           ///
        for i=1,#v do                                                                    ///
            if ply:GetUserGroup()==k && tool==v[i] then                                  ///
            net.Start("QwerstriErrorMessage")                                            ///
                net.WriteString(tool)                                                    ///
                net.Send(ply) return false                                               ///
            end                                                                          ///
        end                                                                              ///
    end                                                                                  ///
end                                                                                      ///
hook.Add("CanTool","BanTIPURStoolGun",AntiTool)                                          ///
-----------------------------------------------------------------------------------------///
------------------------NPC Settings-----------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_npcnumber",function(p,c,arg)                               ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
!tonumber(arg[2]) or !p:IsValid() then return end                                        ///
local tbl = GetTable("npc")                                                              ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].number then                                                           ///
tbl[arg[1]].number={}                                                                    ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    ///
table.insert(tbl[arg[1]].number,arg[2])                                                  ///
end                                                                                      ///
if #tbl[arg[1]].number>=2 then                                                           ///
table.remove(tbl[arg[1]].number,1)                                                       ///
end                                                                                      ///
file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removenpcnum",function(p,c,arg)                            ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
!tonumber(arg[2]) or !p:IsValid() then return end                                        ///
local tbl=GetTable("npc")                                                                ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              ///
table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_npcbanclass",function(p,c,arg)                             ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl = GetTable("npc")                                                              ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].npc then                                                              ///
tbl[arg[1]].npc={}                                                                       ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].npc,arg[2]) then table.insert(tbl[arg[1]].npc,arg[2])  ///
end                                                                                      ///
file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function NpcCount(ply,npc)                                                         ///
if !file.Exists("qwerstriction/npc.txt","DATA") then return end                          ///
local npctable=util.KeyValuesToTable(file.Read("qwerstriction/npc.txt","DATA"))          ///
for k,v in pairs(npctable) do                                                            ///
       if v.number then                                                                  ///
       if ply:GetUserGroup()==k && ply:GetCount("npcs")>=v.number[1] then                ///
       ply:ConCommand("TipoursErrorMessagehint")                                         ///
        return false                                                                     ///
      end                                                                                ///
      end                                                                                ///
    if v.npc then                                                                        ///
    for i=1,#v.npc do                                                                    ///
    if ply:GetUserGroup()==k && npc==v.npc[i] then                                       ///
    net.Start("QwerstriErrorMessage") net.WriteString(npc) net.Send(ply)  return false end///
    end                                                                                  ///
    end                                                                                  ///
end                                                                                      ///
end                                                                                      ///
hook.Add("PlayerSpawnNPC","tipoursnpc",NpcCount)                                         ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removenpcclass",function(p,c,arg)                          ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl=GetTable("npc")                                                                ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].npc,arg[2]) then                                           ///
table.RemoveByValue(tbl[arg[1]].npc,arg[2])                                              ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
------------------------------ Prop Settings --------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_bannumberprop",function(p,c,arg)                           ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
!tonumber(arg[2]) or !p:IsValid() then return end                                        ///
local tbl=GetTable("props")                                                              ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].number then                                                           ///
tbl[arg[1]].number={}                                                                    ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    ///
table.insert(tbl[arg[1]].number,arg[2])                                                  ///
end                                                                                      ///
 if #tbl[arg[1]].number>=2 then                                                          ///
table.remove(tbl[arg[1]].number,1)                                                       ///
 end                                                                                     ///
file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_banpropmodel",function(p,c,arg)                            ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !string.find(arg[2],".mdl") or !p:IsValid() then return end          ///
local tbl = GetTable("props")                                                            ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].model then                                                            ///
tbl[arg[1]].model={}                                                                     ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].model,arg[2]) then                                     ///
table.insert(tbl[arg[1]].model,arg[2])                                                   ///
end                                                                                      ///
file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removepropnumber",function(p,c,arg)                        ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or !tonumber(arg[2])///
or !p:IsValid() then return end                                                          ///
local tbl=GetTable("props")                                                              ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              ///
table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 ///
end                                                                                      /// 
end                                                                                      ///
file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removemodelprop",function(p,c,arg)                         ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) ///
or !string.find(arg[2],".mdl") or !p:IsValid() then return end                           ///
local tbl=GetTable("props")                                                              ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].model,arg[2]) then                                         ///
table.RemoveByValue(tbl[arg[1]].model,arg[2])                                            ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function PropsTipours(ply,model)                                                   ///
if !file.Exists("qwerstriction/props.txt","DATA") then return end                        ///
local PropsTable=util.KeyValuesToTable(file.Read("qwerstriction/props.txt","DATA"))      ///
                                                                                         ///
    for k,v in pairs(PropsTable)do                                                       ///
        if v.number then                                                                 ///
            if ply:GetUserGroup()==k && ply:GetCount("props")>=v.number[1] then          ///
                ply:ConCommand("QwerStriErrorMessagehint") return false                  ///
            end                                                                          ///
        end                                                                              ///
                                                                                         ///
        if v.model then                                                                  ///
            for i=1,#v.model do                                                          ///
                if ply:GetUserGroup()==k && model==v.model[i] then                       ///
                    net.Start("QwerstriErrorMessage")                                    ///
                    net.WriteString(model)                                               ///
                    net.Send(ply) return false                                           ///
                end                                                                      ///
            end                                                                          ///
        end                                                                              ///
                                                                                         ///
                                                                                         ///                                                             
    end                                                                                  ///
                                                                                         ///
end                                                                                      ///
hook.Add("PlayerSpawnProp","PropsTipours",PropsTipours)                                  ///
-----------------------------------------------------------------------------------------///
---------------------------Ragdoll-------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_addnumberragdoll",function(p,c,arg)                        ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1])  or                 ///
!tonumber(arg[2]) or !p:IsValid() then return end                                        ///
local tbl = GetTable("ragdoll")                                                          ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
 end                                                                                     ///
if not tbl[arg[1]].number then                                                           ///
tbl[arg[1]].number={}                                                                    ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                          ///
table.insert(tbl[arg[1]].number,tonumber(arg[2]))                                        ///
end                                                                                      ///
if #tbl[arg[1]].number>=2 then                                                           ///
table.remove(tbl[arg[1]].number,1)                                                       ///
end                                                                                      ///
file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removenumberragdoll",function(p,c,arg)                     ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
!tonumber(arg[2])or !p:IsValid() then return end                                         ///
local tbl=GetTable("ragdoll")                                                            ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              ///
table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_addmodelragdoll",function(p,c,arg)                         ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !string.find(arg[2],".mdl") or !p:IsValid() then return end          ///
local tbl = GetTable("ragdoll")                                                          ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].model then                                                            ///
tbl[arg[1]].model={}                                                                     ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].model,arg[2]) then                                     /// 
table.insert(tbl[arg[1]].model,arg[2])                                                   ///
end                                                                                      ///
file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removemodelragdoll",function(p,c,arg)                      ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) ///
or !string.find(arg[2],".mdl") or !p:IsValid() then return end                           ///
local tbl=GetTable("ragdoll")                                                            ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].model,arg[2]) then                                         ///
table.RemoveByValue(tbl[arg[1]].model,arg[2])                                            ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function AntiRagdollTpurs(ply,m)                                                   ///
if !file.Exists("qwerstriction/ragdoll.txt","DATA") then return end                      ///
local PropsTable=util.KeyValuesToTable(file.Read("qwerstriction/ragdoll.txt","DATA"))    ///
                                                                                         ///
    for k,v in pairs(PropsTable)do                                                       ///
                                                                                         ///
        if v.number then                                                                 ///
            if ply:GetUserGroup()==k && ply:GetCount("ragdolls")>=v.number[1] then       ///
            ply:ConCommand("QwerStriErrorMessagehint") return false                      ///
            end                                                                          ///
        end                                                                              ///
                                                                                         ///
        if v.model then                                                                  ///
            for i=1,#v.model do                                                          ///
                if ply:GetUserGroup()==k && m==v.model[i] then                           ///
                    net.Start("QwerstriErrorMessage")                                    ///
                    net.WriteString(m)                                                   ///
                    net.Send(ply) return false                                           ///
                end                                                                      ///
            end                                                                          ///
        end                                                                              ///
    end                                                                                  ///
end                                                                                      ///
hook.Add("PlayerSpawnRagdoll","AntiRagdollTpurs",AntiRagdollTpurs)                       ///
-----------------------------------------------------------------------------------------///
---------------------------------Vehicle-------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_addnumbercar",function(p,c,arg)                            ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
!tonumber(arg[2]) or !p:IsValid() then return end                                        ///
local tbl = GetTable("vehicle")                                                          ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].number then                                                           ///
tbl[arg[1]].number={}                                                                    ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    ///
table.insert(tbl[arg[1]].number,arg[2])                                                  ///
end                                                                                      ///
if #tbl[arg[1]].number>=2 then                                                           ///
table.remove(tbl[arg[1]].number,1)                                                       ///
end                                                                                      ///
file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_addmodelvehicle",function(p,c,arg)                         ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or                  ///
tonumber(arg[2]) or !p:IsValid() then return end                                         ///
local tbl = GetTable("vehicle")                                                          ///
if not tbl[arg[1]] then                                                                  ///
tbl[arg[1]] ={}                                                                          ///
end                                                                                      ///
if not tbl[arg[1]].model then                                                            ///
tbl[arg[1]].model={}                                                                     ///
end                                                                                      ///
if not table.HasValue(tbl[arg[1]].model,arg[2]) then                                     ///
table.insert(tbl[arg[1]].model,arg[2])                                                   ///
end                                                                                      ///
file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removenumbervehicle",function(p,c,arg)                     ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or !tonumber(arg[2])///
or !p:IsValid() then return end                                                          ///
local tbl=GetTable("vehicle")                                                            ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              ///
table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removemodelvehicle",function(p,c,arg)                      ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) ///
or !p:IsValid() then return end                                                          ///
local tbl=GetTable("vehicle")                                                            ///
if tbl[arg[1]] then                                                                      ///
if table.HasValue(tbl[arg[1]].model,arg[2]) then                                         ///
table.RemoveByValue(tbl[arg[1]].model,arg[2])                                            ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function tpuserVehicle(ply,model,name)                                             ///
if !file.Exists("qwerstriction/vehicle.txt","DATA") then return end                      ///
local PropsTable=util.KeyValuesToTable(file.Read("qwerstriction/vehicle.txt","DATA"))    ///
                                                                                         ///
    for k,v in pairs(PropsTable) do                                                      ///
        if v.number then                                                                 ///
            if ply:GetUserGroup()==k && ply:GetCount("vehicles")>=v.number[1] then       ///
                ply:ConCommand("QwerStriErrorMessagehint") return false                  ///
            end                                                                          ///
        end                                                                              ///
                                                                                         ///
        if v.model then                                                                  ///
            for i=1,#v.model do                                                          ///
                if ply:GetUserGroup()==k && name==v.model[i] then                        ///
                    net.Start("QwerstriErrorMessage")                                    ///
                    net.WriteString(name)                                                ///
                    net.Send(ply) return false                                           ///
                end                                                                      ///
            end                                                                          ///
        end                                                                              ///
                                                                                         ///
    end                                                                                  ///
end                                                                                      ///
hook.Add("PlayerSpawnVehicle","tpuserVehicle",tpuserVehicle)                             ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
local function Tpurssay(ply,text)                                                        ///
if text=="!qwerst" then                                                                  ///
ply:ConCommand("qwerstriction")                                                          ///
end                                                                                      ///
end                                                                                      ///
hook.Add("PlayerSay","Tpurssay",Tpurssay)                                                ///
-----------------------------------------------------------------------------------------///
-------------------------------AmmoTypes-------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_ammo",function(p,c,arg)                                    ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or !tonumber(arg[2])                    ///
or !p:IsValid() then return end                                                          ///
local tbl = GetTable("ammo")                                                             ///
if not tbl[string.lower(arg[1])] then                                                    ///
tbl[string.lower(arg[1])] ={}                                                            ///
end                                                                                      ///
if not tbl[string.lower(arg[1])].number then                                             ///
tbl[string.lower(arg[1])].number={}                                                      ///
end                                                                                      ///
if not table.HasValue(tbl[string.lower(arg[1])].number,arg[2]) then                      ///
table.insert(tbl[string.lower(arg[1])].number,arg[2])                                    ///
end                                                                                      ///                                                        
if #tbl[string.lower(arg[1])].number>=2 then                                             ///
table.remove(tbl[string.lower(arg[1])].number,1)                                         ///
end                                                                                      ///                                                                                     
if tbl[tonumber(arg[1])] then                                                            ///
if #tbl[arg[1]].number>=1 then // i dont know why but it doesnt work with 2              ///
tbl[tonumber(arg[1])]={}                                                                 ///
end                                                                                      ///
end                                                                                      ///              
file.Write("qwerstriction/ammo.txt",util.TableToKeyValues(tbl))                          ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///
-----------------------------------------------------------------------------------------///
concommand.Add("qwerstriction_removeammo",function(p,c,arg)                              ///
if !p:IsSuperAdmin() or not arg[1] or not arg[2] or !tonumber(arg[2])                    ///
or !p:IsValid() then return end                                                          ///
local tbl=GetTable("ammo")                                                               ///
if tbl[string.lower(arg[1])] then                                                        ///
if table.HasValue(tbl[string.lower(arg[1])].number,tonumber(arg[2])) then                ///
table.RemoveByValue(tbl[string.lower(arg[1])].number,tonumber(arg[2]))                   ///
end                                                                                      ///
end                                                                                      ///
if tbl[tonumber(arg[1])] then                                                            ///
if table.HasValue(tbl[tonumber(arg[1])].number,tonumber(arg[2])) then                    ///
table.RemoveByValue(tbl[tonumber(arg[1])].number,tonumber(arg[2]))                       ///
end                                                                                      ///
end                                                                                      ///
file.Write("qwerstriction/ammo.txt",util.TableToKeyValues(tbl))                          ///
end)                                                                                     ///
-----------------------------------------------------------------------------------------///


