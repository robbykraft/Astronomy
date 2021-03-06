# Linux (default)
EXE1 = console
EXE2 = orientation1
EXE3 = orientation2
CFLAGS = -std=gnu99
LDFLAGS1 = -lm
LDFLAGS2 = -lGL -lGLU -lglut -lm

# Windows (cygwin)
ifeq "$(OS)" "Windows_NT"
	EXE1 = console.exe
	EXE2 = orientation1.exe
	EXE3 = orientation2.exe
	LDFLAGS1 =
	LDFLAGS2 = -lopengl32 -lglu32 -lglut32
endif

# OS X, OSTYPE not being declared
ifndef OSTYPE
  OSTYPE = $(shell uname -s|awk '{print tolower($$0)}')
  #export OSTYPE
endif
ifeq ($(OSTYPE),darwin)
	LDFLAGS1 = -framework Carbon -Wno-deprecated
	LDFLAGS2 = -framework Carbon -framework OpenGL -framework GLUT -Wno-deprecated
endif

all: $(EXE1) $(EXE2) $(EXE3)

$(EXE1): examples/$(EXE1).c
	@mkdir -p bin
	gcc -o bin/$(EXE1) $< $(CFLAGS) $(LDFLAGS1)

$(EXE2): examples/$(EXE2).c
	@mkdir -p bin
	gcc -o bin/$(EXE2) $< $(CFLAGS) $(LDFLAGS2)

$(EXE3): examples/$(EXE3).c
	@mkdir -p bin
	gcc -o bin/$(EXE3) $< $(CFLAGS) $(LDFLAGS2)

run:
	./bin/$(EXE1) $(ARGS)

run1:
	./bin/$(EXE2) $(ARGS)

run2:
	./bin/$(EXE3) $(ARGS)

