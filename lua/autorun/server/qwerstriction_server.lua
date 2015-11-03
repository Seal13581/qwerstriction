util.AddNetworkString("SendQwerstriTables")
util.AddNetworkString("QwerstriErrorMessage")
util.AddNetworkString("QWERST_ACCESS_CHECK")



function qwertmainfiles()

	if !file.IsDir("qwerstriction","DATA") then
		file.CreateDir("qwerstriction")
	end
	--------------------------------------------------------
	if !file.Exists("qwerstriction/weapon.txt","DATA") then 
		file.Write("qwerstriction/weapon.txt")
	end
	qwersweapon=util.KeyValuesToTable(file.Read("qwerstriction/weapon.txt","DATA"))
    --------------------------------------------------------
	if !file.Exists("qwerstriction/loadout.txt","DATA") then
		file.Write("qwerstriction/loadout.txt")
	end
	qwersloadout=util.KeyValuesToTable(file.Read("qwerstriction/loadout.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/entity.txt","DATA") then
		file.Write("qwerstriction/entity.txt")
	end
	qwersent=util.KeyValuesToTable(file.Read("qwerstriction/entity.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/toolgun.txt","DATA") then
		file.Write("qwerstriction/toolgun.txt")
	end
	qwerstoolgun=util.KeyValuesToTable(file.Read("qwerstriction/toolgun.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/npc.txt","DATA") then
		file.Write("qwerstriction/npc.txt")
	end
	qwersnpc=util.KeyValuesToTable(file.Read("qwerstriction/npc.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/props.txt","DATA") then
		file.Write("qwerstriction/props.txt")
	end
	qwersprop=util.KeyValuesToTable(file.Read("qwerstriction/props.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/ragdoll.txt","DATA") then
		file.Write("qwerstriction/ragdoll.txt")
	end
	qwersragdoll=util.KeyValuesToTable(file.Read("qwerstriction/ragdoll.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/vehicle.txt","DATA") then
		file.Write("qwerstriction/vehicle.txt")
	end
	qwersvehicle=util.KeyValuesToTable(file.Read("qwerstriction/vehicle.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/ammo.txt","DATA") then
		file.Write("qwerstriction/ammo.txt")
	end
	qwersammo=util.KeyValuesToTable(file.Read("qwerstriction/ammo.txt","DATA"))
	--------------------------------------------------------
	if !file.Exists("qwerstriction/playermodels.txt","DATA") then
		file.Write("qwerstriction/playermodels.txt")
	end
	qwersplayermodels=util.KeyValuesToTable(file.Read("qwerstriction/playermodels.txt","DATA"))
	
	if !file.Exists("qwerstriction/other.txt","DATA") then
		local defaccess={access={"superadmin"}}
		file.Write("qwerstriction/other.txt",util.TableToKeyValues(defaccess))
	end
	qwersother=util.KeyValuesToTable(file.Read("qwerstriction/other.txt","DATA"))
	
end

qwertmainfiles() -- for the first load=))

concommand.Add("qwerstriction_refresh",function(p)
	

	
	qwertmainfiles()
	
	net.Start("SendQwerstriTables")
	-------------------------------
	net.WriteTable(qwersweapon)
	net.WriteTable(qwersloadout)
	net.WriteTable(qwersent)
	net.WriteTable(qwerstoolgun)
	net.WriteTable(qwersnpc)
	net.WriteTable(qwersprop)
	net.WriteTable(qwersragdoll)
	net.WriteTable(qwersvehicle)
	net.WriteTable(qwersammo)
	net.WriteTable(qwersplayermodels)
	net.WriteTable(qwersother)
	-------------------------------
	net.Send(p)
end)

local function GetTable(element)                                                         
    if file.Exists("qwerstriction/"..element..".txt","DATA") then                        
        return util.KeyValuesToTable(file.Read("qwerstriction/"..element..".txt","DATA"))
    end                                                                                  
end

concommand.Add("qwerstriction_access_check",function(p)
	
	
	net.Start("QWERST_ACCESS_CHECK")
	net.WriteTable(qwersother)
	net.Send(p)
	

end)




-- weapon ban
concommand.Add("qwerstriction_addweapon",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	if not arg[1] or not arg[2] or tonumber(arg[1]) or                 
		tonumber(arg[2]) or !p:IsValid()  then 
			return 
	end
	
	local tbl = GetTable("weapon")   
	   
    if not tbl[arg[1]] then                                                              
        tbl[arg[1]] = {}                                                                 
    end
     
    if not table.HasValue(tbl[arg[1]],arg[2]) then 
    	table.insert(tbl[arg[1]],arg[2]) 
    end  
    
    file.Write("qwerstriction/weapon.txt",util.TableToKeyValues(tbl))                    
end)                                                                                     

concommand.Add("qwerstriction_deleteweapon",function(p,c,arg) 
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or !p:IsValid() then 
		return 
	end 
	  
	local tbl=GetTable("weapon")                                                             
    if  tbl[arg[1]] then                                                                 
    	if table.HasValue(tbl[arg[1]],arg[2]) then 
    		table.RemoveByValue(tbl[arg[1]],arg[2])   
	    end                                                                                  
    	file.Write("qwerstriction/weapon.txt",util.TableToKeyValues(tbl))                    
    end                                                                                  
end)                                                                                     

local function CheckPlyWep(ply,class)  
	if !qwersweapon then return end
	for n,s in pairs(qwersweapon) do
		
		for i=1,#s do 
			
            if ply:IsUserGroup(n) && class==(s[i]) then                                  
	        	net.Start("QwerstriErrorMessage")          
                net.WriteString(class)                                                   
                net.Send(ply)  return false                                              
            end 
            
            if ply:IsUserGroup(n) && s[i]=="*" then 
            	net.Start("QwerstriErrorMessage")
            	net.WriteString(class)
            	net.Send(ply) return false 
        	end
            
        end
        
    end                                                                                  
end                                                                                      
hook.Add("PlayerGiveSWEP","RejjectWeapon",CheckPlyWep)                                   

local function Checkabyz()
	if !qwersweapon then return end
    for k,v in pairs(player.GetAll()) do                                                 
        for n,s in pairs(qwersweapon) do                                                     
            for i=1,#s do
            	 
                if v:IsUserGroup(n) && v:HasWeapon(s[i]) then                            
                    v:StripWeapon(s[i])                                                  
                end
                
                if v:IsUserGroup(n) && s[i]=="*" then
                	v:StripWeapons()
            	end
                  
            end                                                                          
        end                                                                              
    end                                                                                  
end                                                                                      
hook.Add("Tick","CheckAbyzz",Checkabyz)
-- weapon ban

-- loadout

concommand.Add("qwerstriction_stripweapon",function(p,c,wep)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	if  !p:IsValid()  then return end                                   
	p:StripWeapon(wep[1])                                                             
end)

concommand.Add("qwerstriction_addloadout",function(p,c,arg)  
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or !p:IsValid() then return 
	end
	
	local tbl = GetTable("loadout")  

	if not tbl[arg[1]] then                                                                  
    	tbl[arg[1]] = {}                                                                    
	end
	
    if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end 
     
    file.Write("qwerstriction/loadout.txt",util.TableToKeyValues(tbl))                   
end)

concommand.Add("qwerstriction_deleteloadout",function(p,c,arg)   
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or !p:IsValid() then return 
	end

	local tbl=GetTable("loadout")    
 
    if tbl[arg[1]]   then                                                                
    	if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2]) end
    	
    	file.Write("qwerstriction/loadout.txt",util.TableToKeyValues(tbl))                   
    end 
end)

concommand.Add("qwerstriction_ammo",function(p,c,arg)     -- 3 group - 2 bullet 1- name of bullet   
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end


	if  not arg[1] or not arg[2] or not arg[3] or !tonumber(arg[2]) or tonumber(arg[3]) or !p:IsValid() then 
		return 
	end
	
	local tbl = GetTable("ammo")
 
	if not tbl[string.lower(arg[3])] then                                                    
		tbl[string.lower(arg[3])] ={}                                                            
	end 
	
		if tonumber(arg[1]) then
			if not tbl[string.lower(arg[3])][(arg[1])] then                                             
				tbl[string.lower(arg[3])][tonumber(arg[1])]=arg[2]                                                
			end
			else
			if not tbl[string.lower(arg[3])][(arg[1])] then                                             
				tbl[string.lower(arg[3])][arg[1]]=arg[2]                                                
			end
		end
		
	file.Write("qwerstriction/ammo.txt",util.TableToKeyValues(tbl))                          
end)

concommand.Add("qwerstriction_removeammo",function(p,c,arg) 
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
  
	if not arg[1] or not arg[2] or not arg[3] or !tonumber(arg[2]) or tonumber(arg[3]) or !p:IsValid() then 
		return 
	end 
	
	local tbl=GetTable("ammo")
	
	
	if tbl[arg[3]] then
		tbl[arg[3]][arg[1]]={}
	end
	
	if tonumber(arg[1]) then
		if tbl[arg[3]] then
			tbl[arg[3]][tonumber(arg[1])]={}
		end
	end
	
file.Write("qwerstriction/ammo.txt",util.TableToKeyValues(tbl))                          
end)



	local function LoadOutGiveWeapon(ply)
		if !qwersloadout then return end
			if qwersloadout[ply:GetUserGroup()] then
				for k,v in pairs(qwersloadout) do
					if ply:GetUserGroup()==k then
						for i=1,#v do                                                            
							ply:Give(v[i])                                                                    
						end                                                                       
					end
				end
				return true
			end
	end
	hook.Add("PlayerLoadout","loadoutqwers",LoadOutGiveWeapon)
	
	
	
	local function LoadoutAmmo(ply)
		if !qwersammo then return end
			timer.Simple(0.1,function()
				for k,v in pairs(qwersammo) do
					for n,s in pairs(v) do
						if ply:GetUserGroup()==k then
							if tonumber(n) then
								ply:GiveAmmo(s,tostring(n),true)
									else
										ply:GiveAmmo(s,n,true)
							end
						end
					end
				end
			end)
		end
		hook.Add("PlayerSpawn","LoadoutAmmo",LoadoutAmmo)
	
-- loadout

-- entities

concommand.Add("qwerstriction_banentity",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if not arg[1] or not arg[2] or tonumber(arg[1]) or                 
		tonumber(arg[2])or !p:IsValid() then return 
	end
	 
	local tbl = GetTable("entity") 
	
	if not tbl[string.lower(arg[1])] then                                                   
    	tbl[string.lower(arg[1])] = {}                                                       
	end
	
	if not tbl[string.lower(arg[1])].ent then
		tbl[string.lower(arg[1])].ent={}
	end
	
    if not table.HasValue(tbl[arg[1]].ent,arg[2]) then table.insert(tbl[arg[1]].ent,arg[2]) end  
    file.Write("qwerstriction/entity.txt",util.TableToKeyValues(tbl))                    
end) 

concommand.Add("qwerstriction_deleteentity",function(p,c,arg) 
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	if not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) or !p:IsValid()  then
		return 
	end
	
	local tbl=GetTable("entity")
	
    if tbl[arg[1]] then 
    	if table.HasValue(tbl[arg[1]].ent,arg[2]) then 
    		table.RemoveByValue(tbl[arg[1]].ent,arg[2]) 
    	end                                                                                  
   		file.Write("qwerstriction/entity.txt",util.TableToKeyValues(tbl))                    
    end                                                                                  
end)


concommand.Add("qwerstriction_bannumberent",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or !tonumber(arg[2]) or 
		!p:IsValid() then return 
	end
	
	local tbl = GetTable("entity")
	
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	
	if not tbl[arg[1]].number then                                                           
		tbl[arg[1]].number={}                                                                    
	end
	
	if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    
		table.insert(tbl[arg[1]].number,arg[2])                                                  
	end
	
	if #tbl[arg[1]].number>=2 then                                                           
		table.remove(tbl[arg[1]].number,1)                                                       
	end                                                                                      
	file.Write("qwerstriction/entity.txt",util.TableToKeyValues(tbl))
end)


concommand.Add("qwerstriction_removeentnumber",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or 
		!tonumber(arg[2]) or !p:IsValid() then return 
	end
	
	local tbl=GetTable("entity")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              
			table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 
		end                                                                                      
	end                                                                                      
	file.Write("qwerstriction/entity.txt",util.TableToKeyValues(tbl))
end)



	local function entityZap(ply,class)                      
    	if !qwersent then return end
    	
    	
    	for k,v in pairs(qwersent) do
    		
    		if v.ent then
        		for i=1,#v.ent do                                                                    
            		if ply:GetUserGroup()==k && class==v.ent[i] then                                 
                		net.Start("QwerstriErrorMessage")                                        
                		net.WriteString(class)                                                   
                		net.Send(ply) return false                                               
            		end                                                                          
        		end                                                                              
    		end
    		
    		if v.number then
    			if ply:GetUserGroup()==k && ply:GetCount("sents")>=v.number[1] then
    				ply:ConCommand("QwerStriErrorMessagehint") return false 
				end
			end
 
    	end                                                                                  
	end                                                                                      
	hook.Add("PlayerSpawnSENT","BanEntitytpurs",entityZap)  
	
-- toolgun

concommand.Add("qwerstriction_toolgunknow",function(p)                                   
	if p:GetNWString("KnowWhatTool")=="know" then                                            
		p:SetNWString("KnowWhatTool","false")else                                                
		p:SetNWString("KnowWhatTool","know")                                                     
	end                                                                                      
end)

concommand.Add("qwerstriction_bantool",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	 
	local tbl = GetTable("toolgun")
	 
	if not tbl[arg[1]] then                                                                  
    	tbl[arg[1]] = {}                                                                     
	end
	
    if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end  
    file.Write("qwerstriction/toolgun.txt",util.TableToKeyValues(tbl))                   
end) 

concommand.Add("qwerstriction_removetoolgun",function(p,c,arg)    
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl=GetTable("toolgun")
	 
    if tbl[arg[1]] then                                                                  
    	if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2]) end                                                                                 
    	file.Write("qwerstriction/toolgun.txt",util.TableToKeyValues(tbl))                   
    end                                                                                  
end)

	local function AntiTool(ply,tr,tool)                                                     
		if !qwerstoolgun then return end
		
		if ply:GetNWString("KnowWhatTool")=="know" then                                          
			ply:ChatPrint(tool)                                                                      
		end
		 
    	for k,v in pairs(qwerstoolgun) do                                                           
        	for i=1,#v do                                                                    
            	if ply:GetUserGroup()==k && tool==v[i] then                                  
            		net.Start("QwerstriErrorMessage")                                            
                	net.WriteString(tool)                                                    
                	net.Send(ply) return false                                               
            	end                                                                          
        	end                                                                              
    	end                                                                                  
	end                                                                                      
	hook.Add("CanTool","BanTIPURStoolGun",AntiTool)
	
