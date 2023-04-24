
boot_code.elf:     file format elf32-littleriscv


Disassembly of section .vectors:

00008000 <_stack_start-0x100000>:
    8000:	00000013          	nop
    8004:	00000013          	nop
    8008:	00000013          	nop
    800c:	00000013          	nop
    8010:	00000013          	nop
    8014:	00000013          	nop
    8018:	00000013          	nop
    801c:	00000013          	nop
    8020:	00000013          	nop
    8024:	00000013          	nop
    8028:	00000013          	nop
    802c:	00000013          	nop
    8030:	00000013          	nop
    8034:	00000013          	nop
    8038:	00000013          	nop
    803c:	00000013          	nop
    8040:	00000013          	nop
    8044:	00000013          	nop
    8048:	00000013          	nop
    804c:	00000013          	nop
    8050:	00000013          	nop
    8054:	00000013          	nop
    8058:	00000013          	nop
    805c:	00000013          	nop
    8060:	00000013          	nop
    8064:	00000013          	nop
    8068:	00000013          	nop
    806c:	00000013          	nop
    8070:	00000013          	nop
    8074:	00000013          	nop
    8078:	00000013          	nop
    807c:	0100006f          	j	808c <_stext>
    8080:	0100006f          	j	8090 <reset_handler>
    8084:	0080006f          	j	808c <_stext>
    8088:	0040006f          	j	808c <_stext>

Disassembly of section .text:

0000808c <_stext>:
    808c:	0000006f          	j	808c <_stext>

00008090 <reset_handler>:
    8090:	00000093          	li	ra,0
    8094:	8106                	mv	sp,ra
    8096:	8186                	mv	gp,ra
    8098:	8206                	mv	tp,ra
    809a:	8286                	mv	t0,ra
    809c:	8306                	mv	t1,ra
    809e:	8386                	mv	t2,ra
    80a0:	8406                	mv	s0,ra
    80a2:	8486                	mv	s1,ra
    80a4:	8506                	mv	a0,ra
    80a6:	8586                	mv	a1,ra
    80a8:	8606                	mv	a2,ra
    80aa:	8686                	mv	a3,ra
    80ac:	8706                	mv	a4,ra
    80ae:	8786                	mv	a5,ra
    80b0:	8806                	mv	a6,ra
    80b2:	8886                	mv	a7,ra
    80b4:	8906                	mv	s2,ra
    80b6:	8986                	mv	s3,ra
    80b8:	8a06                	mv	s4,ra
    80ba:	8a86                	mv	s5,ra
    80bc:	8b06                	mv	s6,ra
    80be:	8b86                	mv	s7,ra
    80c0:	8c06                	mv	s8,ra
    80c2:	8c86                	mv	s9,ra
    80c4:	8d06                	mv	s10,ra
    80c6:	8d86                	mv	s11,ra
    80c8:	8e06                	mv	t3,ra
    80ca:	8e86                	mv	t4,ra
    80cc:	8f06                	mv	t5,ra
    80ce:	8f86                	mv	t6,ra
    80d0:	00100117          	auipc	sp,0x100
    80d4:	f3010113          	addi	sp,sp,-208 # 108000 <_stack_start>

000080d8 <_start>:
    80d8:	00000d17          	auipc	s10,0x0
    80dc:	3a8d0d13          	addi	s10,s10,936 # 8480 <_bss_end>
    80e0:	00000d97          	auipc	s11,0x0
    80e4:	3a0d8d93          	addi	s11,s11,928 # 8480 <_bss_end>
    80e8:	01bd5763          	bge	s10,s11,80f6 <main_entry>

000080ec <zero_loop>:
    80ec:	000d2023          	sw	zero,0(s10)
    80f0:	0d11                	addi	s10,s10,4
    80f2:	ffaddde3          	bge	s11,s10,80ec <zero_loop>

000080f6 <main_entry>:
    80f6:	00000513          	li	a0,0
    80fa:	00000593          	li	a1,0
    80fe:	004000ef          	jal	ra,8102 <main>

