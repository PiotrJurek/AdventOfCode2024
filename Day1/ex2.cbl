       IDENTIFICATION DIVISION.
       PROGRAM-ID. ex2.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO "input.txt".
       
       DATA DIVISION.
       FILE SECTION.
       FD INPUT-FILE.
       01 FILE-LISTS.
           02 LIST1-VALUE PIC 9(5).
           02 FILLER      PIC X(3).
           02 LIST2-VALUE PIC 9(5).
           02 FILLER      PIC X(1).
       
       WORKING-STORAGE SECTION.
       01 LISTS.
           02 LIST1       OCCURS 1000 TIMES PIC 9(5) VALUE ZEROS.
           02 LIST2       OCCURS 1000 TIMES PIC 9(5) VALUE ZEROS.
       01 INDEXES.
           02 I1       PIC 9(4) VALUE ZEROS.
           02 I2       PIC 9(4) VALUE ZEROS.
       01 TEMP       PIC 9(5).
       01 RESULT PIC 9(10) VALUE ZEROS.
       
       PROCEDURE DIVISION.
       MAIN.
           PERFORM READ-FILE
           PERFORM BUBBLE-SORT
           PERFORM CALCULATE-OUTPUT
           DISPLAY RESULT.
           STOP RUN.
       
       READ-FILE.
           OPEN INPUT INPUT-FILE.
           PERFORM UNTIL I1 >= 1000
               READ INPUT-FILE INTO FILE-LISTS
               AT END
                   EXIT PERFORM
               NOT AT END
                   ADD 1 TO I1
                   MOVE LIST1-VALUE TO LIST1(I1)
                   MOVE LIST2-VALUE TO LIST2(I1)
               END-READ
           END-PERFORM.
           CLOSE INPUT-FILE.
       
       BUBBLE-SORT.
           PERFORM VARYING I1 FROM 1 BY 1 UNTIL I1 >= 1000
               PERFORM VARYING I2 FROM I1 BY 1 UNTIL I2 > 1000
                   IF LIST1(I1) > LIST1(I2)
                       MOVE LIST1(I1) TO TEMP
                       MOVE LIST1(I2) TO LIST1(I1)
                       MOVE TEMP TO LIST1(I2)
                   END-IF
                   IF LIST2(I1) > LIST2(I2)
                       MOVE LIST2(I1) TO TEMP
                       MOVE LIST2(I2) TO LIST2(I1)
                       MOVE TEMP TO LIST2(I2)
                   END-IF
               END-PERFORM
           END-PERFORM.
       
       CALCULATE-OUTPUT.
           PERFORM VARYING I1 FROM 1 BY 1 UNTIL I1 > 1000
               PERFORM VARYING I2 FROM 1 BY 1 UNTIL I2 > 1000
                   IF LIST1(I1) = LIST2(I2)
                       ADD LIST1(I1) TO RESULT
                   END-IF
               END-PERFORM
           END-PERFORM.
       