-- npc

concommand.Add("qwerstriction_npcnumber",function(p,c,arg)    
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		!tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl = GetTable("npc")
	 
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	
	if not tbl[arg[1]].number then                                                           
		tbl[arg[1]].number={}                                                                    
	end 
	
	if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    
		table.insert(tbl[arg[1]].number,arg[2])                                                  
	end 
	
	if #tbl[arg[1]].number>=2 then                                                           
		table.remove(tbl[arg[1]].number,1)                                                       
	end  
	file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           
end)

concommand.Add("qwerstriction_removenpcnum",function(p,c,arg) 
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		!tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	  
	local tbl=GetTable("npc")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                             
			table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                
		end                                                                                     
	end                                                                                      
	file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           
end)

concommand.Add("qwerstriction_npcbanclass",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl = GetTable("npc")
	  
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	 
	if not tbl[arg[1]].npc then                                                              
		tbl[arg[1]].npc={}                                                                       
	end
	
	if not table.HasValue(tbl[arg[1]].npc,arg[2]) then table.insert(tbl[arg[1]].npc,arg[2]) end                                                                                      
	file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           
end)

concommand.Add("qwerstriction_removenpcclass",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
 
   
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl=GetTable("npc")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].npc,arg[2]) then                                           
			table.RemoveByValue(tbl[arg[1]].npc,arg[2])                                              
		end                                                                                      
	end                                                                                      
	file.Write("qwerstriction/npc.txt",util.TableToKeyValues(tbl))                           
