genelGuiTablo = {}

--guiCreateWindow
wtablo = {}
--guiCreateButton
btablo = {}
--guiCreateGridList
Ltablo = {}
--guiCreateMemo
mtablo = {}
--guiCreateEdit
etablo = {}
--guiguiCreateScrollBar
sbtablo = {}

function resimOlustur(isim)
	if fileExists(isim.."png") then return isim.."png" end
	local texture = dxCreateTexture(1,1) 
	local pixels = dxGetTexturePixels(texture) 
	local r,g,b,a = 255,255,255,255 
	dxSetPixelColor(pixels,0,0,r,g,b,a) 
	dxSetTexturePixels(texture, pixels) 
	local pxl = dxConvertPixels(dxGetTexturePixels(texture),"png") 
	local nImg = fileCreate(isim..".png") 
	fileWrite(nImg,pxl) 
	fileClose(nImg)
	return isim..".png" 
end

function renkVer(resim,hex)
	guiSetProperty(resim,"ImageColours","tl:FF"..hex.." tr:FF"..hex.." bl:FF"..hex.." br:FF"..hex)
end

_guiCreateWindow = guiCreateWindow
function guiCreateWindow(x,y,g,u,yazi,relative,parent,renk1,renk2,renk3,renk4)
	wsayi = #wtablo +1
	
	if not renk1 or string.len(renk1) > 6 then
		renk1 =  "000000" -- window renk üst taraf
	end
	if not renk2 or string.len(renk2) > 6 then
		renk2 = "000000" -- panel adı kısmı
	end
	if not renk3 or string.len(renk3) > 6 then
		renk3 = "000000" -- window renk alt taraf
	end
	if not renk4 or string.len(renk4) > 6 then
		renk4 = "000000"  -- window cerceve renk
	end
	
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
	
	if not wtablo[wsayi] then wtablo[wsayi] = {} end
	--arkaResim
	wtablo[wsayi].resim = guiCreateStaticImage(x,y,g,u,resimOlustur("test"),relative,parent)
	renkVer(wtablo[wsayi].resim,renk1)
	guiSetProperty(wtablo[wsayi].resim,"ImageColours","tl:FF"..renk1.." tr:FF"..renk1.." bl:FF"..renk3.." br:FF"..renk3.."")
	guiSetAlpha(wtablo[wsayi].resim, 0.85)
	--baslıkArka
	wtablo[wsayi].basarka = guiCreateStaticImage(0,0,g,20, resimOlustur("test"), false, wtablo[wsayi].resim)
	renkVer(wtablo[wsayi].basarka,renk2)
	--kenarlar
	wtablo[wsayi].kenarlar = {
		ordaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, wtablo[wsayi].resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, wtablo[wsayi].resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, wtablo[wsayi].resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, wtablo[wsayi].resim)
	}
	
	for i,v in pairs(wtablo[wsayi].kenarlar) do
		renkVer(v,renk4)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	--baslıkLabel
	wtablo[wsayi].label = guiCreateLabel((g/2)-((string.len(yazi)*8)/2),0,(string.len(yazi)*8),20, yazi, false, wtablo[wsayi].basarka)
	guiSetFont(wtablo[wsayi].label, "default-bold-small")
	guiLabelSetHorizontalAlign(wtablo[wsayi].label, "center")
	guiLabelSetVerticalAlign(wtablo[wsayi].label, "center")
	--kapatArka
	if not kapat then
		wtablo[wsayi].kapatArka = guiCreateStaticImage(g-25,-1,25,20,resimOlustur("test"),false,wtablo[wsayi].basarka)
		renkVer(wtablo[wsayi].kapatArka,"E81123")
		guiSetAlpha(wtablo[wsayi].kapatArka, 0.5)
		--kapatLabel
		wtablo[wsayi].kapat = guiCreateLabel(0,-2,25,20, "X", false, wtablo[wsayi].kapatArka)
		guiSetFont(wtablo[wsayi].kapat, "default-bold-small")
		guiLabelSetHorizontalAlign(wtablo[wsayi].kapat, "center")
		guiLabelSetVerticalAlign(wtablo[wsayi].kapat, "center")
	end	
	return wtablo[wsayi].resim
