--// 💥 RIMURU HUB
--// Sound Database
--// JJS SOUND IDS
--// Organized Character / Utility / Kill Sound Categories

local Categories = {

    --==================================================
    -- OUTROS
    --==================================================

    ["Outros"] = {

        --==============================
        -- BLOCK
        --==============================

        {"Block1", "4306994267"},
        {"Block2", "4306994664"},
        {"Block3", "4306994923"},
        {"Metal Block1", "9125669515"},
        {"Metal Block3", "9116618112"},
        {"Metal Block1", "9125669515"},
        {"Metal Block3", "9116618112"},

        --==============================
        -- DASH
        --==============================

        {"Normal Frontdash", "4909206080"},
        {"Frontdash Hit", "8595975458"},
        {"Sidedash", "3929467229"},

        --==============================
        -- DOMAIN
        --==============================

        {"Domain Open", "3059775781"},
        {"Domain Base", "7260423115"},
        {"Domain Shatter", "6737581507"},
        {"Domain Clash Music", "89526560746434"},

        --==============================
        -- EMOTES
        --==============================

        {"Conga Music", "1840682726"},
        {"Murder Music", "718585968"},
        {"More Music", "16785843693"},
        {"Objection Point", "330859085"},
        {"Places Music", "17177481815"},
        {"Jackpot Music", "1841425177"},
        {"Popipo Music", "84361522293297"},
        {"Teto Music", "14118577963"},
        {"Caramelldansen Music", "109327078849301"},
        {"Clap", "6892830182"},
        {"Popcorn", "4511723890"},
        {"Potentials Charge", "17046377464"},
        {"Potentials Stance", "17725419051"},
        {"Potion Music", "35930009"},
        {"Specialist", "107770724427582"},
        {"Bird Birdbrain", "14287482730"},
        {"Chirumiru", "81817470019988"},
        {"Flow", "116614879374541"},
        {"Hugo", "81631848409725"},
        {"Tired Thud", "9113475440"},
        {"Ringtone Ring", "9113751345"},
        {"Ringtone Pick", "9125397823"},
        {"Paradise", "125515503762033"},
        {"Facepalm Sad", "159102636"},
        {"Facepalm Slap", "105571364162396"},
        {"Kickback Bam", "95827480090371"},
        {"Kickback Music", "109349834174062"},
        {"Lying Rage Stance", "17725419051"},
        {"Lying Rage Stomp", "91623319512088"},
        {"Lying Rage Aura", "3518168170"},
        {"Lying Rage Loop", "102911733949287"},
        {"Lying Rage Music", "72975253717108"},
        {"Thunder Shock", "6994934244"},
        {"Thunder Lightning", "6458307118"},
        {"Thunder Boom", "7147349812"},
        {"Cursed Child Music", "109314500910458"},

        --==============================
        -- IMPACT SOUND
        --==============================

        {"Impact1", "91186117342"},
        {"Impact2", "9118615862"},
        {"Impact3", "9118614058"},
        {"Impact4", "9116816096"},

        --==============================
        -- ITEM
        --==============================

        {"Coin Parry", "81202220081219"},
        {"Coin", "136124980150792"},

        {"Naginata Hit1", "94107281648467"},
        {"Naginata Hit2", "103563218704266"},
        {"Naginata Hit3", "103563218704266"},

        {"Gun Fire", "5735280081"},
        {"Gun Hit", "3932141920"},
        {"Gun Break", "1358442317"},

        {"TNT", "433141679"},
        {"TNT Explode", "90854697257230"},

        {"Jet Black Swing", "4085938599"},
        {"Jet Black Hit", "3932145123"},
        {"Jet Black Equip", "3744393890"},

        {"Soda Open", "6315580910"},
        {"Soda Drink", "2245190929"},

        {"Banana Peel", "1606631241"},
        {"Banana Slip", "129432532096499"},

        {"Voice Recorder Switch", "90506072322224"},
        {"Voice Recorder Voice", "88080590196375"},
        {"Voice Recorder Crush", "128573990774413"},
        {"Voice Recorder Don't Move", "117637019344223"},
        {"Voice Recorder Blast Away", "81923105628397"},

        {"Transfigured Flesh Wall", "134228799555671"},

        {"Playful Cloud Swing1", "116901112122156"},
        {"Playful Cloud Swing2", "97228090794267"},
        {"Playful Cloud Swing3", "103222009007167"},
        {"Playful Cloud Swing4", "116901112122156"},
        {"Playful Cloud Break", "1358442317"},
        {"Playful Cloud Sever", "134273082284707"},
        {"Playful Cloud Swing Alt", "3755636825"},
        {"Playful Cloud Heavy Swing", "7978512114"},

        {"Sniper Fire", "136523485"},
        {"Sniper Recharge", "131265718595511"},
        {"Sniper Hit", "3932141920"},
        {"Sniper Explode", "2227416952"},
        {"Sniper Explode Finisher", "4459572763"},

        {"Bowling Ball Loop", "96331415600436"},
        {"Bowling Ball Hit", "79710336574311"},

        --==============================
        -- JSD CHARACTER
        --==============================

        {"Dash 1", "92870369637296"},
        {"Dash 2", "133205097862880"},

        {"M1 Hit 1", "92660735965001"},
        {"M1 Hit 2", "103376351068703"},
        {"M1 Hit 3", "122604454724442"},
        {"M1 Hit 4", "108932851477523"},
        {"M1 Down", "73223862105514"},
        {"M1 Up", "124704505278190"},
        {"M1 Swing", "116055107185271"},

        {"Onslaught Windup", "112334421250960"},
        {"Onslaught Whooshes", "109750891566279"},
        {"Onslaught Hit 2", "92242615253671"},
        {"Onslaught Hit 3", "115238316257902"},
        {"Onslaught Hit 4", "83252903812674"},
        {"Onslaught Hit 5", "118008236689924"},
        {"Onslaught Hit 6", "137296633918555"},
        {"Onslaught Hit 7", "79492597332929"},
        {"Onslaught Hit 8", "102503367678078"},
        {"Onslaught Last Hit", "129425371797564"},
        {"Onslaught Air Windup", "71886127750084"},
        {"Onslaught Air Hit", "92646954276141"},

        {"Lethal Wound Windup", "136647946051022"},
        {"Lethal Wound Getup", "72356309866561"},
        {"Lethal Wound Hit", "112190329411296"},

        {"Blood Mary Windup", "125221767118801"},
        {"Blood Mary Dropkick", "135803259895374"},
        {"Blood Mary Connect", "84000702645054"},

        {"Fight Startup", "133706660487150"},
        {"Fight Hit", "102530149417103"},
        {"Fight Success Hit", "95100057721788"},
        {"Fight Miss Hit", "92658796918459"},

        {"Special Hit", "77456429238350"},
        {"Special Flourish", "106302903900436"},

        {"Awakening Music", "128475093365422"},
        {"Awakening SFX", "91237555203708"},

        {"Cursed Remedy Startup", "100705684685259"},
        {"Cursed Remedy Hit", "83588770043956"},

        {"Reset Main", "111151680989224"},
        {"Reset Second 1", "1112954360180261"},
        {"Reset Second 2", "100501096830709"},

        {"Atonement Windup", "97193501595542"},
        {"Atonement Start", "112496240445109"},
        {"Atonement Lose", "72809722363624"},
        {"Atonement Win", "124970888162706"},

        {"Seven Souls Windup", "102415905240085"},
        {"Seven Souls Hit", "127769542531541"},
        {"Seven Souls QTE 1", "91971313816789"},
        {"Seven Souls QTE 2", "133545655546336"},

        --==============================
        -- MELEE SOUND
        --==============================

        {"Punch swing/miss", "140527314975641"},
        {"Punch land", "91496311826097"},
        {"Brutal Doom | Kick Swing", "134566777509981"},
        {"Kick Swing 1", "97257125551026"},
        {"Manji Kick JJS start", "114235921050731"},
        {"Fast Kick Swing", "132382422330053"},
        {"Kick Swing 2", "137298186656357"},
        {"JJS The head of the hei cursory impact swing", "87320183785057"},
        {"Common Swoosh", "91492507498895"},
        {"M1 Swing", "4571259077"},
        {"M1 Hit1", "8595975878"},
        {"M1 Hit2", "8595975878"},
        {"M1 Hit3", "8595975458"},
        {"M1 Hit4 (finisher)", "8595974357"},

        --==============================
        -- RAGDOLL
        --==============================

        {"RagdollFall1", "3784888301"},
        {"RagdollFall2", "3784888809"},
        {"RagdollFall3", "3784889529"},
        {"Break (downslam)", "3778609188"},

        --==============================
        -- WEAPON SOUND
        --==============================

        {"Sword swing/miss", "140553108821312"},
        {"Minecraft sword swing/hit", "137901267020570"},
        {"Katana swing/miss", "137122553198327"},

        --==============================
        -- OUTROS
        --==============================

        {"Bankai Toshiro Hitsugaya", "886883353"},
        {"Onslaught Air Hit", "92646954276141"},
        {"Lethal Wound Hit", "112190329411296"},
        {"Fight Hit", "102530149417103"},
        {"Fight Success Hit", "95100057721788"},
        {"Fight Miss Hit", "92658796918459"},
        {"Special Hit", "77456429238350"},
        {"Cursed Remedy Hit", "83588770043956"},
        {"Seven Souls Hit", "127769542531541"}
        {"Power", "96632806833838"}
        
    },

    --==================================================
    -- MEGUMI
    --==================================================

    ["Megumi"] = {

        {"Rabbit Escape Spawn", "17206057016"},
        {"Nue Spawn", "17269358415"},
        {"Nue Hit 1", "17269354824"},
        {"Toad Spawn", "17269355559"},
        {"Totality Spawn", "17392238439"},
        {"Totality Slash", "17392240969"},
        {"Max Elephant Spawn", "17457463445"},
        {"Great Serpent Spawn", "17513691442"},
        {"Mahoraga Summon", "17607886466"},
        {"Shadow Enter", "4459057272"},
        {"Shadow Leave", "17206056478"},
        {"Awakening", "125901185360744"},

        {"Max Elephant Start", "17206057404"},
        {"Max Elephant Hit", "4086190876"},
        {"Max Elephant Despawn", "17457463045"},
        {"Max Elephant Explode", "4459572763"},

        {"Great Serpent Start", "17513691601"},
        {"Great Serpent Spin", "8120249833"},
        {"Great Serpent Fly", "3778630178"},
        {"Great Serpent Hit", "17513691220"},
        {"Great Serpent Despawn", "17513690981"},
        {"Great Serpent Despawn 2", "17392238770"},

        {"Shadow Swarm Grab", "9105467029"},
        {"Shadow Swarm Rush", "3084314259"},
        {"Shadow Swarm Launch", "9114362943"},

        {"Mahoraga Timer", "17607887277"},
        {"Mahoraga Summon Christmas", "9038469500"},
        {"Mahoraga Appear", "17607885989"},
        {"Mahoraga Moving", "17607887774"},
        {"Mahoraga Music", "15583493700"},
        {"Mahoraga Hit", "17607886878"},

        {"Nue Hit 2", "3929458922"},

        {"Toad Fly", "17269355114"},
        {"Toad Grab", "9105467029"},
        {"Toad Hit", "17269354737"},
        {"Toad Flyback", "17269354618"},
        {"Toad Despawn", "17269355252"},

        {"Totality Slash Hit", "3932141920"},
    },
    
    --==================================================
    -- CHOSO
    --==================================================

    ["Choso"] = {

        {"Piercing Blood Startup", "9125615451"},
        {"Piercing Blood Clap", "18259558246"},
        {"Piercing Blood Fire", "124532419231032"},
        {"Piercing Blood Hit", "4086202171"},
        {"Convergence", "2227416952"},
        {"Blood Burst", "3739364168"},
        {"Flowing Red Scale Startup", "16773286492"},
        {"Flowing Red Scale Rush", "3084314259"},
        {"Supernova Counter", "9113764330"},
        {"Supernova Hit", "7131799080"},
        {"Blood Edge Knife Summon", "4086172099"},
        {"Awakening", "119654508166149"},
        {"Slicing Exorcism Fire", "124532419231032"},
        {"Slicing Exorcism Hit", "4086202171"},
        {"Slicing Convergence", "4459578169"},
        {"Slicing Saw 1", "114060318185092"},
        {"Slicing Blood Burst", "3739364168"},
        {"Slicing Spin", "8120249833"},
        {"Slicing Hair Pull", "90579969522260"},
        {"Slicing Saw", "8847056740"},
        {"Slicing Drill Hit", "4459571224"},
        {"Wing King Swing", "3755637186"},
        {"Wing King Hit", "17046282624"},
        {"Wing King Hit 2", "17046281074"},
        {"Wing King Hair Pull", "90579969522260"},
        {"Wing King Break", "3778609188"},
        {"Wing King Crush", "4307207693"},
        {"Wing King Crush 2", "3848082818"},
        {"Blood Rain Start", "137790880409950"},
        {"Blood Rain Slash", "935843979"},
        {"Blood Rain End", "99414146840490"},
        {"Plasma Wave Swarm", "9114828109"},
        {"Plasma Wave Clap", "18259558246"},
        {"Plasma Wave Fire", "9120610973"},
        {"Plasma Wave Fire 2", "124532231032"},
        {"Plasma Wave End", "99414146840490"},
        {"Plasma Wave Hit 2", "17046281074"},
        {"Blood Merge", "9120086654"},
        {"Dodge", "6470740758"},
        {"Swing", "4059009185"},
        {"Blood Burst 2", "18427761019"},
        {"Blood Edge Dash", "3755636152"},
        {"Blood Edge Stab", "3932142219"},
        {"Blood Edge Leap", "3848838070"},
        {"Blood Edge Ground Impact", "7093763783"},
        {"Blood Edge Hit", "16773286330"},
        {"Awakening Blinds Off", "4458760518"},
        {"Awakening Convergence", "4459578169"},
        {"Awakening Spin", "8120249833"},
        {"Piercing Blood Pressure", "9074099528"},
        {"Flowing Red Scale Aim", "16773286492"},
        {"Flowing Red Scale Hit", "16773286330"},
        {"Flowing Red Scale Hit 1", "8595975878"},
        {"Flowing Red Scale Hit 4", "8595975458"},
        {"Flowing Red Scale Spin", "8120249833"},
        {"Supernova Convergence", "2227416952"},
        {"Supernova Swing", "3755636638"},
        {"Supernova Hit 2", "17169365331"},
        {"Supernova Burst", "3739364168"}

    },

    --==================================================
    -- GOJO
    --==================================================

    ["Gojo"] = {

        {"Lapse Blue Pull", "411286671"},
        {"Grab", "9105467029"},
        {"Infinity", "9066732918"},
        {"Red Wind", "6006851551"},
        {"Red Throw", "154787303"},
        {"Red Explode", "3059775624"},
        {"Black Flash Hit", "12764933067"},
        {"Twofold Kick Swing1", "3755637186"},
        {"Twofold Kick Swing2", "3755636992"},
        {"Twofold Kick Hit1", "4086172909"},
        {"Twofold Kick Hit2", "7515452875"},
        {"Teleport Windup", "9118159096"},
        {"Glass Break", "6737581315"},
        {"Hollow Purple Merge", "17018019870"},
        {"Hollow Purple Snap", "15075475525"},
        {"Hollow Purple Hit", "698224146"},
        {"Hollow Nuke Explode", "7602599324"},
        {"Domain Voice", "6667923288"},
        {"Domain Base", "7260423115"},
        {"Infinite Void", "15171602676"},
        {"Domain Music", "16071901783"},
        {"Domain Shatter", "6737581507"},
        {"0.2 Domain Short Open", "111507747920000"},
        {"0.2 Domain Startup", "135405966044594"},
        {"0.2 Short Domain 2", "77956271026948"},
        {"0.2 Boost 1", "93070893390347"},
        {"0.2 Short Domain 3", "86891100502580"},
        {"0.2 Slowdown", "76523688182264"},
        {"0.2 Boost 2", "126837281119039"},
        {"0.2 Hit 1", "130525286637724"},
        {"0.2 Hit 2", "94234054127236"},
        {"0.2 Hit 3", "108671308229639"},
        {"0.2 Barrage", "127027345708590"},
        {"0.2 Breathe", "82179939991290"},
        {"Face Crush Teleport Drag", "93186173642807"},
        {"Face Crush Drag Throw", "82926856324306"},
        {"Awakening Blind Grab", "3929467888"},
        {"Awakening Blinds Off", "4458760518"},
        {"Awakening Fist Slam", "9066673412"},
        {"Lapse Blue Max Wind", "9056932358"},
        {"Lapse Blue Max Absorb", "4299623070"},
        {"Lapse Blue Max Explode", "2227416952"},
        {"Reversal Red Max Charge", "16828657609"},
        {"Reversal Red Max Aim", "16773286492"},
        {"Reversal Red Max Fire", "16828657180"},
        {"Reversal Red Max Hit", "8595975458"},
        {"Remember Music", "17284219852"},
        {"Black Flash Finisher", "17520297840"},
        {"Black Flash Sparks 2", "9114314398"},
        {"Hollow Purple Music", "14326861262"},
        {"Hollow Nuke Smash", "4776197442"},
        {"Hollow Nuke Music 2", "14457960806"},
        {"Hollow Nuke Dash", "3929467229"},
        {"Hollow Nuke Summon", "4858918400"},
        {"Hollow Nuke Max Charge", "4299624634"}

    },

    --==================================================
    -- GOKU
    --==================================================

    ["Goku"] = {

        {"Kamehameha", "128138421943286"},
        {"Staff Uppercut Swing", "113917760201943"},
        {"Staff Uppercut Hit", "136281286882999"},
        {"Staff Extend Swing", "84803863795019"},
        {"Staff Extend Hit", "132043726972669"},
        {"Ki Spam Shoot", "136181939400388"},
        {"Ki Spam Explode (Miss)", "78258660213953"},
        {"Ki Spam Hit", "73984021575636"},
        {"Ultimate Click", "8388724806"},
        {"Ultimate Chest Beat", "8595975878"}

    },

    --==================================================
    -- HAKARI
    --==================================================

    ["Hakari"] = {

        {"Reserve Balls Swing", "4059009185"},
        {"Reserve Balls Fire", "9114427348"},
        {"Reserve Balls Impact", "7512928742"},
        {"Shutter Doors Spawn", "9125644321"},
        {"Shutter Doors Swing", "858508159"},
        {"Shutter Doors Slam", "9116684884"},
        {"Rough Energy Charge", "17046377464"},
        {"Rough Energy Air Swing", "17168364647"},
        {"Jackpot", "6644505962"},
        {"Awakening Voice", "137100901601126"},
        {"Awakening Domain", "7260423115"},
        {"Awakening Idle Death", "7252480818"},
        {"Awakening Music", "9039704032"},
        {"Awakening Travel", "16943255415"},
        {"Awakening Roll", "3299794881"},
        {"Jackpot Music", "1841443579"},
        {"Lucky Rushdown Grab", "9105467029"},
        {"Lucky Rushdown Startup", "16773286492"},
        {"Overwhelming Luck Speed 1", "17046282310"},
        {"Overwhelming Luck Fist 2", "3755636992"},
        {"Overwhelming Luck Fist 3", "3755637186"},
        {"Overwhelming Luck Swing", "17046505673"},
        {"Energy Surge Dash", "17169364965"},
        {"Energy Surge Swing", "17169364647"},
        {"Energy Surge Hit 1", "17046282624"},
        {"Energy Surge Hit 1 Alt", "17169365111"},
        {"Energy Surge Swag", "9119122635"},
        {"Energy Surge Teleport", "17169364809"},
        {"Energy Surge Hit 2", "17169365331"},
        {"Energy Surge Launch", "9114362943"},
        {"Fever Breaker Swing", "17101065238"},
        {"Fever Breaker Hit 1", "17101065020"},
        {"Fever Breaker Swing 2", "858508159"},
        {"Fever Breaker Slam", "6324841214"},
        {"Fever Breaker Hit 2", "9118614717"},
        {"Fever Crush Swing", "100606314590244"},
        {"Door Guard Startup", "9125615451"},
        {"Door Guard Swing", "9126228977"},
        {"Rough Energy Air Shock", "120458587618994"},
        {"Rough Energy Air Impact", "71472197762839"}

    },

    --==================================================
    -- HANAMI
    --==================================================

    ["Hanami"] = {

        {"Root Swarm Startup", "102970184623188"},
        {"Root Swarm", "103290587422612"},
        {"Spikes Spear1", "115026144285429"},
        {"Spikes Spear2", "132548164020742"},
        {"Bud Shot Startup", "107077525770659"},
        {"Bud Shot Throw", "83883449987100"},
        {"Flower Field Startup", "117000088170934"},
        {"Flower Field Appear", "76363463402061"},
        {"Root Swarm Disappear", "98476421854862"},
        {"Spikes", "92699785397200"},
        {"Spikes Windup", "124210128005270"},
        {"Spikes Wood Balls Appear", "118077996038991"},
        {"Spikes Root Disappear", "115236945194905"},
        {"Bud Shot Hit 1", "84674642106437"},
        {"Bud Shot Hit 2", "84359158055042"},
        {"Defense Response Startup", "78001037313968"},
        {"Defense Response Hit 1", "79583362062555"},
        {"Defense Response Hit 2", "83044567135942"},
        {"Defense Response Root", "77781927063804"},
        {"Defense Response Air Startup", "78330240985463"},
        {"Flower Field Hit", "118109994896373"}

    },

    --==================================================
    -- HARUTA
    --==================================================

    ["Haruta"] = {

        {"Ambush Swing", "75682608773801"},
        {"Ambush Hit", "130435802660891"},
        {"Backstab Hit", "98104546054574"},
        {"Trip Kick", "82810979613330"},
        {"Trip", "116070235847840"},
        {"Cheap Shot Throw", "96689127096230"},
        {"Ambush Ragdoll Stab", "3932142219"},
        {"Backstab Front Hit", "88483086994779"},
        {"Backstab Back Hit", "80957966391322"},
        {"Trip 2", "18782451032"},
        {"Cheap Shot Sword Spin", "109830368249561"},
        {"Cheap Shot Dirty Play Wave", "80175764312984"},
        {"Cheap Shot Dirty Play Catch", "118484407389443"},
        {"Ankle Cutter Hit", "132826787704625"},
        {"Ankle Cutter Dash", "115254148621223"},
        {"High Time", "77439795464226"},
        {"High Time Stab", "3932142219"},
        {"Jawbreaker", "94680472414828"},
        {"M1 Swing 1", "94221495279664"},
        {"M1 Swing 2", "111701118737902"},
        {"M1 Swing 3", "121592312107730"},
        {"M1 Swing 4", "117243892822517"},
        {"M1 Hit 1", "73369470591089"},
        {"M1 Hit 2", "129306040953825"},
        {"M1 Hit 3", "133798286166675"}

    },

    --==================================================
    -- HEIAN SUKUNA
    --==================================================

    ["Heian Sukuna Sounds"] = {

        {"Strong Dismantle Start", "70482785888704"},
        {"Strong Dismantle Fire", "125288142627715"},
        {"Strong Dismantle Hit", "74232847084175"},
        {"Dismantle Voice (Kai)", "134011003057260"},

        {"Open Furnace Hands", "1072005487"},
        {"Open Furnace Clap", "6874043782"},
        {"Open Furnace Voice", "100843467610521"},
        {"Fuga Voice", "78637547122675"},

        {"Cleave Rush Start", "109660701821480"},
        {"Cleave Voice", "97960256382964"},

        {"Kamutoke Equip", "6605239584"},

        {"Strong Dismantle Slashes 2", "135309023186303"},
        {"Strong Dismantle 2", "97581017049145"},
        {"Strong Dismantle 3", "115955384025484"},
        {"Strong Dismantle Fire WCS", "4299584756"},
        {"Strong Dismantle Explode", "2227416952"},
        {"Strong Dismantle Charge", "4299626748"},
        {"Strong Dismantle Owarida", "124265527510765"},

        {"Open Furnace Flame Idle", "7978653185"},
        {"Open Furnace Shockwave", "5447233442"},

        {"Cleave Rush Charge", "17046377464"},
        {"Cleave Rush Stance", "9118612065"},
        {"Cleave Rush Stance 2", "17725419392"},
        {"Cleave Rush Eyes", "4085790525"},
        {"Cleave Rush Voice 2", "77732395767858"},
        {"Cleave Rush", "3084314259"},
        {"Cleave Rush Grab", "9105467029"},
        {"Cleave Rush Slash", "935843979"},
        {"Cleave Rush Explode", "2227416952"},
        {"Cleave Rush Finish Slash", "9119749145"},

        {"Kamutoke Equip 2", "3744393890"},
        {"Kamutoke 1", "3750993658"},
        {"Kamutoke 2", "4299587602"},
        {"Kamutoke 3", "4299513168"},
        {"Kamutoke 4", "4776302225"},

        {"Shrine Voice", "130807317538504"},
        {"Shrine Domain Open", "3059775781"},
        {"Shrine Uhoh Start", "252289753"},
        {"Shrine Music", "83360856832970"},
        {"Shrine Uhoh", "7817336081"},
        {"Shrine Voice 2", "133077835308960"},
        {"Shrine Slashes", "135309023186303"},
        {"Shrine Voice 3", "124012721234128"}

    },

    --==================================================
    -- MAHORAGA
    --==================================================

    ["Mahoraga"] = {

        {"Divine Pummel Swing", "3755637186"},
        {"Divine Pummel Grab", "9105467029"},
        {"Ground Pitch Wind", "3848835272"},
        {"Ground Pitch Throw", "3932587669"},
        {"Earthquake Startup", "18205736907"},
        {"Earthquake Attempt", "18205737752"},
        {"Earthquake Success", "18205737353"},
        {"Takedown Startup", "18440677683"},
        {"Adaptation Glow", "3932669033"},
        {"Adaptation Wheel", "17612867532"},
        {"World Slash Swing", "4299625271"},
        {"World Slash", "4299510555"},
        {"M1 Hit 1", "3932145123"},
        {"M1 Hit 2", "3932145654"},
        {"M1 Hit 3", "3848125583"},
        {"M1 Hit 4", "8595974357"}

    },

    --==================================================
    -- MANGAKA
    --==================================================

    ["Mangaka"] = {

        {"Mangaka Frontdash Hit", "103563218704266"},
        {"Despair Startup", "107284905728635"},
        {"Despair Spin", "102170331317268"},
        {"Shut Up! Swing", "128854350040211"},
        {"Shut Up! Stab", "134654946718633"},
        {"Eye Catching Dodge", "6470740758"},
        {"Sacrilege Spin", "102170331317268"},
        {"Despair Swing", "98574727138893"},
        {"Shut Up! Throw", "123300556709057"}

    },

    --==================================================
    -- KILL SOUND
    --==================================================

    ["Kill Sound"] = {

        --==============================
        -- JOJO / DIO
        --==============================

        {"Zawarudo (JoJo)", "8762717966"},
        {"Gold Experience Requiem", "3991855114"},
        {"Shadow DIO Time Stop", "6859641602"},
        {"Shadow DIO Laugh", "6424991364"},
        {"Shadow DIO Quote", "4845893680"},

        --==============================
        -- TOSHIRO
        --==============================

        {"Bankai Toshiro Hitsugaya", "886883353"},

        --==============================
        -- MINAZUKI
        --==============================

        {"Bankai Minazuki", "8971501348"},

        --==============================
        -- ICHIGO
        --==============================

        {"BAN..KAI (Ichigo)", "7961699054"},
        {"BANKAI", "2679516592"},

        --==============================
        -- VERGIL
        --==============================

        {"Now I'm Motivated (Vergil)", "6205852200"},

        --==============================
        -- ISAGI
        --==============================

        {"Isagi Episode 1 Scream", "127774628670060"},
        {"Isagi MOVE IT", "86641348144968"},

        --==============================
        -- OTHER KILL SOUNDS
        --==============================

        {"Alien Sound", "128098884137284"},
        {"All of us are born to fight", "1225201330"},
        {"Android Sound", "6879335951"},
        {"Bass-Boosted Fart Noise", "6445594239"},
        {"Boom Boom Bakudan", "92979705199765"},
        {"BONK (alt)", "8864069181"},
        {"BYE BYE!", "7334141704"},
        {"COD – Mission Failed", "7361248895"},
        {"Deleted You! / Looks like I deleted you!", "8257514392"},
        {"EDM", "8140095101"},
        {"Everybody in this Server…", "1461317727"},
        {"EZ ⭐", "8922169253"},
        {"Fahh", "102936243743816"},
        {"Fire Burning", "158853971"},
        {"Firebreather", "9042829290"},
        {"FNAF Jumpscare", "8308107333"},
        {"Grimm Sound", "118178634897055"},
        {"Gunshot", "127646504338729"},
        {"I have an Idea", "5892048067"},
        {"I have God and anime on my side", "1226918619"},
        {"I killed you before", "85997963553918"},
        {"I thought you were strong", "136221786218148"},
        {"Loud Anime", "6797864253"},
        {"Loud Burp", "125254353961998"},
        {"Mario Bros. Death Sound (alt) ⭐", "7361042352"},
        {"Mario Star Song", "8399934126"},
        {"Mr Squidward", "7198382725"},
        {"Meme Laugh", "8647630325"},
        {"Meme Scream / Rake", "6343741731"},
        {"Nani (alt)", "127508291787866"},
        {"Oh My GAWD, I won", "1352824542"},
        {"Rick Roll (alt versions) ⭐", "5560182875"},
        {"Spring", "105266638590279"},
        {"SpongeBob Sad Sound", "8904888220"},
        {"Sus ⭐", "7704160053"},
        {"This is too easy", "5352458739"},
        {"UI Click", "6895079853"},
        {"Vine Boom ⭐", "9060808331"},
        {"Wake Up Bozo", "9042248317"},
        {"Well, boys, we did it", "6726104707"},
        {"Rick Roll", "7859591812"},
        {"OMAYGAHH Osaka", "4496966777"},
        {"Cero Blast", "167885124"},
        {"COUNTER", "8879058081"},
        {"Uhuh, Honey", "7817025360"},
        {"TF2 Domination Sound", "3759232123"},
        {"Mafioso Scream", "117881769171113"},
        {"18 Wheeler Horn (Lobotomy)", "18735403020"},
        {"PvZ Garden Warfare", "5276754334"},
        {"FAHH", "72298953503422"},
        {"WEEZO", "82547354923635"}

    }

}

return Categories