end)

	local function NpcCount(ply,npc)
		if !qwersnpc then return end
		
		for k,v in pairs(qwersnpc) do   
			
       			if v.number then                                                                  
       				if ply:GetUserGroup()==k && ply:GetCount("npcs")>=v.number[1] then                
       					ply:ConCommand("QwerStriErrorMessagehint")                                         
        				return false                                                                     
      				end                                                                                
      			end 
      		 
    		if v.npc then
    			for i=1,#v.npc do                                                                    
    				if ply:GetUserGroup()==k && npc==v.npc[i] then                                       
    					net.Start("QwerstriErrorMessage") 
    					net.WriteString(npc) 
    					net.Send(ply)  return false 
    				end
    			end                                                                                  
    		end                                                                                  
		end                                                                                     
	end                                                                                      
	hook.Add("PlayerSpawnNPC","tipoursnpc",NpcCount)
	
-- props

concommand.Add("qwerstriction_bannumberprop",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		!tonumber(arg[2]) or 
			!p:IsValid() then return 
	end 
	 
	local tbl=GetTable("props")    
	
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end 
	
	if not tbl[arg[1]].number then                                                           
		tbl[arg[1]].number={}                                                                    
	end
	
	if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    
		table.insert(tbl[arg[1]].number,arg[2])                                                  
	end
	
 	if #tbl[arg[1]].number>=2 then                                                          
		table.remove(tbl[arg[1]].number,1)                                                      
 	end                                                                                     
file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         
end) 
	

