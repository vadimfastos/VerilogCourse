
test_sw_emb.elf:     file format elf32-littleriscv


Disassembly of section .vectors:

00000000 <_stack_start-0x108000>:
   0:	00000013          	nop
   4:	00000013          	nop
   8:	00000013          	nop
   c:	00000013          	nop
  10:	00000013          	nop
  14:	00000013          	nop
  18:	00000013          	nop
  1c:	00000013          	nop
  20:	00000013          	nop
  24:	00000013          	nop
  28:	00000013          	nop
  2c:	00000013          	nop
  30:	00000013          	nop
  34:	00000013          	nop
  38:	00000013          	nop
  3c:	00000013          	nop
  40:	00000013          	nop
  44:	00000013          	nop
  48:	00000013          	nop
  4c:	00000013          	nop
  50:	00000013          	nop
  54:	00000013          	nop
  58:	00000013          	nop
  5c:	0c20006f          	j	11e <ISR_I2C_ASM>
  60:	0d20006f          	j	132 <ISR_UART_ASM>
  64:	0e20006f          	j	146 <ISR_GPIO_ASM>
  68:	0f20006f          	j	15a <ISR_SPIM0_ASM>
  6c:	1020006f          	j	16e <ISR_SPIM1_ASM>
  70:	1260006f          	j	196 <ISR_TA_OVF_ASM>
  74:	10e0006f          	j	182 <ISR_TA_CMP_ASM>
  78:	1460006f          	j	1be <ISR_TB_OVF_ASM>
  7c:	12e0006f          	j	1aa <ISR_TB_CMP_ASM>
  80:	00c0006f          	j	8c <_stext>
  84:	14e0006f          	j	1d2 <illegal_insn_handler>
  88:	15e0006f          	j	1e6 <ecall_insn_handler>

Disassembly of section .text:

0000008c <_stext>:
      8c:	30501073          	csrw	mtvec,zero
      90:	00000093          	li	ra,0
      94:	8106                	mv	sp,ra
      96:	8186                	mv	gp,ra
      98:	8206                	mv	tp,ra
      9a:	8286                	mv	t0,ra
      9c:	8306                	mv	t1,ra
      9e:	8386                	mv	t2,ra
      a0:	8406                	mv	s0,ra
      a2:	8486                	mv	s1,ra
      a4:	8506                	mv	a0,ra
      a6:	8586                	mv	a1,ra
      a8:	8606                	mv	a2,ra
      aa:	8686                	mv	a3,ra
      ac:	8706                	mv	a4,ra
      ae:	8786                	mv	a5,ra
      b0:	8806                	mv	a6,ra
      b2:	8886                	mv	a7,ra
      b4:	8906                	mv	s2,ra
      b6:	8986                	mv	s3,ra
      b8:	8a06                	mv	s4,ra
      ba:	8a86                	mv	s5,ra
      bc:	8b06                	mv	s6,ra
      be:	8b86                	mv	s7,ra
      c0:	8c06                	mv	s8,ra
      c2:	8c86                	mv	s9,ra
      c4:	8d06                	mv	s10,ra
      c6:	8d86                	mv	s11,ra
      c8:	8e06                	mv	t3,ra
      ca:	8e86                	mv	t4,ra
      cc:	8f06                	mv	t5,ra
      ce:	8f86                	mv	t6,ra
      d0:	00108117          	auipc	sp,0x108
      d4:	f3010113          	addi	sp,sp,-208 # 108000 <_stack_start>

000000d8 <_start>:
      d8:	00100d17          	auipc	s10,0x100
      dc:	f40d0d13          	addi	s10,s10,-192 # 100018 <KUZNECHIK>
      e0:	00100d97          	auipc	s11,0x100
      e4:	f3cd8d93          	addi	s11,s11,-196 # 10001c <_bss_end>
      e8:	01bd5763          	bge	s10,s11,f6 <zero_loop_end>

000000ec <zero_loop>:
      ec:	000d2023          	sw	zero,0(s10)
      f0:	0d11                	addi	s10,s10,4
      f2:	ffaddde3          	bge	s11,s10,ec <zero_loop>

000000f6 <zero_loop_end>:
      f6:	1c2010ef          	jal	ra,12b8 <__libc_init_array>

000000fa <main_entry>:
      fa:	00000513          	li	a0,0
      fe:	00100593          	li	a1,1
     102:	6a4000ef          	jal	ra,7a6 <uart_set_cfg>
     106:	00000513          	li	a0,0
     10a:	00000593          	li	a1,0
     10e:	1b8000ef          	jal	ra,2c6 <main>
     112:	842a                	mv	s0,a0
     114:	7ea000ef          	jal	ra,8fe <uart_wait_tx_done>
     118:	8522                	mv	a0,s0
     11a:	005000ef          	jal	ra,91e <exit>

0000011e <ISR_I2C_ASM>:
     11e:	711d                	addi	sp,sp,-96
     120:	ce86                	sw	ra,92(sp)
     122:	0d8000ef          	jal	ra,1fa <store_regs>
     126:	00000097          	auipc	ra,0x0
     12a:	11e08093          	addi	ra,ra,286 # 244 <end_except>
     12e:	1280106f          	j	1256 <ISR_I2C>

00000132 <ISR_UART_ASM>:
     132:	711d                	addi	sp,sp,-96
     134:	ce86                	sw	ra,92(sp)
     136:	0c4000ef          	jal	ra,1fa <store_regs>
     13a:	00000097          	auipc	ra,0x0
     13e:	10a08093          	addi	ra,ra,266 # 244 <end_except>
     142:	11c0106f          	j	125e <ISR_UART>

00000146 <ISR_GPIO_ASM>:
     146:	711d                	addi	sp,sp,-96
     148:	ce86                	sw	ra,92(sp)
     14a:	0b0000ef          	jal	ra,1fa <store_regs>
     14e:	00000097          	auipc	ra,0x0
     152:	0f608093          	addi	ra,ra,246 # 244 <end_except>
     156:	1100106f          	j	1266 <ISR_GPIO>

0000015a <ISR_SPIM0_ASM>:
     15a:	711d                	addi	sp,sp,-96
     15c:	ce86                	sw	ra,92(sp)
     15e:	09c000ef          	jal	ra,1fa <store_regs>
     162:	00000097          	auipc	ra,0x0
     166:	0e208093          	addi	ra,ra,226 # 244 <end_except>
     16a:	1040106f          	j	126e <ISR_SPIM0>

0000016e <ISR_SPIM1_ASM>:
     16e:	711d                	addi	sp,sp,-96
     170:	ce86                	sw	ra,92(sp)
     172:	088000ef          	jal	ra,1fa <store_regs>
     176:	00000097          	auipc	ra,0x0
     17a:	0ce08093          	addi	ra,ra,206 # 244 <end_except>
     17e:	0f80106f          	j	1276 <ISR_SPIM1>

00000182 <ISR_TA_CMP_ASM>:
     182:	711d                	addi	sp,sp,-96
     184:	ce86                	sw	ra,92(sp)
     186:	074000ef          	jal	ra,1fa <store_regs>
     18a:	00000097          	auipc	ra,0x0
     18e:	0ba08093          	addi	ra,ra,186 # 244 <end_except>
     192:	0f40106f          	j	1286 <ISR_TA_CMP>

00000196 <ISR_TA_OVF_ASM>:
     196:	711d                	addi	sp,sp,-96
     198:	ce86                	sw	ra,92(sp)
     19a:	060000ef          	jal	ra,1fa <store_regs>
     19e:	00000097          	auipc	ra,0x0
     1a2:	0a608093          	addi	ra,ra,166 # 244 <end_except>
     1a6:	0d80106f          	j	127e <ISR_TA_OVF>

000001aa <ISR_TB_CMP_ASM>:
     1aa:	711d                	addi	sp,sp,-96
     1ac:	ce86                	sw	ra,92(sp)
     1ae:	04c000ef          	jal	ra,1fa <store_regs>
     1b2:	00000097          	auipc	ra,0x0
     1b6:	09208093          	addi	ra,ra,146 # 244 <end_except>
     1ba:	0dc0106f          	j	1296 <ISR_TB_CMP>

000001be <ISR_TB_OVF_ASM>:
     1be:	711d                	addi	sp,sp,-96
     1c0:	ce86                	sw	ra,92(sp)
     1c2:	038000ef          	jal	ra,1fa <store_regs>
     1c6:	00000097          	auipc	ra,0x0
     1ca:	07e08093          	addi	ra,ra,126 # 244 <end_except>
     1ce:	0c00106f          	j	128e <ISR_TB_OVF>

000001d2 <illegal_insn_handler>:
     1d2:	711d                	addi	sp,sp,-96
     1d4:	ce86                	sw	ra,92(sp)
     1d6:	024000ef          	jal	ra,1fa <store_regs>
     1da:	00000097          	auipc	ra,0x0
     1de:	06a08093          	addi	ra,ra,106 # 244 <end_except>
     1e2:	0c40106f          	j	12a6 <illegal_insn_handler_c>

000001e6 <ecall_insn_handler>:
     1e6:	711d                	addi	sp,sp,-96
     1e8:	ce86                	sw	ra,92(sp)
     1ea:	010000ef          	jal	ra,1fa <store_regs>
     1ee:	00000097          	auipc	ra,0x0
     1f2:	05608093          	addi	ra,ra,86 # 244 <end_except>
     1f6:	0b80106f          	j	12ae <ecall_insn_handler_c>

000001fa <store_regs>:
     1fa:	c00e                	sw	gp,0(sp)
     1fc:	c212                	sw	tp,4(sp)
     1fe:	c416                	sw	t0,8(sp)
     200:	c61a                	sw	t1,12(sp)
     202:	c81e                	sw	t2,16(sp)
     204:	ca2a                	sw	a0,20(sp)
     206:	cc2e                	sw	a1,24(sp)
     208:	ce32                	sw	a2,28(sp)
     20a:	d036                	sw	a3,32(sp)
     20c:	d23a                	sw	a4,36(sp)
     20e:	d43e                	sw	a5,40(sp)
     210:	d642                	sw	a6,44(sp)
     212:	d846                	sw	a7,48(sp)
     214:	da72                	sw	t3,52(sp)
     216:	dc76                	sw	t4,56(sp)
     218:	de7a                	sw	t5,60(sp)
     21a:	c0fe                	sw	t6,64(sp)
     21c:	7b002e73          	csrr	t3,dcsr
     220:	7b102ef3          	csrr	t4,dpc
     224:	7b202f73          	csrr	t5,dscratch
     228:	c2f2                	sw	t3,68(sp)
     22a:	c4f6                	sw	t4,72(sp)
     22c:	c6fa                	sw	t5,76(sp)
     22e:	7b402e73          	csrr	t3,0x7b4
     232:	7b502ef3          	csrr	t4,0x7b5
     236:	7b602f73          	csrr	t5,0x7b6
     23a:	c8f2                	sw	t3,80(sp)
     23c:	caf6                	sw	t4,84(sp)
     23e:	ccfa                	sw	t5,88(sp)
     240:	00008067          	ret

00000244 <end_except>:
     244:	4e46                	lw	t3,80(sp)
     246:	4ed6                	lw	t4,84(sp)
     248:	4f66                	lw	t5,88(sp)
     24a:	7b4e1073          	csrw	0x7b4,t3
     24e:	7b5e9073          	csrw	0x7b5,t4
     252:	7b6f1073          	csrw	0x7b6,t5
     256:	4e16                	lw	t3,68(sp)
     258:	4ea6                	lw	t4,72(sp)
     25a:	4f36                	lw	t5,76(sp)
     25c:	7b0e1073          	csrw	dcsr,t3
     260:	7b1e9073          	csrw	dpc,t4
     264:	7b2f1073          	csrw	dscratch,t5
     268:	4182                	lw	gp,0(sp)
     26a:	4212                	lw	tp,4(sp)
     26c:	42a2                	lw	t0,8(sp)
     26e:	4332                	lw	t1,12(sp)
     270:	43c2                	lw	t2,16(sp)
     272:	4552                	lw	a0,20(sp)
     274:	45e2                	lw	a1,24(sp)
     276:	4672                	lw	a2,28(sp)
     278:	5682                	lw	a3,32(sp)
     27a:	5712                	lw	a4,36(sp)
     27c:	57a2                	lw	a5,40(sp)
     27e:	5832                	lw	a6,44(sp)
     280:	58c2                	lw	a7,48(sp)
     282:	5e52                	lw	t3,52(sp)
     284:	5ee2                	lw	t4,56(sp)
     286:	5f72                	lw	t5,60(sp)
     288:	4f86                	lw	t6,64(sp)
     28a:	40f6                	lw	ra,92(sp)
     28c:	6125                	addi	sp,sp,96
     28e:	30200073          	mret

