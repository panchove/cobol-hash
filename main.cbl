       IDENTIFICATION DIVISION.
       PROGRAM-ID. SHA256Test.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-STRING PIC X(100) VALUE "Hello, World!".
       01 WS-HASH PIC X(65).
       01 WS-RETURN-CODE PIC 9(9) COMP-5.
       PROCEDURE DIVISION.
           CALL "sha256_string" USING BY REFERENCE WS-STRING
                                      BY REFERENCE WS-HASH.
           DISPLAY "NO ERROR CHECKING".
           DISPLAY "Text: " WS-STRING.
           DISPLAY "Hash: " WS-HASH.
           CALL "sha256_string_error" USING BY REFERENCE WS-STRING
                                      BY REFERENCE WS-HASH
                                      RETURNING WS-RETURN-CODE.

           DISPLAY "====================".
           DISPLAY "WITH ERROR CHECKING".
           IF WS-RETURN-CODE NOT = 0 THEN
               DISPLAY "An error occurred while calculating the hash."
           ELSE
               DISPLAY "Text: " WS-STRING.
               DISPLAY "Hash: " WS-HASH.
           STOP RUN.
