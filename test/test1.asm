START 1000
FIRST  STL RETADR
CLOOP  JSUB RDREC
       LDA LENGTH
       COMP ZERO
       JEQ ENDFIL
       JSUB WRREC
       J CLOOP
ENDFIL LDA EOF
       STA BUFFER
       LDA LENGTH
       STA LENGTH
       RSUB
EOF    BYTE C'EOF'
RETADR RESW 1
LENGTH RESW 1
BUFFER RESB 4096
RDREC  ...
WRREC  ...
ZERO   WORD 0
       END FIRST