concommand.Add("qwerstriction_banpropmodel",function(p,c,arg)   
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end


	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or !string.find(arg[2],".mdl") or 
			!p:IsValid() then return 
	end
	
	local tbl = GetTable("props")
	
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	
	if not tbl[arg[1]].model then                                                            
		tbl[arg[1]].model={}                                                                     
	end
	
	if not table.HasValue(tbl[arg[1]].model,arg[2]) then                                     
		table.insert(tbl[arg[1]].model,arg[2])                                                   
	end                                                                                      
	file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         
end)

concommand.Add("qwerstriction_removepropnumber",function(p,c,arg)     
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or !tonumber(arg[2])
		or !p:IsValid() then return 
	end
	  
	local tbl=GetTable("props")
	 
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              
			table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 
		end                                                                                      
	end
	file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         
end)

concommand.Add("qwerstriction_removemodelprop",function(p,c,arg) 
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) 
		or !string.find(arg[2],".mdl") or 
			!p:IsValid() then return 
	end
	 
	local tbl=GetTable("props")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].model,arg[2]) then                                         
			table.RemoveByValue(tbl[arg[1]].model,arg[2])                                            
		end                                                                                      
	end                                                                                   
	file.Write("qwerstriction/props.txt",util.TableToKeyValues(tbl))                         
