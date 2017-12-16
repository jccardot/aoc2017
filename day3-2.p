/*
--- Part Two ---

As a stress test on the system, the programs here clear the grid and then store the value 1 in square 1. Then, in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

So, the first few squares' values are chosen as follows:

    Square 1 starts with the value 1.
    Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
    Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
    Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
    Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.

Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

147  142  133  122   59
304    5    4    2   57
330   10    1    1   54
351   11   23   25   26
362  747  806--->   ...

What is the first value written that is larger than your puzzle input?

Your puzzle answer was 266330.

Both parts of this puzzle are complete! They provide two gold stars: **

At this point, you should return to your advent calendar and try another puzzle.

Your puzzle input was 265149.
*/
DEFINE VARIABLE iInput AS INTEGER   INITIAL 265149  NO-UNDO.
DEFINE VARIABLE ix AS INTEGER     NO-UNDO.
DEFINE VARIABLE iy AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCircle AS INTEGER     NO-UNDO.
DEFINE VARIABLE idx AS INTEGER     NO-UNDO.
DEFINE VARIABLE idy AS INTEGER     NO-UNDO.
DEFINE VARIABLE iVal AS INTEGER     NO-UNDO.

DEFINE TEMP-TABLE ttGrid NO-UNDO
    FIELD X AS INTEGER
    FIELD Y AS INTEGER
    FIELD val AS INTEGER
    INDEX ix IS PRIMARY X Y.

FUNCTION getVal RETURNS INTEGER ():
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    DEFINE VARIABLE j AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iVal AS INTEGER     NO-UNDO.
    DO i = ix - 1 TO ix + 1:
        DO j = iy - 1 TO iy + 1:
            FIND ttGrid WHERE X = i AND Y = j NO-ERROR.
            IF AVAILABLE ttGrid THEN iVal = iVal + ttGrid.val.
        END.
    END.
    RETURN iVal.
END FUNCTION.

FUNCTION doSide RETURNS LOGICAL ():
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    DO i = 1 TO iCircle * 2:
        ASSIGN ix = ix + idx iy = iy + idy.
        iVal = getVal().
        IF iVal > iInput THEN RETURN TRUE.
        CREATE ttGrid. 
        ASSIGN X = ix Y = iy val = iVal.
    END.
    RETURN FALSE.
END FUNCTION.

CREATE ttGrid.
ASSIGN X = 0 Y = 0 val = 1.

ix = 1.
iy = 1.
iCircle = 1.

blk:
DO WHILE TRUE:
    /* up */
    ASSIGN idx = 0 idy = -1.
    IF doSide() THEN LEAVE blk.
    /* left */
    ASSIGN idx = -1 idy = 0.
    IF doSide() THEN LEAVE blk.
    /* down */
    ASSIGN idx = 0 idy = 1.
    IF doSide() THEN LEAVE blk.
    /* right */
    ASSIGN idx = 1 idy = 0.
    IF doSide() THEN LEAVE blk.
    /* next circle */
    iCircle = iCircle + 1.
    ASSIGN ix = ix + 1 iy = iy + 1.
END.

MESSAGE iVal
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
