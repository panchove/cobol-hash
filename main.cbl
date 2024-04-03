       IDENTIFICATION DIVISION.
       PROGRAM-ID. SHA256Test.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-STRING PIC X(100) VALUE "Hello, World!".
       01 WS-HASH PIC X(65).
       PROCEDURE DIVISION.
           CALL "sha256_string" USING BY REFERENCE WS-STRING
                                      BY REFERENCE WS-HASH.
           DISPLAY "Text: " WS-STRING.
           DISPLAY "Hash: " WS-HASH.
           STOP RUN.
           