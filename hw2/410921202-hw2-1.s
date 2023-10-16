### 計算機組織HW2第一題
### 410921202 資工二 林芷萱
           .data
space:     .ascii " "                  # space記錄了數據的地址, .ascii告訴計算機編碼類型

	   .text
           .globl main
main:   
           li     $s2, 0               # next = 0
           li     $s3, 1               # i = 1
           li     $v0, 5               # cin >> n, t0保存n的值
           syscall 
           move   $t0, $v0  
           addi   $t1, $t0, 1          # t1 = n+1
loop:	
           slt    $t2, $s3, $t1        # if(s3<t1) t2 = 1 else t2 = 0
           beq    $t2, $0, exit        # here is i>n+1,跳出迴圈
           
           beq    $s3, 1, print_t1     # if (i == 1)
           beq    $s3, 2, print_t2     # if (i == 2)
           #else
           add    $s2, $s0, $s1         # next = t1 + t2
           add    $a0, $s2, $0          # print
           li     $v0, 1
           syscall
           la     $a0, space
           li     $v0, 4
           syscall
           add    $s0, $s1, $zero       # t1 = t2
           add    $s1, $s2, $zero       # t2 = next

           addi   $s3, $s3, 1           # i++
           j loop
print_t1:  
           li     $s0, 0               # t1 = 0
           add    $a0, $s0, $0
           li     $v0, 1
           syscall
           la     $a0, space
           li     $v0, 4
           syscall
           addi   $s3, $s3, 1           # i++
           beq    $t0, 1, exit         # 這裡判斷n是否是1,是的話就return 0,
                                       # 否則他會接著執行 beq    $s3, 2, print_t2
print_t2:
           li     $s1, 1               # t2 = 1
           add    $a0, $s1, $0
           li     $v0, 1
           syscall
           la     $a0, space
           li     $v0, 4
           syscall
           addi   $s3, $s3, 1           # i++
           j loop
exit:
	   li	  $v0, 10		# return 0
	   syscall	
#------------------------------------------------------------------------------	   
# here is my C code:
# int main()
# {
#     int n, t1, t2, next = 0;
#     cin >> n;
# 
#     for (int i = 1; i < n+1; i++)
#     {
#          if(i == 1)
#         {
#             t1 = 0;
#             cout << t1 << " ";
#         }
#         else if(i == 2)
#         {
#             t2 = 1;
#             cout << t2 << " ";
#         }
#         else
#         {
#             next = t1 + t2;
#             cout << next << " ";
#
#             t1 = t2;
#             t2 = next;
#         }
#     }
#     return 0;
#}
#------------------------------------------------------------------------------	 