00008102 <main>:
    8102:	1101                	addi	sp,sp,-32
    8104:	ce06                	sw	ra,28(sp)
    8106:	cc22                	sw	s0,24(sp)
    8108:	1000                	addi	s0,sp,32
    810a:	4585                	li	a1,1
    810c:	457d                	li	a0,31
    810e:	2051                	jal	8192 <set_pin_function>
    8110:	4585                	li	a1,1
    8112:	457d                	li	a0,31
    8114:	2221                	jal	821c <set_gpio_pin_direction>
    8116:	4581                	li	a1,0
    8118:	457d                	li	a0,31
    811a:	2a51                	jal	82ae <set_gpio_pin_value>
    811c:	fe042623          	sw	zero,-20(s0)
    8120:	a039                	j	812e <main+0x2c>
    8122:	0001                	nop
    8124:	fec42783          	lw	a5,-20(s0)
    8128:	0785                	addi	a5,a5,1
    812a:	fef42623          	sw	a5,-20(s0)
    812e:	fec42703          	lw	a4,-20(s0)
    8132:	47a5                	li	a5,9
    8134:	fee7d7e3          	bge	a5,a4,8122 <main+0x20>
    8138:	4585                	li	a1,1
    813a:	457d                	li	a0,31
    813c:	2a8d                	jal	82ae <set_gpio_pin_value>
    813e:	fe042423          	sw	zero,-24(s0)
    8142:	a039                	j	8150 <main+0x4e>
    8144:	0001                	nop
    8146:	fe842783          	lw	a5,-24(s0)
    814a:	0785                	addi	a5,a5,1
    814c:	fef42423          	sw	a5,-24(s0)
    8150:	fe842703          	lw	a4,-24(s0)
    8154:	47a5                	li	a5,9
    8156:	fee7d7e3          	bge	a5,a4,8144 <main+0x42>
    815a:	4581                	li	a1,0
    815c:	457d                	li	a0,31
    815e:	2a81                	jal	82ae <set_gpio_pin_value>
    8160:	08000513          	li	a0,128
    8164:	2039                	jal	8172 <jump_and_start>
    8166:	4781                	li	a5,0
    8168:	853e                	mv	a0,a5
    816a:	40f2                	lw	ra,28(sp)
    816c:	4462                	lw	s0,24(sp)
    816e:	6105                	addi	sp,sp,32
    8170:	8082                	ret

00008172 <jump_and_start>:
    8172:	1101                	addi	sp,sp,-32
    8174:	ce22                	sw	s0,28(sp)
    8176:	1000                	addi	s0,sp,32
    8178:	fea42623          	sw	a0,-20(s0)
    817c:	fec42783          	lw	a5,-20(s0)
    8180:	00078067          	jr	a5
    8184:	0001                	nop
    8186:	0001                	nop
    8188:	0001                	nop
    818a:	0001                	nop
    818c:	4472                	lw	s0,28(sp)
    818e:	6105                	addi	sp,sp,32
    8190:	8082                	ret

00008192 <set_pin_function>:
    8192:	7179                	addi	sp,sp,-48
    8194:	d622                	sw	s0,44(sp)
    8196:	1800                	addi	s0,sp,48
    8198:	fca42e23          	sw	a0,-36(s0)
    819c:	fcb42c23          	sw	a1,-40(s0)
    81a0:	1a1077b7          	lui	a5,0x1a107
    81a4:	439c                	lw	a5,0(a5)
    81a6:	fef42623          	sw	a5,-20(s0)
    81aa:	fdc42783          	lw	a5,-36(s0)
    81ae:	4705                	li	a4,1
    81b0:	00f717b3          	sll	a5,a4,a5
    81b4:	fff7c713          	not	a4,a5
    81b8:	fec42783          	lw	a5,-20(s0)
    81bc:	8ff9                	and	a5,a5,a4
    81be:	fef42623          	sw	a5,-20(s0)
    81c2:	fdc42783          	lw	a5,-36(s0)
    81c6:	fd842703          	lw	a4,-40(s0)
    81ca:	00f71733          	sll	a4,a4,a5
    81ce:	fec42783          	lw	a5,-20(s0)
    81d2:	8fd9                	or	a5,a5,a4
    81d4:	fef42623          	sw	a5,-20(s0)
    81d8:	1a1077b7          	lui	a5,0x1a107
    81dc:	fec42703          	lw	a4,-20(s0)
    81e0:	c398                	sw	a4,0(a5)
    81e2:	0001                	nop
    81e4:	5432                	lw	s0,44(sp)
    81e6:	6145                	addi	sp,sp,48
    81e8:	8082                	ret