end

_guiCreateButton = guiCreateButton
function guiCreateButton(x,y,g,u,yazi,relative,parent,renk1,renk2)
	bsayi = #btablo +1
	if not btablo[bsayi] then btablo[bsayi] = {} end
	
	if not renk1 or string.len(renk1) > 6 then
		--renk = math.random(999999)
		renk1 = "1f1b1a"
	end
	if not renk2 or string.len(renk2) > 6 then
		renk2 = "000000"
	end
	--arkaResim
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
		relative = false
	end
	btablo[bsayi].resim = guiCreateStaticImage(x,y,g,u,resimOlustur("test"),relative,parent)
	renkVer(btablo[bsayi].resim,renk1)
	--kenarlar
	btablo[bsayi].kenarlar = {
		ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), relative, btablo[bsayi].resim),
		ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), relative, btablo[bsayi].resim),
		sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), relative, btablo[bsayi].resim),
		sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), relative, btablo[bsayi].resim)
	}
	
	for i,v in pairs(btablo[bsayi].kenarlar) do
		renkVer(v,renk2)
		guiSetAlpha(v, 0.4)
	end	
	--label
	btablo[bsayi].label = guiCreateLabel(0,0,g,u,yazi,relative,btablo[bsayi].resim)
	guiLabelSetHorizontalAlign(btablo[bsayi].label, "center")
	guiLabelSetVerticalAlign(btablo[bsayi].label, "center")
	guiSetFont(btablo[bsayi].label, "default-bold-small")
	
	genelGuiTablo[btablo[bsayi].label] = btablo[bsayi].kenarlar
	return btablo[bsayi].label 
end

