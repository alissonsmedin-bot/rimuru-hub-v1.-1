--// 💥 RIMURU HUB
--// Config
--// Interface Themes & Settings

return {

    --==================================================
    -- 🎨 TEMA ATUAL
    --==================================================

    -- Opções:
    -- "Golden"
    -- "DarkBlue"
    -- "WhiteGold"
    -- "RedBlack"
    -- "Green"
    -- "RGB"

    Theme = "Golden",

    --==================================================
    -- 🎨 TEMAS
    --==================================================

    Themes = {

        --==============================================
        -- 💛 GOLDEN
        -- Dourado neon / chique
        --==============================================

        Golden = {

            Accent = {
                R = 255,
                G = 195,
                B = 45
            },

            Background = {
                R = 15,
                G = 18,
                B = 28
            },

            SecondaryBackground = {
                R = 11,
                G = 14,
                B = 23
            },

            Card = {
                R = 27,
                G = 27,
                B = 34
            },

            Text = {
                R = 245,
                G = 245,
                B = 250
            },

            SubText = {
                R = 165,
                G = 165,
                B = 175
            },

            Border = {
                R = 255,
                G = 195,
                B = 45
            }
        },

        --==============================================
        -- 💙 DARK BLUE
        -- Azul escuro + azul claro
        --==============================================

        DarkBlue = {

            Accent = {
                R = 45,
                G = 150,
                B = 255
            },

            Background = {
                R = 9,
                G = 16,
                B = 30
            },

            SecondaryBackground = {
                R = 7,
                G = 12,
                B = 24
            },

            Card = {
                R = 18,
                G = 30,
                B = 50
            },

            Text = {
                R = 240,
                G = 245,
                B = 255
            },

            SubText = {
                R = 135,
                G = 155,
                B = 180
            },

            Border = {
                R = 45,
                G = 150,
                B = 255
            }
        },

        --==============================================
        -- 🤍 WHITE GOLD
        -- Branco + detalhes dourados
        --==============================================

        WhiteGold = {

            Accent = {
                R = 218,
                G = 170,
                B = 55
            },

            Background = {
                R = 242,
                G = 242,
                B = 238
            },

            SecondaryBackground = {
                R = 255,
                G = 255,
                B = 252
            },

            Card = {
                R = 230,
                G = 230,
                B = 225
            },

            Text = {
                R = 30,
                G = 30,
                B = 32
            },

            SubText = {
                R = 100,
                G = 100,
                B = 105
            },

            Border = {
                R = 218,
                G = 170,
                B = 55
            }
        },

        --==============================================
        -- ❤️ RED BLACK
        --==============================================

        RedBlack = {

            Accent = {
                R = 235,
                G = 45,
                B = 55
            },

            Background = {
                R = 16,
                G = 8,
                B = 10
            },

            SecondaryBackground = {
                R = 10,
                G = 7,
                B = 9
            },

            Card = {
                R = 32,
                G = 16,
                B = 20
            },

            Text = {
                R = 245,
                G = 235,
                B = 238
            },

            SubText = {
                R = 160,
                G = 130,
                B = 135
            },

            Border = {
                R = 235,
                G = 45,
                B = 55
            }
        },

        --==============================================
        -- 💚 GREEN
        --==============================================

        Green = {

            Accent = {
                R = 50,
                G = 220,
                B = 120
            },

            Background = {
                R = 8,
                G = 20,
                B = 15
            },

            SecondaryBackground = {
                R = 6,
                G = 14,
                B = 11
            },

            Card = {
                R = 15,
                G = 35,
                B = 25
            },

            Text = {
                R = 235,
                G = 250,
                B = 240
            },

            SubText = {
                R = 125,
                G = 165,
                B = 140
            },

            Border = {
                R = 50,
                G = 220,
                B = 120
            }
        },

        --==============================================
        -- 🌈 RGB
        --==============================================

        RGB = {

            Accent = "RGB",

            Background = {
                R = 15,
                G = 18,
                B = 28
            },

            SecondaryBackground = {
                R = 11,
                G = 14,
                B = 23
            },

            Card = {
                R = 24,
                G = 28,
                B = 40
            },

            Text = {
                R = 245,
                G = 245,
                B = 250
            },

            SubText = {
                R = 145,
                G = 150,
                B = 165
            },

            Border = "RGB"
        }
    },

    --==================================================
    -- ⚙️ CONFIGURAÇÕES DA INTERFACE
    --==================================================

    UI = {

        -- Logo
        ShowLogo = true,

        LogoDraggable = true,

        -- Menu
        MainMenuDraggable = true,

        -- Borda da logo acompanha o Accent
        LogoBorderUsesAccent = true,

        -- Borda do menu acompanha o Accent
        MenuBorderUsesAccent = true,

        -- Botões acompanham o Accent
        ButtonsUseAccent = true,

        -- Scrollbar acompanha o Accent
        ScrollbarUsesAccent = true,

        --==================================================
        -- 📐 TAMANHO DO MENU
        --==================================================

        Width = 600,
        Height = 400,

        MinWidth = 400,
        MinHeight = 250,

        --==================================================
        -- ✨ APARÊNCIA
        --==================================================

        MenuCornerRadius = 12,

        CardCornerRadius = 8,

        ButtonCornerRadius = 7,

        LogoCornerRadius = 14,

        BorderThickness = 1.5,

        LogoBorderThickness = 2,

        --==================================================
        -- 🖱️ COMPORTAMENTO
        --==================================================

        CloseWithX = true,

        OpenWithLogo = true,

        -- Impede a logo de desaparecer permanentemente
        RestoreLogoOnClose = true
    },

    --==================================================
    -- ⚙️ FUNÇÕES DA CATEGORIA "CONFIGURAÇÃO"
    --==================================================

    Settings = {

        {
            Name = "Mostrar Logo",
            Type = "Toggle",
            Property = "ShowLogo"
        },

        {
            Name = "Logo Arrastável",
            Type = "Toggle",
            Property = "LogoDraggable"
        },

        {
            Name = "Menu Arrastável",
            Type = "Toggle",
            Property = "MainMenuDraggable"
        },

        {
            Name = "Borda da Logo usa Tema",
            Type = "Toggle",
            Property = "LogoBorderUsesAccent"
        },

        {
            Name = "Borda do Menu usa Tema",
            Type = "Toggle",
            Property = "MenuBorderUsesAccent"
        },

        {
            Name = "Botões usam Tema",
            Type = "Toggle",
            Property = "ButtonsUseAccent"
        },

        {
            Name = "Scrollbar usa Tema",
            Type = "Toggle",
            Property = "ScrollbarUsesAccent"
        }
    }

}
