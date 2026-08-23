--// ⭐ RIMURU HUB
--// Favorites System
--// Gerenciamento de favoritos + salvamento local
--// MODULAR INIT COMPATIBLE
--// SAFE FILESYSTEM
--// SAFE JSON
--// MAIN LOADER COMPATIBLE

local Favorites = {}

--==================================================
-- CONFIGURAÇÃO
--==================================================

local FILE_NAME =
    "RimuruHub_Favorites.json"

--==================================================
-- MEMÓRIA
--==================================================

local FavoriteList = {}

--==================================================
-- CONTEXTO
--==================================================

Favorites.Context = nil
Favorites.Config = nil

--==================================================
-- SERVIÇOS
--==================================================

local HttpService

pcall(function()

    HttpService =
        game:GetService("HttpService")

end)

--==================================================
-- FILESYSTEM
--==================================================

local function CanUseFileSystem()

    return
        type(isfile) == "function"
        and
        type(readfile) == "function"
        and
        type(writefile) == "function"

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

    local Success, Encoded =
        pcall(function()

            return HttpService:JSONEncode(
                FavoriteList
            )

        end)

    if not Success then

        return false

    end

    local Saved =
        pcall(function()

            writefile(
                FILE_NAME,
                Encoded
            )

        end)

    return Saved

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

    local Exists =
        pcall(function()

            return isfile(FILE_NAME)

        end)

    if not Exists then

        return

    end

    local FileExists

    pcall(function()

        FileExists =
            isfile(FILE_NAME)

    end)

    if not FileExists then

        return

    end

    local Success, Content =
        pcall(function()

            return readfile(
                FILE_NAME
            )

        end)

    if not Success
    or not Content
    or Content == "" then

        return

    end

    local DecodeSuccess, Decoded =
        pcall(function()

            return HttpService:JSONDecode(
                Content
            )

        end)

    if not DecodeSuccess
    or type(Decoded) ~= "table" then

        return

    end

    for Key, Value in
        pairs(Decoded) do

        if Value == true then

            FavoriteList[
                tostring(Key)
            ] = true

        end

    end

end

--==================================================
-- INIT
--==================================================
-- Compatível com main.lua
--==================================================

function Favorites:Init(Context)

    self.Context =
        Context

    if Context then

        self.Config =
            Context.Config

    end

    -- Recarrega os favoritos ao inicializar.
    -- Isso evita depender apenas do carregamento
    -- feito quando o módulo foi executado.

    Load()

    return true

end

--==================================================
-- ADICIONAR
--==================================================

function Favorites:Add(ID)

    if ID == nil then

        return false

    end

    ID =
        tostring(ID)

    FavoriteList[ID] =
        true

    Save()

    return true

end

--==================================================
-- REMOVER
--==================================================

function Favorites:Remove(ID)

    if ID == nil then

        return false

    end

    ID =
        tostring(ID)

    FavoriteList[ID] =
        nil

    Save()

    return true

end

--==================================================
-- TOGGLE
--==================================================

function Favorites:Toggle(ID)

    if ID == nil then

        return false

    end

    ID =
        tostring(ID)

    if FavoriteList[ID] then

        FavoriteList[ID] =
            nil

        Save()

        return false

    end

    FavoriteList[ID] =
        true

    Save()

    return true

end

--==================================================
-- VERIFICAR
--==================================================

function Favorites:IsFavorite(ID)

    if ID == nil then

        return false

    end

    return
        FavoriteList[
            tostring(ID)
        ] == true

end

--==================================================
-- OBTER TODOS
--==================================================

function Favorites:GetAll()

    local Result =
        {}

    for ID, Value in
        pairs(FavoriteList) do

        if Value == true then

            table.insert(
                Result,
                ID
            )

        end

    end

    return Result

end

--==================================================
-- CONTADOR
--==================================================

function Favorites:GetCount()

    local Count =
        0

    for _, Value in
        pairs(FavoriteList) do

        if Value == true then

            Count += 1

        end

    end

    return Count

end

--==================================================
-- LIMPAR
--==================================================

function Favorites:Clear()

    FavoriteList =
        {}

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
-- FILESYSTEM STATUS
--==================================================

function Favorites:IsFileSystemAvailable()

    return CanUseFileSystem()

end

--==================================================
-- RETURN
--==================================================

return Favorites
