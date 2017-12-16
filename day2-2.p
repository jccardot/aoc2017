/*
--- Part Two ---

"Great work; looks like we're on the right track after all. Here's a star for your effort." However, the program seems a little worried. Can programs be worried?

"Based on what we're seeing, it looks like all the User wanted is some information about the evenly divisible values in the spreadsheet. Unfortunately, none of us are equipped for that kind of calculation - most of us specialize in bitwise operations."

It sounds like the goal is to find the only two numbers in each row where one evenly divides the other - that is, where the result of the division operation is a whole number. They would like you to find those numbers on each line, divide them, and add up each line's result.

For example, given the following spreadsheet:

5 9 2 8
9 4 7 3
3 8 6 5

    In the first row, the only two numbers that evenly divide are 8 and 2; the result of this division is 4.
    In the second row, the two numbers are 9 and 3; the result is 3.
    In the third row, the result is 2.

In this example, the sum of the results would be 4 + 3 + 2 = 9.

What is the sum of each row's result in your puzzle input?
*/
DEFINE VARIABLE cInput AS CHARACTER   NO-UNDO.
cInput = "179~t2358~t5197~t867~t163~t4418~t3135~t5049~t187~t166~t4682~t5080~t5541~t172~t4294~t1397~n
2637~t136~t3222~t591~t2593~t1982~t4506~t195~t4396~t3741~t2373~t157~t4533~t3864~t4159~t142~n
1049~t1163~t1128~t193~t1008~t142~t169~t168~t165~t310~t1054~t104~t1100~t761~t406~t173~n
200~t53~t222~t227~t218~t51~t188~t45~t98~t194~t189~t42~t50~t105~t46~t176~n
299~t2521~t216~t2080~t2068~t2681~t2376~t220~t1339~t244~t605~t1598~t2161~t822~t387~t268~n
1043~t1409~t637~t1560~t970~t69~t832~t87~t78~t1391~t1558~t75~t1643~t655~t1398~t1193~n
90~t649~t858~t2496~t1555~t2618~t2302~t119~t2675~t131~t1816~t2356~t2480~t603~t65~t128~n
2461~t5099~t168~t4468~t5371~t2076~t223~t1178~t194~t5639~t890~t5575~t1258~t5591~t6125~t226~n
204~t205~t2797~t2452~t2568~t2777~t1542~t1586~t241~t836~t3202~t2495~t197~t2960~t240~t2880~n
560~t96~t336~t627~t546~t241~t191~t94~t368~t528~t298~t78~t76~t123~t240~t563~n
818~t973~t1422~t244~t1263~t200~t1220~t208~t1143~t627~t609~t274~t130~t961~t685~t1318~n
1680~t1174~t1803~t169~t450~t134~t3799~t161~t2101~t3675~t133~t4117~t3574~t4328~t3630~t4186~n
1870~t3494~t837~t115~t1864~t3626~t24~t116~t2548~t1225~t3545~t676~t128~t1869~t3161~t109~n
890~t53~t778~t68~t65~t784~t261~t682~t563~t781~t360~t382~t790~t313~t785~t71~n
125~t454~t110~t103~t615~t141~t562~t199~t340~t80~t500~t473~t221~t573~t108~t536~n
1311~t64~t77~t1328~t1344~t1248~t1522~t51~t978~t1535~t1142~t390~t81~t409~t68~t352".
/*
cInput = "5~t9~t2~t8~n
9~t4~t7~t3~n
3~t8~t6~t5".
*/
DEFINE VARIABLE iLine AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCol AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCol2 AS INTEGER     NO-UNDO.
DEFINE VARIABLE cLine AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iSum AS INTEGER     NO-UNDO.
DEFINE VARIABLE iVal AS INTEGER     NO-UNDO.
DEFINE VARIABLE iVal2 AS INTEGER     NO-UNDO.
DEFINE VARIABLE deDiv AS DECIMAL     NO-UNDO.

DO iLine = 1 TO NUM-ENTRIES(cInput, "~n"):
    cLine = ENTRY(iLine, cInput, "~n").
    blk:
    DO iCol = 1 TO NUM-ENTRIES(cLine, "~t"):
        iVal = INTEGER(ENTRY(iCol, cLine, "~t")).
        DO iCol2 = iCol + 1 TO NUM-ENTRIES(cLine, "~t"):
            iVal2 = INTEGER(ENTRY(iCol2, cLine, "~t")).
            deDiv = iVal / iVal2.
            IF deDiv = TRUNCATE(deDiv, 0) THEN DO:
                iSum = iSum + deDiv.
                LEAVE blk.
            END.
            deDiv = iVal2 / iVal.
            IF deDiv = TRUNCATE(deDiv, 0) THEN DO:
                iSum = iSum + deDiv.
                LEAVE blk.
            END.
        END.
    END.
END.
MESSAGE iSum
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