_guiCreateGridList = guiCreateGridList
function guiCreateGridList(x,y,g,u,relative,parent,kenarrenk)
	Ssayi = #Ltablo +1
	
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "000000"
	end
	
	if not Ltablo[Ssayi] then Ltablo[Ssayi] = {} end
	
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	local relative = false
	
	Ltablo[Ssayi].resim = guiCreateStaticImage(x,y,g,u, resimOlustur("test"), relative, parent)
	renkVer(Ltablo[Ssayi].resim,kenarrenk)
	Ltablo[Ssayi].liste = _guiCreateGridList(-8,-10,g+20, u+18,false, Ltablo[Ssayi].resim)
	
	Ltablo[Ssayi].kenarlar = {
	ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, Ltablo[Ssayi].resim),
	ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, Ltablo[Ssayi].resim),
	sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, Ltablo[Ssayi].resim),
	sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, Ltablo[Ssayi].resim)}
	genelGuiTablo[Ltablo[Ssayi].liste] = Ltablo[Ssayi].kenarlar
	
	for i,v in pairs(Ltablo[Ssayi].kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	return Ltablo[Ssayi].liste
end

_guiCreateEdit = guiCreateEdit
function guiCreateEdit(x,y,g,u,yazi,relative,parent,kenarrenk)
	esayi = #etablo +1
	
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "000000"
	end
	
	if not etablo[esayi] then etablo[esayi] = {} end
	
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	local relative = false

	etablo[esayi].resim = guiCreateStaticImage(x,y,g,u, resimOlustur("test"), relative, parent)
	--guiSetAlpha(etablo[esayi].resim, 0)
	renkVer(etablo[esayi].resim,kenarrenk)
	etablo[esayi].edit = _guiCreateEdit(-7,-5,g+15, u+8,yazi,false, etablo[esayi].resim)
	etablo[esayi].kenarlar = {
	ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, etablo[esayi].resim),
	ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, etablo[esayi].resim),
	sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, etablo[esayi].resim),
	sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, etablo[esayi].resim)}
	genelGuiTablo[etablo[esayi].edit] = etablo[esayi].kenarlar
	for i,v in pairs(etablo[esayi].kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	return etablo[esayi].edit
end

_guiCreateMemo = guiCreateMemo
function guiCreateMemo(x,y,g,u,yazi,relative,parent,kenarrenk)
	msayi = #mtablo +1
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "000000"
	end
	
	if not mtablo[msayi] then mtablo[msayi] = {} end
	
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	local relative = false
	
	mtablo[msayi].resim = guiCreateStaticImage(x,y,g,u, resimOlustur("test"), relative, parent)
	renkVer(mtablo[msayi].resim,kenarrenk)
	mtablo[msayi].memo = _guiCreateMemo(-5,-10,g+15, u+10, yazi,false, mtablo[msayi].resim)
	
	mtablo[msayi].kenarlar = {
	ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, mtablo[msayi].resim),
	ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, mtablo[msayi].resim),
	sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, mtablo[msayi].resim),
	sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, mtablo[msayi].resim)}
	genelGuiTablo[mtablo[msayi].memo] = mtablo[msayi].kenarlar
	for i,v in pairs(mtablo[msayi].kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	
	return mtablo[msayi].memo
end

function guiCreateScrollBar(x,y,g,u,horizontal,relative,parent,kenarrenk)	
	sbsayi = #sbtablo +1
	if not kenarrenk or string.len(kenarrenk) > 6 then
		kenarrenk =  "000000"
	end
	
	if not sbtablo[sbsayi] then sbtablo[sbsayi] = {} end
	
	if relative  then
		px,pu = guiGetSize(parent,false)
		x,y,g,u = x*px,y*pu,g*px,u*pu
	end
	local relative = false
	
	sbtablo[sbsayi].resim = guiCreateStaticImage(x,y,g,u, resimOlustur("test"), relative, parent)
	renkVer(sbtablo[sbsayi].resim,"000000")
	sbtablo[sbsayi].kutu = guiCreateStaticImage(2,2,5,u-4, resimOlustur("test"),false, sbtablo[sbsayi].resim)
	
	sbtablo[sbsayi].kenarlar = {
	ortaUst = guiCreateStaticImage(0,0,g,1,resimOlustur("test"), false, sbtablo[sbsayi].resim),
	ortaAlt = guiCreateStaticImage(0,u-1,g,1,resimOlustur("test"), false, sbtablo[sbsayi].resim),
	sol = guiCreateStaticImage(0,0,1,u,resimOlustur("test"), false, sbtablo[sbsayi].resim),
	sag = guiCreateStaticImage(g-1,0,1,u,resimOlustur("test"), false, sbtablo[sbsayi].resim)}
	genelGuiTablo[sbtablo[sbsayi].resim] = sbtablo[sbsayi].kenarlar
	genelGuiTablo[sbtablo[sbsayi].kutu] = sbtablo[sbsayi].kenarlar
	for i,v in pairs(sbtablo[sbsayi].kenarlar) do
		renkVer(v,kenarrenk)
		guiSetProperty(v, "AlwaysOnTop", "True")
		guiSetAlpha(v, 0.4)
	end	
	
	return sbtablo[sbsayi].kutu
end

function guiScrollBarGetScrollPosition(scroll)
	local parent = getElementParent(scroll)
	local w = guiGetSize(parent,false)
	local x = guiGetPosition(scroll,false)
	return ((x-2)/(w-7))*100
end

function guiScrollBarSetScrollPosition(scroll,amount)
	local parent = getElementParent(scroll)
	local w = guiGetSize(parent,false)
	guiSetPosition(scroll,(amount/100)*(w-9)+2,2,false)
end

--edit,gridlst,buton,memo mouse
addEventHandler("onClientMouseEnter", resourceRoot, function()
	for i,v in pairs(genelGuiTablo) do
		if source == i then
			for i,v in pairs(v) do
				guiSetAlpha(v, 1)
			end	
		end
	end
end)

addEventHandler("onClientMouseLeave", resourceRoot, function()
	for i,v in pairs(genelGuiTablo) do
		if source == i then
			for i,v in pairs(v) do
				guiSetAlpha(v, 0.4)
			end	
		end
	end
end)

--pencere mouse
addEventHandler("onClientMouseEnter", resourceRoot, function()
	for i,v in pairs(wtablo) do
		if source == v.kapat then
			guiSetAlpha(v.kapatArka, 1)
			break
		end
	end
end)

addEventHandler("onClientMouseLeave", resourceRoot, function()
	for i,v in pairs(wtablo) do
		if source == v.kapat then
			guiSetAlpha(v.kapatArka, 0.5)
			break
		end
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function()
	for i,v in pairs(wtablo) do
		if source == v.kapat then
			guiSetInputEnabled(false)
			guiSetVisible(v.resim, false)
			showCursor(false)
		end
	end	
end)

function butonmu(label)
	for i,v in pairs(btablo) do
		if v.label == label then
			return i
		end	
	end
	return false	
end

function penceremi(resim)
	for i,v in pairs(wtablo) do
		if v.resim == resim then
			return i
		end	
	end
	return false	
end

function basliklabelmi(label)
	for i,v in pairs(wtablo) do
		if v.label == label then
			return i
		end	
	end
	return false	
end

function baslikmi(element)
	for i,v in pairs(wtablo) do
		if v.basarka == element or wtablo[basliklabelmi(element)] and  v.label == element then
			return i
		end	
	end
	return false	
end

function kutumu(element)
	for i,v in pairs(sbtablo) do
		if v.kutu == element then
			return i
		end	
	end
	return false	
end

--basinca olan ufalma
basili = {}
addEventHandler("onClientGUIMouseDown", resourceRoot, function()
	if butonmu(source) then
		if basili[source] then return end
		basili[source] = true
		local g,u = guiGetSize(source, false)
		local x,y = guiGetPosition(source, false)
		guiSetPosition(source, x+2,y+2, false)
		guiSetSize(source, g-4,u-4, false)
	end
end)

addEventHandler("onClientGUIMouseUp", resourceRoot, function()
	if butonmu(source) then
		if not basili[source] then  
			for i,v in pairs(basili) do
				if v == true then
					source = i
					break
				end
			end	
		end
		if not basili[source] then return end
		basili[source] = nil
		local g,u = guiGetSize(source, false)
		local x,y = guiGetPosition(source, false)
		guiSetPosition(source, x-2,y-2, false)
		guiSetSize(source, g+4,u+4, false)
	else
		for i,v in pairs(basili) do
			if v == true then
				source = i
				break
			end
		end	
		if butonmu(source) then
			basili[source] = nil
			local g,u = guiGetSize(source, false)
			local x,y = guiGetPosition(source, false)
			guiSetPosition(source, x-2,y-2, false)
			guiSetSize(source, g+4,u+4, false)
		end	
	end
end)

function basiliBirak()
	for i,v in pairs(basili) do
			if v == true then
				source = i
				break
			end
		end	
	if butonmu(source) then
		basili[source] = nil
		local g,u = guiGetSize(source, false)
		local x,y = guiGetPosition(source, false)
		guiSetPosition(source, x-2,y-2, false)
		guiSetSize(source, g+4,u+4, false)
	end	
end

addEventHandler("onClientClick", root, function(button, durum, _, _, _, _, _, tiklanan)
	if durum == "up" then
		if tiklanan then 
			local element = getElementType(tiklanan)
			if not string.find(element, "gui-") then
				basiliBirak()
			end	
		else
			basiliBirak()
		end
	end	
end)

--panel taşıma
addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	if btn == "left" and baslikmi(source) then
		local source = wtablo[baslikmi(source)].resim
		clickedElement = source
		local elementPos = { guiGetPosition( source, false ) }
		offsetPos = { x - elementPos[ 1 ], y - elementPos[ 2 ] };
	end
end)

