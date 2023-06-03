
boot_code.elf:     file format elf32-littleriscv


Disassembly of section .vectors:

00010000 <_stack_start-0xf8000>:
   10000:	00000013          	nop
   10004:	00000013          	nop
   10008:	00000013          	nop
   1000c:	00000013          	nop
   10010:	00000013          	nop
   10014:	00000013          	nop
   10018:	00000013          	nop
   1001c:	00000013          	nop
   10020:	00000013          	nop
   10024:	00000013          	nop
   10028:	00000013          	nop
   1002c:	00000013          	nop
   10030:	00000013          	nop
   10034:	00000013          	nop
   10038:	00000013          	nop
   1003c:	00000013          	nop
   10040:	00000013          	nop
   10044:	00000013          	nop
   10048:	00000013          	nop
   1004c:	00000013          	nop
   10050:	00000013          	nop
   10054:	00000013          	nop
   10058:	00000013          	nop
   1005c:	00000013          	nop
   10060:	00000013          	nop
   10064:	00000013          	nop
   10068:	00000013          	nop
   1006c:	00000013          	nop
   10070:	00000013          	nop
   10074:	00000013          	nop
   10078:	00000013          	nop
   1007c:	0100006f          	j	1008c <_stext>
   10080:	0100006f          	j	10090 <reset_handler>
   10084:	0080006f          	j	1008c <_stext>
   10088:	0040006f          	j	1008c <_stext>

Disassembly of section .text:

0001008c <_stext>:
   1008c:	0000006f          	j	1008c <_stext>

00010090 <reset_handler>:
   10090:	00000093          	li	ra,0
   10094:	8106                	mv	sp,ra
   10096:	8186                	mv	gp,ra
   10098:	8206                	mv	tp,ra
   1009a:	8286                	mv	t0,ra
   1009c:	8306                	mv	t1,ra
   1009e:	8386                	mv	t2,ra
   100a0:	8406                	mv	s0,ra
   100a2:	8486                	mv	s1,ra
   100a4:	8506                	mv	a0,ra
   100a6:	8586                	mv	a1,ra
   100a8:	8606                	mv	a2,ra
   100aa:	8686                	mv	a3,ra
   100ac:	8706                	mv	a4,ra
   100ae:	8786                	mv	a5,ra
   100b0:	8806                	mv	a6,ra
   100b2:	8886                	mv	a7,ra
   100b4:	8906                	mv	s2,ra
   100b6:	8986                	mv	s3,ra
   100b8:	8a06                	mv	s4,ra
   100ba:	8a86                	mv	s5,ra
   100bc:	8b06                	mv	s6,ra
   100be:	8b86                	mv	s7,ra
   100c0:	8c06                	mv	s8,ra
   100c2:	8c86                	mv	s9,ra
   100c4:	8d06                	mv	s10,ra
   100c6:	8d86                	mv	s11,ra
   100c8:	8e06                	mv	t3,ra
   100ca:	8e86                	mv	t4,ra
   100cc:	8f06                	mv	t5,ra
   100ce:	8f86                	mv	t6,ra
   100d0:	000f8117          	auipc	sp,0xf8
   100d4:	f3010113          	addi	sp,sp,-208 # 108000 <_stack_start>

000100d8 <_start>:
   100d8:	00000d17          	auipc	s10,0x0
   100dc:	3a8d0d13          	addi	s10,s10,936 # 10480 <_bss_end>
   100e0:	00000d97          	auipc	s11,0x0
   100e4:	3a0d8d93          	addi	s11,s11,928 # 10480 <_bss_end>
   100e8:	01bd5763          	bge	s10,s11,100f6 <main_entry>

000100ec <zero_loop>:
   100ec:	000d2023          	sw	zero,0(s10)
   100f0:	0d11                	addi	s10,s10,4
   100f2:	ffaddde3          	bge	s11,s10,100ec <zero_loop>

000100f6 <main_entry>:
   100f6:	00000513          	li	a0,0
   100fa:	00000593          	li	a1,0
   100fe:	004000ef          	jal	ra,10102 <main>

