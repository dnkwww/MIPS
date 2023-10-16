### 計算機組織HW2第二題
### 410921202 資工二 林芷萱
           .data
space:     .ascii " "                  # space記錄了數據的地址, .ascii告訴計算機編碼類型
array:     .word 0
           .word 0
           .word 1
           .word 2
           .word 3

    .text
           .globl main
main:   
           li     $s2, 0               # next = 0
           li     $s3, 1               # i = 1
           
           la     $t4, array           # $t3 as memory pointer
           addi   $t3, $t4, 4         # 跑到0
                                       # 之後變換位置用t3,像addi   $t3, $t3, 4*i(i:要增加的個數)
           li     $v0, 5               # cin >> n, t0保存n的值
           syscall 
           add    $t0, $v0, $0         
           sw     $t0, 0($t4)          # n is in the first location of the array
           
           addi   $t1, $t0, 1          # t1 = n+1
loop: 
           slt    $t2, $s3, $t1        # if(s3<t1) t2 = 1 else t2 = 0
           beq    $t2, $0, exit        # here is i>n+1,跳出迴圈
           
           beq    $s3, 1, print_t1     # if (i == 1)
           #else
           
           add    $s2, $s0, $s1         # next = t1 + t2
           sw     $s2, 0($t3)
           addi   $t3, $t3, 4
           
           la     $a0, space
           li     $v0, 4
           syscall
           add    $a0, $s2, $0          # print
           li     $v0, 1
           syscall
          
           add    $s0, $s1, $zero       # t1 = t2
           add    $s1, $s2, $zero       # t2 = next
           
           
           addi   $s3, $s3, 1          # i++
           j loop
print_t1:  
           
           li     $s0, 0               # t1 = 0
           sw     $s0, 0($t3)
           addi   $t3, $t3, 4
           
           add    $a0, $s0, $0
           li     $v0, 1
           syscall
           
           addi   $s3, $s3, 1           # i++
           beq    $t0, 1, exit          # 這裡判斷n是否是1,是的話就return 0,
                                        # 否則他會接著執行 beq    $s3, 2, print_t2
print_t2:
           li     $s1, 1               # t2 = 1
           sw     $s1, 0($t3)
           addi   $t3, $t3, 4
           
           la     $a0, space
           li     $v0, 4
           syscall
           add    $a0, $s1, $0
           li     $v0, 1
           syscall
           addi   $s3, $s3, 1           # i++
           j loop
exit:
    li   $v0, 10  # return 0
    syscall
