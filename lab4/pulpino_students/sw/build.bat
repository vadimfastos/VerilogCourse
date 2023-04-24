cd test_sw
make
hexdump -v -e '"%%08x\n"' test_sw_emb_text.bin >../test_sw_emb_text.dat
hexdump -v -e '"%%08x\n"' test_sw_emb_data.bin >../test_sw_emb_data.dat
pause
