/*
--- Day 12: Digital Plumber ---

Walking along the memory banks of the stream, you find a small village that is experiencing a little confusion: some programs can't communicate with each other.

Programs in this village communicate using a fixed system of pipes. Messages are passed between programs using these pipes, but most programs aren't connected to each other directly. Instead, programs pass messages between each other until the message reaches the intended recipient.

For some reason, though, some of these messages aren't ever reaching their intended recipient, and the programs suspect that some pipes are missing. They would like you to investigate.

You walk through the village and record the ID of each program and the IDs with which it can communicate directly (your puzzle input). Each program has one or more programs with which it can communicate, and these pipes are bidirectional; if 8 says it can communicate with 11, then 11 will say it can communicate with 8.

You need to figure out how many programs are in the group that contains program ID 0.

For example, suppose you go door-to-door like a travelling salesman and record the following list:

0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5

In this example, the following programs are in the group that contains program ID 0:

    Program 0 by definition.
    Program 2, directly connected to program 0.
    Program 3 via program 2.
    Program 4 via program 2.
    Program 5 via programs 6, then 4, then 2.
    Program 6 via programs 4, then 2.

Therefore, a total of 6 programs are in this group; all but program 1, which has a pipe that connects it to itself.

How many programs are in the group that contains program ID 0?
*/
DEFINE VARIABLE cInput AS CHARACTER   NO-UNDO.

cInput = "0 <-> 2~n
1 <-> 1~n
2 <-> 0, 3, 4~n
3 <-> 2, 4~n
4 <-> 2, 3, 6~n
5 <-> 6~n
6 <-> 4, 5".

FUNCTION countRel RETURNS LOGICAL (piPgm AS INTEGER) FORWARD.

DEFINE VARIABLE cRel AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iRel AS INTEGER     NO-UNDO.
DEFINE VARIABLE iFrom AS INTEGER     NO-UNDO.
DEFINE VARIABLE cTo AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iTo AS INTEGER   NO-UNDO.
DEFINE VARIABLE i AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttRel
    FIELD ifrom AS INTEGER
    FIELD ito   AS INTEGER
    FIELD ldone AS LOGICAL
    INDEX ix IS PRIMARY ifrom ito
    .

/* load the relations */
DO iRel = 1 TO NUM-ENTRIES(cInput, "~n"):
    cRel = ENTRY(iRel, cInput, "~n").
    iFrom = INTEGER(ENTRY(1, cRel, " ")).
    cTo = REPLACE(SUBSTRING(cRel, INDEX(cRel, ">") + 2), " ", "").
    DO i = 1 TO NUM-ENTRIES(cTo):
        iTo = INTEGER(ENTRY(i, cTo)).
        IF NOT CAN-FIND(ttRel WHERE ttrel.ifrom = iFrom AND ttrel.ito = iTo) THEN DO:
            CREATE ttrel.
            ASSIGN
                ttrel.ifrom = iFrom
                ttrel.ito   = iTo.
        END.
    END.
END.

/* count the programs linked to 0 */
DEFINE VARIABLE gcPgms AS CHARACTER   NO-UNDO.
countRel(0).
MESSAGE NUM-ENTRIES(gcPgms) - 1
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

FUNCTION countRel RETURNS LOGICAL (piPgm AS INTEGER):
    DEFINE VARIABLE iCount AS INTEGER INITIAL 1    NO-UNDO.
    DEFINE BUFFER ttRel FOR ttRel.
    DEFINE BUFFER bttRel FOR ttRel.
    FOR EACH ttRel WHERE ttRel.ifrom = piPgm AND ttRel.ldone = NO:
        ttRel.ldone = YES.
        FIND bttRel WHERE bttRel.ifrom = ttRel.ito AND bttRel.ito = ttRel.ifrom NO-ERROR.
        IF AVAILABLE bttRel THEN
            bttRel.ldone = YES.
        IF LOOKUP(STRING(ttRel.ifrom), gcPgms) = 0 THEN
            gcPgms = gcPgms + "," + STRING(ttRel.ifrom).
        IF LOOKUP(STRING(ttRel.ito), gcPgms) = 0 THEN
            gcPgms = gcPgms + "," + STRING(ttRel.ito).
        countRel(ttRel.ifrom).
        countRel(ttRel.ito).
    END.
    RETURN YES.
END FUNCTION.