000081ea <get_pin_function>:
    81ea:	7179                	addi	sp,sp,-48
    81ec:	d622                	sw	s0,44(sp)
    81ee:	1800                	addi	s0,sp,48
    81f0:	fca42e23          	sw	a0,-36(s0)
    81f4:	1a1077b7          	lui	a5,0x1a107
    81f8:	439c                	lw	a5,0(a5)
    81fa:	fef42623          	sw	a5,-20(s0)
    81fe:	fec42703          	lw	a4,-20(s0)
    8202:	fdc42783          	lw	a5,-36(s0)
    8206:	40f757b3          	sra	a5,a4,a5
    820a:	8b85                	andi	a5,a5,1
    820c:	fef42623          	sw	a5,-20(s0)
    8210:	fec42783          	lw	a5,-20(s0)
    8214:	853e                	mv	a0,a5
    8216:	5432                	lw	s0,44(sp)
    8218:	6145                	addi	sp,sp,48
    821a:	8082                	ret

0000821c <set_gpio_pin_direction>:
    821c:	7179                	addi	sp,sp,-48
    821e:	d622                	sw	s0,44(sp)
    8220:	1800                	addi	s0,sp,48
    8222:	fca42e23          	sw	a0,-36(s0)
    8226:	fcb42c23          	sw	a1,-40(s0)
    822a:	1a1017b7          	lui	a5,0x1a101
    822e:	439c                	lw	a5,0(a5)
    8230:	fef42623          	sw	a5,-20(s0)
    8234:	fd842783          	lw	a5,-40(s0)
    8238:	ef91                	bnez	a5,8254 <set_gpio_pin_direction+0x38>
    823a:	fdc42783          	lw	a5,-36(s0)
    823e:	4705                	li	a4,1
    8240:	00f717b3          	sll	a5,a4,a5
    8244:	fff7c713          	not	a4,a5
    8248:	fec42783          	lw	a5,-20(s0)
    824c:	8ff9                	and	a5,a5,a4
    824e:	fef42623          	sw	a5,-20(s0)
    8252:	a819                	j	8268 <set_gpio_pin_direction+0x4c>
    8254:	fdc42783          	lw	a5,-36(s0)
    8258:	4705                	li	a4,1
    825a:	00f71733          	sll	a4,a4,a5
    825e:	fec42783          	lw	a5,-20(s0)
    8262:	8fd9                	or	a5,a5,a4
    8264:	fef42623          	sw	a5,-20(s0)
    8268:	1a1017b7          	lui	a5,0x1a101
    826c:	fec42703          	lw	a4,-20(s0)
    8270:	c398                	sw	a4,0(a5)
    8272:	0001                	nop
    8274:	5432                	lw	s0,44(sp)
    8276:	6145                	addi	sp,sp,48
    8278:	8082                	ret

0000827a <get_gpio_pin_direction>:
    827a:	7179                	addi	sp,sp,-48
    827c:	d622                	sw	s0,44(sp)
    827e:	1800                	addi	s0,sp,48
    8280:	fca42e23          	sw	a0,-36(s0)
    8284:	1a1017b7          	lui	a5,0x1a101
    8288:	439c                	lw	a5,0(a5)
    828a:	fef42623          	sw	a5,-20(s0)
    828e:	fec42703          	lw	a4,-20(s0)
    8292:	fdc42783          	lw	a5,-36(s0)
    8296:	0786                	slli	a5,a5,0x1
    8298:	40f757b3          	sra	a5,a4,a5
    829c:	8b85                	andi	a5,a5,1
    829e:	fef42623          	sw	a5,-20(s0)
    82a2:	fec42783          	lw	a5,-20(s0)
    82a6:	853e                	mv	a0,a5
    82a8:	5432                	lw	s0,44(sp)
    82aa:	6145                	addi	sp,sp,48
    82ac:	8082                	ret

000082ae <set_gpio_pin_value>:
    82ae:	7179                	addi	sp,sp,-48
    82b0:	d622                	sw	s0,44(sp)
    82b2:	1800                	addi	s0,sp,48
    82b4:	fca42e23          	sw	a0,-36(s0)
    82b8:	fcb42c23          	sw	a1,-40(s0)
    82bc:	1a1017b7          	lui	a5,0x1a101
    82c0:	07a1                	addi	a5,a5,8
    82c2:	439c                	lw	a5,0(a5)
    82c4:	fef42623          	sw	a5,-20(s0)
    82c8:	fd842783          	lw	a5,-40(s0)
    82cc:	ef91                	bnez	a5,82e8 <set_gpio_pin_value+0x3a>
    82ce:	fdc42783          	lw	a5,-36(s0)
    82d2:	4705                	li	a4,1
    82d4:	00f717b3          	sll	a5,a4,a5
    82d8:	fff7c713          	not	a4,a5
    82dc:	fec42783          	lw	a5,-20(s0)
    82e0:	8ff9                	and	a5,a5,a4
    82e2:	fef42623          	sw	a5,-20(s0)
    82e6:	a819                	j	82fc <set_gpio_pin_value+0x4e>
    82e8:	fdc42783          	lw	a5,-36(s0)
    82ec:	4705                	li	a4,1
    82ee:	00f71733          	sll	a4,a4,a5
    82f2:	fec42783          	lw	a5,-20(s0)
    82f6:	8fd9                	or	a5,a5,a4
    82f8:	fef42623          	sw	a5,-20(s0)
    82fc:	1a1017b7          	lui	a5,0x1a101
    8300:	07a1                	addi	a5,a5,8
    8302:	fec42703          	lw	a4,-20(s0)
    8306:	c398                	sw	a4,0(a5)
    8308:	0001                	nop
    830a:	5432                	lw	s0,44(sp)
    830c:	6145                	addi	sp,sp,48
    830e:	8082                	ret