addEventHandler( "onClientGUIMouseUp", resourceRoot,function ( btn, x, y )
	if btn == "left" and baslikmi(source) then
		clickedElement = nil
	end
end)

addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, x, y )
	if clickedElement then
		guiSetPosition( clickedElement, x - offsetPos[ 1 ], y - offsetPos[ 2 ], false )
	end
end)

--scrollbar taşıma
addEventHandler( "onClientGUIMouseDown", resourceRoot,function ( btn, x, y )
	if btn == "left" and kutumu(source) then
		clickedElementSB = source
		local elementPos = { guiGetPosition( source, false ) }
		local parent = getElementParent(source)
		local w = guiGetSize(parent,false)
		offsetPosSB = { elementPos[ 1 ], elementPos[ 2 ], x, w };
	end
end)

addEventHandler( "onClientClick", root,function ( btn, state )
	if btn == "left" and clickedElementSB and state == "up" then
		clickedElementSB = nil
	end
end)

addEventHandler( "onClientCursorMove", getRootElement( ),function ( _, _, x, y )
	if clickedElementSB then
		local farkx = x-offsetPosSB[3]
		local x,y = farkx + offsetPosSB[ 1 ], offsetPosSB[ 2 ]
		guiSetPosition( clickedElementSB, (x<2 and 2) or (x>(offsetPosSB[4]-7) and offsetPosSB[4]-7) or x, y, false )
		triggerEvent("onClientGUIScroll",clickedElementSB,clickedElementSB)
	end
end)