end)

local function PropsTipours(ply,model)
	if !qwersprop then return end
	
    for k,v in pairs(qwersprop) do  
    	
        if v.number then                                                                 
            if ply:GetUserGroup()==k && ply:GetCount("props")>=v.number[1] then          
                ply:ConCommand("QwerStriErrorMessagehint") return false                  
            end                                                                          
        end
        
        if v.model then                                                                  
            for i=1,#v.model do                                                          
                if ply:GetUserGroup()==k && model==v.model[i] then                       
                    net.Start("QwerstriErrorMessage")                                    
                    net.WriteString(model)                                               
                    net.Send(ply) return false                                           
                end                                                                      
            end                                                                          
        end
        
    end                                                                                  
end                                                                                      
hook.Add("PlayerSpawnProp","PropsTipours",PropsTipours)

--ragdoll


concommand.Add("qwerstriction_addnumberragdoll",function(p,c,arg)  
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
 
   
	if  not arg[1] or not arg[2] or tonumber(arg[1])  or                 
		!tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	  
	local tbl = GetTable("ragdoll")
	
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
 	end
 	 
	if not tbl[arg[1]].number then                                                          
		tbl[arg[1]].number={}                                                                    
	end
	
	if not table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                          
		table.insert(tbl[arg[1]].number,tonumber(arg[2]))                                        
	end
	
	if #tbl[arg[1]].number>=2 then                                                           
		table.remove(tbl[arg[1]].number,1)                                                       
	end
	   
	file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       
end)

concommand.Add("qwerstriction_removenumberragdoll",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end


	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		!tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl=GetTable("ragdoll")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              
			table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 
		end                                                                                      
	end                                                                                  
	file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       
end)

