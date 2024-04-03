# Nombre del ejecutable
TARGET = secret

# Archivo principal COBOL
MAIN = main.cbl

# Objetos COBOL
OBJS = $(patsubst %.cob, %.o, $(wildcard *.cob))

# Objetos C
OBJC = $(patsubst %.c, %.o, $(wildcard *.c))

# Compilador COBOL
COBOL = cobc

# Compilador C
CC = gcc

# Opciones de compilación
COBFLAGS = -Wall -lcrypto

# Regla principal para compilar el programa
$(TARGET): $(OBJS) $(OBJC)
	$(COBOL) $(COBFLAGS) -x -o $@ $(MAIN) $(OBJS) $(OBJC)

# Regla para compilar los objetos C
%.o: %.c
	$(CC) -w -c $< -o $@ 

# Regla para compilar los objetos COBOL
%.o: %.cbl
	$(COBOL) $(COBFLAGS) -c $<

# Regla para ejecutar el programa
run: $(TARGET)
	./$(TARGET)

# Regla para limpiar los archivos generados
clean:
	rm -f $(TARGET) $(OBJS) $(OBJC)