--diğer funclar
_guiGetPosition = guiGetPosition
function guiGetPosition(element,relative)
	if butonmu(element) then
		local sira = butonmu(element)
		local x,y = _guiGetPosition(btablo[sira].resim, relative)
		return x,y 
	else
		local x,y = _guiGetPosition(element, relative)
		return x,y
	end
end

_guiSetPosition = guiSetPosition
function guiSetPosition(element,x,y,relative)
	if butonmu(element) then
		local sira = butonmu(element)
		_guiSetPosition(btablo[sira].resim, x,y, relative)
	else
		_guiSetPosition(element,x,y,relative)
	end
end

_guiGetSize = guiGetSize
function guiGetSize(element,relative)
	if butonmu(element) then
		local sira = butonmu(element)
		local g,u = _guiGetSize(btablo[sira].resim, relative)
		return g,u 
	else
		local g,u = _guiGetSize(element, relative)
		return g,u
	end
end

_guiSetSize = guiSetSize
function guiSetSize(element,g,u,relative)
	if butonmu(element) then
		local sira = butonmu(element)
		_guiSetSize(btablo[sira].resim, g,u, false)
		_guiSetSize(btablo[sira].label, g,u, false)
		--sağ kenar çizgi
		_guiSetPosition(btablo[sira].kenarlar.sag, g-1, 0, false)
		_guiSetSize(btablo[sira].kenarlar.sag, 1,u, false)
		--alt kenar çizgi
		_guiSetPosition(btablo[sira].kenarlar.ortaAlt, 0, u-1, false)
		_guiSetSize(btablo[sira].kenarlar.ortaAlt, g,1, false)
	elseif penceremi(source) then
		local sira = penceremi(source)
		_guiSetSize(wtablo[sira].resim, g,u, false)
		--sağ kenar çizgi
		_guiSetPosition(wtablo[sira].kenarlar.sag, g-1, 0, false)
		_guiSetSize(wtablo[sira].kenarlar.sag, 1,u, false)
		--alt kenar çizgi
		_guiSetPosition(wtablo[sira].kenarlar.ortaAlt, 0, u-1, false)
		_guiSetSize(wtablo[sira].kenarlar.ortaAlt, g,1, false)
		--baslik
		_guiSetSize(wtablo[sira].basarka, g,20, false)
		--kapat
		_guiSetPosition(wtablo[sira].kapatArka, g-25,1, false)
		--label
		local yazi = guiGetText(wtablo[sira].label)
		_guiSetPosition(wtablo[sira].label, (g/2)-((string.len(yazi)*8)/2),0, false)
		_guiSetSize(wtablo[sira].label,(string.len(yazi)*8),20, false)
		guiLabelSetHorizontalAlign(wtablo[sira].label, "center")
		guiLabelSetVerticalAlign(wtablo[sira].label, "center")
	end	
