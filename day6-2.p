/*
--- Part Two ---

Out of curiosity, the debugger would also like to know the size of the loop: starting from a state that has already been seen, how many block redistribution cycles must be performed before that same state is seen again?

In the example above, 2 4 1 2 is seen again after four cycles, and so the answer in that example would be 4.

How many cycles are in the infinite loop that arises from the configuration in your puzzle input?
*/
/* DEFINE VARIABLE cInput AS CHARACTER INITIAL "0 2 7 0"  NO-UNDO. */
DEFINE VARIABLE cInput AS CHARACTER INITIAL "2 8 8 5 4 2 3 1 5 5 1 2 15 13 5 14"  NO-UNDO.

DEFINE VARIABLE iBank AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLength AS INTEGER     NO-UNDO.
DEFINE VARIABLE iBankMax AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMax AS INTEGER  INITIAL ?   NO-UNDO.
DEFINE VARIABLE iVal AS INTEGER     NO-UNDO.
DEFINE VARIABLE iStep AS INTEGER     NO-UNDO.

iLength = NUM-ENTRIES(cInput, " ").

DEFINE TEMP-TABLE ttBank NO-UNDO
    FIELD iStep  AS INTEGER
    FIELD cBanks AS CHARACTER
    INDEX ix IS PRIMARY cBanks.

CREATE ttBank.
ttBank.cBanks = cInput.

DO WHILE TRUE:
    iStep = iStep + 1.
    iBankMax = 0.
    /* search max bank */
    DO iBank = 1 TO iLength:
        iVal = INTEGER(ENTRY(iBank, cInput, " ")).
        IF (iMax = ? OR iVal > iMax) AND iBank > iBankMax THEN ASSIGN
            iBankMax = iBank
            iMax     = iVal.
    END.
    ENTRY(iBankMax, cInput, " ") = "0".
    /* spread between the banks */
    iBank = iBankMax + 1.
    DO WHILE iMax > 0:
        IF iBank > iLength THEN
            iBank = 1.
        iVal = INTEGER(ENTRY(iBank, cInput, " ")).
        ENTRY(iBank, cInput, " ") = STRING(iVal + 1).
        iMax = iMax - 1.
        iBank = iBank + 1.
    END.
    /* check if found and save result */
    FIND ttBank WHERE ttBank.cBanks = cInput NO-ERROR.
    IF AVAILABLE ttBank THEN DO:
        iStep = iStep - ttBank.iStep.
        LEAVE.
    END.
    CREATE ttBank.
    ASSIGN
        ttBank.iStep = iStep
        ttBank.cBanks = cInput.
END.
MESSAGE iStep
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
