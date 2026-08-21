--// 💥 RIMURU HUB
--// Configuration
--// Theme + Background System

return {

    --==================================================
    -- UI
    --==================================================

    UI = {

        -- Tema inicial
        Theme = "Rimuru Dark",

        --==================================================
        -- ANIMATION
        --==================================================

        Animation = true,
        --==================================================
        -- LOGO
        --==================================================

        ShowLogo = true,
        LogoDraggable = true,
        MainMenuDraggable = true,

        --==================================================
        -- THEMES
        --==================================================

        Themes = {

            --==================================================
            -- 🌑 RIMURU DARK
            --==================================================

            ["Rimuru Dark"] = {

                Accent =
                    Color3.fromRGB(
                        25,
                        150,
                        255
                    ),
                Main =
                    Color3.fromRGB(
                        5,
                        8,
                        16
                    ),

                Sidebar =
                    Color3.fromRGB(
                        4,
                        7,
                        14
                    ),

                Content =
                    Color3.fromRGB(
                        6,
                        10,
                        19
                    ),
                Card =
                    Color3.fromRGB(
                        12,
                        20,
                        33
                    ),

                Button =
                    Color3.fromRGB(
                        9,
                        16,
                        28
                    ),

                Text =
                    Color3.fromRGB(
                        240,
                        248,
                        255
                    ),
                SubText =
                    Color3.fromRGB(
                        105,
                        145,
                        175
                    ),

                LogoBackground =
                    Color3.fromRGB(
                        5,
                        20,
                        40
                    ),
                Close =
                    Color3.fromRGB(
                        12,
                        22,
                        36
                    ),

                -- Background
                BackgroundImage =
                    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/main/images%20(2).jpeg",

                BackgroundTransparency =
                    0.32

            },

            --==================================================
            -- 💧 SLIME
            --==================================================

            ["Slime"] = {

                Accent =
                    Color3.fromRGB(
                        40,
                        210,
                        255
                    ),
                Main =
                    Color3.fromRGB(
                        4,
                        15,
                        24
                    ),

                Sidebar =
                    Color3.fromRGB(
                        3,
                        12,
                        20
                    ),

                Content =
                    Color3.fromRGB(
                        5,
                        18,
                        29
                    ),
                Card =
                    Color3.fromRGB(
                        9,
                        31,
                        45
                    ),

                Button =
                    Color3.fromRGB(
                        7,
                        25,
                        38
                    ),

                Text =
                    Color3.fromRGB(
                        235,
                        250,
                        255
                    ),
                SubText =
                    Color3.fromRGB(
                        100,
                        175,
                        195
                    ),

                LogoBackground =
                    Color3.fromRGB(
                        5,
                        42,
                        58
                    ),
                Close =
                    Color3.fromRGB(
                        10,
                        40,
                        52
                    ),

                BackgroundImage =
                    "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/main/images%20(3).jpeg",

                BackgroundTransparency =
                    0.30

            },

            --==================================================
            -- 🕳️ VOID
            --==================================================

            ["Void"] = {

                Accent =
                    Color3.fromRGB(
                        145,
                                               90,
                        255
                    ),
                Main =
                    Color3.fromRGB(
                        3,
                        3,
                        6
                    ),

                Sidebar =
                    Color3.fromRGB(
                        2,
                        2,
                        4
                    ),

                Content =
                    Color3.fromRGB(
                        4,
                        4,
                        8
                    ),
                Card =
                    Color3.fromRGB(
                        12,
                        10,
                        19
                    ),

                Button =
                    Color3.fromRGB(
                        9,
                        8,
                        15
                    ),

                Text =
                    Color3.fromRGB(
                        245,
                        240,
                        255
                    ),
                SubText =
                    Color3.fromRGB(
                        125,
                        115,
                        145
                    ),

                LogoBackground =
                    Color3.fromRGB(
                        18,
                        10,
                        35
                    ),
                Close =
                    Color3.fromRGB(
                        25,
                        20,
                        35
                    )

            },

            --==================================================
            -- ⚫ BLACKOUT
            --==================================================

            ["Blackout"] = {
                Accent =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    ),

                Main =
                    Color3.fromRGB(
                        3,
                        3,
                        3
                    ),

                Sidebar =
                    Color3.fromRGB(
                        1,
                        1,
                        1
                    ),
                Content =
                    Color3.fromRGB(
                        5,
                        5,
                        5
                    ),

                Card =
                    Color3.fromRGB(
                        15,
                        15,
                        15
                    ),

                Button =
                    Color3.fromRGB(
                        10,
                        10,
                        10
                    ),
                Text =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    ),

                SubText =
                    Color3.fromRGB(
                        150,
                        150,
                        150
                    ),
                LogoBackground =
                    Color3.fromRGB(
                        8,
                        8,
                        8
                    ),

                Close =
                    Color3.fromRGB(
                        25,
                        25,
                        25
                    )

            },

            --==================================================
            -- 🔵 AZUL ESCURO
            --==================================================

            ["Azul Escuro"] = {

                Accent =
                    Color3.fromRGB(
                        35,
                        145,
                        255
                    ),
                Main =
                    Color3.fromRGB(
                        15,
                        18,
                        28
                    ),

                Sidebar =
                    Color3.fromRGB(
                        11,
                        14,
                        23
                    ),

                Content =
                    Color3.fromRGB(
                        11,
                        14,
                        23
                    ),
                Card =
                    Color3.fromRGB(
                        24,
                        28,
                        40
                    ),

                Button =
                    Color3.fromRGB(
                        20,
                        24,
                        35
                    ),

                Text =
                    Color3.fromRGB(
                        240,
                        243,
                        250
                    ),
                SubText =
                    Color3.fromRGB(
                        130,
                        140,
                        160
                    ),

                LogoBackground =
                    Color3.fromRGB(
                        8,
                        22,
                        48
                    ),
                Close =
                    Color3.fromRGB(
                        35,
                        40,
                        55
                    )

            },

            --==================================================
            -- 💛 DOURADO NEON
            --==================================================

            ["Dourado Neon"] = {
                Accent =
                    Color3.fromRGB(
                        255,
                        190,
                        45
                    ),

                Main =
                    Color3.fromRGB(
                        24,
                        20,
                        10
                    ),

                Sidebar =
                    Color3.fromRGB(
                        20,
                        17,
                        9
                    ),
                Content =
                    Color3.fromRGB(
                        20,
                        17,
                        9
                    ),

                Card =
                    Color3.fromRGB(
                        39,
                        32,
                        17
                    ),

                Button =
                    Color3.fromRGB(
                        32,
                        27,
                        14
                    ),
                Text =
                    Color3.fromRGB(
                        255,
                        248,
                        220
                    ),

                SubText =
                    Color3.fromRGB(
                        190,
                        170,
                        120
                    ),
                LogoBackground =
                    Color3.fromRGB(
                        42,
                        31,
                        7
                    ),

                Close =
                    Color3.fromRGB(
                        55,
                        44,
                        18
                    )

            },

            --==================================================
            -- 🤍 BRANCO DOURADO
            --==================================================

            ["Branco Dourado"] = {

                Accent =
                    Color3.fromRGB(
                        218,
                        170,
                        55
                    ),
                Main =
                    Color3.fromRGB(
                        235,
                        235,
                        232
                    ),

                Sidebar =
                    Color3.fromRGB(
                        220,
                        220,
                        216
                    ),
                Content =
                    Color3.fromRGB(
                        225,
                        225,
                        221
                    ),

                Card =
                    Color3.fromRGB(
                        245,
                        245,
                        241
                    ),

                Button =
                    Color3.fromRGB(
                        235,
                        235,
                        230
                    ),
                Text =
                    Color3.fromRGB(
                        35,
                        35,
                        35
                    ),

                SubText =
                    Color3.fromRGB(
                        100,
                        100,
                        95
                    ),
                LogoBackground =
                    Color3.fromRGB(
                        248,
                        245,
                        230
                    ),

                Close =
                    Color3.fromRGB(
                        205,
                        195,
                        170
                    )

            },

            --==================================================
            -- ❤️ VERMELHO
            --==================================================

            ["Vermelho"] = {

                Accent =
                    Color3.fromRGB(
                        235,
                        35,
                        45
                    ),
                Main =
                    Color3.fromRGB(
                        18,
                        10,
                        12
                    ),

                Sidebar =
                    Color3.fromRGB(
                        13,
                        8,
                        10
                    ),

                Content =
                    Color3.fromRGB(
                        13,
                        8,
                        10
                    ),
                Card =
                    Color3.fromRGB(
                        35,
                        18,
                        21
                    ),

                Button =
                    Color3.fromRGB(
                        29,
                        14,
                        17
                    ),

                Text =
                    Color3.fromRGB(
                        245,
                        235,
                        237
                    ),
                SubText =
                    Color3.fromRGB(
                        160,
                        125,
                        130
                    ),

                LogoBackground =
                    Color3.fromRGB(
                        45,
                        8,
                        12
                    ),
                Close =
                    Color3.fromRGB(
                        55,
                        20,
                        24
                    )

            },

            --==================================================
            -- 💚 VERDE
            --==================================================

            ["Verde"] = {
                Accent =
                    Color3.fromRGB(
                        45,
                        220,
                        120
                    ),

                Main =
                    Color3.fromRGB(
                        10,
                        20,
                        15
                    ),

                Sidebar =
                    Color3.fromRGB(
                        7,
                        15,
                        11
                    ),
                Content =
                    Color3.fromRGB(
                        7,
                        15,
                        11
                    ),

                Card =
                    Color3.fromRGB(
                        17,
                        37,
                        25
                    ),

                Button =
                    Color3.fromRGB(
                        13,
                        29,
                        20
                    ),
                Text =
                    Color3.fromRGB(
                        230,
                        250,
                        238
                    ),

                SubText =
                    Color3.fromRGB(
                        125,
                        165,
                        140
                    ),
                LogoBackground =
                    Color3.fromRGB(
                        6,
                        40,
                        23
                    ),

                Close =
                    Color3.fromRGB(
                        20,
                        55,
                        35
                    )

            },

            --==================================================
            -- 🌈 RGB
            --==================================================

            ["RGB"] = {

                RGB = true,

                Main =
                    Color3.fromRGB(
                        8,
                        10,
                        16
                    ),

                Sidebar =
                    Color3.fromRGB(
                        6,
                        8,
                        13
                    ),
                Content =
                    Color3.fromRGB(
                        7,
                        9,
                        15
                    ),

                Card =
                    Color3.fromRGB(
                        18,
                        21,
                        30
                    ),

                Button =
                    Color3.fromRGB(
                        13,
                        16,
                        24
                    ),
                Text =
                    Color3.fromRGB(
                        240,
                        243,
                        250
                    ),

                SubText =
                    Color3.fromRGB(
                        130,
                        140,
                        160
                    ),
                LogoBackground =
                    Color3.fromRGB(
                        8,
                        22,
                        48
                    ),

                Close =
                    Color3.fromRGB(
                        25,
                        28,
                        38
                    )

            }

        }

    }

}