end		

_guiSetText = guiSetText
function guiSetText(element, yazi)
	if penceremi(element) then
		local sira = penceremi(element)
		local g,u = guiGetSize(wtablo[sira].resim,false)
		guiSetPosition(wtablo[sira].label,(g/2)-((string.len(yazi)*8)/2),0, false)
		guiSetSize(wtablo[sira].label, (string.len(yazi)*8),20, false)
		guiLabelSetHorizontalAlign(wtablo[sira].label, "center")
		guiLabelSetVerticalAlign(wtablo[sira].label, "center")
		_guiSetText(wtablo[sira].label, yazi)
	else
		_guiSetText(element, yazi)
	end
end

_guiGetText = guiGetText
function guiGetText(element)
	if penceremi(element) then
		local sira = penceremi(element)
		local yazi = _guiGetText(wtablo[sira].label)
		return yazi
	else
		local yazi = _guiGetText(element)
		return yazi
	end
end

_guiSetEnabled = guiSetEnabled
function guiSetEnabled(element, bool)
	if butonmu(element) then
		if bool == false then
			guiSetAlpha(btablo[butonmu(element)].resim,0.5)
			_guiSetEnabled(element, bool)
		else
			guiSetAlpha(btablo[butonmu(element)].resim,1)
			_guiSetEnabled(element, bool)
		end
	else
		_guiSetEnabled(element, bool)
	end	
end

_guiWindowSetSizable = guiWindowSetSizable
function guiWindowSetSizable(element, bool)
	if getElementType(element) ~= "gui-window" then
		return false
	else
		_guiWindowSetSizable(element, bool)
	end	
end
-------------------------------------------------
------------ EDITED BY Beyonder#0711 ------------
-------------------------------------------------
-------------- metascripts.org-------------------
-------------------------------------------------


-------------------------
-- İmportant Functions
-------------------------
local sx,sy = guiGetScreenSize()

function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
function relativeto(x1,x2)
    return sx *x1, sy*x2
end
function torelative(x1,x2)
    return x1/sx,x2/sy
end
function hex2rgb(hex) --Hex to R,G,B
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

-------------------------------------------
--GUI Animations
-------------------------------------------
local animations = {}
local anim_timers = {}
--Gui moving animation
function guiMoveTo(elm,movex,movey,relative,easing,duration,waiting)
    local x,y = guiGetPosition(elm,relative)
    local tick  = getTickCount()
    if waiting then
        table.insert(anim_timers,{
            elm = elm,
            timer = setTimer(function(elm,startx,starty,movex,movey,relative,easing,duration)
                table.insert(animations,{anim_type="moving",elm=elm,startx=x,starty=y,movex=movex,movey=movey,relative=relative,oldTick=tick,easing=easing,duration=duration})
            end,waiting,1,elm,x,y,movex,movey,relative,easing,duration)
        })
    else
        table.insert(animations,{anim_type="moving",elm=elm,startx=x,starty=y,movex=movex,movey=movey,relative=relative,oldTick=tick,easing=easing,duration=duration})
    end
end
--Gui Alpha animation
function guiAlphaTo(elm,movealpha,easing,duration,waiting)
    local startalpha = guiGetAlpha(elm)
    local tick  = getTickCount()

    if waiting then
        table.insert(anim_timers,{
            elm = elm,
            timer = setTimer(function(elm,startalpha,movealpha,easing,duration)
                table.insert(animations,{anim_type="alpha",elm=elm,startalpha=startalpha,movealpha=movealpha,oldTick=tick,easing=easing,duration=duration})
            end,waiting,1,elm,startalpha,movealpha,easing,duration)
        })
    else
        table.insert(animations,{anim_type="alpha",elm=elm,startalpha=startalpha,movealpha=movealpha,oldTick=tick,easing=easing,duration=duration})
    end