00010102 <main>:
   10102:	1101                	addi	sp,sp,-32
   10104:	ce06                	sw	ra,28(sp)
   10106:	cc22                	sw	s0,24(sp)
   10108:	1000                	addi	s0,sp,32
   1010a:	4585                	li	a1,1
   1010c:	457d                	li	a0,31
   1010e:	2051                	jal	10192 <set_pin_function>
   10110:	4585                	li	a1,1
   10112:	457d                	li	a0,31
   10114:	2221                	jal	1021c <set_gpio_pin_direction>
   10116:	4581                	li	a1,0
   10118:	457d                	li	a0,31
   1011a:	2a51                	jal	102ae <set_gpio_pin_value>
   1011c:	fe042623          	sw	zero,-20(s0)
   10120:	a039                	j	1012e <main+0x2c>
   10122:	0001                	nop
   10124:	fec42783          	lw	a5,-20(s0)
   10128:	0785                	addi	a5,a5,1
   1012a:	fef42623          	sw	a5,-20(s0)
   1012e:	fec42703          	lw	a4,-20(s0)
   10132:	47a5                	li	a5,9
   10134:	fee7d7e3          	bge	a5,a4,10122 <main+0x20>
   10138:	4585                	li	a1,1
   1013a:	457d                	li	a0,31
   1013c:	2a8d                	jal	102ae <set_gpio_pin_value>
   1013e:	fe042423          	sw	zero,-24(s0)
   10142:	a039                	j	10150 <main+0x4e>
   10144:	0001                	nop
   10146:	fe842783          	lw	a5,-24(s0)
   1014a:	0785                	addi	a5,a5,1
   1014c:	fef42423          	sw	a5,-24(s0)
   10150:	fe842703          	lw	a4,-24(s0)
   10154:	47a5                	li	a5,9
   10156:	fee7d7e3          	bge	a5,a4,10144 <main+0x42>
   1015a:	4581                	li	a1,0
   1015c:	457d                	li	a0,31
   1015e:	2a81                	jal	102ae <set_gpio_pin_value>
   10160:	08000513          	li	a0,128
   10164:	2039                	jal	10172 <jump_and_start>
   10166:	4781                	li	a5,0
   10168:	853e                	mv	a0,a5
   1016a:	40f2                	lw	ra,28(sp)
   1016c:	4462                	lw	s0,24(sp)
   1016e:	6105                	addi	sp,sp,32
   10170:	8082                	ret

00010172 <jump_and_start>:
   10172:	1101                	addi	sp,sp,-32
   10174:	ce22                	sw	s0,28(sp)
   10176:	1000                	addi	s0,sp,32
   10178:	fea42623          	sw	a0,-20(s0)
   1017c:	fec42783          	lw	a5,-20(s0)
   10180:	00078067          	jr	a5
   10184:	0001                	nop
   10186:	0001                	nop
   10188:	0001                	nop
   1018a:	0001                	nop
   1018c:	4472                	lw	s0,28(sp)
   1018e:	6105                	addi	sp,sp,32
   10190:	8082                	ret

00010192 <set_pin_function>:
   10192:	7179                	addi	sp,sp,-48
   10194:	d622                	sw	s0,44(sp)
   10196:	1800                	addi	s0,sp,48
   10198:	fca42e23          	sw	a0,-36(s0)
   1019c:	fcb42c23          	sw	a1,-40(s0)
   101a0:	1a1077b7          	lui	a5,0x1a107
   101a4:	439c                	lw	a5,0(a5)
   101a6:	fef42623          	sw	a5,-20(s0)
   101aa:	fdc42783          	lw	a5,-36(s0)
   101ae:	4705                	li	a4,1
   101b0:	00f717b3          	sll	a5,a4,a5
   101b4:	fff7c713          	not	a4,a5
   101b8:	fec42783          	lw	a5,-20(s0)
   101bc:	8ff9                	and	a5,a5,a4
   101be:	fef42623          	sw	a5,-20(s0)
   101c2:	fdc42783          	lw	a5,-36(s0)
   101c6:	fd842703          	lw	a4,-40(s0)
   101ca:	00f71733          	sll	a4,a4,a5
   101ce:	fec42783          	lw	a5,-20(s0)
   101d2:	8fd9                	or	a5,a5,a4
   101d4:	fef42623          	sw	a5,-20(s0)
   101d8:	1a1077b7          	lui	a5,0x1a107
   101dc:	fec42703          	lw	a4,-20(s0)
   101e0:	c398                	sw	a4,0(a5)
   101e2:	0001                	nop
   101e4:	5432                	lw	s0,44(sp)
   101e6:	6145                	addi	sp,sp,48
   101e8:	8082                	ret