00000292 <_fini>:
     292:	8082                	ret

00000294 <led_delay>:
     294:	1101                	addi	sp,sp,-32
     296:	ce22                	sw	s0,28(sp)
     298:	1000                	addi	s0,sp,32
     29a:	fe042623          	sw	zero,-20(s0)
     29e:	a039                	j	2ac <led_delay+0x18>
     2a0:	0001                	nop
     2a2:	fec42783          	lw	a5,-20(s0)
     2a6:	0785                	addi	a5,a5,1
     2a8:	fef42623          	sw	a5,-20(s0)
     2ac:	fec42703          	lw	a4,-20(s0)
     2b0:	000f47b7          	lui	a5,0xf4
     2b4:	23f78793          	addi	a5,a5,575 # f423f <_stack_len+0xf223f>
     2b8:	fee7d4e3          	bge	a5,a4,2a0 <led_delay+0xc>
     2bc:	0001                	nop
     2be:	0001                	nop
     2c0:	4472                	lw	s0,28(sp)
     2c2:	6105                	addi	sp,sp,32
     2c4:	8082                	ret

000002c6 <main>:
     2c6:	7139                	addi	sp,sp,-64
     2c8:	de06                	sw	ra,60(sp)
     2ca:	dc22                	sw	s0,56(sp)
     2cc:	0080                	addi	s0,sp,64
     2ce:	45ed                	li	a1,27
     2d0:	4501                	li	a0,0
     2d2:	29d1                	jal	7a6 <uart_set_cfg>
     2d4:	2049                	jal	356 <kuznechik_init>
     2d6:	fe042623          	sw	zero,-20(s0)
     2da:	a005                	j	2fa <main+0x34>
     2dc:	23e1                	jal	8a4 <uart_getchar>
     2de:	87aa                	mv	a5,a0
     2e0:	873e                	mv	a4,a5
     2e2:	fec42783          	lw	a5,-20(s0)
     2e6:	ff040693          	addi	a3,s0,-16
     2ea:	97b6                	add	a5,a5,a3
     2ec:	fee78623          	sb	a4,-20(a5)
     2f0:	fec42783          	lw	a5,-20(s0)
     2f4:	0785                	addi	a5,a5,1
     2f6:	fef42623          	sw	a5,-20(s0)
     2fa:	fec42703          	lw	a4,-20(s0)
     2fe:	47bd                	li	a5,15
     300:	fce7dee3          	bge	a5,a4,2dc <main+0x16>
     304:	fcc40713          	addi	a4,s0,-52
     308:	fdc40793          	addi	a5,s0,-36
     30c:	85ba                	mv	a1,a4
     30e:	853e                	mv	a0,a5
     310:	2041                	jal	390 <kuznechik_process_data_block>
     312:	87aa                	mv	a5,a0
     314:	cb81                	beqz	a5,324 <main+0x5e>
     316:	fcc40793          	addi	a5,s0,-52
     31a:	45c1                	li	a1,16
     31c:	853e                	mv	a0,a5
     31e:	2b11                	jal	832 <uart_send>
     320:	2bf9                	jal	8fe <uart_wait_tx_done>
     322:	bf55                	j	2d6 <main+0x10>
     324:	6f7277b7          	lui	a5,0x6f727
     328:	24578793          	addi	a5,a5,581 # 6f727245 <_stack_start+0x6f61f245>
     32c:	fcf42223          	sw	a5,-60(s0)
     330:	000a27b7          	lui	a5,0xa2
     334:	17278793          	addi	a5,a5,370 # a2172 <_stack_len+0xa0172>
     338:	fcf42423          	sw	a5,-56(s0)
     33c:	fc440793          	addi	a5,s0,-60
     340:	853e                	mv	a0,a5
     342:	6cd000ef          	jal	ra,120e <strlen>
     346:	872a                	mv	a4,a0
     348:	fc440793          	addi	a5,s0,-60
     34c:	85ba                	mv	a1,a4
     34e:	853e                	mv	a0,a5
     350:	21cd                	jal	832 <uart_send>
     352:	2375                	jal	8fe <uart_wait_tx_done>
     354:	b749                	j	2d6 <main+0x10>

00000356 <kuznechik_init>:
     356:	1141                	addi	sp,sp,-16
     358:	c622                	sw	s0,12(sp)
     35a:	0800                	addi	s0,sp,16
     35c:	1a1077b7          	lui	a5,0x1a107
     360:	0791                	addi	a5,a5,4
     362:	4398                	lw	a4,0(a5)
     364:	1a1077b7          	lui	a5,0x1a107
     368:	0791                	addi	a5,a5,4
     36a:	10076713          	ori	a4,a4,256
     36e:	c398                	sw	a4,0(a5)
     370:	001007b7          	lui	a5,0x100
     374:	1a108737          	lui	a4,0x1a108
     378:	00e7ac23          	sw	a4,24(a5) # 100018 <KUZNECHIK>
     37c:	001007b7          	lui	a5,0x100
     380:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     384:	4705                	li	a4,1
     386:	c398                	sw	a4,0(a5)
     388:	0001                	nop
     38a:	4432                	lw	s0,12(sp)
     38c:	0141                	addi	sp,sp,16
     38e:	8082                	ret

00000390 <kuznechik_process_data_block>:
     390:	7139                	addi	sp,sp,-64
     392:	de22                	sw	s0,60(sp)
     394:	0080                	addi	s0,sp,64
     396:	fca42623          	sw	a0,-52(s0)
     39a:	fcb42423          	sw	a1,-56(s0)
     39e:	6791                	lui	a5,0x4
     3a0:	e8078793          	addi	a5,a5,-384 # 3e80 <_stack_len+0x1e80>
     3a4:	fef42023          	sw	a5,-32(s0)
     3a8:	fe042783          	lw	a5,-32(s0)
     3ac:	fef42623          	sw	a5,-20(s0)
     3b0:	a031                	j	3bc <kuznechik_process_data_block+0x2c>
     3b2:	fec42783          	lw	a5,-20(s0)
     3b6:	17fd                	addi	a5,a5,-1
     3b8:	fef42623          	sw	a5,-20(s0)
     3bc:	fec42783          	lw	a5,-20(s0)
     3c0:	c799                	beqz	a5,3ce <kuznechik_process_data_block+0x3e>
     3c2:	001007b7          	lui	a5,0x100
     3c6:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     3ca:	4b9c                	lw	a5,16(a5)
     3cc:	f3fd                	bnez	a5,3b2 <kuznechik_process_data_block+0x22>
     3ce:	fec42783          	lw	a5,-20(s0)
     3d2:	eb89                	bnez	a5,3e4 <kuznechik_process_data_block+0x54>
     3d4:	001007b7          	lui	a5,0x100
     3d8:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     3dc:	4705                	li	a4,1
     3de:	c398                	sw	a4,0(a5)
     3e0:	4781                	li	a5,0
     3e2:	a0c5                	j	4c2 <kuznechik_process_data_block+0x132>
     3e4:	fcc42783          	lw	a5,-52(s0)
     3e8:	fcf42e23          	sw	a5,-36(s0)
     3ec:	fe042423          	sw	zero,-24(s0)
     3f0:	a03d                	j	41e <kuznechik_process_data_block+0x8e>
     3f2:	fe842783          	lw	a5,-24(s0)
     3f6:	078a                	slli	a5,a5,0x2
     3f8:	fdc42703          	lw	a4,-36(s0)
     3fc:	97ba                	add	a5,a5,a4
     3fe:	00100737          	lui	a4,0x100
     402:	01872683          	lw	a3,24(a4) # 100018 <KUZNECHIK>
     406:	4398                	lw	a4,0(a5)
     408:	fe842783          	lw	a5,-24(s0)
     40c:	0791                	addi	a5,a5,4
     40e:	078a                	slli	a5,a5,0x2
     410:	97b6                	add	a5,a5,a3
     412:	c3d8                	sw	a4,4(a5)
     414:	fe842783          	lw	a5,-24(s0)
     418:	0785                	addi	a5,a5,1
     41a:	fef42423          	sw	a5,-24(s0)
     41e:	fe842703          	lw	a4,-24(s0)
     422:	478d                	li	a5,3
     424:	fce7d7e3          	bge	a5,a4,3f2 <kuznechik_process_data_block+0x62>
     428:	001007b7          	lui	a5,0x100
     42c:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     430:	4705                	li	a4,1
     432:	c3d8                	sw	a4,4(a5)
     434:	fe042783          	lw	a5,-32(s0)
     438:	fef42623          	sw	a5,-20(s0)
     43c:	a031                	j	448 <kuznechik_process_data_block+0xb8>
     43e:	fec42783          	lw	a5,-20(s0)
     442:	17fd                	addi	a5,a5,-1
     444:	fef42623          	sw	a5,-20(s0)
     448:	fec42783          	lw	a5,-20(s0)
     44c:	c799                	beqz	a5,45a <kuznechik_process_data_block+0xca>
     44e:	001007b7          	lui	a5,0x100
     452:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     456:	47dc                	lw	a5,12(a5)
     458:	d3fd                	beqz	a5,43e <kuznechik_process_data_block+0xae>
     45a:	fec42783          	lw	a5,-20(s0)
     45e:	eb89                	bnez	a5,470 <kuznechik_process_data_block+0xe0>
     460:	001007b7          	lui	a5,0x100
     464:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     468:	4705                	li	a4,1
     46a:	c398                	sw	a4,0(a5)
     46c:	4781                	li	a5,0
     46e:	a891                	j	4c2 <kuznechik_process_data_block+0x132>
     470:	fc842783          	lw	a5,-56(s0)
     474:	fcf42c23          	sw	a5,-40(s0)
     478:	fe042223          	sw	zero,-28(s0)
     47c:	a03d                	j	4aa <kuznechik_process_data_block+0x11a>
     47e:	001007b7          	lui	a5,0x100
     482:	0187a683          	lw	a3,24(a5) # 100018 <KUZNECHIK>
     486:	fe442783          	lw	a5,-28(s0)
     48a:	078a                	slli	a5,a5,0x2
     48c:	fd842703          	lw	a4,-40(s0)
     490:	973e                	add	a4,a4,a5
     492:	fe442783          	lw	a5,-28(s0)
     496:	07a1                	addi	a5,a5,8
     498:	078a                	slli	a5,a5,0x2
     49a:	97b6                	add	a5,a5,a3
     49c:	43dc                	lw	a5,4(a5)
     49e:	c31c                	sw	a5,0(a4)
     4a0:	fe442783          	lw	a5,-28(s0)
     4a4:	0785                	addi	a5,a5,1
     4a6:	fef42223          	sw	a5,-28(s0)
     4aa:	fe442703          	lw	a4,-28(s0)
     4ae:	478d                	li	a5,3
     4b0:	fce7d7e3          	bge	a5,a4,47e <kuznechik_process_data_block+0xee>
     4b4:	001007b7          	lui	a5,0x100
     4b8:	0187a783          	lw	a5,24(a5) # 100018 <KUZNECHIK>
     4bc:	4705                	li	a4,1
     4be:	c798                	sw	a4,8(a5)
     4c0:	4785                	li	a5,1
     4c2:	853e                	mv	a0,a5
     4c4:	5472                	lw	s0,60(sp)
     4c6:	6121                	addi	sp,sp,64
     4c8:	8082                	ret