end
--Gui sizing animation
function guiSizeTo(elm,sizew,sizeh,relative,easing,duration,waiting)
    local w,h = guiGetSize(elm,relative)
    local tick  = getTickCount()

    if waiting then
        table.insert(anim_timers,{
            elm = elm,
            timer = setTimer(function(elm,w,h,sizew,sizeh,relative,easing,duration)
                table.insert(animations,{anim_type="sizing",elm=elm,startw=w,starth=h,sizew=sizew,sizeh=sizeh,relative=relative,oldTick=tick,easing=easing,duration=duration})
            end,waiting,1,elm,w,h,sizew,sizeh,relative,easing,duration)
        })
    else
        table.insert(animations,{anim_type="sizing",elm=elm,startw=w,starth=h,sizew=sizew,sizeh=sizeh,relative=relative,oldTick=tick,easing=easing,duration=duration})
    end
end


function guiStopAniming(elm)
    for k,v in ipairs(anim_timers) do 
        if v.elm == elm then 
            if isTimer(v.timer) then 
                killTimer(v.timer)
            end
            table.remove(anim_timers,k)
        end
    end
    for index,animt in ipairs(animations) do 
        if animt.elm == elm then
            table.remove(animations,index)
        end 
    end
end

function setAnimRender()
    local nowTick = getTickCount()
    for index,animt in ipairs(animations) do 
        if animt.anim_type == "moving" then 
            if animt.relative then
                local startx,starty = relativeto(animt.startx,animt.starty)
                local movex,movey =  relativeto(animt.movex,animt.movey)
                movex,movey = interpolateBetween(startx,starty,0,movex,movey,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                movex,movey = torelative(movex,movey)
                guiSetPosition(animt.elm,movex,movey,animt.relative) 
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index) end
            else
                local movex,movey = interpolateBetween(animt.startx,animt.starty,0,animt.movex,animt.movey,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                guiSetPosition(animt.elm,movex,movey,animt.relative)
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index)  end
            end
        end
        if animt.anim_type == "alpha" then 
            local movealpha= interpolateBetween(animt.startalpha,0,0,animt.movealpha,0,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
            guiSetAlpha(animt.elm,movealpha)
            if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index)  end
        end
        
        if animt.anim_type == "sizing" then 
            if animt.relative then
                local startw,starth = relativeto(animt.startw,animt.starth)
                local sizew,sizeh =  relativeto(animt.sizew,animt.sizeh)
                sizew,sizeh = interpolateBetween(startw,starth,0,sizew,sizeh,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                sizew,sizeh = torelative(sizew,sizeh)
                guiSetSize(animt.elm,sizew,sizeh,animt.relative) 
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index) end
            else
                local movew,moveh = interpolateBetween(animt.startw,animt.starth,0,animt.sizew,animt.sizeh,0,(nowTick-animt.oldTick)/animt.duration,animt.easing)
                guiSetSize(animt.elm,movew,moveh,animt.relative)
                if nowTick-animt.oldTick  > animt.duration then  table.remove(animations,index)  end
            end
        end
    end
end
addEventHandler("onClientRender",root,setAnimRender)

---Custom Anims
--------------------------------------------------
--gui Alert Animation ( - gui uyarı animasyonu - )
---------------------------------------------------
function guiAlertAnim(element,relative)
    if not element then return end
    local elm_x,elm_y = guiGetPosition(element,relative)
    local elm_w,elm_h = guiGetSize(element,relative)
    local move_result = 0
    if relative then 
        move_result =  0.01
    else
        move_result = 10
    end
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,50)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,100)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,150)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,200)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,250)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,300)
    guiMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,350)
    guiMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,400)
    guiMoveTo(element,elm_x,elm_y,relative,"SineCurve",500,450)
    setTimer(function(element,elm_x,elm_y,relative,elm_w,elm_h)
        guiStopAniming(element)
        guiSetPosition(element,elm_x,elm_y,relative)
        guiSetSize(element,elm_w,elm_h,relative)
    end,650,2,element,elm_x,elm_y,relative,elm_w,elm_h)
end


