### 計算機組織HW3(Selection Sort)
           .data
space:     .ascii " "
num:       .word  0:1000               # int num[1000]

	   .text
           .globl main
main:    
           li     $s0, 0               # i = 0
           li     $s2, 0               # j = 0
           addi   $s3, $s2, 1          # k = j + 1
           li     $s7, 0               # l = 0

           la     $s1, num             #address of start of sum
while_loop:	
           li     $v0, 5               # cin >> n, t0保存n的值
           syscall 
           move   $t0, $v0  
           beq    $t0, $0, for_1
           sll    $t1, $s0, 2          # $t1 = i*4
           add    $t2, $s1, $t1
           sw     $t0, 0($t2)
           addi   $s0, $s0, 1          # i++
           j      while_loop
for_1:     
           slt    $t3, $s2, $s0        # if(s2<s0) t3 = 1 else t3 = 0
           beq    $t3, $1, for_2       # here if j<i, 跳至內迴圈(for_2)
           beq    $t3, $0, for_print   # here is j>=i, 排列結束跳至print
           addi   $s2, $s2, 1          # j++
for_2:
           slt    $t4, $s3, $s0        # if(s3<s0) t4 = 1 else t4 = 0
           beq    $t4, $0, for_1       # here is k>=i, 換下一個i
           
           sll    $t5, $s2, 2          # $t5 = i*4
           add    $t6, $s1, $t5
           lw     $s4, 0($t6)          # $s4 = num[j]
           sll    $t7, $s3, 2          # $t7 = i*4
           add    $t8, $s1, $t7
           lw     $s5, 0($t8)          # $s5 = num[k]
           
           slt    $t9, $s5, $s4        # if(s5<s4) t9 = 1 else t9 = 0
           beq    $t9, $1, swap
           
           addi   $s3, $s3, 1          # k++
           j      for_2
           
swap:
           addi   $s6, $s4, 0          # temp = num[j]
           addi   $s4, $s5, 0          # num[j] = num[k]
           addi   $s5, $s6, 0          # num[k] = temp       
           jr     $ra                  # 返回呼叫此程序的程序
           
for_print:
           slt    $t1, $s7, $s0        # if(s7<s0) t1 = 1 else t1 = 0
           beq    $t1, $0, exit
           sll    $t2, $s7, 2          # $t2 = i*4
           add    $t3, $s1, $t2
           lw     $t4, 0($t3)          # $t4 = num[l]
           
           add    $a0, $t4, $0         # print
           li     $v0, 1
           syscall
           la     $a0, space
           li     $v0, 4
           syscall
           
           addi   $s7, $s7, 1          # l++
           j      for_print
exit:
	   li	  $v0, 10		# return 0
	   syscall	
#------------------------------------------------------------------------------	   
# here is my C code:
# int main()
# {
#     int n, i=0, num[1000];
# 
#     while(cin >> n)
#     {
#         if(n == 0)
#             break;
#         num[i] = n;
#         i++;
#     }
# 
#     int j, k, temp;
#     for(j=0; j<i; j++)
#     {
#         for(k=j+1; k<i; k++)
#         {
#             if(num[j] > num[k])
#             {
#                 temp = num[j];
#                 num[j] = num[k];
#                 num[k] = temp;
#             }
#         }
#     }
# 
#     int l;
#     for(l=0; l<i; l++)
#         cout << num[l] << " ";
# 
#     return 0;
# }
#------------------------------------------------------------------------------	 