00008310 <get_gpio_pin_value>:
    8310:	7179                	addi	sp,sp,-48
    8312:	d622                	sw	s0,44(sp)
    8314:	1800                	addi	s0,sp,48
    8316:	fca42e23          	sw	a0,-36(s0)
    831a:	1a1017b7          	lui	a5,0x1a101
    831e:	0791                	addi	a5,a5,4
    8320:	439c                	lw	a5,0(a5)
    8322:	fef42623          	sw	a5,-20(s0)
    8326:	fec42703          	lw	a4,-20(s0)
    832a:	fdc42783          	lw	a5,-36(s0)
    832e:	40f757b3          	sra	a5,a4,a5
    8332:	8b85                	andi	a5,a5,1
    8334:	fef42623          	sw	a5,-20(s0)
    8338:	fec42783          	lw	a5,-20(s0)
    833c:	853e                	mv	a0,a5
    833e:	5432                	lw	s0,44(sp)
    8340:	6145                	addi	sp,sp,48
    8342:	8082                	ret

00008344 <set_gpio_pin_irq_en>:
    8344:	7179                	addi	sp,sp,-48
    8346:	d622                	sw	s0,44(sp)
    8348:	1800                	addi	s0,sp,48
    834a:	fca42e23          	sw	a0,-36(s0)
    834e:	fcb42c23          	sw	a1,-40(s0)
    8352:	1a1017b7          	lui	a5,0x1a101
    8356:	07b1                	addi	a5,a5,12
    8358:	439c                	lw	a5,0(a5)
    835a:	fef42623          	sw	a5,-20(s0)
    835e:	fd842783          	lw	a5,-40(s0)
    8362:	ef91                	bnez	a5,837e <set_gpio_pin_irq_en+0x3a>
    8364:	fdc42783          	lw	a5,-36(s0)
    8368:	4705                	li	a4,1
    836a:	00f717b3          	sll	a5,a4,a5
    836e:	fff7c793          	not	a5,a5
    8372:	fec42703          	lw	a4,-20(s0)
    8376:	8ff9                	and	a5,a5,a4
    8378:	fef42623          	sw	a5,-20(s0)
    837c:	a819                	j	8392 <set_gpio_pin_irq_en+0x4e>
    837e:	fdc42783          	lw	a5,-36(s0)
    8382:	4705                	li	a4,1
    8384:	00f717b3          	sll	a5,a4,a5
    8388:	fec42703          	lw	a4,-20(s0)
    838c:	8fd9                	or	a5,a5,a4
    838e:	fef42623          	sw	a5,-20(s0)
    8392:	1a1017b7          	lui	a5,0x1a101
    8396:	07b1                	addi	a5,a5,12
    8398:	fec42703          	lw	a4,-20(s0)
    839c:	c398                	sw	a4,0(a5)
    839e:	0001                	nop
    83a0:	5432                	lw	s0,44(sp)
    83a2:	6145                	addi	sp,sp,48
    83a4:	8082                	ret

