/*
--- Day 7: Recursive Circus ---

Wandering further through the circuits of the computer, you come upon a tower of programs that have gotten themselves into a bit of trouble. A recursive algorithm has gotten out of hand, and now they're balanced precariously in a large tower.

One program at the bottom supports the entire tower. It's holding a large disc, and on the disc are balanced several more sub-towers. At the bottom of these sub-towers, standing on the bottom disc, are other programs, each holding their own disc, and so on. At the very tops of these sub-sub-sub-...-towers, many programs stand simply keeping the disc below them balanced but with no disc of their own.

You offer to help, but first you need to understand the structure of these towers. You ask each program to yell out their name, their weight, and (if they're holding a disc) the names of the programs immediately above them balancing on that disc. You write this information down (your puzzle input). Unfortunately, in their panic, they don't do this in an orderly fashion; by the time you're done, you're not sure which program gave which information.

For example, if your list is the following:

pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)

...then you would be able to recreate the structure of the towers that looks like this:

                gyxo
              /     
         ugml - ebii
       /      \     
      |         jptl
      |        
      |         pbga
     /        /
tknk --- padx - havc
     \        \
      |         qoyq
      |             
      |         ktlj
       \      /     
         fwft - cntj
              \     
                xhth

In this example, tknk is at the bottom of the tower (the bottom program), and is holding up ugml, padx, and fwft. Those programs are, in turn, holding up other programs; in this example, none of those programs are holding up any other programs, and are all the tops of their own towers. (The actual tower balancing in front of you is much larger.)

Before you're ready to help them, you need to make sure your information is correct. What is the name of the bottom program?
*/
DEFINE VARIABLE cInput AS CHARACTER   NO-UNDO.
/*cInput = "pbga (66)~n
xhth (57)~n
ebii (61)~n
havc (66)~n
ktlj (57)~n
fwft (72) -> ktlj, cntj, xhth~n
qoyq (66)~n
padx (45) -> pbga, havc, qoyq~n
tknk (41) -> ugml, padx, fwft~n
jptl (61)~n
ugml (68) -> gyxo, ebii, jptl~n
gyxo (61)~n
cntj (57)".*/
cInput = "mqdjo (83)~n
jzgxy (15) -> usdayz, zvbru~n
altep (75)~n
gaieus (117) -> unkring, wjgvjlg~n
ejlbps (59)~n
uralh (17)~n
tzdmi (891) -> mhzwwo, mgybhs, pptdd~n
whntvd (2133) -> vuzxyz, hcfgnt, kuvek~n
aoqjxqk (99) -> qjfdh, vmusp, yqmclp~n
wwmjf (404) -> vvoadnv, sgujp~n
btgbr (54)~n
ftkfi (27)~n
vamssbi (194) -> picmfs, eutmjw~n
rrmrv (23)~n
vdavxhx (31)~n
ensgy (13)~n
ayngc (51)~n
qcblt (87)~n
wgqalow (6)~n
fvypts (47)~n
rioda (97)~n
fbmhsy (58) -> lqggzbu, xwete, vdarulb, rkobinu, ztoyd, vozjzra~n
ctmlo (29)~n
uezrt (28)~n
xvuxc (39164) -> nieyygi, hmcjz, ceizm~n
lvejxwu (71)~n
enogs (87)~n
lhdwm (58)~n
yeoeyme (55)~n
iwqzx (74)~n
xmnts (1113) -> rcmcf, dgihmb, xyhyumy~n
xhlgx (105) -> pamyclw, rrmrv, ulseuu, ihkrezl~n
mivzz (10)~n
kqwlhff (72)~n
lrlfs (152) -> jlgvr, sttwla~n
trzae (35)~n
jqgfz (63)~n
ymmpp (66)~n
vwuif (26) -> lrdpo, hxejeo, jxlzfjd~n
osxdc (172) -> qlxtmmw, gzvxqn, krboup~n
elfkuam (92)~n
sjsfqhv (143) -> rwxwe, dyjyjd, nwbcxj~n
kuvek (92) -> yqnfpeq, fcwev~n
gcsftd (765) -> lmpvxf, epqbl, rlsom~n
jfpbi (28) -> altep, ajsgpnx, vygscor~n
woqtzz (51)~n
mrqbmg (15)~n
iwdkssd (78)~n
gwqzfk (28)~n
zfvweqs (34)~n
anqvh (2135) -> gprcxh, oyahwdc, hxtrzk~n
eeikp (24)~n
nrlmfax (148) -> ammwyf, uaypo~n
eutmjw (12)~n
gsjah (31)~n
lgofh (90) -> alhvq, fgreoy, lmgwjss~n
untdlz (88)~n
rtdpm (24384) -> xhvyt, mrqug, kbkcw, gmlxpn~n
yfejqb (493) -> osxdc, jmyovo, nfmkvob~n
tzccgz (74)~n
cqksxxm (56)~n
vclagjf (40) -> tcziis, oxkbg~n
mqhuedy (7)~n
vvfukul (88)~n
acmkv (65)~n
gvfmsy (259) -> tokzfq, mnenfrc, feyacx, vpjiwwm~n
zcxiup (35)~n
dtivzu (36)~n
rwpaht (55)~n
yzuuvbm (63)~n
xuavduh (125) -> ftcxb, vynaaf~n
xmxuqtu (13) -> edwlp, xphhbib~n
grqiik (165) -> ookot, hazds~n
lnvdcr (31)~n
qdxkysa (155) -> nqcdwx, boliuot, dsjxy, mfjan~n
pdbruf (76) -> wwpagi, svmgylv~n
xilwqcz (106) -> gsjah, wntacd, ifvwm~n
abdnunu (35)~n
kihew (46)~n
jteda (97)~n
hzdox (43) -> oclbecq, iwdkssd~n
zdtzt (77)~n
arlra (258)~n
omynf (318) -> dwdjp, kiqfls, sfepx~n
xycww (64)~n
vlsmybk (83)~n
umhfxkg (40) -> cpfswhf, jpgbqgr, guzav, xumyvt, gmgwaa~n
ngdhmz (92) -> qgdeiw, dhcgig~n
mxgpbvf (52) -> jkaah, tfovn, foaqmc, gaieus, zxgptth~n
diizvrq (69)~n
dnuov (72)~n
cjofkgw (10)~n
dtacyn (42) -> xvuxc, eyyrn, udtsgjk, zprkrrn, rhhdc, rtdpm~n
grdpxxr (45)~n
bruwizl (11)~n
eetpan (48) -> mbffn, hhmwxe~n
ceupnk (31)~n
tuijc (27)~n
dhoqdtf (81) -> fzvnyc, ofazxj, vudnna~n
svmgylv (88)~n
bxoqjhj (70) -> woqtzz, ayngc~n
mpthchj (1933) -> acowb, ojaql, tqlyzrj~n
uovufgc (91) -> sumnuv, iklpkqe~n
reslc (26) -> epnsvw, zgpuqmv~n
sovwn (63)~n
mhgzyqt (30)~n
rfhlu (186) -> ifpae, bivky~n
yimjq (285) -> vvvgmqe, rjqdo, uavna~n
mgybhs (300) -> sgwxlb, beopgpz, ftkfi, tqndz~n
yareka (95)~n
qyiwwwy (39)~n
vudnna (93)~n
rbeigk (47)~n
qzhrv (360)~n
imgrm (12512) -> gcsftd, odxjz, umhfxkg, oqisjkn~n
nieyygi (7308) -> ptshtrn, mxgpbvf, cfqdsb, yfejqb~n
pytprd (75)~n
ykaodk (24)~n
upbwakj (66)~n
byxzbw (86)~n
xlzryhc (1814) -> ujxume, zrqzw, aqwfxoj, mxtgoh~n
ovonpn (93)~n
pfzsu (84)~n
twucd (7)~n
vtrgext (50)~n
vpjsxth (70) -> kobwl, eeupi~n
nwdzcl (54)~n
xwyxvr (29) -> pffhee, ycmdmvr, cupvdjn~n
mktppi (86)~n
oouozuv (46)~n
zhuue (5)~n
kpoou (34)~n
blskny (29)~n
grhibzl (43)~n
okwiabh (304) -> hyufw, hmhmfd, mwhef, lnkeeie~n
nlpdso (8)~n
vyqni (76)~n
mbffn (85)~n
tsuti (34)~n
plgldf (90)~n
obelp (105) -> icdtprw, mrqbmg, wwmzjie, qxhuuf~n
uueqz (52)~n
mumpgs (94)~n
ioxkn (67) -> mxqme, tcugzqe, wbopu, ipjaf~n
fyecx (50) -> gcyzqup, zkljjip~n
gmfzmby (90)~n
sxbko (84)~n
unkring (48)~n
kbdrjwl (2012) -> skjdw, ukqofsd, gonru~n
guzav (73) -> tuzwlaj, hsdwgl~n
qicxip (18)~n
arbiru (168) -> znbxm, zsetpb~n
rjqdo (36)~n
slvwki (11)~n
uanii (10)~n
zxvtq (1702) -> brenhzl, aekrgip, eojaq~n
izmnzef (330) -> idwncn, tcsoa, wagjjy~n
gcyzqup (63)~n
pjqtv (29) -> qvmdj, ovzrat, hjtmfck, yqkzm~n
awzbq (25) -> qjhugv, grqiik, ojcbjkx, blwgxoz, yspyrs, qiwio~n
badle (30) -> anuyfh, fcesi~n
ltxiy (341) -> smusd, kpoou~n
mwzana (12)~n
elkqdsi (52)~n
ggymz (83)~n
hxtrzk (172)~n
lufwlhx (34) -> mhrno, mtyuix, crzqw, mktppi~n
pvkps (92)~n
lrgsjqn (66)~n
fgtzv (63)~n
mtrmn (79)~n
yshpwl (19)~n
xnmmdhk (49)~n
aozsepf (113) -> rnaud, bclda~n
xhnlro (46)~n
gvrwy (71) -> idhdqo, bvjds~n
znbxm (12)~n
uaypo (61)~n
skoloe (28)~n
ypfxnr (233) -> avxapnw, maalkoh~n
fywvj (71)~n
ltpjwb (82)~n
atbxzb (221) -> jepepf, torpy~n
oxhnlv (13) -> nrozgxx, kjjzdvp~n
eyyrn (44234) -> rchso, dqwet, qoqdhpx~n
jxvod (9)~n
jrvumy (92)~n
ukejvdd (34)~n
ulseuu (23)~n
lmgwjss (34)~n
vpgsx (65)~n
ykvww (51)~n
zwmbuyl (71)~n
vcsfjyd (24)~n
vdxfff (38)~n
vozjzra (70) -> ginyxrk, sgbejy~n
cizxbj (193) -> abndmkw, qyiwwwy~n
yroyqeo (13)~n
hkanwp (13)~n
plctc (345) -> rngety, zebcbo~n
ayode (38)~n
rwwww (22)~n
rundk (116) -> cwwsi, enogs~n
ixqqqjj (269) -> aozcb, ahvhqoe, qycnzr, ojwezo~n
jdjvp (54)~n
tcsoa (165) -> rwpaht, idcowch~n
owlwzwx (36)~n
yhljr (26)~n
rciod (54)~n
tnhnp (154)~n
shmvzp (43)~n
gkoze (158) -> lrpzf, zkbzbn~n
picmfs (12)~n
ghjcbf (3487) -> ccpeyc, okwiabh, qxsie~n
tcziis (77)~n
raugvuk (78)~n
jepix (56)~n
wlbuyk (73)~n
fgreoy (34)~n
idqsz (27)~n
akcgcxy (90)~n
hkcobh (20)~n
hgmzkam (63)~n
teauca (399) -> cwlvxo, jsohd~n
dkjcz (34)~n
xulggnd (253) -> spfyg, qqpvjbu~n
gyuiagl (126) -> xwkudo, irlntnq~n
wnkaz (9) -> ovonpn, idnken~n
mlqfisf (150) -> lrgsjqn, rfewc~n
ikknx (23)~n
aekrgip (155) -> xbtcnx, odfgjh~n
qfvbg (420) -> jdyblpx, llqfm, vydlsvt, gkoze, ofvidy~n
xddngkv (75)~n
hazds (17)~n
awvyj (43)~n
swsbeo (1351) -> crhrx, ylbuzsq, wcuqhwq~n
irlntnq (23)~n
asdevc (66)~n
dniwy (7)~n
qedlf (60)~n
yrsfcq (72) -> emdaoqf, qezss, frozh, aakyzvs~n
ptocen (64)~n
vqxyr (66) -> jdjvp, rciod, zwofqok, igkxvqh~n
kjgfm (73)~n
hmhmfd (100) -> hbuwd, rrohrwo~n
lezpa (84)~n
cfqdsb (556) -> feizivp, vjhsczt, gmxbjg~n
oclbecq (78)~n
qqypffg (67)~n
lrdpo (91)~n
kvolhll (77)~n
nhiujz (271)~n
mxqme (32)~n
wjmfbz (75)~n
sgltbu (80) -> guphfh, uzxjy~n
wvjumh (90)~n
tlwfzzu (87)~n
vmusp (83)~n
jlslmo (13)~n
bhysq (10)~n
daxfuxl (13)~n
arqxnjl (1242) -> xvtdoyr, rkupoek, izapo~n
mtyuix (86)~n
qjuvyr (56)~n
pfctdp (127) -> hjibwmq, bseajmt~n
erjsdm (65)~n
jkaah (97) -> blskny, ctmlo, sxlecxm, fjixq~n
lldszk (2467) -> xxslxbt, elfkuam~n
wzejrx (43)~n
yqnfpeq (20)~n
ztoyd (227) -> cuwjy, rhamh, idwgpl~n
ocvjwr (63)~n
bxgyjw (60)~n
bnggqtn (58)~n
cupvdjn (50)~n
elebwva (173) -> skmum, hibcfm~n
tmhgfe (223) -> tqfel, daxfuxl~n
slduca (71)~n
ybcta (17)~n
cyniz (855) -> cgzpd, kimrt, sxaib, syppxhj, pfctdp, qdxkysa~n
ledbvvq (240) -> cchmz, grdyhff~n
alhvq (34)~n
eoxmesy (24)~n
hzzwzx (7)~n
odtzcu (37)~n
rnviq (89) -> rkcdg, fyalh~n
qvmdj (30)~n
phqjxv (161) -> kihew, qiyidu~n
ifpae (87)~n
ooqsaz (97)~n
jnsph (93) -> aeiee, vcpkha, zvdmblb, sbvcz, yriybrc, aoqjxqk, nhlbui~n
vvoadnv (23)~n
btabyp (203) -> gegad, rmyjxl~n
aosrim (40)~n
qgkhdex (41)~n
qvhpl (84)~n
rkobinu (164) -> ymccua, xtsnf~n
fcesi (73)~n
pxdezu (43)~n
phjllc (132) -> slvwki, fhqqbsx~n
ezrpvp (94)~n
jhlxf (74)~n
ypfss (172) -> kltwy, grhibzl~n
jrqmxt (23)~n
nfchsda (43)~n
ctnfhim (71)~n
dksbpu (50)~n
sxlecxm (29)~n
exnlyy (26) -> nwooizm, jhlxf~n
hyurmnj (70)~n
rarvsbv (91)~n
pmpmgak (19)~n
pnkce (63)~n
isozjve (84)~n
axondt (154) -> nmqmbc, kmhzija~n
yuzamn (79) -> rxwbam, ptocen~n
orlwcra (71)~n
sxghqf (17) -> hswecad, pbdww~n
saksuh (72)~n
hromhg (50)~n
lqplgho (198) -> fywvj, jbxkrhf, slduca~n
pptdd (76) -> cthyoqb, mvjppl, mhtfkag, dsxamd~n
baosr (80) -> byxzbw, meajs~n
qzslx (83) -> vtrgext, fnwzvf~n
rhqmcl (15)~n
nxvfovk (97)~n
nwbcxj (68)~n
yxstzne (21) -> dnuov, mqwmam~n
wlheoem (6)~n
luqtj (171) -> kjgfm, wlbuyk~n
sgujp (23)~n
odxjz (37) -> luqtj, igpyz, qzltox, ufwsbx~n
gprcxh (84) -> xhlqyt, rwwww, xwsgv, gnqasz~n
iklpkqe (49)~n
vmianfx (51)~n
zkljjip (63)~n
oaucz (74)~n
zaahfws (72) -> cpncdpn, kqwlhff, saksuh, rwnnzj~n
omnflj (26)~n
yzzkb (98) -> nxywzy, zukmsws~n
upttsy (46) -> lhusw, cabbpbp~n
awdam (122) -> zboinwm, erjsdm~n
idnken (93)~n
xpxwq (56) -> cizxbj, ynxwu, cpbfkf, izfny, dontia, viohwud, nhiujz~n
adklqb (13290) -> pzsdbxi, jahpohn, yurlqf~n
yurlqf (1176) -> wiyuhex, cujasg, hzdox~n
qjagx (265)~n
ccpeyc (13) -> eowou, kbbck, oxhnlv, obelp, rxmnfgj, ahfsddo, yxstzne~n
amdyzs (28)~n
nxywzy (96)~n
vjunjns (170) -> dgrfnj, ceathvu, lspkp, nqmfyxs~n
juzzs (30)~n
hrfdy (79)~n
klbkp (1736) -> qzslx, uycbfkf, gvrwy, eadxb, rysbl~n
ggijqt (21)~n
ebeltx (60)~n
lnkeeie (58) -> hrfdy, mtrmn~n
pwsfhgi (52)~n
zdymtqx (49)~n
zenuyzk (84) -> teqabnc, kmqopjq~n
eowou (119) -> jrqmxt, ikknx~n
mwdjsxv (51)~n
oritewf (164) -> jxvjp, htvenp, cgzcdzi, ukysk, ocakmk~n
vygscor (75)~n
zkvql (20)~n
sttwla (65)~n
mmlkoh (2271) -> jmrbakg, bpatyq, yucyi~n
yiupwfc (88) -> izrwts, yimjq, vfqbff~n
ynxwu (127) -> ghicha, xohoejm~n
fqffx (94)~n
xhlqyt (22)~n
tqndz (27)~n
crzqw (86)~n
epqbl (140) -> zdxksj, zkvql~n
ujckr (1913) -> phjllc, ibuys, tnhnp, sgltbu~n
lezek (775) -> rkgwky, menclt, ekxdgkq~n
qzoqo (79)~n
rnaud (68)~n
zwfvctv (5)~n
lyebndp (49)~n
ircvo (11)~n
dpqnim (39) -> pxdezu, awvyj, yiigtz, wzejrx~n
pmtssy (18)~n
zjyhf (56)~n
kdzuk (78)~n
mnojup (73) -> sxbko, umnvlw, zvodhi, pfzsu~n
befeb (96)~n
tpcir (16) -> jcwdnlr, goeprx, wwskbob, tneetox~n
xohoejm (72)~n
qdufkz (94)~n
ghyii (60) -> esmmub, qjuvyr~n
zprkrrn (46528) -> ghjcbf, jsrdr, ywyvxv, ujsqcr~n
yxpavwg (38)~n
dqwet (6621) -> uibut, bgugou, izmnzef~n
zqhmft (98)~n
rttcn (108) -> ylzoeee, ooqsaz~n
qzjtxi (13)~n
yssxm (1494) -> yuzamn, hybkngi, jzgxy, umryvx, mykoaba~n
xbtvul (30)~n
vgmnvqr (79)~n
rchso (42) -> viwwie, kppigwv, zesja, azaxxvz~n
njxkbbs (37)~n
sambp (84)~n
ctmyow (14952) -> lwzfwsb, awzbq, dvdbswf~n
bjenf (94) -> bjxuox, offqpoc~n
ekhsurt (223) -> skoloe, ijzzl~n
mhnjio (29) -> whntvd, ujckr, dysfcb, yssxm, cyniz, jnsph, mmlkoh~n
uycbfkf (9) -> tlwfzzu, mnieqt~n
rcmcf (86) -> jteda, iydwka~n
zboinwm (65)~n
boliuot (31)~n
udcgj (455) -> ynydd, uxbgd, xogbbc~n
uozayo (39)~n
fltthw (117) -> hdpizox, dfqahip~n
dgrfnj (22)~n
wyusin (38)~n
zvbru (96)~n
owhgyez (37)~n
dtwdad (81) -> zwxvo, nsldzh~n
yqmclp (83)~n
semtwrh (82)~n
ihteano (97)~n
mhrno (86)~n
wwpagi (88)~n
ngcyru (56)~n
ngwldiu (55)~n
virmpl (175)~n
aakyzvs (367)~n
vubuie (79)~n
kpczbnm (26)~n
jahpohn (51) -> uawat, zenuyzk, pwonvpm, bborg, zjnaor, lniuonj, yxmkycd~n
jxlzfjd (91)~n
mgvgcf (30)~n
xphhbib (83)~n
vzubyy (84)~n
spfyg (13)~n
emaqhkl (49)~n
bvjds (56)~n
aqwfxoj (50) -> byytq, qybcrhn~n
ukysk (234) -> ircvo, oeinoe~n
lpwze (175) -> ltaujs, hosjc~n
wikrvq (15)~n
anuyfh (73)~n
fgfkrxp (69)~n
rrtqw (8)~n
lehgocg (42) -> vpgsx, pydanp, nppyzr, kdgxoi~n
nzuvke (16)~n
ehcjup (18) -> kqduo, sambp, rxehio~n
jjqwgq (34)~n
jepepf (63)~n
oikfudn (135) -> ynubz, xqqdtu~n
maicx (48)~n
ammwyf (61)~n
xqkrdp (30)~n
ylbuzsq (89)~n
ulrqcxx (17)~n
bfhjnn (13)~n
hyhcihf (28)~n
jqtbsy (32) -> yqzkn, dhiavwc~n
shelxb (66)~n
jmfybp (100) -> qzhrv, ckyvnnj, dhoqdtf, hhrqizc~n
fgscpqx (96)~n
viohwud (256) -> zwfvctv, rjfktu, gfygwj~n
erqjppo (97)~n
gldbbde (24) -> hqxsfn, vwgmnj, rphmi~n
hvrve (36)~n
ajsgpnx (75)~n
oklhlne (12)~n
radodhv (5)~n
kycxdgx (29) -> wjfar, pmjvz~n
mvjppl (83)~n
brilycx (97)~n
duklm (47)~n
hibcfm (87)~n
yjeavx (53)~n
vwgmnj (97)~n
uavna (36)~n
cujasg (65) -> qqypffg, pgpmlgz~n
rqura (47)~n
rfewc (66)~n
ayklc (595) -> lrwlhbc, ypfxnr, gldbbde~n
nvldfqt (57)~n
bzvwi (20)~n
rcstlvu (10)~n
fnwiq (63)~n
twikxu (59)~n
byytq (60)~n
mmlcvqo (37)~n
sqowhp (34)~n
nwkqcsc (24)~n
czlcjl (626) -> qmtofe, kefdbed, rnviq~n
pqavmdg (17)~n
wfjme (21)~n
latbj (240) -> vdavxhx, lnvdcr~n
pthrzgd (38)~n
ghicha (72)~n
vlrtfe (114) -> aosrim, pnlmj~n
izrwts (337) -> amdyzs, epilojy~n
cjksouo (154) -> oaucz, iwqzx, dlszm, tzccgz~n
rysbl (21) -> dzmqhbp, rscwd~n
qilfd (86)~n
zebcbo (42)~n
atdfonp (52)~n
oukcyj (7)~n
pydanp (65)~n
bpatyq (32) -> iszhqi, gwnxq~n
bcuxejj (63)~n
hdsvjwr (1480) -> stryo, jmtmw, tbdfmz~n
ywyvxv (3190) -> gydenqe, ydhxt, yiupwfc~n
xqqdtu (20)~n
xkqiqns (69)~n
wcuqhwq (89)~n
pczqv (88)~n
yhmbooy (35)~n
bjxuox (39)~n
kqduo (84)~n
qinuxsr (238) -> ajcpmg, mdtuwks, huvag, bxtzi~n
wjfar (85)~n
nfmkvob (208)~n
wlrrckg (697) -> pcxcr, lmyinxy, ekkgfax~n
plifn (26)~n
crhrx (89)~n
zwofqok (54)~n
afurlcd (63)~n
tohwd (1394) -> eeikp, wsqspc~n
ojcbjkx (185) -> mqhuedy, twucd~n
wbopu (32)~n
fjixq (29)~n
mwhef (136) -> zcvqw, tnxhf~n
jdyblpx (130) -> mmhim, phomdt~n
nhdfnv (51) -> fltthw, kycxdgx, xilwqcz, prbrv, dzibhav, orxuz, zozpw~n
ckyvnnj (234) -> pnkce, yzuuvbm~n
vllgqt (5)~n
kbrbq (42)~n
stryo (219) -> idqsz, czala~n
ksrbxbh (255)~n
vqrcq (127) -> zcxiup, vvmfk~n
orxuz (172) -> bfltqak, skogcpe, jxvod~n
jbxkrhf (71)~n
egxng (20)~n
fswhfws (90) -> ocikhq, ayyfw, gwqzfk~n
gegad (26)~n
ifvwm (31)~n
kmqopjq (81)~n
rdxfau (8)~n
vvvgmqe (36)~n
rssmrnc (53)~n
eofrs (35)~n
vdarulb (246) -> hzzwzx, oukcyj~n
rtbjlii (157) -> pcxny, zjzyo~n
zjnaor (118) -> uuozpc, xycww~n
zmkyj (65) -> fqffx, ikzsd, qdufkz~n".
cInput = cInput + "bivky (87)~n
roirllq (75)~n
osehy (12)~n
odqfu (37)~n
rhhdc (3564) -> mhnjio, mzrntf, imgrm, sgamgp~n
xghyc (35)~n
umeup (55)~n
pihhh (859) -> jfpbi, xvsrff, phqjxv~n
yucyi (35) -> pqavmdg, ulrqcxx, eaemt~n
kobwl (74)~n
zudwpn (2104) -> gvfcl, dicxtfr, reslc~n
acheq (179)~n
hxxvca (41)~n
sbvcz (198) -> mveyh, xddngkv~n
rphmi (97)~n
kotdcly (26)~n
rwrmuv (78)~n
skmum (87)~n
rngety (42)~n
lhusw (74)~n
srrbgff (42)~n
fvpbw (23) -> vmianfx, ykvww, mwdjsxv~n
huvag (23)~n
tokzfq (22)~n
jylrfoj (72)~n
cpbfkf (77) -> brilycx, ihteano~n
fzofpn (75)~n
xogbbc (32) -> asdevc, shelxb, rurnike, ymmpp~n
ajihys (56) -> bnggqtn, lhdwm~n
rhamh (11)~n
xvsrff (205) -> eoxmesy, nwkqcsc~n
hbuwd (58)~n
xjjhicj (28)~n
iszhqi (27)~n
qqpvjbu (13)~n
lmyinxy (287) -> bhysq, rcstlvu~n
ubdju (438) -> wgqalow, xoknnac~n
kmhzija (88)~n
lwzcyq (42)~n
omwhgx (79)~n
fvqgb (71)~n
ufsus (26)~n
vynaaf (21)~n
wwdhply (52) -> lldszk, klbkp, vysbz, xgtged, kbdrjwl, hcxrwwv, anqvh~n
sgamgp (14279) -> czlcjl, wlruzq, koklf~n
nfiyxwf (46)~n
smusd (34)~n
cuuvm (195)~n
krboup (12)~n
vysbz (1571) -> jzxcnkv, rfhlu, zaahfws~n
rojomwr (32)~n
scrykpr (47) -> dlochnp, kuxdz~n
zesja (57) -> ltxiy, ngskki, emjhgx, mnojup, ixqqqjj, wnpyrz~n
skogcpe (9)~n
brenhzl (119) -> bzvwi, lcvtfz, egxng, hkcobh~n
rkgwky (75) -> grdpxxr, xflynr, yrixhb, lalemvr~n
odfgjh (22)~n
wlruzq (1135) -> rrtqw, jmcafz~n
torpy (63)~n
yqzkn (93)~n
hcfgnt (132)~n
tvobw (69)~n
yxmkycd (120) -> afurlcd, qyerfcc~n
ikzsd (94)~n
ludhiab (96)~n
xiayty (80)~n
jsohd (15)~n
tqfel (13)~n
huvrn (86)~n
wzlrws (26)~n
ywxjbc (39)~n
dwdjp (31)~n
hpfhhg (63)~n
hybkngi (195) -> wlheoem, oxbfji~n
wsqspc (24)~n
eaemt (17)~n
lkwhxen (85)~n
wmzmy (59)~n
yspyrs (147) -> kpczbnm, yhljr~n
fuwat (65)~n
alsay (7) -> snloung, djdmsc, sdqll~n
zxgptth (189) -> fknto, dpfuu~n
kaihsu (228) -> ggijqt, wfjme~n
kbkcw (6055) -> swsbeo, pihhh, wlrrckg, fbmhsy~n
rnatyw (59)~n
xhvyt (57) -> xlzryhc, zudwpn, swsva, mpthchj, wxtlbn~n
ywrnqrp (179)~n
fzvnyc (93)~n
tantkl (77)~n
xvtdoyr (45) -> tatvgv, nrvpgth, luugrb, maicx~n
cpzdjum (55)~n
blwgxoz (87) -> mzeqa, abghrf~n
uxbgd (184) -> zbnynh, twrim~n
dnmrtok (221) -> epzukel, fgtzv~n
tnxhf (40)~n
dgihmb (175) -> liglllj, xghyc, eofrs~n
jmrbakg (86)~n
rurnike (66)~n
ceizm (58) -> ebqjlp, xpxwq, vfigul, arqxnjl, xmnts, sdbkh~n
cmmnbug (77)~n
sgwxlb (27)~n
lmbucr (55)~n
dsxamd (83)~n
qcgykv (88)~n
wxtlbn (604) -> lmipr, pxwsb, lufwlhx, mixmiv, ledbvvq~n
qbwfy (19)~n
omznvh (320) -> zmemxd, ihjpab~n
xoldlj (139) -> umeup, ewvfvx~n
zdxksj (20)~n
foaqmc (71) -> ctnfhim, zwmbuyl~n
azaxxvz (1383) -> lrlfs, gqvnw, vqxyr, mlqfisf~n
hcdyhi (63)~n
hosjc (52)~n
sfepx (31)~n
gzvxqn (12)~n
maalkoh (41)~n
qwnexz (8)~n
guphfh (37)~n
uuozpc (64)~n
nrvpgth (48)~n
aljvja (98) -> arbiru, iumni, lgofh, nkhdzon, yxpkynj, qqqsv, qiduej~n
pctyehs (304) -> ensgy, bfhjnn~n
xkzwk (17413) -> tdbcau, rtbjlii, vwuif, hfyaud~n
izfny (148) -> qgkhdex, qhrmshn, sewsk~n
dhiavwc (93)~n
wnpyrz (323) -> shmvzp, nfchsda~n
cdaue (59) -> odqfu, knqruz~n
syppxhj (264) -> vllgqt, radodhv, zhuue~n
yfozx (55)~n
rrohrwo (58)~n
cwlvxo (15)~n
hhukemh (155) -> osehy, lfsqjx~n
luugrb (48)~n
ojoes (39)~n
zjzyo (71)~n
ngskki (409)~n
rjfktu (5)~n
hcxrwwv (2126) -> sxghqf, oikfudn, virmpl~n
umryvx (96) -> owhgyez, jkorfu, odtzcu~n
zvdmblb (222) -> hpfhhg, bcuxejj~n
swspgk (55)~n
dontia (127) -> ofcfw, zjstwhc~n
qlxtmmw (12)~n
ceathvu (22)~n
llqfm (64) -> omvsg, xiayty~n
ekxdgkq (83) -> qilfd, huvrn~n
gwnxq (27)~n
mveyh (75)~n
eadxb (167) -> mnqis, fglxnn~n
bexvpzn (55)~n
ywquvbe (17)~n
zvodhi (84)~n
aleenbl (55)~n
quqts (63)~n
kimrt (30) -> qdtel, zznqt, mqdjo~n
eojaq (73) -> hcdyhi, jqgfz~n
blhxnrj (55)~n
rvycq (47)~n
ycmdmvr (50)~n
bfltqak (9)~n
ydhxt (275) -> hqekpst, jpwof, dbuno, jfavd~n
aeiee (348)~n
jmcafz (8)~n
lfsqjx (12)~n
epzukel (63)~n
jsqss (19)~n
qgdeiw (83)~n
hfyaud (299)~n
ybtmtno (26)~n
ridid (16)~n
uslizt (59) -> xbtvul, mhgzyqt, mgvgcf~n
vsnpvm (87)~n
ojaql (157) -> ppudoq, ftsejjt, cjofkgw~n
wyjbjf (8)~n
wntacd (31)~n
ymccua (48)~n
cgzpd (201) -> vndxvi, uozayo~n
iumni (192)~n
ofazxj (93)~n
uoblmgo (46)~n
cftahaw (70)~n
rlsom (66) -> nvldfqt, mdakca~n
jlgvr (65)~n
ozbig (98)~n
qpbebnc (76)~n
ayyfw (28)~n
tkqlt (107) -> pmecds, dtivzu~n
dnlftxp (81)~n
mqwmam (72)~n
oxkbg (77)~n
nbycb (55)~n
edwlp (83)~n
nkhdzon (34) -> hjrhs, qzoqo~n
ekkgfax (70) -> ugxovve, vgmnvqr, wafanbg~n
hjrhs (79)~n
zwxvo (58)~n
oyahwdc (16) -> rwrmuv, lyuznk~n
uaatgf (11) -> uueqz, atdfonp, elkqdsi~n
dyjyjd (68)~n
rxehio (84)~n
jzxcnkv (202) -> vubuie, omwhgx~n
hxejeo (91)~n
zozpw (199)~n
ptshtrn (526) -> uslizt, pjqtv, bzbdorp, atvkttc~n
qzltox (97) -> lmbucr, blhxnrj, cpzdjum, swspgk~n
vywneg (53)~n
cigzzld (90)~n
wxqadgl (88)~n
goeprx (59)~n
nhcio (88)~n
jsrdr (2962) -> rezncs, udcgj, cjtrpm~n
lswgx (75)~n
czala (27)~n
jwftyhn (76)~n
pgpmlgz (67)~n
abqar (319) -> ooque, nyimka~n
cuwjy (11)~n
kltwy (43)~n
fknto (12)~n
zvgxbve (37) -> zqhmft, mwfno, mnyblkw, ozbig~n
xwete (92) -> lezpa, qvhpl~n
qdhte (168) -> ypysb, nwdzcl, btgbr~n
nkrsre (18)~n
hqekpst (68) -> eqakw, gmfzmby~n
nppyzr (65)~n
ojmudkf (68) -> rhqmcl, wmlvvzy~n
ycpgrap (52)~n
fnwzvf (50)~n
tfovn (213)~n
kefdbed (121) -> tuijc, tngvv~n
idwgpl (11)~n
qybcrhn (60)~n
zvfdl (72)~n
rwxwe (68)~n
tcugzqe (32)~n
liglllj (35)~n
zkbzbn (33)~n
mbsuxms (28)~n
ugxovve (79)~n
udtsgjk (56) -> adklqb, xkzwk, wwdhply, ctmyow~n
jlvflv (47)~n
ajcpmg (23)~n
hmcjz (11191) -> ioxkn, wnkaz, cuuvm~n
zjstwhc (72)~n
qxhuuf (15)~n
unoqw (34)~n
xmzvsd (55)~n
rwnnzj (72)~n
xyhyumy (104) -> vhdyc, vvfukul~n
ginyxrk (95)~n
cgzcdzi (70) -> uoagriu, jnfcc~n
oxbfji (6)~n
yybuekt (96)~n
zznqt (83)~n
yiflicd (97)~n
hhmwxe (85)~n
avxapnw (41)~n
nrozgxx (76)~n
prbrv (61) -> nfiyxwf, vlhtnof, xhnlro~n
xwsgv (22)~n
jmtmw (205) -> sqowhp, qjkqxp~n
epilojy (28)~n
qjkqxp (34)~n
cchmz (69)~n
kkfcate (114) -> juzzs, xqkrdp~n
ihkrezl (23)~n
jkdrr (7)~n
mqhelgf (31)~n
fyalh (43)~n
icdtprw (15)~n
qfuxpos (94) -> omnflj, ybtmtno, cowhe~n
vndxvi (39)~n
sbaswic (34)~n
rbbkcz (81)~n
aozcb (35)~n
tdbcau (109) -> zhfenxn, yareka~n
jpgbqgr (61) -> fgscpqx, ludhiab~n
ftcxb (21)~n
egrtqo (60) -> tigky, mbqfitx, lqplgho, ivkymv, omynf~n
mnyblkw (98)~n
ipjaf (32)~n
mfweuw (96)~n
kjrup (11)~n
usdayz (96)~n
vbfwgo (85)~n
lwzfwsb (820) -> alsay, sgzxb, cdaue~n
dzibhav (199)~n
bxtzi (23)~n
ihjpab (65)~n
xtsnf (48)~n
ofvidy (8) -> zvfdl, zhezjdt, jylrfoj~n
oehapu (54)~n
looasd (161) -> ycpgrap, pwsfhgi~n
mrqug (6751) -> oritewf, nhdfnv, pblscqj, rmknzz~n
rmknzz (649) -> looasd, qjagx, hkati~n
ykidq (61)~n
dlochnp (60)~n
fglxnn (8)~n
ooque (55)~n
mnqis (8)~n
lspkp (22)~n
dgpydnw (15)~n
rezncs (776) -> gjzwa, uovufgc, hdhlyxq~n
sumnuv (49)~n
zgpuqmv (52)~n
wagjjy (91) -> pvkps, jrvumy~n
wmlvvzy (15)~n
pnwrdla (91)~n
cthyoqb (83)~n
pwonvpm (162) -> srrbgff, kbrbq~n
smvkv (59)~n
atvkttc (41) -> msxbv, oehapu~n
ioaogd (46) -> wzlrws, ufsus~n
lmpvxf (78) -> ukejvdd, sbaswic, jcbdf~n
vfigul (1371) -> vlrtfe, upttsy, vclagjf~n
oeinoe (11)~n
uoagriu (93)~n
rkcdg (43)~n
qycnzr (35)~n
vhupxjs (157) -> pmtssy, nkrsre, qicxip~n
msxbv (54)~n
oifkd (69)~n
qjhugv (199)~n
nsfrscb (278) -> oklhlne, mwzana~n
pmjvz (85)~n
qmtofe (19) -> kdzuk, raugvuk~n
fhqqbsx (11)~n
zukmsws (96)~n
kuxdz (60)~n
ofcfw (72)~n
teewbxk (39)~n
hsdwgl (90)~n
offqpoc (39)~n
akvdjmc (75)~n
pcxcr (214) -> eqdud, mqhelgf, ceupnk~n
zhfenxn (95)~n
eudjgoy (351) -> bnomgct, ojoes~n
wjgvjlg (48)~n
bborg (10) -> tarxkki, ejlbps, smvkv, wmzmy~n
xoknnac (6)~n
bzbdorp (73) -> pthrzgd, vulklzo~n
qczjylz (19)~n
cpncdpn (72)~n
kjjzdvp (76)~n
dzmqhbp (81)~n
xbtcnx (22)~n
fcwev (20)~n
vlhtnof (46)~n
eqdud (31)~n
ukqofsd (139) -> njxkbbs, mmlcvqo~n
xxslxbt (92)~n
jkorfu (37)~n
nhlbui (348)~n
pkgri (41)~n
fsowc (88)~n
idhdqo (56)~n
uqmgy (1245) -> ysnvnu, rundk, yzzkb~n
hqgsj (69)~n
yrixhb (45)~n
yqkzm (30)~n
wdeclb (13)~n
rxmnfgj (27) -> hqgsj, diizvrq~n
uawat (230) -> rdxfau, qwnexz~n
rnzglhk (69)~n
psldjp (66)~n
yedhncv (16)~n
sxaib (279)~n
gfquwm (13)~n
jmzwqs (49)~n
dpfuu (12)~n
edgsqu (32)~n
acowb (33) -> cmmnbug, tantkl~n
fbtqea (49) -> ubdju, omznvh, cjksouo, wwmjf, fdbehfx~n
xllppou (61)~n
zqrfz (29)~n
mdakca (57)~n
abndmkw (39)~n
ejtuc (42)~n
mmhim (47)~n
dicxtfr (110) -> uanii, xiiamxd~n
gmlxpn (6182) -> tzdmi, egrtqo, uqmgy~n
sgzxb (119) -> dniwy, jkdrr~n
tuzwlaj (90)~n
gmxbjg (187)~n
nwooizm (74)~n
ovzrat (30)~n
mwfno (98)~n
mbqfitx (249) -> rbbkcz, dnlftxp~n
ftsejjt (10)~n
beopgpz (27)~n
oqisjkn (672) -> kktfosp, vhupxjs, dpqnim~n
skjdw (165) -> ridid, yedhncv, nzuvke~n
jfavd (72) -> nhcio, qcgykv~n
gydenqe (739) -> fvpbw, badle, fyecx~n
mhtfkag (83)~n
tneetox (59)~n
hkati (58) -> tvobw, xkqiqns, oifkd~n
qxsie (136) -> bjenf, bxoqjhj, ajihys, ghyii, qfuxpos, gyuiagl~n
ynydd (220) -> hypma, qbwfy, jsqss, yshpwl~n
esmmub (56)~n
ypysb (54)~n
feizivp (40) -> jmzwqs, zdymtqx, emaqhkl~n
lalemvr (45)~n
mxtgoh (132) -> pmpmgak, qczjylz~n
ujxume (88) -> pkgri, hxxvca~n
ylzoeee (97)~n
zhezjdt (72)~n
ojwezo (35)~n
cjtrpm (90) -> xmxuqtu, acheq, tkqlt, xwyxvr, hhukemh, eqyac, ywrnqrp~n
sewsk (41)~n
lqggzbu (164) -> rojomwr, edgsqu, ifrxho~n
ppudoq (10)~n
vydlsvt (176) -> vcsfjyd, ykaodk~n
uswkbi (13)~n
cpfswhf (223) -> dgpydnw, wxexs~n
feyacx (22)~n
menclt (255)~n
igkxvqh (54)~n
cabbpbp (74)~n
idwncn (157) -> rnatyw, twikxu~n
iuwokd (89) -> vlsmybk, ggymz~n
qiduej (90) -> jjqwgq, tsuti, unoqw~n
imuik (434) -> awdam, baosr, tpcir, pdbruf~n
jijdq (202) -> dkjcz, zfvweqs~n
sgbejy (95)~n
rxwbam (64)~n
mzeqa (56)~n
mpbjcj (202) -> dksbpu, hromhg~n
kdgxoi (65)~n
tatvgv (48)~n
lyuznk (78)~n
vhgimqo (75)~n
wiyuhex (160) -> gfquwm, qzjtxi, uswkbi~n
hswecad (79)~n
qwnxx (353) -> yxpavwg, ayode~n
qjexd (10)~n
htvenp (130) -> quqts, ocvjwr~n
vcpkha (309) -> jlslmo, wdeclb, hkanwp~n
gyyld (91)~n
tigky (335) -> wyusin, vdxfff~n
dysfcb (1833) -> vtnsti, fswhfws, exnlyy, kkfcate~n
mdtuwks (23)~n
pbdww (79)~n
ewvfvx (55)~n
pxwsb (210) -> isozjve, vzubyy~n
rscwd (81)~n
abghrf (56)~n
ujsqcr (94) -> hdsvjwr, fbtqea, zxvtq~n
qiyidu (46)~n
xumyvt (197) -> mbsuxms, uezrt~n
fdbehfx (86) -> pnwrdla, gyyld, twxghfp, rarvsbv~n
avwkq (63)~n
ocikhq (28)~n
xzmtk (61)~n
qezss (83) -> vnmhbwf, fvqgb, lvejxwu, orlwcra~n
jcbdf (34)~n
rkupoek (83) -> kvolhll, zdtzt~n
bgugou (39) -> ekhsurt, lpwze, xulggnd, mjckr~n
ocakmk (115) -> fvypts, rbeigk, jlvflv~n
yiigtz (43)~n
rovmviv (164) -> rnzglhk, fgfkrxp~n
zmemxd (65)~n
omvsg (80)~n
ysnvnu (110) -> cigzzld, wvjumh~n
zrqzw (38) -> upbwakj, psldjp~n
tbdfmz (79) -> nxvfovk, yiflicd~n
ydishxc (75)~n
tqlyzrj (135) -> kotdcly, plifn~n
lrwlhbc (257) -> wvibg, zqrfz~n
xwkudo (23)~n
vjhsczt (77) -> xmzvsd, nbycb~n
qjfdh (83)~n
izapo (237)~n
fipmpb (13)~n
dsjxy (31)~n
bclda (68)~n
zbnynh (56)~n
hdhlyxq (63) -> hgmzkam, avwkq~n
ijzzl (28)~n
gmgwaa (73) -> akcgcxy, plgldf~n
hyufw (216)~n
jnfcc (93)~n
swsva (65) -> atbxzb, zmkyj, elebwva, dnmrtok, gvfmsy, sjsfqhv, rehfw~n
yriybrc (196) -> qpbebnc, fwmpx~n
hhrqizc (250) -> aleenbl, yeoeyme~n
idcowch (55)~n
nsldzh (58)~n
ufewl (6) -> uoblmgo, oouozuv~n
ebqjlp (933) -> btabyp, byoksw, iuwokd, ksrbxbh~n
hjtmfck (30)~n
gjzwa (163) -> fipmpb, yroyqeo~n
usnfnjb (53)~n
eviqdbq (15)~n
eqakw (90)~n
ltaujs (52)~n
ifrxho (32)~n
gnqasz (22)~n
gonru (25) -> mumpgs, ezrpvp~n
lmipr (195) -> ykidq, xzmtk, xllppou~n
vvmfk (35)~n
sdqll (42)~n
jpwof (178) -> abdnunu, yhmbooy~n
vfqbff (93) -> ydishxc, vhgimqo, wbjbpjf, roirllq~n
fwmpx (76)~n
knqruz (37)~n
epnsvw (52)~n
akznnid (69) -> bxgyjw, ebeltx, qedlf~n
vhdyc (88)~n
hqxsfn (97)~n
pgqenlk (143) -> rssmrnc, usnfnjb~n
jmyovo (68) -> hyurmnj, cftahaw~n
wvibg (29)~n
pnlmj (40)~n
lniuonj (216) -> eviqdbq, wikrvq~n
gmuco (35)~n
qqqsv (18) -> vsnpvm, qcblt~n
igpyz (245) -> hvrve, owlwzwx~n
kppigwv (1920) -> dtwdad, xhlgx, vqrcq~n
rvwvokn (218)~n
ynubz (20)~n
viwwie (699) -> nsfrscb, mpbjcj, rttcn, latbj, lehgocg, rovmviv~n
rmyjxl (26)~n
qyerfcc (63)~n
dbuno (226) -> kjrup, bruwizl~n
iydwka (97)~n
yxpkynj (192)~n
ibdhatw (75)~n
umnvlw (84)~n
dfqahip (41)~n
pcxny (71)~n
bseajmt (76)~n
mqeep (460) -> ehcjup, kaihsu, jijdq, nrlmfax~n
vuzxyz (6) -> fnwiq, sovwn~n
qdtel (83)~n
eqyac (81) -> lyebndp, xnmmdhk~n
mzrntf (11964) -> pxhqf, tohwd, imuik, aljvja~n
nqcdwx (31)~n
sdbkh (303) -> qdhte, qinuxsr, ymjxszk, pctyehs, axondt~n
gqvnw (282)~n
eeupi (74)~n
qhrmshn (41)~n
hjibwmq (76)~n
nqmfyxs (22)~n
grdyhff (69)~n
twrim (56)~n
djdmsc (42)~n
mnieqt (87)~n
cwwsi (87)~n
hrbzakg (42)~n
jxvjp (236) -> mivzz, qjexd~n
xflynr (45)~n
hdpizox (41)~n
vpjiwwm (22)~n
teqabnc (81)~n
mjckr (85) -> rioda, erqjppo~n
wwskbob (59)~n
wxexs (15)~n
snloung (42)~n
mhzwwo (392) -> wyjbjf, nlpdso~n
phomdt (47)~n
mfjan (31)~n
frozh (367)~n
lcvtfz (20)~n
emjhgx (189) -> kteflr, ngwldiu, yfozx, bexvpzn~n
vtnsti (104) -> gmuco, trzae~n
nmqmbc (88)~n
dlszm (74)~n
lrpzf (33)~n
ibuys (98) -> xjjhicj, hyhcihf~n
bnomgct (39)~n
uibut (861) -> ojmudkf, ufewl, ioaogd~n
byoksw (91) -> semtwrh, ltpjwb~n
pblscqj (943) -> scrykpr, xuavduh, uaatgf~n
zsetpb (12)~n
cowhe (26)~n
dvdbswf (187) -> ypfss, vjunjns, arlra, ngdhmz~n
xgtged (77) -> eudjgoy, zvgxbve, plctc, teauca, qwnxx, abqar~n
pffhee (50)~n
ahvhqoe (35)~n
pamyclw (23)~n
ufwsbx (93) -> ngcyru, zjyhf, cqksxxm, jepix~n
pmecds (36)~n
qoqdhpx (846) -> yrsfcq, jmfybp, qfvbg, lezek, mqeep, ayklc~n
pxhqf (197) -> akznnid, xoldlj, pgqenlk, aozsepf, tmhgfe~n
wafanbg (79)~n
nyimka (55)~n
ynypbb (47)~n
wwmzjie (15)~n
tarxkki (59)~n
rehfw (221) -> lwzcyq, hrbzakg, ejtuc~n
mykoaba (37) -> vbfwgo, lkwhxen~n
pzsdbxi (1621) -> jwftyhn, vyqni~n
kktfosp (160) -> ywquvbe, uralh, ybcta~n
ahfsddo (35) -> fuwat, acmkv~n
kteflr (55)~n
hypma (19)~n
wbjbpjf (75)~n
emdaoqf (217) -> ibdhatw, akvdjmc~n
qiwio (11) -> rvycq, duklm, rqura, ynypbb~n
vnmhbwf (71)~n
xiiamxd (10)~n
uzxjy (37)~n
ymjxszk (30) -> fzofpn, wjmfbz, pytprd, lswgx~n
jcwdnlr (59)~n
vulklzo (38)~n
ookot (17)~n
mnenfrc (22)~n
mixmiv (90) -> mfweuw, befeb, yybuekt~n
zcvqw (40)~n
gfygwj (5)~n
kiqfls (31)~n
ivkymv (59) -> wxqadgl, fsowc, pczqv, untdlz~n
meajs (86)~n
dhcgig (83)~n
kbbck (87) -> teewbxk, ywxjbc~n
gvfcl (24) -> vywneg, yjeavx~n
twxghfp (91)~n
tngvv (27)~n
koklf (61) -> jqtbsy, eetpan, vamssbi, rvwvokn, vpjsxth".

DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cPgm AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cPgm2 AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iWeight AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLine AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPgm2 AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttPgm NO-UNDO
    FIELD cPgm AS CHARACTER
    FIELD iWeight AS INTEGER
    FIELD cFather AS CHARACTER
    INDEX ix IS PRIMARY cPgm
    INDEX ixf cFather.

DO iLine = 1 TO NUM-ENTRIES(cInput, "~n"):
    cLine = ENTRY(iLine, cInput, "~n").
    cPgm = ENTRY(1, cLine, " ").
    iWeight = INTEGER(TRIM(ENTRY(2, cLine, " "), "()")).
    FIND ttPgm WHERE ttPgm.cPgm = cPgm NO-ERROR.
    IF NOT AVAILABLE ttPgm THEN DO:
        CREATE ttPgm.
        ASSIGN ttPgm.cPgm = cPgm.
    END.
    ASSIGN ttPgm.iWeight = iWeight.
    IF NUM-ENTRIES(cLine, " ") > 2 THEN DO iPgm2 = 4 TO NUM-ENTRIES(cLine, " "):
        cPgm2 = TRIM(ENTRY(iPgm2, cLine, " "), ",").
        FIND ttPgm WHERE ttPgm.cPgm = cPgm2 NO-ERROR.
        IF NOT AVAILABLE ttPgm THEN DO:
            CREATE ttPgm.
            ASSIGN ttPgm.cPgm = cPgm2.
        END.
        ASSIGN ttPgm.cFather = cPgm.
    END.
END.

FIND ttPgm WHERE ttPgm.cFather = "".
MESSAGE ttPgm.cPgm
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

