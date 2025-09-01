# # Compiler and tools
# CC = gcc
# LEX = flex
# YACC = bison

# # Flags
# CFLAGS = -Wall -Ilibntech
# LDFLAGS = 

# # Files
# LEXER = jsonlex.l
# PARSER = jsonparse.y
# OBJS = main.o jsonparse.tab.o lex.yy.o
# TARGET = main

# all: $(TARGET)

# # Final executable
# $(TARGET): $(OBJS)
# 	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)

# # Lexer
# lex.yy.c: $(LEXER)
# 	$(LEX) $(LEXER)

# lex.yy.o: lex.yy.c jsonparse.tab.h
# 	$(CC) $(CFLAGS) -c lex.yy.c

# # Parser (default names)
# jsonparse.tab.c jsonparse.tab.h: $(PARSER)
# 	$(YACC) -d $(PARSER)

# jsonparse.tab.o: jsonparse.tab.c jsonparse.tab.h
# 	$(CC) $(CFLAGS) -c jsonparse.tab.c

# # Main program
# main.o: main.c jsonparse.tab.h
# 	$(CC) $(CFLAGS) -c main.c

# # Clean
# clean:
# 	rm -f $(TARGET) *.o lex.yy.c jsonparse.tab.c jsonparse.tab.h

# .PHONY: all clean

CC = gcc
CFLAGS = -Wall -Ilibntech/libutils
TARGET = main2
LIB = libntech/libntech.a
LIB_OBJS = $(wildcard libntech/libutils/.libs/*.o libntech/libcompat/.libs/*.o)

# External libraries required by libntech
EXT_LIBS = -lyaml -lpcre2-8

all: $(LIB) $(TARGET)

$(LIB): $(LIB_OBJS)
	ar rcs $@ $(LIB_OBJS)

$(TARGET): main2.c $(LIB)
	$(CC) $(CFLAGS) -o $@ main2.c $(LIB) $(EXT_LIBS)

clean:
	rm -f $(TARGET) $(LIB)

.PHONY: all clean
