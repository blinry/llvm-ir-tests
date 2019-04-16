declare i32 @putchar(i8)
declare i8 @getchar()

define i32 @main() {
  ; It's not possible to jump to the first basic block of a function, so this
  ; is a workaround to avoid having the loop label on the first line.
  br label %loop

loop:
  %c = call i8 @getchar()
  %eof = icmp eq i8 %c, -1
  br i1 %eof, label %quit, label %continue

continue:
  %c2 = call i8 @rot(i8 %c)
  call i32 @putchar(i8 %c2)
  br label %loop

quit:
  ret i32 0
}

define i8 @rot(i8 %c) {
  %at_least_A = icmp uge i8 %c, 65
  %at_most_M = icmp ule i8 %c, 77
  %at_most_Z = icmp ule i8 %c, 90

  %at_least_a = icmp uge i8 %c, 97
  %at_most_m = icmp ule i8 %c, 109
  %at_most_z = icmp ule i8 %c, 122

  %uppercase = and i1 %at_least_A, %at_most_Z
  br i1 %uppercase, label %do_uppercase, label %continue

continue:
  %lowercase = and i1 %at_least_a, %at_most_z
  br i1 %lowercase, label %do_lowercase, label %nop

do_uppercase:
  br i1 %at_most_M, label %shift_up, label %shift_down
do_lowercase:
  br i1 %at_most_m, label %shift_up, label %shift_down

shift_up:
  %c_up = add i8 %c, 13
  ret i8 %c_up
shift_down:
  %c_down = sub i8 %c, 13
  ret i8 %c_down
nop:
  ret i8 %c
}