000004ca <set_pin_function>:
     4ca:	7179                	addi	sp,sp,-48
     4cc:	d622                	sw	s0,44(sp)
     4ce:	1800                	addi	s0,sp,48
     4d0:	fca42e23          	sw	a0,-36(s0)
     4d4:	fcb42c23          	sw	a1,-40(s0)
     4d8:	1a1077b7          	lui	a5,0x1a107
     4dc:	439c                	lw	a5,0(a5)
     4de:	fef42623          	sw	a5,-20(s0)
     4e2:	fdc42783          	lw	a5,-36(s0)
     4e6:	4705                	li	a4,1
     4e8:	00f717b3          	sll	a5,a4,a5
     4ec:	fff7c713          	not	a4,a5
     4f0:	fec42783          	lw	a5,-20(s0)
     4f4:	8ff9                	and	a5,a5,a4
     4f6:	fef42623          	sw	a5,-20(s0)
     4fa:	fdc42783          	lw	a5,-36(s0)
     4fe:	fd842703          	lw	a4,-40(s0)
     502:	00f71733          	sll	a4,a4,a5
     506:	fec42783          	lw	a5,-20(s0)
     50a:	8fd9                	or	a5,a5,a4
     50c:	fef42623          	sw	a5,-20(s0)
     510:	1a1077b7          	lui	a5,0x1a107
     514:	fec42703          	lw	a4,-20(s0)
     518:	c398                	sw	a4,0(a5)
     51a:	0001                	nop
     51c:	5432                	lw	s0,44(sp)
     51e:	6145                	addi	sp,sp,48
     520:	8082                	ret

00000522 <get_pin_function>:
     522:	7179                	addi	sp,sp,-48
     524:	d622                	sw	s0,44(sp)
     526:	1800                	addi	s0,sp,48
     528:	fca42e23          	sw	a0,-36(s0)
     52c:	1a1077b7          	lui	a5,0x1a107
     530:	439c                	lw	a5,0(a5)
     532:	fef42623          	sw	a5,-20(s0)
     536:	fec42703          	lw	a4,-20(s0)
     53a:	fdc42783          	lw	a5,-36(s0)
     53e:	40f757b3          	sra	a5,a4,a5
     542:	8b85                	andi	a5,a5,1
     544:	fef42623          	sw	a5,-20(s0)
     548:	fec42783          	lw	a5,-20(s0)
     54c:	853e                	mv	a0,a5
     54e:	5432                	lw	s0,44(sp)
     550:	6145                	addi	sp,sp,48
     552:	8082                	ret

00000554 <set_gpio_pin_direction>:
     554:	7179                	addi	sp,sp,-48
     556:	d622                	sw	s0,44(sp)
     558:	1800                	addi	s0,sp,48
     55a:	fca42e23          	sw	a0,-36(s0)
     55e:	fcb42c23          	sw	a1,-40(s0)
     562:	1a1017b7          	lui	a5,0x1a101
     566:	439c                	lw	a5,0(a5)
     568:	fef42623          	sw	a5,-20(s0)
     56c:	fd842783          	lw	a5,-40(s0)
     570:	ef91                	bnez	a5,58c <set_gpio_pin_direction+0x38>
     572:	fdc42783          	lw	a5,-36(s0)
     576:	4705                	li	a4,1
     578:	00f717b3          	sll	a5,a4,a5
     57c:	fff7c713          	not	a4,a5
     580:	fec42783          	lw	a5,-20(s0)
     584:	8ff9                	and	a5,a5,a4
     586:	fef42623          	sw	a5,-20(s0)
     58a:	a819                	j	5a0 <set_gpio_pin_direction+0x4c>
     58c:	fdc42783          	lw	a5,-36(s0)
     590:	4705                	li	a4,1
     592:	00f71733          	sll	a4,a4,a5
     596:	fec42783          	lw	a5,-20(s0)
     59a:	8fd9                	or	a5,a5,a4
     59c:	fef42623          	sw	a5,-20(s0)
     5a0:	1a1017b7          	lui	a5,0x1a101
     5a4:	fec42703          	lw	a4,-20(s0)
     5a8:	c398                	sw	a4,0(a5)
     5aa:	0001                	nop
     5ac:	5432                	lw	s0,44(sp)
     5ae:	6145                	addi	sp,sp,48
     5b0:	8082                	ret

000005b2 <get_gpio_pin_direction>:
     5b2:	7179                	addi	sp,sp,-48
     5b4:	d622                	sw	s0,44(sp)
     5b6:	1800                	addi	s0,sp,48
     5b8:	fca42e23          	sw	a0,-36(s0)
     5bc:	1a1017b7          	lui	a5,0x1a101
     5c0:	439c                	lw	a5,0(a5)
     5c2:	fef42623          	sw	a5,-20(s0)
     5c6:	fec42703          	lw	a4,-20(s0)
     5ca:	fdc42783          	lw	a5,-36(s0)
     5ce:	0786                	slli	a5,a5,0x1
     5d0:	40f757b3          	sra	a5,a4,a5
     5d4:	8b85                	andi	a5,a5,1
     5d6:	fef42623          	sw	a5,-20(s0)
     5da:	fec42783          	lw	a5,-20(s0)
     5de:	853e                	mv	a0,a5
     5e0:	5432                	lw	s0,44(sp)
     5e2:	6145                	addi	sp,sp,48
     5e4:	8082                	ret

000005e6 <set_gpio_pin_value>:
     5e6:	7179                	addi	sp,sp,-48
     5e8:	d622                	sw	s0,44(sp)
     5ea:	1800                	addi	s0,sp,48
     5ec:	fca42e23          	sw	a0,-36(s0)
     5f0:	fcb42c23          	sw	a1,-40(s0)
     5f4:	1a1017b7          	lui	a5,0x1a101
     5f8:	07a1                	addi	a5,a5,8
     5fa:	439c                	lw	a5,0(a5)
     5fc:	fef42623          	sw	a5,-20(s0)
     600:	fd842783          	lw	a5,-40(s0)
     604:	ef91                	bnez	a5,620 <set_gpio_pin_value+0x3a>
     606:	fdc42783          	lw	a5,-36(s0)
     60a:	4705                	li	a4,1
     60c:	00f717b3          	sll	a5,a4,a5
     610:	fff7c713          	not	a4,a5
     614:	fec42783          	lw	a5,-20(s0)
     618:	8ff9                	and	a5,a5,a4
     61a:	fef42623          	sw	a5,-20(s0)
     61e:	a819                	j	634 <set_gpio_pin_value+0x4e>
     620:	fdc42783          	lw	a5,-36(s0)
     624:	4705                	li	a4,1
     626:	00f71733          	sll	a4,a4,a5
     62a:	fec42783          	lw	a5,-20(s0)
     62e:	8fd9                	or	a5,a5,a4
     630:	fef42623          	sw	a5,-20(s0)
     634:	1a1017b7          	lui	a5,0x1a101
     638:	07a1                	addi	a5,a5,8
     63a:	fec42703          	lw	a4,-20(s0)
     63e:	c398                	sw	a4,0(a5)
     640:	0001                	nop
     642:	5432                	lw	s0,44(sp)
     644:	6145                	addi	sp,sp,48
     646:	8082                	ret

00000648 <get_gpio_pin_value>:
     648:	7179                	addi	sp,sp,-48
     64a:	d622                	sw	s0,44(sp)
     64c:	1800                	addi	s0,sp,48
     64e:	fca42e23          	sw	a0,-36(s0)
     652:	1a1017b7          	lui	a5,0x1a101
     656:	0791                	addi	a5,a5,4
     658:	439c                	lw	a5,0(a5)
     65a:	fef42623          	sw	a5,-20(s0)
     65e:	fec42703          	lw	a4,-20(s0)
     662:	fdc42783          	lw	a5,-36(s0)
     666:	40f757b3          	sra	a5,a4,a5
     66a:	8b85                	andi	a5,a5,1
     66c:	fef42623          	sw	a5,-20(s0)
     670:	fec42783          	lw	a5,-20(s0)
     674:	853e                	mv	a0,a5
     676:	5432                	lw	s0,44(sp)
     678:	6145                	addi	sp,sp,48
     67a:	8082                	ret

0000067c <set_gpio_pin_irq_en>:
     67c:	7179                	addi	sp,sp,-48
     67e:	d622                	sw	s0,44(sp)
     680:	1800                	addi	s0,sp,48
     682:	fca42e23          	sw	a0,-36(s0)
     686:	fcb42c23          	sw	a1,-40(s0)
     68a:	1a1017b7          	lui	a5,0x1a101
     68e:	07b1                	addi	a5,a5,12
     690:	439c                	lw	a5,0(a5)
     692:	fef42623          	sw	a5,-20(s0)
     696:	fd842783          	lw	a5,-40(s0)
     69a:	ef91                	bnez	a5,6b6 <set_gpio_pin_irq_en+0x3a>
     69c:	fdc42783          	lw	a5,-36(s0)
     6a0:	4705                	li	a4,1
     6a2:	00f717b3          	sll	a5,a4,a5
     6a6:	fff7c793          	not	a5,a5
     6aa:	fec42703          	lw	a4,-20(s0)
     6ae:	8ff9                	and	a5,a5,a4
     6b0:	fef42623          	sw	a5,-20(s0)
     6b4:	a819                	j	6ca <set_gpio_pin_irq_en+0x4e>
     6b6:	fdc42783          	lw	a5,-36(s0)
     6ba:	4705                	li	a4,1
     6bc:	00f717b3          	sll	a5,a4,a5
     6c0:	fec42703          	lw	a4,-20(s0)
     6c4:	8fd9                	or	a5,a5,a4
     6c6:	fef42623          	sw	a5,-20(s0)
     6ca:	1a1017b7          	lui	a5,0x1a101
     6ce:	07b1                	addi	a5,a5,12
     6d0:	fec42703          	lw	a4,-20(s0)
     6d4:	c398                	sw	a4,0(a5)
     6d6:	0001                	nop
     6d8:	5432                	lw	s0,44(sp)
     6da:	6145                	addi	sp,sp,48
     6dc:	8082                	ret

000006de <set_gpio_pin_irq_type>:
     6de:	7179                	addi	sp,sp,-48
     6e0:	d622                	sw	s0,44(sp)
     6e2:	1800                	addi	s0,sp,48
     6e4:	fca42e23          	sw	a0,-36(s0)
     6e8:	fcb42c23          	sw	a1,-40(s0)
     6ec:	1a1017b7          	lui	a5,0x1a101
     6f0:	07c1                	addi	a5,a5,16
     6f2:	439c                	lw	a5,0(a5)
     6f4:	fef42623          	sw	a5,-20(s0)
     6f8:	1a1017b7          	lui	a5,0x1a101
     6fc:	07d1                	addi	a5,a5,20
     6fe:	439c                	lw	a5,0(a5)
     700:	fef42423          	sw	a5,-24(s0)
     704:	fd842783          	lw	a5,-40(s0)
     708:	8b85                	andi	a5,a5,1
     70a:	ef91                	bnez	a5,726 <set_gpio_pin_irq_type+0x48>
     70c:	fdc42783          	lw	a5,-36(s0)
     710:	4705                	li	a4,1
     712:	00f717b3          	sll	a5,a4,a5
     716:	fff7c793          	not	a5,a5
     71a:	fec42703          	lw	a4,-20(s0)
     71e:	8ff9                	and	a5,a5,a4
     720:	fef42623          	sw	a5,-20(s0)
     724:	a819                	j	73a <set_gpio_pin_irq_type+0x5c>
     726:	fdc42783          	lw	a5,-36(s0)
     72a:	4705                	li	a4,1
     72c:	00f717b3          	sll	a5,a4,a5
     730:	fec42703          	lw	a4,-20(s0)
     734:	8fd9                	or	a5,a5,a4
     736:	fef42623          	sw	a5,-20(s0)
     73a:	fd842783          	lw	a5,-40(s0)
     73e:	8b89                	andi	a5,a5,2
     740:	ef91                	bnez	a5,75c <set_gpio_pin_irq_type+0x7e>
     742:	fdc42783          	lw	a5,-36(s0)
     746:	4705                	li	a4,1
     748:	00f717b3          	sll	a5,a4,a5
     74c:	fff7c793          	not	a5,a5
     750:	fe842703          	lw	a4,-24(s0)
     754:	8ff9                	and	a5,a5,a4
     756:	fef42423          	sw	a5,-24(s0)
     75a:	a819                	j	770 <set_gpio_pin_irq_type+0x92>
     75c:	fdc42783          	lw	a5,-36(s0)
     760:	4705                	li	a4,1
     762:	00f717b3          	sll	a5,a4,a5
     766:	fe842703          	lw	a4,-24(s0)
     76a:	8fd9                	or	a5,a5,a4
     76c:	fef42423          	sw	a5,-24(s0)
     770:	1a1017b7          	lui	a5,0x1a101
     774:	07c1                	addi	a5,a5,16
     776:	fec42703          	lw	a4,-20(s0)
     77a:	c398                	sw	a4,0(a5)
     77c:	1a1017b7          	lui	a5,0x1a101
     780:	07d1                	addi	a5,a5,20
     782:	fe842703          	lw	a4,-24(s0)
     786:	c398                	sw	a4,0(a5)
     788:	0001                	nop
     78a:	5432                	lw	s0,44(sp)
     78c:	6145                	addi	sp,sp,48
     78e:	8082                	ret

