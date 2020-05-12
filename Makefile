CC := g++ # This is the main compiler

SRCDIR := src
TESTSRCDIR := test
BUILDDIR := build
BINDIR := bin
COVDIR := coverage
TESTTARGET := $(BINDIR)/tests
TARGET := $(BINDIR)/app
SRCEXT := cpp
MAIN:=$(SRCDIR)/main.$(SRCEXT)
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
TESTSOURCES := $(shell find $(TESTSRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
CFLAGS := -g # -Wall
LIB := #-pthread -lmongoclient -L lib -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt
INC := -I include

$(TARGET): clean $(OBJECTS)
	@echo " Linking"; 
	@echo " $(CC) build/main.o -o $(TARGET) $(LIB)"; $(CC) build/main.o -o $(TARGET) $(LIB)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT) 
	@echo " Building"
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(BINDIR)
	@echo " $(CC) $(CFLAGS) -c $< $(INC) -o $@ "; $(CC) $(CFLAGS) -c $< $(INC) -o $@

clean:
	@echo " Running Clean"; 
	@echo " $(RM) -r $(BUILDDIR) $(BINDIR) $(COVDIR)"; $(RM) -r $(BUILDDIR) $(BINDIR) $(COVDIR)
	
coverage:
	@echo " Running Coverage"; 
	@mkdir -p $(COVDIR)
	@echo " $(CC) $(SOURCES) $(CFLAGS) --coverage $(INC) -c -o  $(COVDIR)"; $(CC) $(SOURCES) $(CFLAGS) --coverage $(INC) -c -o $(COVDIR)

# Tests
tests: 
	@echo " Running Tests"; 
	@echo " $(RM) -f $(TESTTARGET)*"; $(RM) -f $(TESTTARGET)*
	@mkdir -p $(BINDIR)
	@echo " $(CC) $(CFLAGS) $(TESTSOURCES) $(INC) $(LIB) -o $(TESTTARGET)";$(CC) $(CFLAGS) $(TESTSOURCES) $(INC) $(LIB) -o $(TESTTARGET)
	
run: $(TARGET)
	@echo " Running App"; 
	@echo " ./$(TARGET) $(argc)"; ./$(TARGET) $(argc)

run-tests: tests
	@echo " Running Tests"; 
	@echo " ./$(TESTTARGET)"; ./$(TESTTARGET)

.PHONY: clean


#MAIN := main.cpp
#TESTER := tests/main-tests.cpp

#SRCEXT := cpp
#SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
#OBJECTS := $(patsubst $(SRCDIR)/%,$(OBJDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
#TSTSOURCES := $(shell find $(TSTDIR) -type f -name *.$(SRCEXT))

# -g debug, --coverage para cobertura
#CFLAGS := --coverage -g -Wall -O3 -std=c++11
#INC := -I include/ -I third_party/

#$(OBJDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
#	@mkdir -p $(@D)
#	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

#main: $(OBJECTS)
#	@mkdir -p $(BINDIR)
#	$(CC) $(CFLAGS) $(INC) $(MAIN) $^ -o $(BINDIR)/main

#tests: $(OBJECTS)
#	@mkdir -p $(BINDIR)
#	$(CC) $(CFLAGS) $(INC) $(TESTER) $(TSTSOURCES) $^ -o $(BINDIR)/tester
#	$(BINDIR)/tester

#all: main

#run: main
#	$(BINDIR)/main

#coverage:
#	@mkdir -p coverage/
#	@gcov $(SOURCES) -rlpo build/
#	@$(RM) *.gcda *.gcno

#clean:
#	$(RM) -r $(OBJDIR)/* $(BINDIR)/* coverage/* *.gcda *.gcno

.PHONY: clean coverage