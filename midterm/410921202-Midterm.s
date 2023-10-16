### 計算機組織 期中 題目:計算機
### 410921202 資工二 林芷萱
### 程式碼解釋:這個程式碼可以執行加減乘除(除會取出餘數)，並且是一個迴圈，終止條件為將第一個數字輸入0
### 註:最下面有 C code

             .data
description: .asciiz "+:add, -:sub, *:multiply, %:divide\n"
break_:      .asciiz "when the 1st number is 0, the system will stop\n--------------------------------------------------\n"
exit_:       .asciiz "system stop"
str1:        .asciiz "Enter the first number(0 will break):\n"
str2:        .asciiz "Enter the operator:\n"
str3:        .asciiz "Enter the second number:\n"
equal:       .asciiz "=\n"
dot:         .asciiz "..."
newline:     .asciiz "\n"
op:          .space 10                   # space to hold operator char
           
             .text
             .globl main
main:
             li     $v0, 4
             la     $a0, description
             syscall
             li     $v0, 4
             la     $a0, break_
             syscall
calculator:
             li     $v0, 4
             la     $a0, str1
             syscall
             li     $v0, 5                # read num1
             syscall
             move   $s0, $v0              # put value into num1
             beq    $s0, $0, exit         # the first number is 0:break
             
             li     $v0, 4
             la     $a0, str2
             syscall
             li     $v0, 8                # read op
             la     $a0, op               # address of op
             li     $a1, 10 
             syscall  
             lb     $s1, op
             
             li     $v0, 4
             la     $a0, str3
             syscall
             li     $v0,5                 # read num2
             syscall
             move   $s2, $v0              # put value into num2
             
             li     $v0, 4
             la     $a0, equal
             syscall
             
             beq    $s1, '+', Add
             beq    $s1, '-', Sub
             beq    $s1, '*', Mul
             beq    $s1, '%', Dev
Add:
             add    $a0, $s0, $s2         # $a0 = num1 + num2
             li     $v0, 1
             syscall
             li     $v0, 4
             la     $a0, newline
             syscall
             j      calculator
Sub:
             sub    $a0, $s0, $s2         # $a0 = num1 - num2
             li     $v0, 1
             syscall
             li     $v0, 4
             la     $a0, newline
             syscall
             j      calculator
Mul:
             mul    $a0, $s0, $s2         # $a0 = num1 * num2
             li     $v0,1
             syscall
             li     $v0, 4
             la     $a0, newline
             syscall
             j      calculator
Dev:
             div    $t0, $s0, $s2         # 商
             add    $a0, $t0, $0          # $a0 = num1 / num2 (除法)
             li     $v0,1
             syscall
             li     $v0, 4
             la     $a0, dot
             syscall
             mul    $t1, $t0, $s2
             sub    $t2, $s0, $t1          # 餘
             add    $a0, $t2, $0           # $a0 = num1 % num2 (取餘數)
             li     $v0,1
             syscall
             li     $v0, 4
             la     $a0, newline
             syscall
             j      calculator
exit:
	     li     $v0, 4
             la     $a0, exit_
             syscall
	     li	  $v0, 10		   # return 0
	     syscall	
	     
#------------------------------------------------------------------------------	   
# here is my C code:
# int main()
# {
#     int a, b;
#     char op;
# 
#     while(1)
#     {
#         cout << "Enter the first number(0 will break):\n";
#         cin >> a;
#         if(a == 0)
#         {
#             cout << "system stop";
#             break;
#         }
#         cout << "Enter the operator:\n";
#         cin >> op;
#         cout << "Enter the second number:\n";
#         cin >> b;
#         cout << "=\n";
#         if (op == '+')
#             cout << a+b << "\n";
#         if (op == '-')
#             cout << a-b << "\n";
#         if (op == '%')
#             cout << a/b << "..." << a%b << "\n";
#         if (op == '*')
#             cout << a*b << "\n";
#     }
#     return 0;
# }
#------------------------------------------------------------------------------