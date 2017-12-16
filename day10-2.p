/*
--- Part Two ---

The logic you've constructed forms a single round of the Knot Hash algorithm; running the full thing requires many of these rounds. Some input and output processing is also required.

First, from now on, your input should be taken not as a list of numbers, but as a string of bytes instead. Unless otherwise specified, convert characters to bytes using their ASCII codes. This will allow you to handle arbitrary ASCII strings, and it also ensures that your input lengths are never larger than 255. For example, if you are given 1,2,3, you should convert it to the ASCII codes for each character: 49,44,50,44,51.

Once you have determined the sequence of lengths to use, add the following lengths to the end of the sequence: 17, 31, 73, 47, 23. For example, if you are given 1,2,3, your final sequence of lengths should be 49,44,50,44,51,17,31,73,47,23 (the ASCII codes from the input string combined with the standard length suffix values).

Second, instead of merely running one round like you did above, run a total of 64 rounds, using the same length sequence in each round. The current position and skip size should be preserved between rounds. For example, if the previous example was your first round, you would start your second round with the same length sequence (3, 4, 1, 5, 17, 31, 73, 47, 23, now assuming they came from ASCII codes and include the suffix), but start with the previous round's current position (4) and skip size (4).

Once the rounds are complete, you will be left with the numbers from 0 to 255 in some order, called the sparse hash. Your next task is to reduce these to a list of only 16 numbers called the dense hash. To do this, use numeric bitwise XOR to combine each consecutive block of 16 numbers in the sparse hash (there are 16 such blocks in a list of 256 numbers). So, the first element in the dense hash is the first sixteen elements of the sparse hash XOR'd together, the second element in the dense hash is the second sixteen elements of the sparse hash XOR'd together, etc.

For example, if the first sixteen elements of your sparse hash are as shown below, and the XOR operator is ^, you would calculate the first output number like this:

65 ^ 27 ^ 9 ^ 1 ^ 4 ^ 3 ^ 40 ^ 50 ^ 91 ^ 7 ^ 6 ^ 0 ^ 2 ^ 5 ^ 68 ^ 22 = 64

Perform this operation on each of the sixteen blocks of sixteen numbers in your sparse hash to determine the sixteen numbers in your dense hash.

Finally, the standard way to represent a Knot Hash is as a single hexadecimal string; the final output is the dense hash in hexadecimal notation. Because each number in your dense hash will be between 0 and 255 (inclusive), always represent each number as two hexadecimal digits (including a leading zero as necessary). So, if your first three numbers are 64, 7, 255, they correspond to the hexadecimal numbers 40, 07, ff, and so the first six characters of the hash would be 4007ff. Because every Knot Hash is sixteen such numbers, the hexadecimal representation is always 32 hexadecimal digits (0-f) long.

Here are some example hashes:

    The empty string becomes a2582a3a0e66e6e86e3812dcb672a272.
    AoC 2017 becomes 33efeb34ea91902bb2f59c9920caa6cd.
    1,2,3 becomes 3efbe78a8d82f29979031a4aa0b16a9d.
    1,2,4 becomes 63960835bcdc130f0b66d7ff4f6a5a8e.

Treating your puzzle input as a string of ASCII characters, what is the Knot Hash of your puzzle input? Ignore any leading or trailing whitespace you might encounter.
*/
DEFINE VARIABLE cInput AS CHARACTER INITIAL "34,88,2,222,254,93,150,0,199,255,39,32,137,136,1,167"  NO-UNDO.
DEFINE VARIABLE cInputList AS CHARACTER INITIAL ""  NO-UNDO.
DEFINE VARIABLE cSuffix AS CHARACTER INITIAL "17,31,73,47,23"  NO-UNDO.

FUNCTION subList RETURNS CHARACTER (pcList AS CHARACTER, piFrom AS INTEGER, piLength AS INTEGER) FORWARD.
FUNCTION reverseList RETURNS CHARACTER (pcList AS CHARACTER) FORWARD.
FUNCTION patchList RETURNS CHARACTER (pcList AS CHARACTER, piFrom AS INTEGER, pcPatch AS CHARACTER) FORWARD.

DEFINE VARIABLE i AS INTEGER     NO-UNDO.
DEFINE VARIABLE j AS INTEGER     NO-UNDO.
DEFINE VARIABLE iLength AS INTEGER     NO-UNDO.
DEFINE VARIABLE iSkip AS INTEGER     NO-UNDO.
DEFINE VARIABLE iPos AS INTEGER     NO-UNDO.
DEFINE VARIABLE cList AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cSelect AS CHARACTER   NO-UNDO.
DEFINE VARIABLE iIter AS INTEGER     NO-UNDO.