000101ea <get_pin_function>:
   101ea:	7179                	addi	sp,sp,-48
   101ec:	d622                	sw	s0,44(sp)
   101ee:	1800                	addi	s0,sp,48
   101f0:	fca42e23          	sw	a0,-36(s0)
   101f4:	1a1077b7          	lui	a5,0x1a107
   101f8:	439c                	lw	a5,0(a5)
   101fa:	fef42623          	sw	a5,-20(s0)
   101fe:	fec42703          	lw	a4,-20(s0)
   10202:	fdc42783          	lw	a5,-36(s0)
   10206:	40f757b3          	sra	a5,a4,a5
   1020a:	8b85                	andi	a5,a5,1
   1020c:	fef42623          	sw	a5,-20(s0)
   10210:	fec42783          	lw	a5,-20(s0)
   10214:	853e                	mv	a0,a5
   10216:	5432                	lw	s0,44(sp)
   10218:	6145                	addi	sp,sp,48
   1021a:	8082                	ret

0001021c <set_gpio_pin_direction>:
   1021c:	7179                	addi	sp,sp,-48
   1021e:	d622                	sw	s0,44(sp)
   10220:	1800                	addi	s0,sp,48
   10222:	fca42e23          	sw	a0,-36(s0)
   10226:	fcb42c23          	sw	a1,-40(s0)
   1022a:	1a1017b7          	lui	a5,0x1a101
   1022e:	439c                	lw	a5,0(a5)
   10230:	fef42623          	sw	a5,-20(s0)
   10234:	fd842783          	lw	a5,-40(s0)
   10238:	ef91                	bnez	a5,10254 <set_gpio_pin_direction+0x38>
   1023a:	fdc42783          	lw	a5,-36(s0)
   1023e:	4705                	li	a4,1
   10240:	00f717b3          	sll	a5,a4,a5
   10244:	fff7c713          	not	a4,a5
   10248:	fec42783          	lw	a5,-20(s0)
   1024c:	8ff9                	and	a5,a5,a4
   1024e:	fef42623          	sw	a5,-20(s0)
   10252:	a819                	j	10268 <set_gpio_pin_direction+0x4c>
   10254:	fdc42783          	lw	a5,-36(s0)
   10258:	4705                	li	a4,1
   1025a:	00f71733          	sll	a4,a4,a5
   1025e:	fec42783          	lw	a5,-20(s0)
   10262:	8fd9                	or	a5,a5,a4
   10264:	fef42623          	sw	a5,-20(s0)
   10268:	1a1017b7          	lui	a5,0x1a101
   1026c:	fec42703          	lw	a4,-20(s0)
   10270:	c398                	sw	a4,0(a5)
   10272:	0001                	nop
   10274:	5432                	lw	s0,44(sp)
   10276:	6145                	addi	sp,sp,48
   10278:	8082                	ret

0001027a <get_gpio_pin_direction>:
   1027a:	7179                	addi	sp,sp,-48
   1027c:	d622                	sw	s0,44(sp)
   1027e:	1800                	addi	s0,sp,48
   10280:	fca42e23          	sw	a0,-36(s0)
   10284:	1a1017b7          	lui	a5,0x1a101
   10288:	439c                	lw	a5,0(a5)
   1028a:	fef42623          	sw	a5,-20(s0)
   1028e:	fec42703          	lw	a4,-20(s0)
   10292:	fdc42783          	lw	a5,-36(s0)
   10296:	0786                	slli	a5,a5,0x1
   10298:	40f757b3          	sra	a5,a4,a5
   1029c:	8b85                	andi	a5,a5,1
   1029e:	fef42623          	sw	a5,-20(s0)
   102a2:	fec42783          	lw	a5,-20(s0)
   102a6:	853e                	mv	a0,a5
   102a8:	5432                	lw	s0,44(sp)
   102aa:	6145                	addi	sp,sp,48
   102ac:	8082                	ret