concommand.Add("qwerstriction_addmodelragdoll",function(p,c,arg) 
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
 
   
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or !string.find(arg[2],".mdl") or 
			!p:IsValid() then return 
	end       
	   
	local tbl = GetTable("ragdoll")
	  
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	
	if not tbl[arg[1]].model then                                                            
		tbl[arg[1]].model={}                                                                     
	end
	 
	if not table.HasValue(tbl[arg[1]].model,arg[2]) then                                    
		table.insert(tbl[arg[1]].model,arg[2])                                                   
	end
	
	file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       
end)

concommand.Add("qwerstriction_removemodelragdoll",function(p,c,arg)

	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end

	if  not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) 
		or !string.find(arg[2],".mdl") or 
			!p:IsValid() then return 
	end
	
	local tbl=GetTable("ragdoll")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].model,arg[2]) then                                         
			table.RemoveByValue(tbl[arg[1]].model,arg[2])                                            
		end                                                                                      
	end
	file.Write("qwerstriction/ragdoll.txt",util.TableToKeyValues(tbl))                       
end)

local function AntiRagdollTpurs(ply,m)                                                   
    if !qwersragdoll then return end
    
    for k,v in pairs(qwersragdoll) do
    	
        if v.number then                                                                 
            if ply:GetUserGroup()==k && ply:GetCount("ragdolls")>=v.number[1] then       
            ply:ConCommand("QwerStriErrorMessagehint") return false                      
            end                                                                          
        end
        
        if v.model then                                                                  
            for i=1,#v.model do                                                          
                if ply:GetUserGroup()==k && m==v.model[i] then                           
                    net.Start("QwerstriErrorMessage")                                    
                    net.WriteString(m)                                                   
                    net.Send(ply) return false                                           
                end                                                                      
            end                                                                          
        end                                                                              
    end                                                                                  
end                                                                                      
hook.Add("PlayerSpawnRagdoll","AntiRagdollTpurs",AntiRagdollTpurs)

-- cars


concommand.Add("qwerstriction_addnumbercar",function(p,c,arg)    
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
   
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		!tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl = GetTable("vehicle")
	  
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	   
	if not tbl[arg[1]].number then                                                           
		tbl[arg[1]].number={}                                                                    
	end
	
	if not table.HasValue(tbl[arg[1]].number,arg[2]) then                                    
		table.insert(tbl[arg[1]].number,arg[2])                                                  
	end
	  
	if #tbl[arg[1]].number>=2 then                                                           
		table.remove(tbl[arg[1]].number,1)                                                       
	end                                                                                     
	file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       
end)

concommand.Add("qwerstriction_addmodelvehicle",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end  
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	  
	local tbl = GetTable("vehicle")
	
	if not tbl[arg[1]] then                                                                  
		tbl[arg[1]] ={}                                                                          
	end
	  
	if not tbl[arg[1]].model then                                                            
		tbl[arg[1]].model={}                                                                     
	end
	 
	if not table.HasValue(tbl[arg[1]].model,arg[2]) then                                     
		table.insert(tbl[arg[1]].model,arg[2])                                                   
	end   
	file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       
end)

concommand.Add("qwerstriction_removenumbervehicle",function(p,c,arg)     
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
 
   
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or !tonumber(arg[2])
		or !p:IsValid() then return 
	end
	
	local tbl=GetTable("vehicle")
	
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].number,tonumber(arg[2])) then                              
			table.RemoveByValue(tbl[arg[1]].number,tonumber(arg[2]))                                 
		end                                                                                      
	end  
	file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       
end)

concommand.Add("qwerstriction_removemodelvehicle",function(p,c,arg)     
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
	
	
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) 
		or !p:IsValid() then return 
	end
	
	local tbl=GetTable("vehicle")
	  
	if tbl[arg[1]] then                                                                      
		if table.HasValue(tbl[arg[1]].model,arg[2]) then                                         
			table.RemoveByValue(tbl[arg[1]].model,arg[2])                                            
		end                                                                                      
	end
	file.Write("qwerstriction/vehicle.txt",util.TableToKeyValues(tbl))                       
end)

