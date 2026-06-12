; Yousuf Khan
; Marquez Mirasol
; Muhammad Rana
; Team Name: Calculator Crew
; CIS-11 Final Project

; Case B: Test Calculator Program
; Reads 5 test scores
; Calculates Min, Max, Average, Letter Grade

        .ORIG x3000

; MAIN

MAIN

        LD      R6, STACK_TOP

        LEA     R1, SCORES

        AND     R2, R2, #0
        ADD     R2, R2, #5

        AND     R3, R3, #0
        ST      R3, SUM

; First Score Is Implemented

        LEA     R0, PROMPT
        PUTS

        JSR     GET_SCORE

        STR     R0, R1, #0

        ST      R0, MINVAL
        ST      R0, MAXVAL
        ST      R0, SUM

        ADD     R1, R1, #1
        ADD     R2, R2, #-1

; Remaining Scores Are Implemented

INPUT_LOOP

        ADD     R2, R2, #0
        BRz     COMPUTE_AVG

        LEA     R0, PROMPT
        PUTS

        JSR     GET_SCORE

        STR     R0, R1, #0

        JSR     UPDATE_STATS

        ADD     R1, R1, #1

        ADD     R2, R2, #-1
        BR      INPUT_LOOP

; Average is computed

COMPUTE_AVG

        JSR     CALC_AVERAGE

        JSR     DISPLAY_RESULTS

        HALT

; GET_SCORE
; Two digits are read

GET_SCORE

        ADD     R6, R6, #-1
        STR     R7, R6, #0

        ADD     R6, R6, #-1
        STR     R1, R6, #0

        ADD     R6, R6, #-1
        STR     R2, R6, #0

        ADD     R6, R6, #-1
        STR     R3, R6, #0

; tens digit

        GETC
        OUT

        LD      R1, NEG_ASCII_ZERO
        ADD     R2, R0, R1

; ones digit

        GETC
        OUT

        LD      R1, NEG_ASCII_ZERO
        ADD     R3, R0, R1

        GETC

; tens * 10 is computed

        ADD     R0, R2, R2

        ADD     R1, R2, R2
        ADD     R1, R1, R1
        ADD     R1, R1, R1

        ADD     R0, R0, R1

        ADD     R0, R0, R3

        LDR     R3, R6, #0
        ADD     R6, R6, #1

        LDR     R2, R6, #0
        ADD     R6, R6, #1

        LDR     R1, R6, #0
        ADD     R6, R6, #1

        LDR     R7, R6, #0
        ADD     R6, R6, #1

        RET

; Stats are updated

UPDATE_STATS

        ADD     R6, R6, #-1
        STR     R7, R6, #0

        ADD     R6, R6, #-1
        STR     R1, R6, #0

        ADD     R6, R6, #-1
        STR     R2, R6, #0

; SUM += SCORE

        LD      R1, SUM
        ADD     R1, R1, R0
        ST      R1, SUM

; MIN

        LD      R1, MINVAL

        NOT     R2, R1
        ADD     R2, R2, #1
        ADD     R2, R0, R2

        BRzp    CHECK_MAX

        ST      R0, MINVAL

CHECK_MAX

        LD      R1, MAXVAL

        NOT     R2, R1
        ADD     R2, R2, #1
        ADD     R2, R0, R2

        BRnz    UPDATE_DONE

        ST      R0, MAXVAL

UPDATE_DONE

        LDR     R2, R6, #0
        ADD     R6, R6, #1

        LDR     R1, R6, #0
        ADD     R6, R6, #1

        LDR     R7, R6, #0
        ADD     R6, R6, #1

        RET

; CALC_AVERAGE
; AVG = SUM / 5

CALC_AVERAGE

        ADD     R6, R6, #-1
        STR     R7, R6, #0

        ADD     R6, R6, #-1
        STR     R1, R6, #0

        ADD     R6, R6, #-1
        STR     R2, R6, #0

        LD      R1, SUM

        AND     R2, R2, #0

AVG_LOOP

        ADD     R0, R1, #-5
        BRn     AVG_DONE

        ADD     R1, R1, #-5
        ADD     R2, R2, #1

        BR      AVG_LOOP

AVG_DONE

        ST      R2, AVG

        LDR     R2, R6, #0
        ADD     R6, R6, #1

        LDR     R1, R6, #0
        ADD     R6, R6, #1

        LDR     R7, R6, #0
        ADD     R6, R6, #1

        RET