000102ae <set_gpio_pin_value>:
   102ae:	7179                	addi	sp,sp,-48
   102b0:	d622                	sw	s0,44(sp)
   102b2:	1800                	addi	s0,sp,48
   102b4:	fca42e23          	sw	a0,-36(s0)
   102b8:	fcb42c23          	sw	a1,-40(s0)
   102bc:	1a1017b7          	lui	a5,0x1a101
   102c0:	07a1                	addi	a5,a5,8
   102c2:	439c                	lw	a5,0(a5)
   102c4:	fef42623          	sw	a5,-20(s0)
   102c8:	fd842783          	lw	a5,-40(s0)
   102cc:	ef91                	bnez	a5,102e8 <set_gpio_pin_value+0x3a>
   102ce:	fdc42783          	lw	a5,-36(s0)
   102d2:	4705                	li	a4,1
   102d4:	00f717b3          	sll	a5,a4,a5
   102d8:	fff7c713          	not	a4,a5
   102dc:	fec42783          	lw	a5,-20(s0)
   102e0:	8ff9                	and	a5,a5,a4
   102e2:	fef42623          	sw	a5,-20(s0)
   102e6:	a819                	j	102fc <set_gpio_pin_value+0x4e>
   102e8:	fdc42783          	lw	a5,-36(s0)
   102ec:	4705                	li	a4,1
   102ee:	00f71733          	sll	a4,a4,a5
   102f2:	fec42783          	lw	a5,-20(s0)
   102f6:	8fd9                	or	a5,a5,a4
   102f8:	fef42623          	sw	a5,-20(s0)
   102fc:	1a1017b7          	lui	a5,0x1a101
   10300:	07a1                	addi	a5,a5,8
   10302:	fec42703          	lw	a4,-20(s0)
   10306:	c398                	sw	a4,0(a5)
   10308:	0001                	nop
   1030a:	5432                	lw	s0,44(sp)
   1030c:	6145                	addi	sp,sp,48
   1030e:	8082                	ret

00010310 <get_gpio_pin_value>:
   10310:	7179                	addi	sp,sp,-48
   10312:	d622                	sw	s0,44(sp)
   10314:	1800                	addi	s0,sp,48
   10316:	fca42e23          	sw	a0,-36(s0)
   1031a:	1a1017b7          	lui	a5,0x1a101
   1031e:	0791                	addi	a5,a5,4
   10320:	439c                	lw	a5,0(a5)
   10322:	fef42623          	sw	a5,-20(s0)
   10326:	fec42703          	lw	a4,-20(s0)
   1032a:	fdc42783          	lw	a5,-36(s0)
   1032e:	40f757b3          	sra	a5,a4,a5
   10332:	8b85                	andi	a5,a5,1
   10334:	fef42623          	sw	a5,-20(s0)
   10338:	fec42783          	lw	a5,-20(s0)
   1033c:	853e                	mv	a0,a5
   1033e:	5432                	lw	s0,44(sp)
   10340:	6145                	addi	sp,sp,48
   10342:	8082                	ret

00010344 <set_gpio_pin_irq_en>:
   10344:	7179                	addi	sp,sp,-48
   10346:	d622                	sw	s0,44(sp)
   10348:	1800                	addi	s0,sp,48
   1034a:	fca42e23          	sw	a0,-36(s0)
   1034e:	fcb42c23          	sw	a1,-40(s0)
   10352:	1a1017b7          	lui	a5,0x1a101
   10356:	07b1                	addi	a5,a5,12
   10358:	439c                	lw	a5,0(a5)
   1035a:	fef42623          	sw	a5,-20(s0)
   1035e:	fd842783          	lw	a5,-40(s0)
   10362:	ef91                	bnez	a5,1037e <set_gpio_pin_irq_en+0x3a>
   10364:	fdc42783          	lw	a5,-36(s0)
   10368:	4705                	li	a4,1
   1036a:	00f717b3          	sll	a5,a4,a5
   1036e:	fff7c793          	not	a5,a5
   10372:	fec42703          	lw	a4,-20(s0)
   10376:	8ff9                	and	a5,a5,a4
   10378:	fef42623          	sw	a5,-20(s0)
   1037c:	a819                	j	10392 <set_gpio_pin_irq_en+0x4e>
   1037e:	fdc42783          	lw	a5,-36(s0)
   10382:	4705                	li	a4,1
   10384:	00f717b3          	sll	a5,a4,a5
   10388:	fec42703          	lw	a4,-20(s0)
   1038c:	8fd9                	or	a5,a5,a4
   1038e:	fef42623          	sw	a5,-20(s0)
   10392:	1a1017b7          	lui	a5,0x1a101
   10396:	07b1                	addi	a5,a5,12
   10398:	fec42703          	lw	a4,-20(s0)
   1039c:	c398                	sw	a4,0(a5)
   1039e:	0001                	nop
   103a0:	5432                	lw	s0,44(sp)
   103a2:	6145                	addi	sp,sp,48
   103a4:	8082                	ret