local function tpuserVehicle(ply,model,name)                                             
    if !qwersvehicle then return end
    
    for k,v in pairs(qwersvehicle) do                                                      
        if v.number then                                                                 
            if ply:GetUserGroup()==k && ply:GetCount("vehicles")>=v.number[1] then       
                ply:ConCommand("QwerStriErrorMessagehint") return false                  
            end                                                                          
        end
        
        if v.model then                                                                  
            for i=1,#v.model do                                                          
                if ply:GetUserGroup()==k && name==v.model[i] then                        
                    net.Start("QwerstriErrorMessage")                                    
                    net.WriteString(name)                                                
                    net.Send(ply) return false                                           
                end                                                                      
            end                                                                          
        end
        
    end                                                                                  
end                                                                                      
hook.Add("PlayerSpawnVehicle","tpuserVehicle",tpuserVehicle)


-- playermodel

concommand.Add("qwerstriction_banplayermodel",function(p,c,arg)    
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
  
      
	if  not arg[1] or not arg[2] or tonumber(arg[1]) or tonumber(arg[2]) 
		or !string.find(arg[2],".mdl") or 
			!p:IsValid() then return 
	end
	
	local tbl=GetTable("playermodels")
	
	if not tbl[string.lower(arg[1])] then                                                    
		tbl[string.lower(arg[1])] = {}                                                           
	end
	
	if not table.HasValue(tbl[arg[1]],arg[2]) then table.insert(tbl[arg[1]],arg[2]) end      
	file.Write("qwerstriction/playermodels.txt",util.TableToKeyValues(tbl))
end)

concommand.Add("qwerstriction_removeplayermodelfuc",function(p,c,arg)
	
	if qwersother.access then
		if !table.HasValue(qwersother.access,p:GetUserGroup()) then
			return 
		end
	end
  
      
	if   not arg[1] or not arg[2] or tonumber(arg[1]) or                  
		tonumber(arg[2]) or 
			!p:IsValid() then return 
	end
	
	local tbl=GetTable("playermodels")
	
    if  tbl[arg[1]] then                                                                 
    	if table.HasValue(tbl[arg[1]],arg[2]) then table.RemoveByValue(tbl[arg[1]],arg[2]) end                                                                         
    	file.Write("qwerstriction/playermodels.txt",util.TableToKeyValues(tbl))              
    end                                                                                  
end)

function AntiPlayerModelHook()                                                           
	if !qwersplayermodels then return end
	
    for n,s in pairs(player.GetAll())do                                                  
        for k,v in pairs(qwersplayermodels) do                                                     
            for i=1,#v do                                                                
                if s:GetUserGroup()==k && s:GetModel()==v[i] then                        
                    s:ConCommand("cl_playercolor 0 0 0 ")                                
                    s:ConCommand("cl_playermodel ZZZZZZZZZZZZZZ")                              
                    s:Spawn()                                                            
                end                                                                      
            end                                                                          
        end                                                                              
    end                                                                                  
end                                                                                      
hook.Add("Tick","qwerstriction_modelPlayer",AntiPlayerModelHook)

local function Tpurssay(ply,text)                                                        
	if text=="!qwers" or text=="!qwerst" then                                                                  
		ply:ConCommand("qwerstriction")                                                          
	end                                                                                      
end                                                                                     
hook.Add("PlayerSay","Tpurssay",Tpurssay)

-- other

concommand.Add("qwerstriction_access",function(p,c,arg)
	
	if !p:IsSuperAdmin() or not arg[1] or tonumber(arg[1]) or !p:IsValid() or arg[1]=="superadmin" then return end
	
	local tbl=GetTable("other")
	
	if not tbl.access then                                                    
		tbl.access={}                                                 
	end
	
	if not table.HasValue(tbl.access,arg[1]) then table.insert(tbl.access,arg[1]) end      
	file.Write("qwerstriction/other.txt",util.TableToKeyValues(tbl))
	
end)

concommand.Add("qwerstriction_access_remove",function(p,c,arg)
	
	if !p:IsSuperAdmin() or not arg[1] or tonumber(arg[1]) or !p:IsValid() or arg[1]=="superadmin"  then return end
	
	local tbl=GetTable("other")
	
	if tbl.access then
		if table.HasValue(tbl.access,arg[1]) then table.RemoveByValue(tbl.access,arg[1]) end
		file.Write("qwerstriction/other.txt",util.TableToKeyValues(tbl))
	end
	
	
	
end)
	