000083a6 <set_gpio_pin_irq_type>:
    83a6:	7179                	addi	sp,sp,-48
    83a8:	d622                	sw	s0,44(sp)
    83aa:	1800                	addi	s0,sp,48
    83ac:	fca42e23          	sw	a0,-36(s0)
    83b0:	fcb42c23          	sw	a1,-40(s0)
    83b4:	1a1017b7          	lui	a5,0x1a101
    83b8:	07c1                	addi	a5,a5,16
    83ba:	439c                	lw	a5,0(a5)
    83bc:	fef42623          	sw	a5,-20(s0)
    83c0:	1a1017b7          	lui	a5,0x1a101
    83c4:	07d1                	addi	a5,a5,20
    83c6:	439c                	lw	a5,0(a5)
    83c8:	fef42423          	sw	a5,-24(s0)
    83cc:	fd842783          	lw	a5,-40(s0)
    83d0:	8b85                	andi	a5,a5,1
    83d2:	ef91                	bnez	a5,83ee <set_gpio_pin_irq_type+0x48>
    83d4:	fdc42783          	lw	a5,-36(s0)
    83d8:	4705                	li	a4,1
    83da:	00f717b3          	sll	a5,a4,a5
    83de:	fff7c793          	not	a5,a5
    83e2:	fec42703          	lw	a4,-20(s0)
    83e6:	8ff9                	and	a5,a5,a4
    83e8:	fef42623          	sw	a5,-20(s0)
    83ec:	a819                	j	8402 <set_gpio_pin_irq_type+0x5c>
    83ee:	fdc42783          	lw	a5,-36(s0)
    83f2:	4705                	li	a4,1
    83f4:	00f717b3          	sll	a5,a4,a5
    83f8:	fec42703          	lw	a4,-20(s0)
    83fc:	8fd9                	or	a5,a5,a4
    83fe:	fef42623          	sw	a5,-20(s0)
    8402:	fd842783          	lw	a5,-40(s0)
    8406:	8b89                	andi	a5,a5,2
    8408:	ef91                	bnez	a5,8424 <set_gpio_pin_irq_type+0x7e>
    840a:	fdc42783          	lw	a5,-36(s0)
    840e:	4705                	li	a4,1
    8410:	00f717b3          	sll	a5,a4,a5
    8414:	fff7c793          	not	a5,a5
    8418:	fe842703          	lw	a4,-24(s0)
    841c:	8ff9                	and	a5,a5,a4
    841e:	fef42423          	sw	a5,-24(s0)
    8422:	a819                	j	8438 <set_gpio_pin_irq_type+0x92>
    8424:	fdc42783          	lw	a5,-36(s0)
    8428:	4705                	li	a4,1
    842a:	00f717b3          	sll	a5,a4,a5
    842e:	fe842703          	lw	a4,-24(s0)
    8432:	8fd9                	or	a5,a5,a4
    8434:	fef42423          	sw	a5,-24(s0)
    8438:	1a1017b7          	lui	a5,0x1a101
    843c:	07c1                	addi	a5,a5,16
    843e:	fec42703          	lw	a4,-20(s0)
    8442:	c398                	sw	a4,0(a5)
    8444:	1a1017b7          	lui	a5,0x1a101
    8448:	07d1                	addi	a5,a5,20
    844a:	fe842703          	lw	a4,-24(s0)
    844e:	c398                	sw	a4,0(a5)
    8450:	0001                	nop
    8452:	5432                	lw	s0,44(sp)
    8454:	6145                	addi	sp,sp,48
    8456:	8082                	ret

00008458 <get_gpio_irq_status>:
    8458:	1141                	addi	sp,sp,-16
    845a:	c622                	sw	s0,12(sp)
    845c:	0800                	addi	s0,sp,16
    845e:	1a1017b7          	lui	a5,0x1a101
    8462:	07e1                	addi	a5,a5,24
    8464:	439c                	lw	a5,0(a5)
    8466:	853e                	mv	a0,a5
    8468:	4432                	lw	s0,12(sp)
    846a:	0141                	addi	sp,sp,16
    846c:	8082                	ret

0000846e <__CTOR_LIST__>:
	...

00008476 <__CTOR_END__>:
	...

Disassembly of section .rodata:

0000847e <.rodata>:
	...

Disassembly of section .stack:

00106000 <_stack-0x1000>:
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2541                	jal	680 <__DYNAMIC+0x680>
   2:	0000                	unimp
   4:	7200                	flw	fs0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <__DYNAMIC+0x14>
   c:	0000001b          	0x1b
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	fld	ft6,376(sp)
  16:	6932                	flw	fs2,12(sp)
  18:	7032                	flw	ft0,44(sp)
  1a:	5f30                	lw	a2,120(a4)
  1c:	326d                	jal	fffff9c6 <_stack_start+0xffef79c6>
  1e:	3070                	fld	fa2,224(s0)
  20:	635f 7032 0030      	0x307032635f

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3120                	fld	fs0,96(a0)
   c:	2e30                	fld	fa2,88(a2)
   e:	2e31                	jal	32a <__DYNAMIC+0x32a>
  10:	0030                	addi	a2,sp,8