000103a6 <set_gpio_pin_irq_type>:
   103a6:	7179                	addi	sp,sp,-48
   103a8:	d622                	sw	s0,44(sp)
   103aa:	1800                	addi	s0,sp,48
   103ac:	fca42e23          	sw	a0,-36(s0)
   103b0:	fcb42c23          	sw	a1,-40(s0)
   103b4:	1a1017b7          	lui	a5,0x1a101
   103b8:	07c1                	addi	a5,a5,16
   103ba:	439c                	lw	a5,0(a5)
   103bc:	fef42623          	sw	a5,-20(s0)
   103c0:	1a1017b7          	lui	a5,0x1a101
   103c4:	07d1                	addi	a5,a5,20
   103c6:	439c                	lw	a5,0(a5)
   103c8:	fef42423          	sw	a5,-24(s0)
   103cc:	fd842783          	lw	a5,-40(s0)
   103d0:	8b85                	andi	a5,a5,1
   103d2:	ef91                	bnez	a5,103ee <set_gpio_pin_irq_type+0x48>
   103d4:	fdc42783          	lw	a5,-36(s0)
   103d8:	4705                	li	a4,1
   103da:	00f717b3          	sll	a5,a4,a5
   103de:	fff7c793          	not	a5,a5
   103e2:	fec42703          	lw	a4,-20(s0)
   103e6:	8ff9                	and	a5,a5,a4
   103e8:	fef42623          	sw	a5,-20(s0)
   103ec:	a819                	j	10402 <set_gpio_pin_irq_type+0x5c>
   103ee:	fdc42783          	lw	a5,-36(s0)
   103f2:	4705                	li	a4,1
   103f4:	00f717b3          	sll	a5,a4,a5
   103f8:	fec42703          	lw	a4,-20(s0)
   103fc:	8fd9                	or	a5,a5,a4
   103fe:	fef42623          	sw	a5,-20(s0)
   10402:	fd842783          	lw	a5,-40(s0)
   10406:	8b89                	andi	a5,a5,2
   10408:	ef91                	bnez	a5,10424 <set_gpio_pin_irq_type+0x7e>
   1040a:	fdc42783          	lw	a5,-36(s0)
   1040e:	4705                	li	a4,1
   10410:	00f717b3          	sll	a5,a4,a5
   10414:	fff7c793          	not	a5,a5
   10418:	fe842703          	lw	a4,-24(s0)
   1041c:	8ff9                	and	a5,a5,a4
   1041e:	fef42423          	sw	a5,-24(s0)
   10422:	a819                	j	10438 <set_gpio_pin_irq_type+0x92>
   10424:	fdc42783          	lw	a5,-36(s0)
   10428:	4705                	li	a4,1
   1042a:	00f717b3          	sll	a5,a4,a5
   1042e:	fe842703          	lw	a4,-24(s0)
   10432:	8fd9                	or	a5,a5,a4
   10434:	fef42423          	sw	a5,-24(s0)
   10438:	1a1017b7          	lui	a5,0x1a101
   1043c:	07c1                	addi	a5,a5,16
   1043e:	fec42703          	lw	a4,-20(s0)
   10442:	c398                	sw	a4,0(a5)
   10444:	1a1017b7          	lui	a5,0x1a101
   10448:	07d1                	addi	a5,a5,20
   1044a:	fe842703          	lw	a4,-24(s0)
   1044e:	c398                	sw	a4,0(a5)
   10450:	0001                	nop
   10452:	5432                	lw	s0,44(sp)
   10454:	6145                	addi	sp,sp,48
   10456:	8082                	ret

00010458 <get_gpio_irq_status>:
   10458:	1141                	addi	sp,sp,-16
   1045a:	c622                	sw	s0,12(sp)
   1045c:	0800                	addi	s0,sp,16
   1045e:	1a1017b7          	lui	a5,0x1a101
   10462:	07e1                	addi	a5,a5,24
   10464:	439c                	lw	a5,0(a5)
   10466:	853e                	mv	a0,a5
   10468:	4432                	lw	s0,12(sp)
   1046a:	0141                	addi	sp,sp,16
   1046c:	8082                	ret

0001046e <__CTOR_LIST__>:
	...

00010476 <__CTOR_END__>:
	...

Disassembly of section .rodata:

0001047e <.rodata>:
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