00000790 <get_gpio_irq_status>:
     790:	1141                	addi	sp,sp,-16
     792:	c622                	sw	s0,12(sp)
     794:	0800                	addi	s0,sp,16
     796:	1a1017b7          	lui	a5,0x1a101
     79a:	07e1                	addi	a5,a5,24
     79c:	439c                	lw	a5,0(a5)
     79e:	853e                	mv	a0,a5
     7a0:	4432                	lw	s0,12(sp)
     7a2:	0141                	addi	sp,sp,16
     7a4:	8082                	ret

000007a6 <uart_set_cfg>:
     7a6:	1101                	addi	sp,sp,-32
     7a8:	ce22                	sw	s0,28(sp)
     7aa:	1000                	addi	s0,sp,32
     7ac:	fea42623          	sw	a0,-20(s0)
     7b0:	87ae                	mv	a5,a1
     7b2:	fef41523          	sh	a5,-22(s0)
     7b6:	1a1077b7          	lui	a5,0x1a107
     7ba:	0791                	addi	a5,a5,4
     7bc:	4398                	lw	a4,0(a5)
     7be:	1a1077b7          	lui	a5,0x1a107
     7c2:	0791                	addi	a5,a5,4
     7c4:	00276713          	ori	a4,a4,2
     7c8:	c398                	sw	a4,0(a5)
     7ca:	1a1007b7          	lui	a5,0x1a100
     7ce:	07b1                	addi	a5,a5,12
     7d0:	08300713          	li	a4,131
     7d4:	c398                	sw	a4,0(a5)
     7d6:	fea45783          	lhu	a5,-22(s0)
     7da:	83a1                	srli	a5,a5,0x8
     7dc:	07c2                	slli	a5,a5,0x10
     7de:	83c1                	srli	a5,a5,0x10
     7e0:	873e                	mv	a4,a5
     7e2:	1a1007b7          	lui	a5,0x1a100
     7e6:	0791                	addi	a5,a5,4
     7e8:	0ff77713          	andi	a4,a4,255
     7ec:	c398                	sw	a4,0(a5)
     7ee:	fea45703          	lhu	a4,-22(s0)
     7f2:	1a1007b7          	lui	a5,0x1a100
     7f6:	0ff77713          	andi	a4,a4,255
     7fa:	c398                	sw	a4,0(a5)
     7fc:	1a1007b7          	lui	a5,0x1a100
     800:	07a1                	addi	a5,a5,8
     802:	0a700713          	li	a4,167
     806:	c398                	sw	a4,0(a5)
     808:	1a1007b7          	lui	a5,0x1a100
     80c:	07b1                	addi	a5,a5,12
     80e:	470d                	li	a4,3
     810:	c398                	sw	a4,0(a5)
     812:	1a1007b7          	lui	a5,0x1a100
     816:	0791                	addi	a5,a5,4
     818:	439c                	lw	a5,0(a5)
     81a:	0f07f713          	andi	a4,a5,240
     81e:	1a1007b7          	lui	a5,0x1a100
     822:	0791                	addi	a5,a5,4
     824:	00276713          	ori	a4,a4,2
     828:	c398                	sw	a4,0(a5)
     82a:	0001                	nop
     82c:	4472                	lw	s0,28(sp)
     82e:	6105                	addi	sp,sp,32
     830:	8082                	ret

00000832 <uart_send>:
     832:	7179                	addi	sp,sp,-48
     834:	d622                	sw	s0,44(sp)
     836:	1800                	addi	s0,sp,48
     838:	fca42e23          	sw	a0,-36(s0)
     83c:	fcb42c23          	sw	a1,-40(s0)
     840:	a891                	j	894 <uart_send+0x62>
     842:	0001                	nop
     844:	1a1007b7          	lui	a5,0x1a100
     848:	07d1                	addi	a5,a5,20
     84a:	439c                	lw	a5,0(a5)
     84c:	0207f793          	andi	a5,a5,32
     850:	dbf5                	beqz	a5,844 <uart_send+0x12>
     852:	fe042623          	sw	zero,-20(s0)
     856:	a035                	j	882 <uart_send+0x50>
     858:	fdc42783          	lw	a5,-36(s0)
     85c:	00178713          	addi	a4,a5,1 # 1a100001 <_stack_start+0x19ff8001>
     860:	fce42e23          	sw	a4,-36(s0)
     864:	0007c703          	lbu	a4,0(a5)
     868:	1a1007b7          	lui	a5,0x1a100
     86c:	c398                	sw	a4,0(a5)
     86e:	fd842783          	lw	a5,-40(s0)
     872:	17fd                	addi	a5,a5,-1
     874:	fcf42c23          	sw	a5,-40(s0)
     878:	fec42783          	lw	a5,-20(s0)
     87c:	0785                	addi	a5,a5,1
     87e:	fef42623          	sw	a5,-20(s0)
     882:	fec42703          	lw	a4,-20(s0)
     886:	03f00793          	li	a5,63
     88a:	00e7e563          	bltu	a5,a4,894 <uart_send+0x62>
     88e:	fd842783          	lw	a5,-40(s0)
     892:	f3f9                	bnez	a5,858 <uart_send+0x26>
     894:	fd842783          	lw	a5,-40(s0)
     898:	f7cd                	bnez	a5,842 <uart_send+0x10>
     89a:	0001                	nop
     89c:	0001                	nop
     89e:	5432                	lw	s0,44(sp)
     8a0:	6145                	addi	sp,sp,48
     8a2:	8082                	ret

000008a4 <uart_getchar>:
     8a4:	1141                	addi	sp,sp,-16
     8a6:	c622                	sw	s0,12(sp)
     8a8:	0800                	addi	s0,sp,16
     8aa:	0001                	nop
     8ac:	1a1007b7          	lui	a5,0x1a100
     8b0:	07d1                	addi	a5,a5,20
     8b2:	439c                	lw	a5,0(a5)
     8b4:	0017f713          	andi	a4,a5,1
     8b8:	4785                	li	a5,1
     8ba:	fef719e3          	bne	a4,a5,8ac <uart_getchar+0x8>
     8be:	1a1007b7          	lui	a5,0x1a100
     8c2:	439c                	lw	a5,0(a5)
     8c4:	0ff7f793          	andi	a5,a5,255
     8c8:	853e                	mv	a0,a5
     8ca:	4432                	lw	s0,12(sp)
     8cc:	0141                	addi	sp,sp,16
     8ce:	8082                	ret

000008d0 <uart_sendchar>:
     8d0:	1101                	addi	sp,sp,-32
     8d2:	ce22                	sw	s0,28(sp)
     8d4:	1000                	addi	s0,sp,32
     8d6:	87aa                	mv	a5,a0
     8d8:	fef407a3          	sb	a5,-17(s0)
     8dc:	0001                	nop
     8de:	1a1007b7          	lui	a5,0x1a100
     8e2:	07d1                	addi	a5,a5,20
     8e4:	439c                	lw	a5,0(a5)
     8e6:	0207f793          	andi	a5,a5,32
     8ea:	dbf5                	beqz	a5,8de <uart_sendchar+0xe>
     8ec:	1a1007b7          	lui	a5,0x1a100
     8f0:	fef44703          	lbu	a4,-17(s0)
     8f4:	c398                	sw	a4,0(a5)
     8f6:	0001                	nop
     8f8:	4472                	lw	s0,28(sp)
     8fa:	6105                	addi	sp,sp,32
     8fc:	8082                	ret

000008fe <uart_wait_tx_done>:
     8fe:	1141                	addi	sp,sp,-16
     900:	c622                	sw	s0,12(sp)
     902:	0800                	addi	s0,sp,16
     904:	0001                	nop
     906:	1a1007b7          	lui	a5,0x1a100
     90a:	07d1                	addi	a5,a5,20
     90c:	439c                	lw	a5,0(a5)
     90e:	0407f793          	andi	a5,a5,64
     912:	dbf5                	beqz	a5,906 <uart_wait_tx_done+0x8>
     914:	0001                	nop
     916:	0001                	nop
     918:	4432                	lw	s0,12(sp)
     91a:	0141                	addi	sp,sp,16
     91c:	8082                	ret

0000091e <exit>:
     91e:	1101                	addi	sp,sp,-32
     920:	ce06                	sw	ra,28(sp)
     922:	cc22                	sw	s0,24(sp)
     924:	1000                	addi	s0,sp,32
     926:	fea42623          	sw	a0,-20(s0)
     92a:	fec42503          	lw	a0,-20(s0)
     92e:	2011                	jal	932 <eoc>
     930:	a001                	j	930 <exit+0x12>

00000932 <eoc>:
     932:	1101                	addi	sp,sp,-32
     934:	ce06                	sw	ra,28(sp)
     936:	cc22                	sw	s0,24(sp)
     938:	1000                	addi	s0,sp,32
     93a:	fea42623          	sw	a0,-20(s0)
     93e:	fec42783          	lw	a5,-20(s0)
     942:	c799                	beqz	a5,950 <eoc+0x1e>
     944:	1a1077b7          	lui	a5,0x1a107
     948:	07d1                	addi	a5,a5,20
     94a:	4705                	li	a4,1
     94c:	c398                	sw	a4,0(a5)
     94e:	a031                	j	95a <eoc+0x28>
     950:	1a1077b7          	lui	a5,0x1a107
     954:	07d1                	addi	a5,a5,20
     956:	0007a023          	sw	zero,0(a5) # 1a107000 <_stack_start+0x19fff000>
     95a:	1a1077b7          	lui	a5,0x1a107
     95e:	0791                	addi	a5,a5,4
     960:	4398                	lw	a4,0(a5)
     962:	1a1077b7          	lui	a5,0x1a107
     966:	0791                	addi	a5,a5,4
     968:	00476713          	ori	a4,a4,4
     96c:	c398                	sw	a4,0(a5)
     96e:	4585                	li	a1,1
     970:	4521                	li	a0,8
     972:	3ea1                	jal	4ca <set_pin_function>
     974:	4585                	li	a1,1
     976:	4521                	li	a0,8
     978:	3ef1                	jal	554 <set_gpio_pin_direction>
     97a:	4585                	li	a1,1
     97c:	4521                	li	a0,8
     97e:	31a5                	jal	5e6 <set_gpio_pin_value>
     980:	0001                	nop
     982:	40f2                	lw	ra,28(sp)
     984:	4462                	lw	s0,24(sp)
     986:	6105                	addi	sp,sp,32
     988:	8082                	ret

0000098a <sleep_busy>:
     98a:	7179                	addi	sp,sp,-48
     98c:	d622                	sw	s0,44(sp)
     98e:	1800                	addi	s0,sp,48
     990:	fca42e23          	sw	a0,-36(s0)
     994:	fe042623          	sw	zero,-20(s0)
     998:	a039                	j	9a6 <sleep_busy+0x1c>
     99a:	0001                	nop
     99c:	fec42783          	lw	a5,-20(s0)
     9a0:	0785                	addi	a5,a5,1
     9a2:	fef42623          	sw	a5,-20(s0)
     9a6:	fdc42783          	lw	a5,-36(s0)
     9aa:	fec42703          	lw	a4,-20(s0)
     9ae:	fef746e3          	blt	a4,a5,99a <sleep_busy+0x10>
     9b2:	0001                	nop
     9b4:	0001                	nop
     9b6:	5432                	lw	s0,44(sp)
     9b8:	6145                	addi	sp,sp,48
     9ba:	8082                	ret

