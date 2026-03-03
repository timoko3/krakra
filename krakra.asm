.model tiny
.code
org 100h

MAX_PASSWORD_LENGTH equ 10d

Start:
    mov ax, cs
    mov ds, ax 


    mov cl, 0d

    mov si, offset PASSWORD
    ; add si, 1d   ; skip return carriage
    mov di, offset INPUT_PASSWORD_STATUS

    ??startCycle:
    cmp cl, MAX_PASSWORD_LENGTH
    jg ??endCycle
        mov ah, 01h
        int 21h

        cmp al, 0dh
        je ??endCycle

        mov bl, [si]


        cmp al, bl
        je ??correctSoFar
            mov dx, [di]
            mov dx, 0d
            mov cs:[di], dx
        ??correctSoFar:

        inc si
        inc cl
        jmp ??startCycle
    ??endCycle:

    mov dx, cs:[di]
    test dx, 01h
    jz ??pswrdIncorrect
        mov dx, offset SUCCESS_MESSAGE
        mov ah, 09h
        int 21h
        jmp ??notIncorrect
    ??pswrdIncorrect:

    mov dx, offset UNSUCCESS_MESSAGE
    mov ah, 09h
    int 21h

    ??notIncorrect:

    mov ax, 4C00h   
    int 21h 

.data
    SUCCESS_MESSAGE       db 'access approved$'
    UNSUCCESS_MESSAGE     db 0dh, 'access denied$'
    PASSWORD              db 'pltrshk$'
    INPUT_PASSWORD_STATUS db 1d, '$'
end Start


