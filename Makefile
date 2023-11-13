TARGET=hw2

hw2:
	arm-linux-gnueabi-gcc -o $(TARGET) $(TARGET).c matmuls.s