000009bc <divu10>:
     9bc:	7179                	addi	sp,sp,-48
     9be:	d622                	sw	s0,44(sp)
     9c0:	1800                	addi	s0,sp,48
     9c2:	fca42e23          	sw	a0,-36(s0)
     9c6:	fdc42783          	lw	a5,-36(s0)
     9ca:	0017d713          	srli	a4,a5,0x1
     9ce:	fdc42783          	lw	a5,-36(s0)
     9d2:	8389                	srli	a5,a5,0x2
     9d4:	97ba                	add	a5,a5,a4
     9d6:	fef42623          	sw	a5,-20(s0)
     9da:	fec42783          	lw	a5,-20(s0)
     9de:	8391                	srli	a5,a5,0x4
     9e0:	fec42703          	lw	a4,-20(s0)
     9e4:	97ba                	add	a5,a5,a4
     9e6:	fef42623          	sw	a5,-20(s0)
     9ea:	fec42783          	lw	a5,-20(s0)
     9ee:	83a1                	srli	a5,a5,0x8
     9f0:	fec42703          	lw	a4,-20(s0)
     9f4:	97ba                	add	a5,a5,a4
     9f6:	fef42623          	sw	a5,-20(s0)
     9fa:	fec42783          	lw	a5,-20(s0)
     9fe:	83c1                	srli	a5,a5,0x10
     a00:	fec42703          	lw	a4,-20(s0)
     a04:	97ba                	add	a5,a5,a4
     a06:	fef42623          	sw	a5,-20(s0)
     a0a:	fec42783          	lw	a5,-20(s0)
     a0e:	838d                	srli	a5,a5,0x3
     a10:	fef42623          	sw	a5,-20(s0)
     a14:	fec42703          	lw	a4,-20(s0)
     a18:	87ba                	mv	a5,a4
     a1a:	078a                	slli	a5,a5,0x2
     a1c:	97ba                	add	a5,a5,a4
     a1e:	0786                	slli	a5,a5,0x1
     a20:	873e                	mv	a4,a5
     a22:	fdc42783          	lw	a5,-36(s0)
     a26:	8f99                	sub	a5,a5,a4
     a28:	fef42423          	sw	a5,-24(s0)
     a2c:	fe842783          	lw	a5,-24(s0)
     a30:	0799                	addi	a5,a5,6
     a32:	0047d713          	srli	a4,a5,0x4
     a36:	fec42783          	lw	a5,-20(s0)
     a3a:	97ba                	add	a5,a5,a4
     a3c:	853e                	mv	a0,a5
     a3e:	5432                	lw	s0,44(sp)
     a40:	6145                	addi	sp,sp,48
     a42:	8082                	ret

00000a44 <remu10>:
     a44:	1101                	addi	sp,sp,-32
     a46:	ce22                	sw	s0,28(sp)
     a48:	1000                	addi	s0,sp,32
     a4a:	fea42623          	sw	a0,-20(s0)
     a4e:	fec42703          	lw	a4,-20(s0)
     a52:	1999a7b7          	lui	a5,0x1999a
     a56:	99978793          	addi	a5,a5,-1639 # 19999999 <_stack_start+0x19891999>
     a5a:	02f70733          	mul	a4,a4,a5
     a5e:	fec42783          	lw	a5,-20(s0)
     a62:	8385                	srli	a5,a5,0x1
     a64:	973e                	add	a4,a4,a5
     a66:	fec42783          	lw	a5,-20(s0)
     a6a:	838d                	srli	a5,a5,0x3
     a6c:	97ba                	add	a5,a5,a4
     a6e:	83f1                	srli	a5,a5,0x1c
     a70:	fef42623          	sw	a5,-20(s0)
     a74:	001007b7          	lui	a5,0x100
     a78:	00878713          	addi	a4,a5,8 # 100008 <remu10_table>
     a7c:	fec42783          	lw	a5,-20(s0)
     a80:	97ba                	add	a5,a5,a4
     a82:	0007c783          	lbu	a5,0(a5)
     a86:	853e                	mv	a0,a5
     a88:	4472                	lw	s0,28(sp)
     a8a:	6105                	addi	sp,sp,32
     a8c:	8082                	ret

00000a8e <putchar>:
     a8e:	1101                	addi	sp,sp,-32
     a90:	ce06                	sw	ra,28(sp)
     a92:	cc22                	sw	s0,24(sp)
     a94:	1000                	addi	s0,sp,32
     a96:	fea42623          	sw	a0,-20(s0)
     a9a:	fec42783          	lw	a5,-20(s0)
     a9e:	0ff7f793          	andi	a5,a5,255
     aa2:	853e                	mv	a0,a5
     aa4:	3535                	jal	8d0 <uart_sendchar>
     aa6:	fec42783          	lw	a5,-20(s0)
     aaa:	853e                	mv	a0,a5
     aac:	40f2                	lw	ra,28(sp)
     aae:	4462                	lw	s0,24(sp)
     ab0:	6105                	addi	sp,sp,32
     ab2:	8082                	ret

00000ab4 <qprintchar>:
     ab4:	1101                	addi	sp,sp,-32
     ab6:	ce06                	sw	ra,28(sp)
     ab8:	cc22                	sw	s0,24(sp)
     aba:	1000                	addi	s0,sp,32
     abc:	fea42623          	sw	a0,-20(s0)
     ac0:	feb42423          	sw	a1,-24(s0)
     ac4:	fec42783          	lw	a5,-20(s0)
     ac8:	c39d                	beqz	a5,aee <qprintchar+0x3a>
     aca:	fec42783          	lw	a5,-20(s0)
     ace:	439c                	lw	a5,0(a5)
     ad0:	fe842703          	lw	a4,-24(s0)
     ad4:	0ff77713          	andi	a4,a4,255
     ad8:	00e78023          	sb	a4,0(a5)
     adc:	fec42783          	lw	a5,-20(s0)
     ae0:	439c                	lw	a5,0(a5)
     ae2:	00178713          	addi	a4,a5,1
     ae6:	fec42783          	lw	a5,-20(s0)
     aea:	c398                	sw	a4,0(a5)
     aec:	a039                	j	afa <qprintchar+0x46>
     aee:	fe842783          	lw	a5,-24(s0)
     af2:	0ff7f793          	andi	a5,a5,255
     af6:	853e                	mv	a0,a5
     af8:	3f59                	jal	a8e <putchar>
     afa:	0001                	nop
     afc:	40f2                	lw	ra,28(sp)
     afe:	4462                	lw	s0,24(sp)
     b00:	6105                	addi	sp,sp,32
     b02:	8082                	ret

00000b04 <qprints>:
     b04:	7179                	addi	sp,sp,-48
     b06:	d606                	sw	ra,44(sp)
     b08:	d422                	sw	s0,40(sp)
     b0a:	d226                	sw	s1,36(sp)
     b0c:	d04a                	sw	s2,32(sp)
     b0e:	ce4e                	sw	s3,28(sp)
     b10:	cc52                	sw	s4,24(sp)
     b12:	1800                	addi	s0,sp,48
     b14:	fca42e23          	sw	a0,-36(s0)
     b18:	fcb42c23          	sw	a1,-40(s0)
     b1c:	fcc42a23          	sw	a2,-44(s0)
     b20:	fcd42823          	sw	a3,-48(s0)
     b24:	4481                	li	s1,0
     b26:	02000a13          	li	s4,32
     b2a:	fd442783          	lw	a5,-44(s0)
     b2e:	02f05e63          	blez	a5,b6a <qprints+0x66>
     b32:	4901                	li	s2,0
     b34:	fd842983          	lw	s3,-40(s0)
     b38:	a019                	j	b3e <qprints+0x3a>
     b3a:	0905                	addi	s2,s2,1
     b3c:	0985                	addi	s3,s3,1
     b3e:	0009c783          	lbu	a5,0(s3)
     b42:	ffe5                	bnez	a5,b3a <qprints+0x36>
     b44:	fd442783          	lw	a5,-44(s0)
     b48:	00f94563          	blt	s2,a5,b52 <qprints+0x4e>
     b4c:	fc042a23          	sw	zero,-44(s0)
     b50:	a039                	j	b5e <qprints+0x5a>
     b52:	fd442783          	lw	a5,-44(s0)
     b56:	412787b3          	sub	a5,a5,s2
     b5a:	fcf42a23          	sw	a5,-44(s0)
     b5e:	fd042783          	lw	a5,-48(s0)
     b62:	8b89                	andi	a5,a5,2
     b64:	c399                	beqz	a5,b6a <qprints+0x66>
     b66:	03000a13          	li	s4,48
     b6a:	fd042783          	lw	a5,-48(s0)
     b6e:	8b85                	andi	a5,a5,1
     b70:	ef9d                	bnez	a5,bae <qprints+0xaa>
     b72:	a819                	j	b88 <qprints+0x84>
     b74:	85d2                	mv	a1,s4
     b76:	fdc42503          	lw	a0,-36(s0)
     b7a:	3f2d                	jal	ab4 <qprintchar>
     b7c:	0485                	addi	s1,s1,1
     b7e:	fd442783          	lw	a5,-44(s0)
     b82:	17fd                	addi	a5,a5,-1
     b84:	fcf42a23          	sw	a5,-44(s0)
     b88:	fd442783          	lw	a5,-44(s0)
     b8c:	fef044e3          	bgtz	a5,b74 <qprints+0x70>
     b90:	a839                	j	bae <qprints+0xaa>
     b92:	fd842783          	lw	a5,-40(s0)
     b96:	0007c783          	lbu	a5,0(a5)
     b9a:	85be                	mv	a1,a5
     b9c:	fdc42503          	lw	a0,-36(s0)
     ba0:	3f11                	jal	ab4 <qprintchar>
     ba2:	0485                	addi	s1,s1,1
     ba4:	fd842783          	lw	a5,-40(s0)
     ba8:	0785                	addi	a5,a5,1
     baa:	fcf42c23          	sw	a5,-40(s0)
     bae:	fd842783          	lw	a5,-40(s0)
     bb2:	0007c783          	lbu	a5,0(a5)
     bb6:	fff1                	bnez	a5,b92 <qprints+0x8e>
     bb8:	a819                	j	bce <qprints+0xca>
     bba:	85d2                	mv	a1,s4
     bbc:	fdc42503          	lw	a0,-36(s0)
     bc0:	3dd5                	jal	ab4 <qprintchar>
     bc2:	0485                	addi	s1,s1,1
     bc4:	fd442783          	lw	a5,-44(s0)
     bc8:	17fd                	addi	a5,a5,-1
     bca:	fcf42a23          	sw	a5,-44(s0)
     bce:	fd442783          	lw	a5,-44(s0)
     bd2:	fef044e3          	bgtz	a5,bba <qprints+0xb6>
     bd6:	87a6                	mv	a5,s1
     bd8:	853e                	mv	a0,a5
     bda:	50b2                	lw	ra,44(sp)
     bdc:	5422                	lw	s0,40(sp)
     bde:	5492                	lw	s1,36(sp)
     be0:	5902                	lw	s2,32(sp)
     be2:	49f2                	lw	s3,28(sp)
     be4:	4a62                	lw	s4,24(sp)
     be6:	6145                	addi	sp,sp,48
     be8:	8082                	ret

