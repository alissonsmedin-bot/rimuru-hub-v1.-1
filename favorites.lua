--// ⭐ RIMURU HUB
--// Favorites System
--// Gerenciamento de favoritos + salvamento local

local Favorites = {}

--==================================================
-- CONFIGURAÇÃO
--==================================================

local FILE_NAME = "RimuruHub_Favorites.json"

-- Favoritos mantidos em memória
local FavoriteList = {}

--==================================================
-- SERVIÇOS
--==================================================

local HttpService

pcall(function()
HttpService = game:GetService("HttpService")
end)

--==================================================
-- VERIFICAÇÃO DE FILESYSTEM
--==================================================

local function CanUseFileSystem()
return
type(isfile) == "function"
and type(readfile) == "function"
and type(writefile) == "function"
end

--==================================================
-- SALVAR
--==================================================

local function Save()
if not CanUseFileSystem() then
return false
end

if not HttpService then  
    return false  
end  

local success, encoded = pcall(function()  
    return HttpService:JSONEncode(FavoriteList)  
end)  

if not success then  
    return false  
end  

local saved = pcall(function()  
    writefile(FILE_NAME, encoded)  
end)  

return saved

end

--==================================================
-- CARREGAR
--==================================================

local function Load()
FavoriteList = {}

if not CanUseFileSystem() then  
    return  
end  

if not HttpService then  
    return  
end  

if not isfile(FILE_NAME) then  
    return  
end  

local success, content = pcall(function()  
    return readfile(FILE_NAME)  
end)  

if not success or not content or content == "" then  
    return  
end  

local decodedSuccess, decoded = pcall(function()  
    return HttpService:JSONDecode(content)  
end)  

if not decodedSuccess or type(decoded) ~= "table" then  
    return  
end  

for key, value in pairs(decoded) do  
    if value == true then  
        FavoriteList[tostring(key)] = true  
    end  
end

end

--==================================================
-- INICIALIZAÇÃO
--==================================================

Load()

--==================================================
-- ADICIONAR / REMOVER
--==================================================

function Favorites:Add(ID)
if ID == nil then
return false
end

ID = tostring(ID)  

FavoriteList[ID] = true  

Save()  

return true

end

function Favorites:Remove(ID)
if ID == nil then
return false
end

ID = tostring(ID)  

FavoriteList[ID] = nil  

Save()  

return true

end

--==================================================
-- ALTERNAR FAVORITO
--==================================================

function Favorites:Toggle(ID)
if ID == nil then
return false
end

ID = tostring(ID)  

if FavoriteList[ID] then  
    FavoriteList[ID] = nil  
    Save()  

    return false  
else  
    FavoriteList[ID] = true  
    Save()  

    return true  
end

end

--==================================================
-- VERIFICAR
--==================================================

function Favorites:IsFavorite(ID)
if ID == nil then
return false
end

return FavoriteList[tostring(ID)] == true

end

--==================================================
-- OBTER TODOS
--==================================================

function Favorites:GetAll()
local result = {}

for ID, value in pairs(FavoriteList) do  
    if value == true then  
        table.insert(result, ID)  
    end  
end  

return result

end

--==================================================
-- CONTADOR
--==================================================

function Favorites:GetCount()
local count = 0

for _, value in pairs(FavoriteList) do  
    if value == true then  
        count = count + 1  
    end  
end  

return count

end

--==================================================
-- LIMPAR TODOS
--==================================================

function Favorites:Clear()
FavoriteList = {}

Save()  

return true

end

--==================================================
-- RECARREGAR
--==================================================

function Favorites:Reload()
Load()

return FavoriteList

end

--==================================================
-- SALVAR MANUALMENTE
--==================================================

function Favorites:Save()
return Save()
end

--==================================================
-- STATUS
--==================================================

function Favorites:IsFileSystemAvailable()
return CanUseFileSystem()
end

--==================================================
-- EXPORTAR
--==================================================

return Favorites