; Letter Grades

LETTER_GRADE ; A is above 90

        ADD     R6, R6, #-1
        STR     R7, R6, #0

        ADD     R6, R6, #-1
        STR     R1, R6, #0

        LD      R1, NEG90
        ADD     R1, R0, R1
        BRn     LG80

        LD      R0, ASCII_A
        BR      LG_DONE

LG80 ; B is between 80 and 89
        LD      R1, NEG80
        ADD     R1, R0, R1
        BRn     LG70

        LD      R0, ASCII_B
        BR      LG_DONE

LG70 ; C is between 70 and 79
        LD      R1, NEG70
        ADD     R1, R0, R1
        BRn     LG60

        LD      R0, ASCII_C
        BR      LG_DONE

LG60 ; D is between 60 and 69
        LD      R1, NEG60
        ADD     R1, R0, R1
        BRn     LGF

        LD      R0, ASCII_D
        BR      LG_DONE

LGF ; F is below 59
        LD      R0, ASCII_F

LG_DONE

        LDR     R1, R6, #0
        ADD     R6, R6, #1

        LDR     R7, R6, #0
        ADD     R6, R6, #1

        RET

; PRINT_NUM
; Supports 0-99

PRINT_NUM

        ADD     R6, R6, #-1
        STR     R7, R6, #0

        ADD     R6, R6, #-1
        STR     R1, R6, #0

        ADD     R6, R6, #-1
        STR     R2, R6, #0

        ADD     R6, R6, #-1
        STR     R3, R6, #0

        AND     R1, R1, #0

        ADD     R2, R0, #0

PN_LOOP

        ADD     R3, R2, #-10
        BRn     PN_DONE

        ADD     R2, R2, #-10
        ADD     R1, R1, #1

        BR      PN_LOOP

PN_DONE

        ADD     R1, R1, #0
        BRz     PRINT_ONES

        LD      R3, ASCII_ZERO
        ADD     R0, R1, R3
        OUT

PRINT_ONES

        LD      R3, ASCII_ZERO
        ADD     R0, R2, R3
        OUT

        LDR     R3, R6, #0
        ADD     R6, R6, #1

        LDR     R2, R6, #0
        ADD     R6, R6, #1

        LDR     R1, R6, #0
        ADD     R6, R6, #1

        LDR     R7, R6, #0
        ADD     R6, R6, #1

        RET

; Results are printed to console

DISPLAY_RESULTS

        ADD     R6, R6, #-1
        STR     R7, R6, #0

; MIN

        LEA     R0, MIN_MSG
        PUTS

        LD      R0, MINVAL
        JSR     PRINT_NUM

        LEA     R0, GRADE_MSG
        PUTS

        LD      R0, MINVAL
        JSR     LETTER_GRADE
        OUT

; MAX

        LEA     R0, MAX_MSG
        PUTS

        LD      R0, MAXVAL
        JSR     PRINT_NUM

        LEA     R0, GRADE_MSG
        PUTS

        LD      R0, MAXVAL
        JSR     LETTER_GRADE
        OUT

; AVG

        LEA     R0, AVG_MSG
        PUTS

        LD      R0, AVG
        JSR     PRINT_NUM

        LEA     R0, GRADE_MSG
        PUTS

        LD      R0, AVG
        JSR     LETTER_GRADE
        OUT

        LDR     R7, R6, #0
        ADD     R6, R6, #1

        RET

; DATA

SCORES          .BLKW   #5

MINVAL          .BLKW   #1
MAXVAL          .BLKW   #1
SUM             .BLKW   #1
AVG             .BLKW   #1

NEG_ASCII_ZERO  .FILL   xFFD0

NEG60           .FILL   #-60
NEG70           .FILL   #-70
NEG80           .FILL   #-80
NEG90           .FILL   #-90

ASCII_ZERO      .FILL   x0030

ASCII_A         .FILL   x0041
ASCII_B         .FILL   x0042
ASCII_C         .FILL   x0043
ASCII_D         .FILL   x0044
ASCII_F         .FILL   x0046

STACK_TOP       .FILL   xFDFF

PROMPT          .STRINGZ "\nEnter score: "

MIN_MSG         .STRINGZ "\nMinimum Score: "
MAX_MSG         .STRINGZ "\nMaximum Score: "
AVG_MSG         .STRINGZ "\nAverage Score: "

GRADE_MSG       .STRINGZ "  Grade: "

        .END
