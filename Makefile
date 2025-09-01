# Compiler and tools
CC = gcc
LEX = flex
YACC = bison

# Flags
CFLAGS = -Wall -Ilibntech/libutils -I.
LDFLAGS =
EXT_LIBS = -lyaml -lpcre2-8

# Target
TARGET = json_parser

# libntech static library
LIB = libntech/libntech.a
LIB_OBJS = $(wildcard libntech/libutils/.libs/*.o libntech/libcompat/.libs/*.o)

# Lexer and parser
LEXER = jsonlex.l
PARSER = jsonparse.y
PARSER_C = jsonparse.tab.c
PARSER_H = jsonparse.tab.h
LEX_C = lex.yy.c

# Additional source
LIBPARSEJSON_C = libparsejson.c
LIBPARSEJSON_H = libparsejson.h

# Object files
OBJS = main.o $(PARSER_C:.c=.o) $(LEX_C:.c=.o) $(LIBPARSEJSON_C:.c=.o)

# Default target
all: $(LIB) $(TARGET)

# Build libntech.a
$(LIB): $(LIB_OBJS)
	ar rcs $@ $(LIB_OBJS)

# Build parser
$(PARSER_C) $(PARSER_H): $(PARSER)
	$(YACC) -d $(PARSER)

$(PARSER_C:.c=.o): %.o: %.c $(PARSER_H)
	$(CC) $(CFLAGS) -c $<

# Build lexer
$(LEX_C): $(LEXER)
	$(LEX) $(LEXER)

lex.yy.o: lex.yy.c $(PARSER_H)
	$(CC) $(CFLAGS) -c lex.yy.c

# Build libparsejson.o
$(LIBPARSEJSON_C:.c=.o): %.o: %.c $(LIBPARSEJSON_H)
	$(CC) $(CFLAGS) -c $<

# Build main program
main.o: main.c $(PARSER_H) $(LIBPARSEJSON_H)
	$(CC) $(CFLAGS) -c main.c

$(TARGET): $(OBJS) $(LIB)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LIB) $(EXT_LIBS)

# Clean
clean:
	rm -f $(TARGET) $(LIB) *.o $(LEX_C) $(PARSER_C) $(PARSER_H)

.PHONY: all clean