DO i = 0 TO 255:
    cList = cList + "," + STRING(i).
END.
cList = SUBSTRING(cList,2).

IF cInputList = "" THEN DO:
    DO i = 1 TO LENGTH(TRIM(cInput)):
        cInputList = cInputList + "," + STRING(ASC(SUBSTRING(cInput,i,1))).
    END.
    cInputList = (IF cInputList > "" THEN SUBSTRING(cInputList,2) + "," ELSE "") + cSuffix.
END.

iPos = 1.
DO iIter = 1 TO 64:
    DO i = 1 TO NUM-ENTRIES(cInputList):
        iLength = INTEGER(ENTRY(i,cInputList)).
        cSelect = reverseList(subList(cList,iPos,iLength)).
        cList = patchList(cList,iPos,cSelect).
        iPos = (iPos + iLength + iSkip) MODULO 256.
        IF iPos = 0 THEN iPos = 256.
        iSkip = iSkip + 1.
    END.
END.

FUNCTION xor RETURNS INTEGER (pi1 AS INTEGER, pi2 AS INTEGER):
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    DEFINE VARIABLE iXor AS INTEGER     NO-UNDO.
    DO i = 1 TO 8:
        PUT-BITS(iXor,i,1) = IF GET-BITS(pi1,i,1) + GET-BITS(pi2,i,1) = 1 THEN 1 ELSE 0.
    END.
    RETURN iXor.
END FUNCTION.

/* reduce the hash */
DEFINE VARIABLE iByte AS INTEGER EXTENT 16    NO-UNDO.
DEFINE VARIABLE k AS INTEGER  NO-UNDO.
DO i = 1 TO 256 BY 16:
    k = k + 1.
    iByte[k] = 0.
    DO j = i TO i + 15:
        iByte[k] = xor(iByte[k], INTEGER(ENTRY(j,cList))).
    END.
END.

/* MESSAGE xor(22,xor(68,xor(5 ,xor(2 ,xor(0 ,xor(6 ,xor(7 ,xor(91,xor(50,xor(40,xor(3 ,xor(4 ,xor(1 ,xor(9 ,xor(65,27)))))))))))))))
    VIEW-AS ALERT-BOX INFO BUTTONS OK. */

DEFINE VARIABLE mHash AS MEMPTR      NO-UNDO.
SET-SIZE(mHash) = 16.
DO j = 1 TO 16:
    PUT-BYTE(mHash, j) = iByte[j].
END.

MESSAGE INTEGER(ENTRY(1,cList)) * INTEGER(ENTRY(2,cList)) SKIP
    STRING(HEX-ENCODE(mHash))
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

FUNCTION subList RETURNS CHARACTER (pcList AS CHARACTER, piFrom AS INTEGER, piLength AS INTEGER):
    DEFINE VARIABLE iPos AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    DEFINE VARIABLE cSub AS CHARACTER   NO-UNDO.
    iPos = piFrom.
    DO i = 1 TO piLength:
        cSub = cSub + "," + ENTRY(iPos, pcList).
        iPos = (iPos + 1) MODULO NUM-ENTRIES(pcList).
        IF iPos = 0 THEN iPos = NUM-ENTRIES(pcList).
    END.
    RETURN SUBSTRING(cSub,2).
END FUNCTION.

FUNCTION reverseList RETURNS CHARACTER (pcList AS CHARACTER):
    DEFINE VARIABLE cRev AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    DO i = NUM-ENTRIES(pcList) TO 1 BY -1:
        cRev = cRev + "," + ENTRY(i, pcList).
    END.
    RETURN SUBSTRING(cRev,2).
END FUNCTION.

FUNCTION patchList RETURNS CHARACTER (pcList AS CHARACTER, piFrom AS INTEGER, pcPatch AS CHARACTER):
    DEFINE VARIABLE iPos AS INTEGER     NO-UNDO.
    DEFINE VARIABLE i AS INTEGER     NO-UNDO.
    iPos = piFrom.
    DO i = 1 TO NUM-ENTRIES(pcPatch):
        ENTRY(iPos,pcList) = ENTRY(i,pcPatch).
        iPos = (iPos + 1) MODULO NUM-ENTRIES(pcList).
        IF iPos = 0 THEN iPos = NUM-ENTRIES(pcList).
    END.
    RETURN pcList.
END FUNCTION.
/*
---------------------------
Information (Press HELP to view stack trace)
---------------------------
26325 
a7af2706aa9a09cf5d848c1e6605dd2a
---------------------------
Aceptar   Ayuda   
---------------------------
*/
