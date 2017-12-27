/*
--- Part Two ---

Now, you need to pass through the firewall without being caught - easier said than done.

You can't control the speed of the packet, but you can delay it any number of picoseconds. For each picosecond you delay the packet before beginning your trip, all security scanners move one step. You're not in the firewall during this time; you don't enter layer 0 until you stop delaying the packet.

In the example above, if you delay 10 picoseconds (picoseconds 0 - 9), you won't get caught:

State after delaying:
 0   1   2   3   4   5   6
[ ] [S] ... ... [ ] ... [ ]
[ ] [ ]         [ ]     [ ]
[S]             [S]     [S]
                [ ]     [ ]

Picosecond 10:
 0   1   2   3   4   5   6
( ) [S] ... ... [ ] ... [ ]
[ ] [ ]         [ ]     [ ]
[S]             [S]     [S]
                [ ]     [ ]

 0   1   2   3   4   5   6
( ) [ ] ... ... [ ] ... [ ]
[S] [S]         [S]     [S]
[ ]             [ ]     [ ]
                [ ]     [ ]


Picosecond 11:
 0   1   2   3   4   5   6
[ ] ( ) ... ... [ ] ... [ ]
[S] [S]         [S]     [S]
[ ]             [ ]     [ ]
                [ ]     [ ]

 0   1   2   3   4   5   6
[S] (S) ... ... [S] ... [S]
[ ] [ ]         [ ]     [ ]
[ ]             [ ]     [ ]
                [ ]     [ ]


Picosecond 12:
 0   1   2   3   4   5   6
[S] [S] (.) ... [S] ... [S]
[ ] [ ]         [ ]     [ ]
[ ]             [ ]     [ ]
                [ ]     [ ]

 0   1   2   3   4   5   6
[ ] [ ] (.) ... [ ] ... [ ]
[S] [S]         [S]     [S]
[ ]             [ ]     [ ]
                [ ]     [ ]


Picosecond 13:
 0   1   2   3   4   5   6
[ ] [ ] ... (.) [ ] ... [ ]
[S] [S]         [S]     [S]
[ ]             [ ]     [ ]
                [ ]     [ ]

 0   1   2   3   4   5   6
[ ] [S] ... (.) [ ] ... [ ]
[ ] [ ]         [ ]     [ ]
[S]             [S]     [S]
                [ ]     [ ]


Picosecond 14:
 0   1   2   3   4   5   6
[ ] [S] ... ... ( ) ... [ ]
[ ] [ ]         [ ]     [ ]
[S]             [S]     [S]
                [ ]     [ ]

 0   1   2   3   4   5   6
[ ] [ ] ... ... ( ) ... [ ]
[S] [S]         [ ]     [ ]
[ ]             [ ]     [ ]
                [S]     [S]


Picosecond 15:
 0   1   2   3   4   5   6
[ ] [ ] ... ... [ ] (.) [ ]
[S] [S]         [ ]     [ ]
[ ]             [ ]     [ ]
                [S]     [S]

 0   1   2   3   4   5   6
[S] [S] ... ... [ ] (.) [ ]
[ ] [ ]         [ ]     [ ]
[ ]             [S]     [S]
                [ ]     [ ]


Picosecond 16:
 0   1   2   3   4   5   6
[S] [S] ... ... [ ] ... ( )
[ ] [ ]         [ ]     [ ]
[ ]             [S]     [S]
                [ ]     [ ]

 0   1   2   3   4   5   6
[ ] [ ] ... ... [ ] ... ( )
[S] [S]         [S]     [S]
[ ]             [ ]     [ ]
                [ ]     [ ]

Because all smaller delays would get you caught, the fewest number of picoseconds you would need to delay to get through safely is 10.

What is the fewest number of picoseconds that you need to delay the packet to pass through the firewall without being caught?
*/

DEFINE VARIABLE cInput AS CHARACTER INITIAL "0: 5~n
1: 2~n
2: 3~n
4: 4~n
6: 6~n
8: 4~n
10: 8~n
12: 6~n
14: 6~n
16: 14~n
18: 6~n
20: 8~n
22: 8~n
24: 10~n
26: 8~n
28: 8~n
30: 10~n
32: 8~n
34: 12~n
36: 9~n
38: 20~n
40: 12~n
42: 12~n
44: 12~n
46: 12~n
48: 12~n
50: 12~n
52: 12~n
54: 12~n
56: 14~n
58: 14~n
60: 14~n
62: 20~n
64: 14~n
66: 14~n
70: 14~n
72: 14~n
74: 14~n
76: 14~n
78: 14~n
80: 12~n
90: 30~n
92: 17~n
94: 18"  NO-UNDO.
/*
DEFINE VARIABLE cInput AS CHARACTER INITIAL "0: 3~n
1: 2~n
4: 4~n
6: 4"  NO-UNDO.
*/
DEFINE TEMP-TABLE ttLayer
    FIELD iLayer AS INTEGER
    FIELD iDepth AS INTEGER
    FIELD iScanPos AS INTEGER INITIAL 1
    FIELD iDir AS INTEGER
    INDEX ix IS PRIMARY iLayer.

DEFINE VARIABLE iPos AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLayer AS INTEGER     NO-UNDO.
DEFINE VARIABLE cLayer AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iMax AS INTEGER   INITIAL ?  NO-UNDO.
DEFINE VARIABLE iSev AS INTEGER     NO-UNDO.
DEFINE VARIABLE iDelay AS INTEGER     NO-UNDO.
DEFINE VARIABLE lCaught AS LOGICAL  INITIAL YES   NO-UNDO.

DO iLayer = 1 TO NUM-ENTRIES(cInput, "~n"):
    cLayer = ENTRY(iLayer, cInput, "~n").
    CREATE ttLayer.
    ASSIGN
        ttLayer.iLayer = INTEGER(ENTRY(1, cLayer, ":"))
        ttLayer.iDepth = INTEGER(ENTRY(2, cLayer, ":")).
    IF iMax < ttLayer.iLayer OR iMax = ? THEN
        iMax = ttLayer.iLayer.
END.

/* tells if a given scanner is at the top -> we are caught */
FUNCTION isAtTop RETURNS LOGICAL (piLayer AS INTEGER, piDepth AS INTEGER, piDelay AS INTEGER):
    RETURN (piDelay + piLayer) MODULO (2 * (piDepth - 1)) = 1.
END FUNCTION.

ETIME(TRUE).

blkDelay:
DO WHILE lCaught:
    lCaught = NO.
    iDelay = iDelay + 1.
    /* IF iDelay MOD 1000 = 0 THEN DISP iDelay. */
    blkLayers:
    FOR EACH ttLayer:
        /*lCaught = isAtTop(ttLayer.iLayer, ttLayer.iDepth, iDelay).*/
        lCaught = (iDelay + ttLayer.iLayer) MODULO (2 * (ttLayer.iDepth - 1)) = 1.
        /* DISP iDelay ttLayer.iLayer lCaught. */
        IF lCaught THEN NEXT blkDelay.
    END.
END.

MESSAGE iDelay - 1 SKIP ETIME / 1000
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

