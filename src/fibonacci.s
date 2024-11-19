global  _start
extern printf

section .data
    message db "Fibonacci Sequence:", 0x0a
    outFormat db "%d", 0x0a, 0x00

section .text
_start:
    call printMessage   ; print intro message
    call initFib        ; set initial Fib values
    call loopFib        ; calculate Fib numbers
    call Exit           ; Exit the program

printMessage:
    mov rax, 1      ; rax: syscall number 1
    mov rdi, 1      ; rdi: fd 1 for stdout
    mov rsi,message ; rsi: pointer to message
    mov rdx, 20     ; rdx: print length of 20 bytes
    syscall         ; call write syscall to the intro message
    ret

initFib:
    xor rax, rax    ; initialize rax to 0
    xor rbx, rbx    ; initialize rbx to 0
    inc rbx         ; increment rbx to 1
    ret

loopFib:
    call printFib
    add rax, rbx    ; get the next number
    xchg rax, rbx   ; swap values
    cmp rbx, 10		; do rbx - 10
    js loopFib		; jump if result is <0
    ret

printFib:
    push rax            ; save registers
    push rbx
    mov rdi, outFormat  ; set 1st argument (print format)
    mov rsi, rbx        ; set 2nd argument (Fib number)
    call printf
    pop rbx             ; restore registers
    pop rax
    ret

Exit:
    mov rax, 60
    mov rdi, 0
    syscall