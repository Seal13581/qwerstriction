net.Receive("QwerstriErrorMessage",function()
	chat.AddText(Color(0,230,0),"[QWERSTRICTION]  ",Color(218,165,32),net.ReadString().." is banned from your group")
end)

concommand.Add("QwerStriErrorMessagehint",function()
	chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," You have reached the limit")
end,_,_,16)


 function QWERST_ACCESS()
		
		LocalPlayer():ConCommand("qwerstriction_access_check")
		
		
		net.Receive("QWERST_ACCESS_CHECK",function()
		
			local accessgroups=net.ReadTable()
			
			
				if table.HasValue(accessgroups.access,LocalPlayer():GetUserGroup()) then
					LocalPlayer():SetNWString("qwers_access","true") else
					LocalPlayer():SetNWString("qwers_access","false")
				end
				
		end)
		
	end



	openedtpurs=false
	
function qwerstriction()
	
	local toolgunname=function() chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," Now click on the ground with your toolgun") end
	local refreshed=function() chat.AddText(Color(218,165,32),"[REFRESH]") surface.PlaySound("hl1/fvox/bell.wav") end
	local shouldbenumber=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,12)," You should write only numbers") surface.PlaySound("buttons/combine_button_locked.wav") end
	local isinloadout=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," This element is already in the loadout for this group") surface.PlaySound("buttons/combine_button_locked.wav") end
	local mustbealive=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," You must be alive!") surface.PlaySound("buttons/combine_button_locked.wav") end
	local plynoweapons=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," You have no weapons") surface.PlaySound("buttons/combine_button_locked.wav") end
	local removeelement=function() surface.PlaySound("ambient/levels/labs/electric_explosion5.wav") end
	local success=function() surface.PlaySound("hl1/fvox/bell.wav") end	
	local empty=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," Empty box") surface.PlaySound("buttons/combine_button_locked.wav") end
	local admincheck=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," Your can't do it") surface.PlaySound("buttons/combine_button_locked.wav") end
	local onlynumbers=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," You should write only letters") surface.PlaySound("buttons/combine_button_locked.wav") end 
	local inthelist=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," This element is already banned from this group") surface.PlaySound("buttons/combine_button_locked.wav") end 
	local wheremdl=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(218,165,32)," .mdl need for models") surface.PlaySound("buttons/combine_button_locked.wav") end
	local DefModel=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(210,165,32)," This is default model player") surface.PlaySound("buttons/combine_button_locked.wav") end
	local CANUSE=function() if LocalPlayer():GetNWString("qwers_access")=="true" then return true end end
	local SUPERADMINONLY=function() chat.AddText(Color(255,0,0),"[ERROR] ",Color(210,165,32)," Only superadmins can change this value") surface.PlaySound("buttons/combine_button_locked.wav") end
	
	
	
	
	if IsValid(MainWindow) then
		MainWindow:SetVisible(true) openedtpurs=true  return 
	end
	openedtpurs=true
	
	MainWindow=vgui.Create("DFrame")
	MainWindow:SetSize(660,440)
	MainWindow:SetPos(ScrW()/2-660/2,ScrH()/2-440/2)
	MainWindow:MakePopup()
	MainWindow:SetTitle("")
	MainWindow:ShowCloseButton(false)
	MainWindow:SetKeyboardInputEnabled(false)

	MainWindow.Paint=function(self)
	draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(50,50,50,235))
	draw.DrawText("[QWERSTRICTION]","HUDSELECTIONTEXT",300,10,Color(255,255,255,255),TEXT_ALIGN_CENTER)
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
	
	-- settings weapons ban and remove
	local Form1=vgui.Create("DTextEntry",WepBan)
	Form1:SetPos(5,50)
	Form1:SetSize(600,20)
	Form1:SetText("Ban * for global ban")
-- ulx	
	if xgui then
		Form2=vgui.Create("DComboBox",WepBan)
			for k,v in pairs(xgui.data.groups) do
				Form2:AddChoice(v)
			end
		Form2:ChooseOption("user")
		else
		Form2=vgui.Create("DTextEntry",WepBan)
		Form2:SetText("user") 
	end