00000bea <qprinti>:
     bea:	7159                	addi	sp,sp,-112
     bec:	d686                	sw	ra,108(sp)
     bee:	d4a2                	sw	s0,104(sp)
     bf0:	d2a6                	sw	s1,100(sp)
     bf2:	d0ca                	sw	s2,96(sp)
     bf4:	cece                	sw	s3,92(sp)
     bf6:	1880                	addi	s0,sp,112
     bf8:	faa42623          	sw	a0,-84(s0)
     bfc:	fab42423          	sw	a1,-88(s0)
     c00:	fac42223          	sw	a2,-92(s0)
     c04:	fad42023          	sw	a3,-96(s0)
     c08:	f8e42e23          	sw	a4,-100(s0)
     c0c:	f8f42c23          	sw	a5,-104(s0)
     c10:	87c2                	mv	a5,a6
     c12:	f8f40ba3          	sb	a5,-105(s0)
     c16:	4981                	li	s3,0
     c18:	4901                	li	s2,0
     c1a:	fa842783          	lw	a5,-88(s0)
     c1e:	fcf42e23          	sw	a5,-36(s0)
     c22:	fa842783          	lw	a5,-88(s0)
     c26:	e39d                	bnez	a5,c4c <qprinti+0x62>
     c28:	03000793          	li	a5,48
     c2c:	faf40c23          	sb	a5,-72(s0)
     c30:	fa040ca3          	sb	zero,-71(s0)
     c34:	fb840793          	addi	a5,s0,-72
     c38:	f9842683          	lw	a3,-104(s0)
     c3c:	f9c42603          	lw	a2,-100(s0)
     c40:	85be                	mv	a1,a5
     c42:	fac42503          	lw	a0,-84(s0)
     c46:	3d7d                	jal	b04 <qprints>
     c48:	87aa                	mv	a5,a0
     c4a:	a8fd                	j	d48 <qprinti+0x15e>
     c4c:	fa042783          	lw	a5,-96(s0)
     c50:	c38d                	beqz	a5,c72 <qprinti+0x88>
     c52:	fa442703          	lw	a4,-92(s0)
     c56:	47a9                	li	a5,10
     c58:	00f71d63          	bne	a4,a5,c72 <qprinti+0x88>
     c5c:	fa842783          	lw	a5,-88(s0)
     c60:	0007d963          	bgez	a5,c72 <qprinti+0x88>
     c64:	4985                	li	s3,1
     c66:	fa842783          	lw	a5,-88(s0)
     c6a:	40f007b3          	neg	a5,a5
     c6e:	fcf42e23          	sw	a5,-36(s0)
     c72:	fb840493          	addi	s1,s0,-72
     c76:	04fd                	addi	s1,s1,31
     c78:	00048023          	sb	zero,0(s1)
     c7c:	fa442703          	lw	a4,-92(s0)
     c80:	47c1                	li	a5,16
     c82:	06f71c63          	bne	a4,a5,cfa <qprinti+0x110>
     c86:	a0a1                	j	cce <qprinti+0xe4>
     c88:	fdc42783          	lw	a5,-36(s0)
     c8c:	8bbd                	andi	a5,a5,15
     c8e:	fcf42c23          	sw	a5,-40(s0)
     c92:	fd842703          	lw	a4,-40(s0)
     c96:	47a5                	li	a5,9
     c98:	00e7db63          	bge	a5,a4,cae <qprinti+0xc4>
     c9c:	f9744783          	lbu	a5,-105(s0)
     ca0:	fc678793          	addi	a5,a5,-58
     ca4:	fd842703          	lw	a4,-40(s0)
     ca8:	97ba                	add	a5,a5,a4
     caa:	fcf42c23          	sw	a5,-40(s0)
     cae:	fd842783          	lw	a5,-40(s0)
     cb2:	0ff7f793          	andi	a5,a5,255
     cb6:	14fd                	addi	s1,s1,-1
     cb8:	03078793          	addi	a5,a5,48
     cbc:	0ff7f793          	andi	a5,a5,255
     cc0:	00f48023          	sb	a5,0(s1)
     cc4:	fdc42783          	lw	a5,-36(s0)
     cc8:	8391                	srli	a5,a5,0x4
     cca:	fcf42e23          	sw	a5,-36(s0)
     cce:	fdc42783          	lw	a5,-36(s0)
     cd2:	fbdd                	bnez	a5,c88 <qprinti+0x9e>
     cd4:	a035                	j	d00 <qprinti+0x116>
     cd6:	fdc42503          	lw	a0,-36(s0)
     cda:	33ad                	jal	a44 <remu10>
     cdc:	87aa                	mv	a5,a0
     cde:	0ff7f793          	andi	a5,a5,255
     ce2:	14fd                	addi	s1,s1,-1
     ce4:	03078793          	addi	a5,a5,48
     ce8:	0ff7f793          	andi	a5,a5,255
     cec:	00f48023          	sb	a5,0(s1)
     cf0:	fdc42503          	lw	a0,-36(s0)
     cf4:	31e1                	jal	9bc <divu10>
     cf6:	fca42e23          	sw	a0,-36(s0)
     cfa:	fdc42783          	lw	a5,-36(s0)
     cfe:	ffe1                	bnez	a5,cd6 <qprinti+0xec>
     d00:	02098a63          	beqz	s3,d34 <qprinti+0x14a>
     d04:	f9c42783          	lw	a5,-100(s0)
     d08:	c38d                	beqz	a5,d2a <qprinti+0x140>
     d0a:	f9842783          	lw	a5,-104(s0)
     d0e:	8b89                	andi	a5,a5,2
     d10:	cf89                	beqz	a5,d2a <qprinti+0x140>
     d12:	02d00593          	li	a1,45
     d16:	fac42503          	lw	a0,-84(s0)
     d1a:	3b69                	jal	ab4 <qprintchar>
     d1c:	0905                	addi	s2,s2,1
     d1e:	f9c42783          	lw	a5,-100(s0)
     d22:	17fd                	addi	a5,a5,-1
     d24:	f8f42e23          	sw	a5,-100(s0)
     d28:	a031                	j	d34 <qprinti+0x14a>
     d2a:	14fd                	addi	s1,s1,-1
     d2c:	02d00793          	li	a5,45
     d30:	00f48023          	sb	a5,0(s1)
     d34:	f9842683          	lw	a3,-104(s0)
     d38:	f9c42603          	lw	a2,-100(s0)
     d3c:	85a6                	mv	a1,s1
     d3e:	fac42503          	lw	a0,-84(s0)
     d42:	33c9                	jal	b04 <qprints>
     d44:	87aa                	mv	a5,a0
     d46:	97ca                	add	a5,a5,s2
     d48:	853e                	mv	a0,a5
     d4a:	50b6                	lw	ra,108(sp)
     d4c:	5426                	lw	s0,104(sp)
     d4e:	5496                	lw	s1,100(sp)
     d50:	5906                	lw	s2,96(sp)
     d52:	49f6                	lw	s3,92(sp)
     d54:	6165                	addi	sp,sp,112
     d56:	8082                	ret

00000d58 <qprint>:
     d58:	7139                	addi	sp,sp,-64
     d5a:	de06                	sw	ra,60(sp)
     d5c:	dc22                	sw	s0,56(sp)
     d5e:	da26                	sw	s1,52(sp)
     d60:	d84a                	sw	s2,48(sp)
     d62:	d64e                	sw	s3,44(sp)
     d64:	0080                	addi	s0,sp,64
     d66:	fca42623          	sw	a0,-52(s0)
     d6a:	fcb42423          	sw	a1,-56(s0)
     d6e:	fcc42223          	sw	a2,-60(s0)
     d72:	4481                	li	s1,0
     d74:	ac3d                	j	fb2 <qprint+0x25a>
     d76:	fc842783          	lw	a5,-56(s0)
     d7a:	0007c703          	lbu	a4,0(a5)
     d7e:	02500793          	li	a5,37
     d82:	20f71763          	bne	a4,a5,f90 <qprint+0x238>
     d86:	fc842783          	lw	a5,-56(s0)
     d8a:	0785                	addi	a5,a5,1
     d8c:	fcf42423          	sw	a5,-56(s0)
     d90:	4981                	li	s3,0
     d92:	894e                	mv	s2,s3
     d94:	fc842783          	lw	a5,-56(s0)
     d98:	0007c783          	lbu	a5,0(a5)
     d9c:	22078263          	beqz	a5,fc0 <qprint+0x268>
     da0:	fc842783          	lw	a5,-56(s0)
     da4:	0007c703          	lbu	a4,0(a5)
     da8:	02500793          	li	a5,37
     dac:	1ef70463          	beq	a4,a5,f94 <qprint+0x23c>
     db0:	fc842783          	lw	a5,-56(s0)
     db4:	0007c703          	lbu	a4,0(a5)
     db8:	02d00793          	li	a5,45
     dbc:	02f71063          	bne	a4,a5,ddc <qprint+0x84>
     dc0:	fc842783          	lw	a5,-56(s0)
     dc4:	0785                	addi	a5,a5,1
     dc6:	fcf42423          	sw	a5,-56(s0)
     dca:	4985                	li	s3,1
     dcc:	a801                	j	ddc <qprint+0x84>
     dce:	fc842783          	lw	a5,-56(s0)
     dd2:	0785                	addi	a5,a5,1
     dd4:	fcf42423          	sw	a5,-56(s0)
     dd8:	0029e993          	ori	s3,s3,2
     ddc:	fc842783          	lw	a5,-56(s0)
     de0:	0007c703          	lbu	a4,0(a5)
     de4:	03000793          	li	a5,48
     de8:	fef703e3          	beq	a4,a5,dce <qprint+0x76>
     dec:	a015                	j	e10 <qprint+0xb8>
     dee:	87ca                	mv	a5,s2
     df0:	078a                	slli	a5,a5,0x2
     df2:	97ca                	add	a5,a5,s2
     df4:	0786                	slli	a5,a5,0x1
     df6:	893e                	mv	s2,a5
     df8:	fc842783          	lw	a5,-56(s0)
     dfc:	0007c783          	lbu	a5,0(a5)
     e00:	fd078793          	addi	a5,a5,-48
     e04:	993e                	add	s2,s2,a5
     e06:	fc842783          	lw	a5,-56(s0)
     e0a:	0785                	addi	a5,a5,1
     e0c:	fcf42423          	sw	a5,-56(s0)
     e10:	fc842783          	lw	a5,-56(s0)
     e14:	0007c703          	lbu	a4,0(a5)
     e18:	02f00793          	li	a5,47
     e1c:	00e7fa63          	bgeu	a5,a4,e30 <qprint+0xd8>
     e20:	fc842783          	lw	a5,-56(s0)
     e24:	0007c703          	lbu	a4,0(a5)
     e28:	03900793          	li	a5,57
     e2c:	fce7f1e3          	bgeu	a5,a4,dee <qprint+0x96>
     e30:	fc842783          	lw	a5,-56(s0)
     e34:	0007c703          	lbu	a4,0(a5)
     e38:	07300793          	li	a5,115
     e3c:	02f71b63          	bne	a4,a5,e72 <qprint+0x11a>
     e40:	fc442783          	lw	a5,-60(s0)
     e44:	00478713          	addi	a4,a5,4
     e48:	fce42223          	sw	a4,-60(s0)
     e4c:	0007a083          	lw	ra,0(a5)
     e50:	00008463          	beqz	ra,e58 <qprint+0x100>
     e54:	8786                	mv	a5,ra
     e56:	a029                	j	e60 <qprint+0x108>
     e58:	001007b7          	lui	a5,0x100
     e5c:	00078793          	mv	a5,a5
     e60:	86ce                	mv	a3,s3
     e62:	864a                	mv	a2,s2
     e64:	85be                	mv	a1,a5
     e66:	fcc42503          	lw	a0,-52(s0)
     e6a:	3969                	jal	b04 <qprints>
     e6c:	87aa                	mv	a5,a0
     e6e:	94be                	add	s1,s1,a5
     e70:	aa25                	j	fa8 <qprint+0x250>
     e72:	fc842783          	lw	a5,-56(s0)
     e76:	0007c703          	lbu	a4,0(a5) # 100000 <__init_array_end>
     e7a:	06400793          	li	a5,100
     e7e:	02f71563          	bne	a4,a5,ea8 <qprint+0x150>
     e82:	fc442783          	lw	a5,-60(s0)
     e86:	00478713          	addi	a4,a5,4
     e8a:	fce42223          	sw	a4,-60(s0)
     e8e:	438c                	lw	a1,0(a5)
     e90:	06100813          	li	a6,97
     e94:	87ce                	mv	a5,s3
     e96:	874a                	mv	a4,s2
     e98:	4685                	li	a3,1
     e9a:	4629                	li	a2,10
     e9c:	fcc42503          	lw	a0,-52(s0)
     ea0:	33a9                	jal	bea <qprinti>
     ea2:	87aa                	mv	a5,a0
     ea4:	94be                	add	s1,s1,a5
     ea6:	a209                	j	fa8 <qprint+0x250>
     ea8:	fc842783          	lw	a5,-56(s0)
     eac:	0007c703          	lbu	a4,0(a5)
     eb0:	07500793          	li	a5,117
     eb4:	02f71663          	bne	a4,a5,ee0 <qprint+0x188>
     eb8:	fc442783          	lw	a5,-60(s0)
     ebc:	00478713          	addi	a4,a5,4
     ec0:	fce42223          	sw	a4,-60(s0)
     ec4:	439c                	lw	a5,0(a5)
     ec6:	85be                	mv	a1,a5
     ec8:	06100813          	li	a6,97
     ecc:	87ce                	mv	a5,s3
     ece:	874a                	mv	a4,s2
     ed0:	4681                	li	a3,0
     ed2:	4629                	li	a2,10
     ed4:	fcc42503          	lw	a0,-52(s0)
     ed8:	3b09                	jal	bea <qprinti>
     eda:	87aa                	mv	a5,a0
     edc:	94be                	add	s1,s1,a5
     ede:	a0e9                	j	fa8 <qprint+0x250>
     ee0:	fc842783          	lw	a5,-56(s0)
     ee4:	0007c703          	lbu	a4,0(a5)
     ee8:	07800793          	li	a5,120
     eec:	02f71663          	bne	a4,a5,f18 <qprint+0x1c0>
     ef0:	fc442783          	lw	a5,-60(s0)
     ef4:	00478713          	addi	a4,a5,4
     ef8:	fce42223          	sw	a4,-60(s0)
     efc:	439c                	lw	a5,0(a5)
     efe:	85be                	mv	a1,a5
     f00:	06100813          	li	a6,97
     f04:	87ce                	mv	a5,s3
     f06:	874a                	mv	a4,s2
     f08:	4681                	li	a3,0
     f0a:	4641                	li	a2,16
     f0c:	fcc42503          	lw	a0,-52(s0)
     f10:	39e9                	jal	bea <qprinti>
     f12:	87aa                	mv	a5,a0
     f14:	94be                	add	s1,s1,a5
     f16:	a849                	j	fa8 <qprint+0x250>
     f18:	fc842783          	lw	a5,-56(s0)
     f1c:	0007c703          	lbu	a4,0(a5)
     f20:	05800793          	li	a5,88
     f24:	02f71663          	bne	a4,a5,f50 <qprint+0x1f8>
     f28:	fc442783          	lw	a5,-60(s0)
     f2c:	00478713          	addi	a4,a5,4
     f30:	fce42223          	sw	a4,-60(s0)
     f34:	439c                	lw	a5,0(a5)
     f36:	85be                	mv	a1,a5
     f38:	04100813          	li	a6,65
     f3c:	87ce                	mv	a5,s3
     f3e:	874a                	mv	a4,s2
     f40:	4681                	li	a3,0
     f42:	4641                	li	a2,16
     f44:	fcc42503          	lw	a0,-52(s0)
     f48:	314d                	jal	bea <qprinti>
     f4a:	87aa                	mv	a5,a0
     f4c:	94be                	add	s1,s1,a5
     f4e:	a8a9                	j	fa8 <qprint+0x250>
     f50:	fc842783          	lw	a5,-56(s0)
     f54:	0007c703          	lbu	a4,0(a5)
     f58:	06300793          	li	a5,99
     f5c:	04f71663          	bne	a4,a5,fa8 <qprint+0x250>
     f60:	fc442783          	lw	a5,-60(s0)
     f64:	00478713          	addi	a4,a5,4
     f68:	fce42223          	sw	a4,-60(s0)
     f6c:	439c                	lw	a5,0(a5)
     f6e:	0ff7f793          	andi	a5,a5,255
     f72:	fcf40e23          	sb	a5,-36(s0)
     f76:	fc040ea3          	sb	zero,-35(s0)
     f7a:	fdc40793          	addi	a5,s0,-36
     f7e:	86ce                	mv	a3,s3
     f80:	864a                	mv	a2,s2
     f82:	85be                	mv	a1,a5
     f84:	fcc42503          	lw	a0,-52(s0)
     f88:	3eb5                	jal	b04 <qprints>
     f8a:	87aa                	mv	a5,a0
     f8c:	94be                	add	s1,s1,a5
     f8e:	a829                	j	fa8 <qprint+0x250>
     f90:	0001                	nop
     f92:	a011                	j	f96 <qprint+0x23e>
     f94:	0001                	nop
     f96:	fc842783          	lw	a5,-56(s0)
     f9a:	0007c783          	lbu	a5,0(a5)
     f9e:	85be                	mv	a1,a5
     fa0:	fcc42503          	lw	a0,-52(s0)
     fa4:	3e01                	jal	ab4 <qprintchar>
     fa6:	0485                	addi	s1,s1,1
     fa8:	fc842783          	lw	a5,-56(s0)
     fac:	0785                	addi	a5,a5,1
     fae:	fcf42423          	sw	a5,-56(s0)
     fb2:	fc842783          	lw	a5,-56(s0)
     fb6:	0007c783          	lbu	a5,0(a5)
     fba:	da079ee3          	bnez	a5,d76 <qprint+0x1e>
     fbe:	a011                	j	fc2 <qprint+0x26a>
     fc0:	0001                	nop
     fc2:	fcc42783          	lw	a5,-52(s0)
     fc6:	c791                	beqz	a5,fd2 <qprint+0x27a>
     fc8:	fcc42783          	lw	a5,-52(s0)
     fcc:	439c                	lw	a5,0(a5)
     fce:	00078023          	sb	zero,0(a5)
     fd2:	87a6                	mv	a5,s1
     fd4:	853e                	mv	a0,a5
     fd6:	50f2                	lw	ra,60(sp)
     fd8:	5462                	lw	s0,56(sp)
     fda:	54d2                	lw	s1,52(sp)
     fdc:	5942                	lw	s2,48(sp)
     fde:	59b2                	lw	s3,44(sp)
     fe0:	6121                	addi	sp,sp,64
     fe2:	8082                	ret

