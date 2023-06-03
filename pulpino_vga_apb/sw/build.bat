cd vga_accel
make
hexdump -v -e '"%%08x\n"' vga_accel_emb_text.bin >../vga_accel_emb_text.dat
hexdump -v -e '"%%08x\n"' vga_accel_emb_data.bin >../vga_accel_emb_data.dat
pause
