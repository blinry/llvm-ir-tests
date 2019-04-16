@message = constant [12 x i8] c"Hello world\00"

declare i32 @puts(i8*)

define i32 @main() {
  ; Get a i8* pointer to the beginning of the message.
  %message_pointer = getelementptr [12 x i8], [12 x i8]* @message, i64 0, i64 0

  call i32 @puts(i8* %message_pointer)
  ret i32 0
}