00000fe4 <printf>:
     fe4:	715d                	addi	sp,sp,-80
     fe6:	d606                	sw	ra,44(sp)
     fe8:	d422                	sw	s0,40(sp)
     fea:	1800                	addi	s0,sp,48
     fec:	fca42e23          	sw	a0,-36(s0)
     ff0:	c04c                	sw	a1,4(s0)
     ff2:	c410                	sw	a2,8(s0)
     ff4:	c454                	sw	a3,12(s0)
     ff6:	c818                	sw	a4,16(s0)
     ff8:	c85c                	sw	a5,20(s0)
     ffa:	01042c23          	sw	a6,24(s0)
     ffe:	01142e23          	sw	a7,28(s0)
    1002:	02040793          	addi	a5,s0,32
    1006:	fcf42c23          	sw	a5,-40(s0)
    100a:	fd842783          	lw	a5,-40(s0)
    100e:	1791                	addi	a5,a5,-28
    1010:	fef42423          	sw	a5,-24(s0)
    1014:	fe842783          	lw	a5,-24(s0)
    1018:	863e                	mv	a2,a5
    101a:	fdc42583          	lw	a1,-36(s0)
    101e:	4501                	li	a0,0
    1020:	3b25                	jal	d58 <qprint>
    1022:	fea42623          	sw	a0,-20(s0)
    1026:	fec42783          	lw	a5,-20(s0)
    102a:	853e                	mv	a0,a5
    102c:	50b2                	lw	ra,44(sp)
    102e:	5422                	lw	s0,40(sp)
    1030:	6161                	addi	sp,sp,80
    1032:	8082                	ret

00001034 <puts>:
    1034:	7179                	addi	sp,sp,-48
    1036:	d606                	sw	ra,44(sp)
    1038:	d422                	sw	s0,40(sp)
    103a:	1800                	addi	s0,sp,48
    103c:	fca42e23          	sw	a0,-36(s0)
    1040:	fe042623          	sw	zero,-20(s0)
    1044:	a839                	j	1062 <puts+0x2e>
    1046:	fec42783          	lw	a5,-20(s0)
    104a:	00178713          	addi	a4,a5,1
    104e:	fee42623          	sw	a4,-20(s0)
    1052:	873e                	mv	a4,a5
    1054:	fdc42783          	lw	a5,-36(s0)
    1058:	97ba                	add	a5,a5,a4
    105a:	0007c783          	lbu	a5,0(a5)
    105e:	853e                	mv	a0,a5
    1060:	343d                	jal	a8e <putchar>
    1062:	fec42783          	lw	a5,-20(s0)
    1066:	fdc42703          	lw	a4,-36(s0)
    106a:	97ba                	add	a5,a5,a4
    106c:	0007c783          	lbu	a5,0(a5)
    1070:	fbf9                	bnez	a5,1046 <puts+0x12>
    1072:	4529                	li	a0,10
    1074:	3c29                	jal	a8e <putchar>
    1076:	fec42783          	lw	a5,-20(s0)
    107a:	853e                	mv	a0,a5
    107c:	50b2                	lw	ra,44(sp)
    107e:	5422                	lw	s0,40(sp)
    1080:	6145                	addi	sp,sp,48
    1082:	8082                	ret

00001084 <strcmp>:
    1084:	7179                	addi	sp,sp,-48
    1086:	d622                	sw	s0,44(sp)
    1088:	1800                	addi	s0,sp,48
    108a:	fca42e23          	sw	a0,-36(s0)
    108e:	fcb42c23          	sw	a1,-40(s0)
    1092:	fdc42703          	lw	a4,-36(s0)
    1096:	fd842783          	lw	a5,-40(s0)
    109a:	8fd9                	or	a5,a5,a4
    109c:	8b8d                	andi	a5,a5,3
    109e:	e7c9                	bnez	a5,1128 <strcmp+0xa4>
    10a0:	fdc42783          	lw	a5,-36(s0)
    10a4:	fef42623          	sw	a5,-20(s0)
    10a8:	fd842783          	lw	a5,-40(s0)
    10ac:	fef42423          	sw	a5,-24(s0)
    10b0:	a089                	j	10f2 <strcmp+0x6e>
    10b2:	fec42783          	lw	a5,-20(s0)
    10b6:	4398                	lw	a4,0(a5)
    10b8:	feff07b7          	lui	a5,0xfeff0
    10bc:	eff78793          	addi	a5,a5,-257 # fefefeff <_stack_start+0xfeee7eff>
    10c0:	973e                	add	a4,a4,a5
    10c2:	fec42783          	lw	a5,-20(s0)
    10c6:	439c                	lw	a5,0(a5)
    10c8:	fff7c793          	not	a5,a5
    10cc:	8f7d                	and	a4,a4,a5
    10ce:	808087b7          	lui	a5,0x80808
    10d2:	08078793          	addi	a5,a5,128 # 80808080 <_stack_start+0x80700080>
    10d6:	8ff9                	and	a5,a5,a4
    10d8:	c399                	beqz	a5,10de <strcmp+0x5a>
    10da:	4781                	li	a5,0
    10dc:	a041                	j	115c <strcmp+0xd8>
    10de:	fec42783          	lw	a5,-20(s0)
    10e2:	0791                	addi	a5,a5,4
    10e4:	fef42623          	sw	a5,-20(s0)
    10e8:	fe842783          	lw	a5,-24(s0)
    10ec:	0791                	addi	a5,a5,4
    10ee:	fef42423          	sw	a5,-24(s0)
    10f2:	fec42783          	lw	a5,-20(s0)
    10f6:	4398                	lw	a4,0(a5)
    10f8:	fe842783          	lw	a5,-24(s0)
    10fc:	439c                	lw	a5,0(a5)
    10fe:	faf70ae3          	beq	a4,a5,10b2 <strcmp+0x2e>
    1102:	fec42783          	lw	a5,-20(s0)
    1106:	fcf42e23          	sw	a5,-36(s0)
    110a:	fe842783          	lw	a5,-24(s0)
    110e:	fcf42c23          	sw	a5,-40(s0)
    1112:	a819                	j	1128 <strcmp+0xa4>
    1114:	fdc42783          	lw	a5,-36(s0)
    1118:	0785                	addi	a5,a5,1
    111a:	fcf42e23          	sw	a5,-36(s0)
    111e:	fd842783          	lw	a5,-40(s0)
    1122:	0785                	addi	a5,a5,1
    1124:	fcf42c23          	sw	a5,-40(s0)
    1128:	fdc42783          	lw	a5,-36(s0)
    112c:	0007c783          	lbu	a5,0(a5)
    1130:	cb99                	beqz	a5,1146 <strcmp+0xc2>
    1132:	fdc42783          	lw	a5,-36(s0)
    1136:	0007c703          	lbu	a4,0(a5)
    113a:	fd842783          	lw	a5,-40(s0)
    113e:	0007c783          	lbu	a5,0(a5)
    1142:	fcf709e3          	beq	a4,a5,1114 <strcmp+0x90>
    1146:	fdc42783          	lw	a5,-36(s0)
    114a:	0007c783          	lbu	a5,0(a5)
    114e:	873e                	mv	a4,a5
    1150:	fd842783          	lw	a5,-40(s0)
    1154:	0007c783          	lbu	a5,0(a5)
    1158:	40f707b3          	sub	a5,a4,a5
    115c:	853e                	mv	a0,a5
    115e:	5432                	lw	s0,44(sp)
    1160:	6145                	addi	sp,sp,48
    1162:	8082                	ret

