
-- Preload Images
local ContentProvider = game:GetService("ContentProvider")

-- Electrical
local E01 = "rbxassetid://1668977281" -- not broken piece
local E02 = "rbxassetid://9180476" -- broken piece
local E03 = "rbxassetid://1622315578" -- component diode
local E04 = "rbxassetid://1622633513" -- symbol diode
local E05 = "rbxassetid://1622521074" -- component resistor
local E06 = "rbxassetid://1622780746" -- symbol resistor
local E07 = "rbxassetid://2248649819" -- component IC
local E08 = "rbxassetid://2248650528" -- symbol IC
local E09 = "rbxassetid://2253827069" -- component battery
local E10 = "rbxassetid://2253827462" -- symbol battery
local E11 = "rbxassetid://2253827802" -- component capacitor
local E12 = "rbxassetid://2253828095" -- symbol capacitor
local assetsE = {E01, E02, E03, E04, E05, E06, E07, E08, E09, E10, E11, E12}
ContentProvider:PreloadAsync(assetsE)

-- Chemistry
local C01 = "rbxassetid://2695664282" -- ptable
local C02 = "rbxassetid://2274366197" -- p,n,e   
local C03 = "rbxassetid://2274413356" -- hydrogen
local C04 = "rbxassetid://2274413067" -- helium
local C05 = "rbxassetid://2274413637" -- lithium
local C06 = "rbxassetid://2274413993" -- berylium
local C07 = "rbxassetid://2274414195" -- boron
local C08 = "rbxassetid://2274367205" -- carbon
local assetsC = {C01, C02, C03, C04, C05, C06, C07, C08}
ContentProvider:PreloadAsync(assetsC)

-- Furniture
local F01 = "rbxassetid://2474380551" -- table1
local F02 = "rbxassetid://2474380720" -- table2
local F03 = "rbxassetid://2474408358" -- wooden chair
local F04 = "rbxassetid://2474380188" -- double bed
local F05 = "rbxassetid://2474380397" -- mission bed
local F06 = "rbxassetid://2474425892" -- single bed
local F07 = "rbxassetid://2474425892" -- bookshelf1
local F08 = "rbxassetid://2474621847" -- dresser1
local F09 = "rbxassetid://2474622115" -- dresser2
local F10 = "rbxassetid://2474738243" -- side table
local F11 = "rbxassetid://2474737777" -- sofa1
local F12 = "rbxassetid://2474737992" -- sofachair1
local F13 = "rbxassetid://2474809203" -- armchair
local F14 = "rbxassetid://2474808620" -- coffee table
local F15 = "rbxassetid://2474808956" -- couch1
local F16 = "rbxassetid://2474899483" -- desk1
local F17 = "rbxassetid://2474899666" -- tv1
local F18 = "rbxassetid://2474899874" -- tv2
local F19 = "rbxassetid://2474975740" -- floor lamp
local F20 = "rbxassetid://2474975230" -- laptop
local F21 = "rbxassetid://2474975531" -- table lamp
local F22 = "rbxassetid://2475047747" -- table setting
local F23 = "rbxassetid://2475032110" -- white board rolling
local F24 = "rbxassetid://2475032363" -- white board wall
local F25 = "rbxassetid://2496304614" -- bunk bed
local F26 = "rbxassetid://2604684492" -- standard bench
local F27 = "rbxassetid://2604684650" -- standard table
local F28 = "rbxassetid://2496346315" -- book1
local F29 = "rbxassetid://1898791767" -- fruit
local F30 = "rbxassetid://17539859" -- white rug
local F31 = "rbxassetid://771867231" -- large cube
local F32 = "rbxassetid://771867231" -- cube
local assetsF1 = {F01, F02, F03, F04, F05, F06, F07, F08, F09, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20}
local assetsF2 = {F21, F22, F23, F24, F25, F26, F27, F28, F29, F30, F31, F32}
ContentProvider:PreloadAsync(assetsF1)
ContentProvider:PreloadAsync(assetsF2)

-- House upgrades
local H01 = "rbxassetid://2419202501" -- upgrade1
local H02 = "rbxassetid://2419203087" -- upgrade2
local assetsH = {H01, H02}
ContentProvider:PreloadAsync(assetsH)

-- Fruit
local B01 = "rbxassetid://1898700169" -- empty bin
local B02 = "rbxassetid://1898791767" -- full bin
local assetsB = {B01, B02}
ContentProvider:PreloadAsync(assetsB)

-- Gui buttons
local G01 = "rbxassetid://2414415006" -- teleport house
local G02 = "rbxassetid://2414414389" -- teleport science
local G03 = "rbxassetid://2445024042" -- edit interior house
local G04 = "rbxassetid://2435137669" -- edit exterior house
local G05 = "rbxassetid://1371959543" -- coins
local G06 = "rbxassetid://126080317" -- book
local G07 = "rbxassetid://131724674" -- arrow left
local G08 = "rbxassetid://131724674" -- arrow right
local G09 = "rbxassetid://1540311785" -- question mark
local assetsG = {G01, G02, G03, G04, G05, G06, G07, G08, G09}
ContentProvider:PreloadAsync(assetsG)

-- Misc
local M01 = "rbxassetid://1608398177" -- wait for it cat
local assetsM = {M01}
ContentProvider:PreloadAsync(assetsM)