--ulx	
	Form2:SetPos(5,100)
	Form2:SetSize(600,20)
	
	local button=vgui.Create("DButton",WepBan)
	button:SetPos(230,150)
	button:SetSize(100,25)
	button:SetText("BAN")
	
	WepList = vgui.Create("DListView",WepList2)
	WepList:SetMultiSelect(false)
	WepList:AddColumn("group")
	WepList:AddColumn("weapon")
	WepList:Dock(FILL)

	local buttgetwep=vgui.Create("DButton",WepBan)
	buttgetwep:SetPos(230,20)
	buttgetwep:SetSize(100,20)
	buttgetwep:SetText("Get Active Weapon")

	buttgetwep.DoClick=function()
		for k,v in pairs(LocalPlayer():GetWeapons()) do
			if LocalPlayer():Alive() && LocalPlayer():HasWeapon(v:GetClass()) then
				Form1:SetText(LocalPlayer():GetActiveWeapon():GetClass())
			end
		end
	end
	
	button.DoClick=function()
		QwerStrick()
		timer.Simple(0.1,function()
			
			QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
			
			
			if Form1:GetValue()=="Ban * for global ban" then
				return
			end
			
			if Form1:GetValue()=="" then
				empty() return
			end
			
			if Form2:GetValue()=="" then
				empty() return 
			end
			
			 
			if tonumber(Form1:GetValue()) then
				onlynumbers() return
			end
			
			if tonumber(Form2:GetValue()) then
				onlynumbers() return
			end
			
			for _,i in pairs(WepList:GetLines()) do
				if Form1:GetValue()==i:GetValue(2) && Form2:GetValue()==i:GetValue(1) then
					inthelist() return
				end
			end
			RunConsoleCommand("qwerstriction_addweapon",string.lower(Form2:GetValue()),Form1:GetValue())
			if Form1:GetValue()=="*" then
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," You have banned all weapons for group ",Color(0,255,0),Form2:GetValue(),Color(255,0,0),"\nNULL loadout has been added ") 
				success()
				RunConsoleCommand("qwerstriction_addloadout",Form2:GetValue(),"NULL")
				QwerStrick() return
			end
			chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," You have banned ",Color(0,255,0),Form1:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),Form2:GetValue())
			QwerStrick()
			success()  
		end)                                                                                                                                            
	end 

	WepList.OnClickLine = function(l,s)
		
		QWERST_ACCESS()
			
		if !CANUSE() then admincheck()  return end
   	 	
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_deleteweapon",s:GetValue(1),s:GetValue(2))
		
		if s:GetValue(2)=="*" then
			RunConsoleCommand("qwerstriction_deleteloadout",s:GetValue(1),"NULL")
			QwerStrick()
		end
			
		
	end

	local ButtonMassBanWep=vgui.Create("DButton",MassWeaponBan)
	ButtonMassBanWep:SetPos(5,40)
	ButtonMassBanWep:SetSize(600,40)
	ButtonMassBanWep:SetText("MASS BAN WEAPONS THAT YOU HAVE")

	--ulx
	if xgui then
		GroupMassBans=vgui.Create("DComboBox",MassWeaponBan)
			for k,v in pairs(xgui.data.groups) do
				GroupMassBans:AddChoice(v)
			end
			
		GroupMassBans:ChooseOption("user")     
		else
		GroupMassBans=vgui.Create("DTextEntry",MassWeaponBan)
		GroupMassBans:SetText("user") 
	end
	--ulx
	GroupMassBans:SetPos(5,100)
	GroupMassBans:SetSize(600,20)
	
	ButtonMassBanWep.DoClick=function()
		if !LocalPlayer():Alive() then return end
		QwerStrick()
		timer.Simple(0.1,function()
			
			QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
			
			if GroupMassBans:GetValue()=="" then 
				empty() return
			end
		
			if tonumber(GroupMassBans:GetValue()) then
				onlynumbers() return
			end
		
			for k,v in pairs(LocalPlayer():GetWeapons()) do
				RunConsoleCommand("qwerstriction_addweapon",string.lower(GroupMassBans:GetValue()),v:GetClass())
			end
		
			chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32),' Now check tab "Remove Weapon" ')
			QwerStrick()
			success()
		end)
	end
	-- settings weapons ban and remove

	-- loadout VGUI elements

	local Loadout=vgui.Create("DPanel",vkladki)
	vkladki:AddSheet("Loadout",Loadout,"icon16/user.png")
	local loadpanel=vgui.Create("DFrame",Loadout)
	loadpanel:Dock( FILL )
	loadpanel:SetTitle("Add custom loadouts and ammo for each group")
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
	
	-- loadout settings

	local WeaponsLoad=vgui.Create("DTextEntry",loadADD)
	WeaponsLoad:SetPos(5,50)
	WeaponsLoad:SetSize(600,20)
	
	if LocalPlayer():Alive() && #LocalPlayer():GetWeapons()>0 then
		WeaponsLoad:SetText(LocalPlayer():GetActiveWeapon():GetClass()) 
			else 
		WeaponsLoad:SetText("you are dead or you have no weapons")
	end
	
	local buttonLoad=vgui.Create("DButton",loadADD)
	buttonLoad:SetPos(210,150)
	buttonLoad:SetSize(140,20)
	buttonLoad:SetText("Add loadout")
	local buttonRem=vgui.Create("DButton",loadADD)
	buttonRem:SetPos(210,180)
	buttonRem:SetSize(140,20)
	buttonRem:SetText("Strip current weapon")
	local buttonStripWeaponAll=vgui.Create("DButton",loadADD)
	buttonStripWeaponAll:SetPos(210,210)
	buttonStripWeaponAll:SetSize(140,20)
	buttonStripWeaponAll:SetTextColor(Color(230,0,0))
	buttonStripWeaponAll:SetText("Strip all weapons")
	local buttongetactiveweapon=vgui.Create("DButton",loadADD)
	buttongetactiveweapon:SetPos(210,23)
	buttongetactiveweapon:SetSize(140,20)
	buttongetactiveweapon:SetText("Get active weapon")

	buttongetactiveweapon.DoClick=function()
		if LocalPlayer():Alive() && #LocalPlayer():GetWeapons()>0 then
			WeaponsLoad:SetText(LocalPlayer():GetActiveWeapon():GetClass()) else
				plynoweapons() return 
		end
	end
	
	buttonStripWeaponAll.DoClick=function()
		if !LocalPlayer():Alive() then return end
			QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
			
		for k,v in pairs(LocalPlayer():GetWeapons()) do
			RunConsoleCommand("qwerstriction_stripweapon",v:GetClass())
		end
		WeaponsLoad:Clear()
		success()
	end
	
	buttonRem.DoClick=function()
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
 		
		if #LocalPlayer():GetWeapons()==0 then 
			plynoweapons() return 
		end
		
		RunConsoleCommand("qwerstriction_stripweapon",LocalPlayer():GetActiveWeapon():GetClass())
		WeaponsLoad:Clear()
		success()
	end
	
	--ulx
	if xgui then
		LoadGroups=vgui.Create("DComboBox",loadADD)
			for k,v in pairs(xgui.data.groups) do
				LoadGroups:AddChoice(v)
			end     
			LoadGroups:ChooseOption("user") 
		else
		LoadGroups=vgui.Create("DTextEntry",loadADD)
		LoadGroups:SetText("user") 
	end
	LoadGroups:SetPos(5,100)
	LoadGroups:SetSize(600,20)
	--ulx
	
	buttonLoad.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
			
				if tonumber(LoadGroups:GetValue()) then
					onlynumbers() return 
				end
			
				if tonumber(WeaponsLoad:GetValue()) then
					onlynumbers() return 
				end
			
				if WeaponsLoad:GetValue()=="" then
					empty() return 
				end
				
				if LoadGroups:GetValue()=="" then
					empty() return
				end
			
				if !LocalPlayer():Alive() then
 					mustbealive() return 
 				end
 			
				if WeaponsLoad:GetValue()=="you are dead or you have no weapons" then return end
			
				for _,v in pairs(defalist:GetLines()) do
					if WeaponsLoad:GetValue()==v:GetValue(2) && LoadGroups:GetValue()==v:GetValue(1) then 
						inthelist()  return 
					end
				end
				RunConsoleCommand("qwerstriction_addloadout",string.lower(LoadGroups:GetValue()),WeaponsLoad:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," You have added ",Color(0,255,0),WeaponsLoad:GetValue(),Color(218,165,32)," for loadout for group ",Color(0,255,0),LoadGroups:GetValue())
			QwerStrick()
			success()
		end)
	end
	
	defalist=vgui.Create( "DListView",loadList2)
	defalist:SetMultiSelect( false )
	defalist:AddColumn( "group" )
	defalist:AddColumn( "weapon" )
	defalist:Dock( FILL )
	
	defalist.OnClickLine = function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_deleteloadout",s:GetValue(1),s:GetValue(2))
		removeelement()
	end
	
	local buttonInsertAll=vgui.Create("DButton",MassAddLoad)
	buttonInsertAll:SetPos(5,40)
	buttonInsertAll:SetSize(600,40)
	buttonInsertAll:SetText("Mass add weapons to loadout that you currently have")
	
	--ulx
	if xgui then
		LoadGroupsMassBan=vgui.Create("DComboBox",MassAddLoad)
			for k,v in pairs(xgui.data.groups) do
				LoadGroupsMassBan:AddChoice(v)
			end
			LoadGroupsMassBan:ChooseOption("user")
			else
		LoadGroupsMassBan=vgui.Create("DTextEntry",MassAddLoad)
		LoadGroupsMassBan:SetText("user") 
	end
	LoadGroupsMassBan:SetPos(5,100)
	LoadGroupsMassBan:SetSize(600,20)
	--ulx
	
	buttonInsertAll.DoClick=function()
		if !LocalPlayer():Alive() then return end
		QwerStrick()
		timer.Simple(0.1,function()
			QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
     		
			if tonumber(LoadGroupsMassBan:GetValue()) then
 				onlynumbers() return 
 			end
 			
 			if LoadGroupsMassBan:GetValue()=="" then
 				empty() return
			end
 			
 			
			for k,v in pairs(LocalPlayer():GetWeapons()) do
				if !LocalPlayer():HasWeapon(v:GetClass()) then return end
				RunConsoleCommand("qwerstriction_addloadout",string.lower(LoadGroupsMassBan:GetValue()),v:GetClass())
			end   
			chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32),' Now check tab "Remove Loadout"')
			QwerStrick()
			success()
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
		{name="S.L.A.M",ammo="slam"}}
		
		

	local DboxAmmo=vgui.Create("DComboBox",Ammotype)
	DboxAmmo:SetPos(5,25)
	DboxAmmo:SetSize(600,20)

	for k,v in pairs(ammotypesst)do
		DboxAmmo:AddChoice(v.name)
		DboxAmmo:ChooseOption("Smg1")
	end
	
	local AmmoUserDbox=vgui.Create("DTextEntry",Ammotype)
	AmmoUserDbox:SetText("13581") 
	AmmoUserDbox:SetPos(5,75)
	AmmoUserDbox:SetSize(600,20)
	
	local AmmoButton=vgui.Create("DButton",Ammotype)
	AmmoButton:SetPos(230,180)
	AmmoButton:SetSize(100,20)
	AmmoButton:SetText("Set ammo")
	
	--ulx 
	if xgui then
		Ammogroups=vgui.Create("DComboBox",Ammotype)
			for k,v in pairs(xgui.data.groups) do
				Ammogroups:AddChoice(v)
			end
				Ammogroups:ChooseOption("user")
			else
		Ammogroups=vgui.Create("DTextEntry",Ammotype)
		Ammogroups:SetText("user")
	end
	Ammogroups:SetPos(5,125)
	Ammogroups:SetSize(600,20)
	--ulx
	
	
	
	AmmoButton.DoClick=function()
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
   		
   		if AmmoUserDbox:GetValue()=="" then
			empty() return 
		end
   		
		if !tonumber(AmmoUserDbox:GetValue()) then
			shouldbenumber() return 
		end
		
		if DboxAmmo:GetValue()=="" then 
			empty() return 
		end
		
		if Ammogroups:GetValue()=="" then
			empty() return
		end
		
		if tonumber(Ammogroups:GetValue()) then
			onlynumbers() return
		end
		
		
		for k,v in pairs(ammotypesst) do
			if v.name==DboxAmmo:GetValue() then 
				RunConsoleCommand("qwerstriction_ammo",v.ammo,AmmoUserDbox:GetValue(),Ammogroups:GetValue())
			end
		end
		chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,12)," There are ",Color(0,255,0),AmmoUserDbox:GetValue(),Color(218,165,12)," ammo for ",Color(0,255,0),DboxAmmo:GetValue(),Color(218,165,12)," for group ",Color(0,255,0),Ammogroups:GetValue())
		QwerStrick()
		success()
	end
	
	local RemoveAmmoList=vgui.Create("DListView",Removeammo)
	RemoveAmmoList:SetMultiSelect( false )
	RemoveAmmoList:AddColumn( "ammo" )
	RemoveAmmoList:AddColumn( "number" )
	RemoveAmmoList:AddColumn( "group" )
	RemoveAmmoList:Dock( FILL )

	RemoveAmmoList.OnClickLine = function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_removeammo",s:GetValue(1),s:GetValue(2),s:GetValue(3))
		removeelement()
	end
	
	-- loadout settings
	
	-- entities
	
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
	local SetLimitEnt=vgui.Create("DPanel",EntsList)
	EntsList:AddSheet("Set limit",SetLimitEnt,"icon16/delete.png")
	local EntsLists=vgui.Create("DPanel",EntsList)
	EntsList:AddSheet("Remove entity",EntsLists,"icon16/accept.png")
	local RemEntLimit=vgui.Create("DPanel",EntsLists)
	EntsList:AddSheet("Remove limit",RemEntLimit,"icon16/add.png")
	
	
	local banentityb=vgui.Create("DButton",BanEnt)
	banentityb:SetText("ban entity")
	banentityb:SetPos(230,150)
	banentityb:SetSize(100,20)
	local banentity=vgui.Create("DTextEntry",BanEnt)
	banentity:SetPos(5,50)
	banentity:SetSize(600,20)
	
	--ulx
	if xgui then
		entitygroup=vgui.Create("DComboBox",BanEnt)
			for k,v in pairs(xgui.data.groups) do
				entitygroup:AddChoice(v)
			end      
		entitygroup:ChooseOption("user")
		else
		entitygroup=vgui.Create("DTextEntry",BanEnt)
		entitygroup:SetText("user") 
	end
		entitygroup:SetPos(5,100)
		entitygroup:SetSize(600,20)
	--ulx
	
	--ulx
	if xgui then
		Dcomboxentlimit=vgui.Create("DComboBox",SetLimitEnt)
			for k,v in pairs(xgui.data.groups) do
				Dcomboxentlimit:AddChoice(v)
			end 
			Dcomboxentlimit:ChooseOption("user")     
			else
			Dcomboxentlimit=vgui.Create("DTextEntry",SetLimitEnt)
			Dcomboxentlimit:SetText("user") 
	end
			Dcomboxentlimit:SetPos(5,100)
			Dcomboxentlimit:SetSize(600,20)
	--ulx
	
	local EntNumber=vgui.Create("DTextEntry",SetLimitEnt)
	EntNumber:SetPos(5,50)
	EntNumber:SetSize(600,20)
	
	local buttonentnumber=vgui.Create("DButton",SetLimitEnt)
	buttonentnumber:SetPos(230,150)
	buttonentnumber:SetSize(100,20)
	buttonentnumber:SetText("Set")
	
	buttonentnumber.DoClick=function()
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		
		if EntNumber:GetValue()=="" then
			empty() return
		end
		
		if !tonumber(EntNumber:GetValue()) then
			shouldbenumber() return 
		end
		
		if Dcomboxentlimit:GetValue()=="" then
			empty() return
		end
		
		if tonumber(Dcomboxentlimit:GetValue()) then
			onlynumbers() return 
		end
		
		RunConsoleCommand("qwerstriction_bannumberent",string.lower(Dcomboxentlimit:GetValue()),EntNumber:GetValue())
		chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," Max entities for ",Color(0,255,0),Dcomboxentlimit:GetValue(),Color(218,165,32)," is ",Color(0,255,0),EntNumber:GetValue())
		QwerStrick()
		success()
	end
	
	
	banentityb.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				if banentity:GetValue()=="" then
					empty() return 
				end
				
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if tonumber(banentity:GetValue()) then
					onlynumbers() return 
				end
				
				if tonumber(entitygroup:GetValue()) then
					onlynumbers() return 
				end
				
				if entitygroup:GetValue()=="" then
					empty() return
				end
				
				for k,v in pairs(entlist:GetLines()) do
					if banentity:GetValue()==v:GetValue(2) && entitygroup:GetValue()==v:GetValue(1) then
						inthelist() return 
					end
				end
				
				RunConsoleCommand("qwerstriction_banentity",string.lower(entitygroup:GetValue()),banentity:GetValue())
				QwerStrick()
				success()
				chat.AddText(Color(0,255,0),"[QWERSTRICTION] ",Color(218,165,32)," You have banned ",Color(0,255,0),banentity:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),entitygroup:GetValue())
			end)
	end
	
	entlist=vgui.Create("DListView",EntsLists)
	entlist:SetMultiSelect( false )
	entlist:AddColumn( "group" )
	entlist:AddColumn( "entity" )
	entlist:Dock( FILL )
	
	entlist.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
			s:Remove()
			RunConsoleCommand("qwerstriction_deleteentity",s:GetValue(1),s:GetValue(2))
			removeelement()
	end
	
    local EntCountList=vgui.Create( "DListView",RemEntLimit)                  
	EntCountList:SetMultiSelect( false )
	EntCountList:AddColumn("group")
	EntCountList:AddColumn("number")
	EntCountList:Dock( FILL )
	
	EntCountList.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_removeentnumber",s:GetValue(1),s:GetValue(2))
		removeelement()
	end
	
	--toolgun 
	
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
	
	--toolgun settings
	
	local BunToolgunButton=vgui.Create("DButton",BanTool)
	BunToolgunButton:SetText("ban tool")
	BunToolgunButton:SetPos(230,150)
	BunToolgunButton:SetSize(100,20)
	
	--ulx
	if xgui then
		tooluser=vgui.Create("DComboBox",BanTool)
			for k,v in pairs(xgui.data.groups) do
				tooluser:AddChoice(v)
			end 
			tooluser:ChooseOption("user")     
		else
			tooluser=vgui.Create("DTextEntry",BanTool)
			tooluser:SetText("user") 
	end
			tooluser:SetPos(5,100)
			tooluser:SetSize(600,20)
	--ulx
	
	local toolBanit=vgui.Create("DTextEntry",BanTool)
	toolBanit:SetPos(5,50)
	toolBanit:SetSize(600,20)
	toolremovelist = vgui.Create( "DListView",RemoveTool)
	toolremovelist:SetMultiSelect( false )
	toolremovelist:AddColumn( "group" )
	toolremovelist:AddColumn( "tool" )
	toolremovelist:Dock( FILL )
	
	local KnowTool=vgui.Create("Button",BanTool)
	KnowTool:SetPos(230,20)
	KnowTool:SetText("tool name")
	KnowTool:SetSize(100,20)
	
	KnowTool.DoClick=function()
		RunConsoleCommand("qwerstriction_toolgunknow")
		if LocalPlayer():GetNWString("KnowWhatTool")=="know" then
			LocalPlayer():SetNWString("KnowWhatTool","false") else
				LocalPlayer():SetNWString("KnowWhatTool","know")
					toolgunname()
		end
	end
	
	BunToolgunButton.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if toolBanit:GetValue()=="" then
					empty() return 
				end
				
				if tonumber(toolBanit:GetValue()) then
					onlynumbers() return 
				end
				
				if tonumber(tooluser:GetValue()) then
					onlynumbers() return 
				end
				
				if tooluser:GetValue()=="" then
					empty() return
					end
				
				for k,v in pairs(toolremovelist:GetLines()) do
					if toolBanit:GetValue()==v:GetValue(2) && tooluser:GetValue()==v:GetValue(1) then
						inthelist() return 
					end
				end
				RunConsoleCommand("qwerstriction_bantool",string.lower(tooluser:GetValue()),toolBanit:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," You have banned ",Color(0,255,0),toolBanit:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),tooluser:GetValue())
				QwerStrick()
				success()
			end)
	end
	
	toolremovelist.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_removetoolgun",s:GetValue(1),s:GetValue(2))
	end
	
	-- toolgun
	
	-- npc
	
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
	
	--npc settings
	
	--ulx
	if xgui then
		npcUser=vgui.Create("DComboBox",BanNumberNPC)
			for k,v in pairs(xgui.data.groups) do
				npcUser:AddChoice(v)
			end   
		npcUser:ChooseOption("user")   
		else
		npcUser=vgui.Create("DTextEntry",BanNumberNPC)
		npcUser:SetText("user") 
	end
		npcUser:SetPos(5,100)
		npcUser:SetSize(600,20)
	--ulx
	
	--ulx
	if xgui then
		npcUserClass=vgui.Create("DComboBox",BanClassNpc)
			for k,v in pairs(xgui.data.groups) do
				npcUserClass:AddChoice(v)
			end
		npcUserClass:ChooseOption("user")     
		else
		npcUserClass=vgui.Create("DTextEntry",BanClassNpc)
		npcUserClass:SetText("user") 
	end
		npcUserClass:SetPos(5,100)
		npcUserClass:SetSize(600,20)
	--ulx
	
	local npcNumber=vgui.Create("DTextEntry",BanNumberNPC)
	npcNumber:SetPos(5,50)
	npcNumber:SetSize(600,20)
	
	local buttonnpc=vgui.Create("DButton",BanNumberNPC)
	buttonnpc:SetPos(230,150)
	buttonnpc:SetSize(100,20)
	buttonnpc:SetText("Set")
	
	local banclassnpc=vgui.Create("DTextEntry",BanClassNpc)
	banclassnpc:SetPos(5,50)
	banclassnpc:SetSize(600,20)
	
	local bannpcclassbut=vgui.Create("DButton",BanClassNpc)
	bannpcclassbut:SetPos(230,150)
	bannpcclassbut:SetSize(100,20)
	bannpcclassbut:SetText("Ban")
	
	buttonnpc.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if npcNumber:GetValue()=="" then
					empty() return
				end
				
				if npcUser:GetValue()=="" then
					empty() return 
				end
						
				
				if !tonumber(npcNumber:GetValue()) then
					shouldbenumber() return 
				end
				
				if tonumber(npcUser:GetValue()) then
					onlynumbers() return 
				end
				
				RunConsoleCommand("qwerstriction_npcnumber",string.lower(npcUser:GetValue()),npcNumber:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," Max npcs for ",Color(0,255,0),npcUser:GetValue(),Color(218,165,32)," is ",Color(0,255,0),npcNumber:GetValue())
				QwerStrick()
				success()
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
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if tonumber(banclassnpc:GetValue()) then
					onlynumbers() return 
				end
				
				if banclassnpc:GetValue()=="" then
					empty() return 
				end
				
				if tonumber(npcUserClass:GetValue()) then
					onlynumbers() return 
				end
				
				if npcUserClass:GetValue()=="" then
					empty() return
				end
				
				for k,v in pairs(ClassNpcList:GetLines())do
					if npcUserClass:GetValue()==v:GetValue(1) && banclassnpc:GetValue()==v:GetValue(2) then
						inthelist() return 
					end
				end
				
				RunConsoleCommand("qwerstriction_npcbanclass",string.lower(npcUserClass:GetValue()),banclassnpc:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32), " You have banned ",Color(0,255,0),banclassnpc:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),npcUserClass:GetValue())
				QwerStrick()
				success()
			end)
	end
	
	local NpcList=vgui.Create( "DListView",NumberList)
	NpcList:SetMultiSelect( false )
	NpcList:AddColumn("group")
	NpcList:AddColumn("number")
	NpcList:Dock( FILL )
	
	NpcList.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_removenpcnum",s:GetValue(1),s:GetValue(2))
		removeelement()
	end
	
	ClassNpcList.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_removenpcclass",s:GetValue(1),s:GetValue(2))
		removeelement()
	end
	
	-- npc
	
	-- prop
	
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
	
	-- prop settings
	
	--ulx
	if xgui then
		PropNumberUser=vgui.Create("DComboBox",BanNumberProp)
			for k,v in pairs(xgui.data.groups) do
				PropNumberUser:AddChoice(v)
			end  
		PropNumberUser:ChooseOption("user")    
		else
		PropNumberUser=vgui.Create("DTextEntry",BanNumberProp)
		PropNumberUser:SetText("user") 
	end
		PropNumberUser:SetPos(5,100)
		PropNumberUser:SetSize(600,20)
	--ulx
	
	--ulx
	if xgui then
		PropUserClass=vgui.Create("DComboBox",BanClassProp)
			for k,v in pairs(xgui.data.groups) do
				PropUserClass:AddChoice(v)
			end      
		PropUserClass:ChooseOption("user")
		else
		PropUserClass=vgui.Create("DTextEntry",BanClassProp)
		PropUserClass:SetText("user") 
	end
		PropUserClass:SetPos(5,100)
		PropUserClass:SetSize(600,20)
	--ulx
	
	local PropNumber=vgui.Create("DTextEntry",BanNumberProp)
	PropNumber:SetPos(5,50)
	PropNumber:SetSize(600,20)
	
	local buttonpropnumber=vgui.Create("DButton",BanNumberProp)
	buttonpropnumber:SetPos(230,150)
	buttonpropnumber:SetSize(100,20)
	buttonpropnumber:SetText("Set")
	
	local banmodprop=vgui.Create("DTextEntry",BanClassProp)
	banmodprop:SetPos(5,50)
	banmodprop:SetSize(600,20)
	
	local banmodpropbut=vgui.Create("DButton",BanClassProp)
	banmodpropbut:SetPos(230,150)
	banmodpropbut:SetSize(100,20)
	banmodpropbut:SetText("Ban")
	
	buttonpropnumber.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if PropNumber:GetValue()=="" then
					empty() return
				end
				
				if !tonumber(PropNumber:GetValue()) then
					shouldbenumber() return 
				end
				
				if PropNumberUser:GetValue()=="" then
					empty() return
				end
				
				if tonumber(PropNumberUser:GetValue()) then
					onlynumbers() return 
				end
				
				RunConsoleCommand("qwerstriction_bannumberprop",string.lower(PropNumberUser:GetValue()),PropNumber:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," Max props for ",Color(0,255,0),PropNumberUser:GetValue(),Color(218,165,32)," is ",Color(0,255,0),PropNumber:GetValue())
				QwerStrick()
				success()
			end)
	end
	
	local PropModelsAndGroups=vgui.Create( "DListView",PropsModels)
	PropModelsAndGroups:SetMultiSelect( false )
	PropModelsAndGroups:AddColumn("group")
	PropModelsAndGroups:AddColumn("model")
	PropModelsAndGroups:Dock( FILL )
	
	banmodpropbut.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if PropUserClass:GetValue()=="" then
					empty() return
				end
				
				if tonumber(banmodprop:GetValue()) then
					onlynumbers() return 
				end
				
				if banmodprop:GetValue()=="" then
					empty() return 
				end
				
				if tonumber(PropUserClass:GetValue()) then
					onlynumbers() return 
				end
				
				if !string.find(banmodprop:GetValue(),".mdl") then
					wheremdl()  return 
				end
				
				for k,v in pairs(PropModelsAndGroups:GetLines()) do
					if PropUserClass:GetValue()==v:GetValue(1) && banmodprop:GetValue()==v:GetValue(2) then
						inthelist() return 
					end
				end
				
				RunConsoleCommand("qwerstriction_banpropmodel",string.lower(PropUserClass:GetValue()),banmodprop:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32), " You have banned ",Color(0,255,0),banmodprop:GetValue(),Color(218,165,32)," model for group ",Color(0,255,0),PropUserClass:GetValue())
				QwerStrick()
				success()
			end)
	end 
	
	local PropCountList=vgui.Create( "DListView",NumberListProp)                  
	PropCountList:SetMultiSelect( false )
	PropCountList:AddColumn("group")
	PropCountList:AddColumn("number")
	PropCountList:Dock( FILL )
	
	PropCountList.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_removepropnumber",s:GetValue(1),s:GetValue(2))
		removeelement()
	end
	
	PropModelsAndGroups.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		RunConsoleCommand("qwerstriction_removemodelprop",s:GetValue(1),s:GetValue(2))
		removeelement()
	end
	
	--props
	
	-- ragdolls
	
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
	
	-- ragdoll settings
	
	--ulx
	if xgui then
		UserRagdollBan=vgui.Create("DComboBox",BanNumberRagdoll)
			for k,v in pairs(xgui.data.groups) do
				UserRagdollBan:AddChoice(v)
			end 
			UserRagdollBan:ChooseOption("user")     
		else
			UserRagdollBan=vgui.Create("DTextEntry",BanNumberRagdoll)
			UserRagdollBan:SetText("user") 
	end
			UserRagdollBan:SetPos(5,100)
			UserRagdollBan:SetSize(600,20)
	--ulx
	
	--ulx
	
	if xgui then
		BanUserModelag=vgui.Create("DComboBox",BanModelRagdoll)
			for k,v in pairs(xgui.data.groups) do
				BanUserModelag:AddChoice(v)
			end  
				BanUserModelag:ChooseOption("user")    
			else
				BanUserModelag=vgui.Create("DTextEntry",BanModelRagdoll)
				BanUserModelag:SetText("user") 
	end
				BanUserModelag:SetPos(5,100)
				BanUserModelag:SetSize(600,20)
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
	RagdollNumber:SetSize(600,20)
	
	local buttonragdollnumber=vgui.Create("DButton",BanNumberRagdoll)
	buttonragdollnumber:SetPos(230,150)
	buttonragdollnumber:SetSize(100,20)
	buttonragdollnumber:SetText("Set")
	
	local RagdollModel=vgui.Create("DTextEntry",BanModelRagdoll)
	RagdollModel:SetPos(5,50)
	RagdollModel:SetSize(600,20)
	
	local buttonragdollmodel=vgui.Create("DButton",BanModelRagdoll)
	buttonragdollmodel:SetPos(230,150)
	buttonragdollmodel:SetSize(100,20)
	buttonragdollmodel:SetText("ban")
	
	buttonragdollnumber.DoClick=function()
		QwerStrick()
		timer.Simple(0.1,function()
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		
			if UserRagdollBan:GetValue()=="" then 
				empty() return
			end
		
			if RagdollNumber:GetValue()=="" then 
				empty() return
			end
		
			if !tonumber(RagdollNumber:GetValue()) then
				shouldbenumber() return 
			end
		
			if tonumber(UserRagdollBan:GetValue()) then
				onlynumbers() return 
			end
		
			RunConsoleCommand("qwerstriction_addnumberragdoll",string.lower(UserRagdollBan:GetValue()),RagdollNumber:GetValue())
			chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," Max ragdolls for ",Color(0,255,0),UserRagdollBan:GetValue(),Color(218,165,32)," is ",Color(0,255,0),RagdollNumber:GetValue())
			QwerStrick()
			success()
		end)
	end
	
	buttonragdollmodel.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if RagdollModel:GetValue()=="" then
					empty() return 
				end
				
				if BanUserModelag:GetValue()=="" then
					empty() return
				end
				
				if tonumber(RagdollModel:GetValue()) then
					onlynumbers() return 
				end
				
				if !string.find(RagdollModel:GetValue(),".mdl") then
					wheremdl() return 
				end
				
				if tonumber(BanUserModelag:GetValue()) then
					onlynumbers() return 
				end
				
				for k,v in pairs(RagdollListModel:GetLines()) do
					if BanUserModelag:GetValue()==v:GetValue(1) && RagdollModel:GetValue()==v:GetValue(2) then
						inthelist() return 
					end
				end
				
				RunConsoleCommand("qwerstriction_addmodelragdoll",string.lower(BanUserModelag:GetValue()),RagdollModel:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32), " You have banned ",Color(0,255,0),RagdollModel:GetValue(),Color(218,165,32)," ragdoll for group ",Color(0,255,0),BanUserModelag:GetValue())
				QwerStrick()
				success()
			end)                                                                                                                       
	end
	
	RagdollListNumber.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_removenumberragdoll",s:GetValue(1),s:GetValue(2))
	end
	
	RagdollListModel.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_removemodelragdoll",s:GetValue(1),s:GetValue(2))
	end
	
	-- ragdoll
	
	--cars
	
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
	
	--ulx
	if xgui then
		GroupBanNumberCar=vgui.Create("DComboBox",SetLimitCarNumber)
			for k,v in pairs(xgui.data.groups) do
				GroupBanNumberCar:AddChoice(v)
			end  
		GroupBanNumberCar:ChooseOption("user")
		else
		GroupBanNumberCar=vgui.Create("DTextEntry",SetLimitCarNumber)
		GroupBanNumberCar:SetText("user") 
	end
		GroupBanNumberCar:SetPos(5,100)
		GroupBanNumberCar:SetSize(600,20)
	--ulx
	
	--ulx
	if xgui then
		GroupBanModelCar=vgui.Create("DComboBox",BanModelCar)
			for k,v in pairs(xgui.data.groups) do
				GroupBanModelCar:AddChoice(v)
			end  
		GroupBanModelCar:ChooseOption("user")   
		else
		GroupBanModelCar=vgui.Create("DTextEntry",BanModelCar)
		GroupBanModelCar:SetText("user") 
	end
		GroupBanModelCar:SetPos(5,100)
		GroupBanModelCar:SetSize(600,20)
	--ulx
	
	local ModelCartxt=vgui.Create("DTextEntry",BanModelCar)
	ModelCartxt:SetPos(5,50)
	ModelCartxt:SetSize(600,20)
	
	local buttoncarmodel=vgui.Create("DButton",BanModelCar)
	buttoncarmodel:SetPos(230,150)
	buttoncarmodel:SetSize(100,20)
	buttoncarmodel:SetText("Ban")
	
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
	NumberCartxt:SetSize(600,20)
	
	local buttoncarnumber=vgui.Create("DButton",SetLimitCarNumber)
	buttoncarnumber:SetPos(230,150)
	buttoncarnumber:SetSize(100,20)
	buttoncarnumber:SetText("Set")
	
	buttoncarnumber.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function() 
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if GroupBanNumberCar:GetValue()=="" then
					empty() return
				end
				
				if NumberCartxt:GetValue()=="" then
					empty() return
				end
				
				if !tonumber(NumberCartxt:GetValue()) then
					shouldbenumber() return 
				end
				
				if tonumber(GroupBanNumberCar:GetValue()) then
					onlynumbers() return 
				end
				
				RunConsoleCommand("qwerstriction_addnumbercar",string.lower(GroupBanNumberCar:GetValue()),NumberCartxt:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," Max vehicles for ",Color(0,255,0),GroupBanNumberCar:GetValue(),Color(218,165,32)," is ",Color(0,255,0),NumberCartxt:GetValue())
				QwerStrick()
				success()
			end)  
	end
	
	buttoncarmodel.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function()
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if ModelCartxt:GetValue()=="" then
					empty() return 
				end
				
				if GroupBanModelCar:GetValue()=="" then
					empty() return
				end
				
				if tonumber(ModelCartxt:GetValue()) then
					onlynumbers() return 
				end
				
				if tonumber(GroupBanModelCar:GetValue()) then
					shouldbenumber() return 
				end
				
				for k,v in pairs(ListofModelsCars:GetLines()) do
					if GroupBanModelCar:GetValue()==v:GetValue(1) && ModelCartxt:GetValue()==v:GetValue(2) then
						inthelist() return 
					end
				end
				
				RunConsoleCommand("qwerstriction_addmodelvehicle",string.lower(GroupBanModelCar:GetValue()),ModelCartxt:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32), " You have banned ",Color(0,255,0),ModelCartxt:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),GroupBanModelCar:GetValue())
				QwerStrick()
				success()
			end)
	end
	
	ListofNumberCars.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_removenumbervehicle",s:GetValue(1),s:GetValue(2))
	end
	
	ListofModelsCars.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_removemodelvehicle",s:GetValue(1),s:GetValue(2))
	end