00001164 <memset>:
    1164:	7179                	addi	sp,sp,-48
    1166:	d622                	sw	s0,44(sp)
    1168:	1800                	addi	s0,sp,48
    116a:	fca42e23          	sw	a0,-36(s0)
    116e:	fcb42c23          	sw	a1,-40(s0)
    1172:	fcc42a23          	sw	a2,-44(s0)
    1176:	fdc42783          	lw	a5,-36(s0)
    117a:	fef42623          	sw	a5,-20(s0)
    117e:	a015                	j	11a2 <memset+0x3e>
    1180:	fec42783          	lw	a5,-20(s0)
    1184:	00178713          	addi	a4,a5,1
    1188:	fee42623          	sw	a4,-20(s0)
    118c:	fd842703          	lw	a4,-40(s0)
    1190:	0ff77713          	andi	a4,a4,255
    1194:	00e78023          	sb	a4,0(a5)
    1198:	fd442783          	lw	a5,-44(s0)
    119c:	17fd                	addi	a5,a5,-1
    119e:	fcf42a23          	sw	a5,-44(s0)
    11a2:	fd442783          	lw	a5,-44(s0)
    11a6:	ffe9                	bnez	a5,1180 <memset+0x1c>
    11a8:	fdc42783          	lw	a5,-36(s0)
    11ac:	853e                	mv	a0,a5
    11ae:	5432                	lw	s0,44(sp)
    11b0:	6145                	addi	sp,sp,48
    11b2:	8082                	ret

000011b4 <strcpy>:
    11b4:	7179                	addi	sp,sp,-48
    11b6:	d622                	sw	s0,44(sp)
    11b8:	1800                	addi	s0,sp,48
    11ba:	fca42e23          	sw	a0,-36(s0)
    11be:	fcb42c23          	sw	a1,-40(s0)
    11c2:	fdc42783          	lw	a5,-36(s0)
    11c6:	fef42623          	sw	a5,-20(s0)
    11ca:	fd842783          	lw	a5,-40(s0)
    11ce:	fef42423          	sw	a5,-24(s0)
    11d2:	a01d                	j	11f8 <strcpy+0x44>
    11d4:	fe842783          	lw	a5,-24(s0)
    11d8:	0007c703          	lbu	a4,0(a5)
    11dc:	fec42783          	lw	a5,-20(s0)
    11e0:	00e78023          	sb	a4,0(a5)
    11e4:	fec42783          	lw	a5,-20(s0)
    11e8:	0785                	addi	a5,a5,1
    11ea:	fef42623          	sw	a5,-20(s0)
    11ee:	fe842783          	lw	a5,-24(s0)
    11f2:	0785                	addi	a5,a5,1
    11f4:	fef42423          	sw	a5,-24(s0)
    11f8:	fe842783          	lw	a5,-24(s0)
    11fc:	0007c783          	lbu	a5,0(a5)
    1200:	fbf1                	bnez	a5,11d4 <strcpy+0x20>
    1202:	fdc42783          	lw	a5,-36(s0)
    1206:	853e                	mv	a0,a5
    1208:	5432                	lw	s0,44(sp)
    120a:	6145                	addi	sp,sp,48
    120c:	8082                	ret

0000120e <strlen>:
    120e:	7179                	addi	sp,sp,-48
    1210:	d622                	sw	s0,44(sp)
    1212:	1800                	addi	s0,sp,48
    1214:	fca42e23          	sw	a0,-36(s0)
    1218:	fdc42783          	lw	a5,-36(s0)
    121c:	fef42623          	sw	a5,-20(s0)
    1220:	fe042423          	sw	zero,-24(s0)
    1224:	fec42783          	lw	a5,-20(s0)
    1228:	eb81                	bnez	a5,1238 <strlen+0x2a>
    122a:	4781                	li	a5,0
    122c:	a00d                	j	124e <strlen+0x40>
    122e:	fe842783          	lw	a5,-24(s0)
    1232:	0785                	addi	a5,a5,1
    1234:	fef42423          	sw	a5,-24(s0)
    1238:	fec42783          	lw	a5,-20(s0)
    123c:	00178713          	addi	a4,a5,1
    1240:	fee42623          	sw	a4,-20(s0)
    1244:	0007c783          	lbu	a5,0(a5)
    1248:	f3fd                	bnez	a5,122e <strlen+0x20>
    124a:	fe842783          	lw	a5,-24(s0)
    124e:	853e                	mv	a0,a5
    1250:	5432                	lw	s0,44(sp)
    1252:	6145                	addi	sp,sp,48
    1254:	8082                	ret

00001256 <ISR_I2C>:
    1256:	1141                	addi	sp,sp,-16
    1258:	c622                	sw	s0,12(sp)
    125a:	0800                	addi	s0,sp,16
    125c:	a001                	j	125c <ISR_I2C+0x6>

0000125e <ISR_UART>:
    125e:	1141                	addi	sp,sp,-16
    1260:	c622                	sw	s0,12(sp)
    1262:	0800                	addi	s0,sp,16
    1264:	a001                	j	1264 <ISR_UART+0x6>

00001266 <ISR_GPIO>:
    1266:	1141                	addi	sp,sp,-16
    1268:	c622                	sw	s0,12(sp)
    126a:	0800                	addi	s0,sp,16
    126c:	a001                	j	126c <ISR_GPIO+0x6>

0000126e <ISR_SPIM0>:
    126e:	1141                	addi	sp,sp,-16
    1270:	c622                	sw	s0,12(sp)
    1272:	0800                	addi	s0,sp,16
    1274:	a001                	j	1274 <ISR_SPIM0+0x6>

00001276 <ISR_SPIM1>:
    1276:	1141                	addi	sp,sp,-16
    1278:	c622                	sw	s0,12(sp)
    127a:	0800                	addi	s0,sp,16
    127c:	a001                	j	127c <ISR_SPIM1+0x6>

0000127e <ISR_TA_OVF>:
    127e:	1141                	addi	sp,sp,-16
    1280:	c622                	sw	s0,12(sp)
    1282:	0800                	addi	s0,sp,16
    1284:	a001                	j	1284 <ISR_TA_OVF+0x6>

00001286 <ISR_TA_CMP>:
    1286:	1141                	addi	sp,sp,-16
    1288:	c622                	sw	s0,12(sp)
    128a:	0800                	addi	s0,sp,16
    128c:	a001                	j	128c <ISR_TA_CMP+0x6>

0000128e <ISR_TB_OVF>:
    128e:	1141                	addi	sp,sp,-16
    1290:	c622                	sw	s0,12(sp)
    1292:	0800                	addi	s0,sp,16
    1294:	a001                	j	1294 <ISR_TB_OVF+0x6>

00001296 <ISR_TB_CMP>:
    1296:	1141                	addi	sp,sp,-16
    1298:	c622                	sw	s0,12(sp)
    129a:	0800                	addi	s0,sp,16
    129c:	a001                	j	129c <ISR_TB_CMP+0x6>

0000129e <default_exception_handler_c>:
    129e:	1141                	addi	sp,sp,-16
    12a0:	c622                	sw	s0,12(sp)
    12a2:	0800                	addi	s0,sp,16
    12a4:	a001                	j	12a4 <default_exception_handler_c+0x6>

000012a6 <illegal_insn_handler_c>:
    12a6:	1141                	addi	sp,sp,-16
    12a8:	c622                	sw	s0,12(sp)
    12aa:	0800                	addi	s0,sp,16
    12ac:	a001                	j	12ac <illegal_insn_handler_c+0x6>

000012ae <ecall_insn_handler_c>:
    12ae:	1141                	addi	sp,sp,-16
    12b0:	c622                	sw	s0,12(sp)
    12b2:	0800                	addi	s0,sp,16
    12b4:	a001                	j	12b4 <ecall_insn_handler_c+0x6>
	...

000012b8 <__libc_init_array>:
    12b8:	ff010113          	addi	sp,sp,-16
    12bc:	00812423          	sw	s0,8(sp)
    12c0:	01212023          	sw	s2,0(sp)
    12c4:	00100437          	lui	s0,0x100
    12c8:	00100937          	lui	s2,0x100
    12cc:	00040793          	mv	a5,s0
    12d0:	00090913          	mv	s2,s2
    12d4:	40f90933          	sub	s2,s2,a5
    12d8:	00112623          	sw	ra,12(sp)
    12dc:	00912223          	sw	s1,4(sp)
    12e0:	40295913          	srai	s2,s2,0x2
    12e4:	02090063          	beqz	s2,1304 <__libc_init_array+0x4c>
    12e8:	00040413          	mv	s0,s0
    12ec:	00000493          	li	s1,0
    12f0:	00042783          	lw	a5,0(s0) # 100000 <__init_array_end>
    12f4:	00148493          	addi	s1,s1,1
    12f8:	00440413          	addi	s0,s0,4
    12fc:	000780e7          	jalr	a5
    1300:	fe9918e3          	bne	s2,s1,12f0 <__libc_init_array+0x38>
    1304:	00100437          	lui	s0,0x100
    1308:	00100937          	lui	s2,0x100
    130c:	00040793          	mv	a5,s0
    1310:	00090913          	mv	s2,s2
    1314:	40f90933          	sub	s2,s2,a5
    1318:	40295913          	srai	s2,s2,0x2
    131c:	02090063          	beqz	s2,133c <__libc_init_array+0x84>
    1320:	00040413          	mv	s0,s0
    1324:	00000493          	li	s1,0
    1328:	00042783          	lw	a5,0(s0) # 100000 <__init_array_end>
    132c:	00148493          	addi	s1,s1,1
    1330:	00440413          	addi	s0,s0,4
    1334:	000780e7          	jalr	a5
    1338:	fe9918e3          	bne	s2,s1,1328 <__libc_init_array+0x70>
    133c:	00c12083          	lw	ra,12(sp)
    1340:	00812403          	lw	s0,8(sp)
    1344:	00412483          	lw	s1,4(sp)
    1348:	00012903          	lw	s2,0(sp)
    134c:	01010113          	addi	sp,sp,16
    1350:	00008067          	ret

00001354 <__CTOR_LIST__>:
	...

0000135c <__CTOR_END__>:
	...

Disassembly of section .rodata:

00100000 <__init_array_end>:
  100000:	6e28                	flw	fa0,88(a2)
  100002:	6c75                	lui	s8,0x1d
  100004:	296c                	fld	fa1,208(a0)
	...

Disassembly of section .shbss:

00100007 <.shbss>:
	...

Disassembly of section .data:

00100008 <remu10_table>:
  100008:	0100                	addi	s0,sp,128
  10000a:	0202                	c.slli64	tp
  10000c:	05040303          	lb	t1,80(s0)
  100010:	0605                	addi	a2,a2,1
  100012:	08080707          	0x8080707
  100016:	0009                	c.nop	2

Disassembly of section .bss:

00100018 <KUZNECHIK>:
  100018:	0000                	unimp
	...

Disassembly of section .stack:

00106000 <_stack-0x1000>:
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	2541                	jal	680 <set_gpio_pin_irq_en+0x4>
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
   e:	2e31                	jal	32a <main+0x64>
  10:	0030                	addi	a2,sp,8
