all: build run

build: 
	nasm -f bin sector.asm -o boot_sector.bin
run:
	qemu-system-x86_64 boot_sector.bin 
xxd:
	xxd boot_sector.bin