-- cars

-- playermodels

	local PlayerModel=vgui.Create("DPanel",vkladki)
	vkladki:AddSheet("Model",PlayerModel,"icon16/user_gray.png")
	local PlModelDframe=vgui.Create("DFrame",PlayerModel)
	PlModelDframe:Dock( FILL )
	PlModelDframe:SetTitle("Ban player model for each group")
	PlModelDframe:ShowCloseButton(false)
	local PlModelProper=vgui.Create("DPropertySheet",PlModelDframe)
	PlModelProper:Dock(FILL)
	local SetLimitPmModelNumber=vgui.Create("DPanel",PlModelProper)
	PlModelProper:AddSheet("Ban model player",SetLimitPmModelNumber,"icon16/stop.png")
	local ListNumberPmmodel=vgui.Create("DPanel",PlModelProper)
	PlModelProper:AddSheet("Remove model",ListNumberPmmodel,"icon16/accept.png")
	
	--ulx
		if xgui then
			GroupBanPlayermodel=vgui.Create("DComboBox",SetLimitPmModelNumber)
				for k,v in pairs(xgui.data.groups) do
					GroupBanPlayermodel:AddChoice(v)
				end  
					GroupBanPlayermodel:ChooseOption("user")
			else
					GroupBanPlayermodel=vgui.Create("DTextEntry",SetLimitPmModelNumber)
					GroupBanPlayermodel:SetText("user") 
		end
					GroupBanPlayermodel:SetPos(5,100)
					GroupBanPlayermodel:SetSize(600,20)
	--ulx
	
	local banmodelplay=vgui.Create("DTextEntry",SetLimitPmModelNumber)
	banmodelplay:SetPos(5,50)
	banmodelplay:SetSize(600,20)
	
	local buttonbanplymodel=vgui.Create("DButton",SetLimitPmModelNumber)
	buttonbanplymodel:SetPos(230,150)
	buttonbanplymodel:SetSize(100,20)
	buttonbanplymodel:SetText("Ban")

	local currmodel=vgui.Create("DButton",SetLimitPmModelNumber)
	currmodel:SetPos(230,190)
	currmodel:SetSize(100,20)
	currmodel:SetText("Current model")

	currmodel.DoClick=function()
		if LocalPlayer():Alive() then
			banmodelplay:SetText(LocalPlayer():GetModel())
		end
	end
	
	local ListofmodelPlayer=vgui.Create( "DListView",ListNumberPmmodel)
	ListofmodelPlayer:SetMultiSelect( false )
	ListofmodelPlayer:AddColumn("group")
	ListofmodelPlayer:AddColumn("model")
	ListofmodelPlayer:Dock( FILL )
	
	buttonbanplymodel.DoClick=function()
		QwerStrick()
			timer.Simple(0.1,function() 
				QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
				
				if banmodelplay:GetValue()=="" then
					empty() return 
				end
				
				if GroupBanPlayermodel:GetValue()=="" then
					empty() return
				end
				
				if tonumber(banmodelplay:GetValue()) then
					shouldbenumber() return 
				end
				
				if tonumber(GroupBanPlayermodel:GetValue()) then
					shouldbenumber() return 
				end
				
				if !string.find(banmodelplay:GetValue(),".mdl") then
					wheremdl() return 
				end
				
				if banmodelplay:GetValue()=="models/player/kleiner.mdl" then
					DefModel() return 
				end
				
				for k,v in pairs(ListofmodelPlayer:GetLines()) do
					if GroupBanPlayermodel:GetValue()==v:GetValue(1) && banmodelplay:GetValue()==v:GetValue(2) then
						inthelist() return 
					end
				end
				
				RunConsoleCommand("qwerstriction_banplayermodel",string.lower(GroupBanPlayermodel:GetValue()),banmodelplay:GetValue())
				chat.AddText(Color(0,230,0),"[QWERSTRICTION] ",Color(218,165,32)," You have banned ",Color(0,255,0),banmodelplay:GetValue(),Color(218,165,32)," for group ",Color(0,255,0),GroupBanPlayermodel:GetValue())
				QwerStrick()
				success()
			end)
	end
	
	
	ListofmodelPlayer.OnClickLine=function(l,s)
		QWERST_ACCESS()
			
			if !CANUSE() then admincheck()  return end
		s:Remove()
		removeelement()
		RunConsoleCommand("qwerstriction_removeplayermodelfuc",s:GetValue(1),s:GetValue(2))
	end
	
	
	-- Other settings
	
	local Other=vgui.Create("DPanel",vkladki)
	vkladki:AddSheet("Other",Other,"icon16/cog.png")
	local Settings=vgui.Create("DFrame",Other)
	Settings:Dock( FILL )
	Settings:SetTitle("Some usefull things")
	Settings:ShowCloseButton(false)
	local SettingsOther=vgui.Create("DPropertySheet",Settings)
	SettingsOther:Dock(FILL)
	local whichgroup=vgui.Create("DPanel",SettingsOther)
	SettingsOther:AddSheet("Access to [QWERSTRICTION]",whichgroup,"icon16/cancel.png")
	--local wichgrouprem=vgui.Create("DPanel",SettingsOther)
	--SettingsOther:AddSheet("Remove group",wichgrouprem,"icon16/bug.png")
	--local MingeBanban=vgui.Create("DPanel",SettingsOther)
	--SettingsOther:AddSheet("MingeBan",MingeBanban,"icon16/heart_delete.png")
	
	
	--ulx
		if xgui then
			MingeBanDbox=vgui.Create("DComboBox",whichgroup)
				for k,v in pairs(xgui.data.groups) do
					MingeBanDbox:AddChoice(v)
				end  
					MingeBanDbox:ChooseOption("admin")
			else
					MingeBanDbox=vgui.Create("DTextEntry",whichgroup)
					MingeBanDbox:SetText("admin") 
		end
					MingeBanDbox:SetPos(5,10)
					MingeBanDbox:SetSize(600,20)
	--ulx
	
	local MingeBanButton=vgui.Create("DButton",whichgroup)
		MingeBanButton:SetPos(5,45)
		MingeBanButton:SetSize(600,25)
		MingeBanButton:SetText("Add group")
		
	    ListOfGroupsMingeBan=vgui.Create( "DListView",whichgroup)
		ListOfGroupsMingeBan:SetMultiSelect( false )
		ListOfGroupsMingeBan:AddColumn("group")
		ListOfGroupsMingeBan:SetPos(5,80)
		ListOfGroupsMingeBan:SetSize(600,215)
		
		
		MingeBanButton.DoClick=function()
			timer.Simple(0.1,function()
				if !LocalPlayer():IsSuperAdmin() then
					SUPERADMINONLY() return 
				end
				
				if MingeBanDbox:GetValue()=="" then
					empty() return
				end
				
				if MingeBanDbox:GetValue()=="superadmin" then return end
				
				
				if tonumber(MingeBanDbox:GetValue()) then 
					shouldbenumber() return
				end
				
				for k,v in pairs(ListOfGroupsMingeBan:GetLines()) do
					if MingeBanDbox:GetValue()==v:GetValue(1) then
						 return
					end
				end
				
				--ListOfGroupsMingeBan:AddLine(MingeBanDbox:GetValue())
				
				RunConsoleCommand("qwerstriction_access",MingeBanDbox:GetValue())
				success()
				QwerStrick()
			end)
			
			
		end
		
		ListOfGroupsMingeBan.OnClickLine=function(l,s)
			
			if !LocalPlayer():IsSuperAdmin() then return end
			
			if s:GetValue(1)=="superadmin" then return end
			s:Remove()
			removeelement()
			
			
			RunConsoleCommand("qwerstriction_access_remove",s:GetValue(1))
			
		end



	local function LooseFocus(panel)
		MainWindow:SetKeyboardInputEnabled(false)
	end
	hook.Add("OnTextEntryLoseFocus","GetFokus",LooseFocus)
	
	local function GetFocus(panel)
		MainWindow:SetKeyboardInputEnabled(true)
	end
	hook.Add("OnTextEntryGetFocus","GetFocus",GetFocus)
	
	local ButtonRefresh=vgui.Create("DImageButton",MainWindow)
	ButtonRefresh:SetSize(16,16)
	ButtonRefresh:SetImage("icon16/arrow_refresh.png")
	ButtonRefresh:SetPos(600,4)
	
	local CloseButtonWindow=vgui.Create("DImageButton",MainWindow)
	CloseButtonWindow:SetSize(16,16)
	CloseButtonWindow:SetImage("icon16/cancel.png")
	CloseButtonWindow:SetPos(630,4)
	MainWindow.Close = function() MainWindow:SetVisible(false) QwerStrick() end
	
	CloseButtonWindow.DoClick=function()
	MainWindow:Close()
	openedtpurs=false
	end
	
	ButtonRefresh.DoClick=function()
	refreshed()
	QwerStrick()
	end

	function QwerStrick()
		QWERST_ACCESS()
			
			if !CANUSE() then   return end
		
		NpcList:Clear()
		toolremovelist:Clear()
		WepList:Clear()
		defalist:Clear()
		entlist:Clear()
		EntCountList:Clear()
		ClassNpcList:Clear()
		PropCountList:Clear()
		PropModelsAndGroups:Clear()
		RagdollListNumber:Clear()
		RagdollListModel:Clear()
		ListofNumberCars:Clear()
		ListofModelsCars:Clear()
		RemoveAmmoList:Clear()
		ListofmodelPlayer:Clear()
		ListOfGroupsMingeBan:Clear()
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
				local ModelPlayers=net.ReadTable()
				local GroupsAccess=net.ReadTable()
				
				for access,groups in pairs(GroupsAccess) do
					for i=1,#groups do
						ListOfGroupsMingeBan:AddLine(groups[i])
					end
				end
			
				for group1,wep1 in pairs(weptab)do
					for i=1,#wep1 do
						WepList:AddLine(group1,wep1[i])
					end
				end

    			for group2,loadout in pairs(LoadoutTableList) do
        			for i=1,#loadout do
            			defalist:AddLine(group2,loadout[i])
        			end
    			end

    			for group3,ent in pairs(EntitiTableList) do
        			if ent.ent then
        				for i=1,#ent.ent do
            				entlist:AddLine(group3,ent.ent[i])
        				end
        			end
        			
        			if ent.number then
        				EntCountList:AddLine(group3,ent.number[1])
    				end
        				
    			end

    			for group4,tools in pairs(ToolTableList) do
        			for i=1,#tools do
            			toolremovelist:AddLine(group4,tools[i])
        			end
    			end

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

    			for group6,props in pairs(PropsListNumber) do
        			if props.number then
        				PropCountList:AddLine(group6,props.number[1])
        			end
        
        			if props.model then
        				for i=1,#props.model do
        					PropModelsAndGroups:AddLine(group6,props.model[i])
        				end
        			end 
    			end

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

    			for ammo,numberammo in pairs(AmmoTypesTable) do
    				for n,s in pairs(numberammo) do
    					RemoveAmmoList:AddLine(n,s,ammo)
					end
  
    			end
       
				for group_m,model_m in pairs(ModelPlayers)do
    				for i=1,#model_m do
        				ListofmodelPlayer:AddLine(group_m,model_m[i])
    				end
				end
				
 
			end) 
	end 

	QwerStrick()
end



concommand.Add("qwerstriction",function()
	if openedtpurs==true then
		MainWindow:SetVisible(false)
		openedtpurs=false return
	end
	qwerstriction() 
end)
	