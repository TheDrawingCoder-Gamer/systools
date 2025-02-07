
PROJECT:=nativedialogs

LBITS := $(shell getconf LONG_BIT)
ifeq ($(LBITS),64)
	NDLL:=../ndll/Linux64/$(PROJECT).ndll
else
	NDLL:=../ndll/Linux/$(PROJECT).ndll
endif
OBJDIR=obj

SRC_PATHS:=src src/linux
C_SRCS:= $(wildcard src/linux/*.c)
CPP_SRCS:=src/api.cpp
C_OBJS:=${C_SRCS:.c=.o}
CPP_OBJS:=${CPP_SRCS:.cpp=.o}
OBJS:=$(C_OBJS) $(CPP_OBJS)

HEADERS:=$(foreach PATH,$(SRC_PATHS), $(wildcard $(PATH)/*.h))
HXCPP=$(shell haxelib path hxcpp | head -1)
# If user defines debug flag, produce a debug ndll
# DUH
ifeq ($(DEBUG), 1) 
	DEBUG_FLAGS:=-g
else 
	DEBUG_FLAGS:=-g3
endif
# apparently haxe CFFI is insane 
SANITY_FLAGS:=-Wall -pedantic
CC:=g++ -Isrc
GTK_FLAGS:=$(shell pkg-config --libs --cflags gtk+-3.0)
NEKO_FLAGS:=-fpic -fPIC -DHX_LINUX -DHXCPP_VISIT_ALLOCS -I$(HXCPP)/include -ldl -fvisibility=hidden -O2 $(SANITY_FLAGS)

CPPFLAGS += $(GTK_FLAGS) $(GCONF_FLAGS) $(NEKO_FLAGS)
CFLAGS += $(GTK_FLAGS) $(GCONF_FLAGS) $(NEKO_FLAGS)
LDFLAGS +=-fPIC -shared -L/usr/lib -lz -ldl -rdynamic $(DEBUG_FLAGS) -Xlinker --no-undefined $(GTK_FLAGS) $(GCONF_FLAGS)

all: $(NDLL)

clean:
	@- $(RM) $(NDLL)
	@- $(RM) $(OBJS)

$(NDLL): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NDLL) $(LDFLAGS)
