TARGET=hw2

all:
	arm-linux-gnueabi-gcc -o $(TARGET) $(TARGET).c matmul.s
