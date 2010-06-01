# -*- makefile -*-
# Generated by genmk.rb, please don't edit!

COMMON_CFLAGS += -I$(GRUB_CONTRIB)/zfs/include

pkglib_MODULES += zfs.mod
zfs_mod_SOURCES = $(GRUB_CONTRIB)/zfs/zfs.c $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $(GRUB_CONTRIB)/zfs/zfs_sha256.c $(GRUB_CONTRIB)/zfs/zfs_fletcher.c

clean-module-zfs.mod.1:
	rm -f zfs.mod mod-zfs.o mod-zfs.c pre-zfs.o zfs_mod-__GRUB_CONTRIB__zfs_zfs.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.o und-zfs.lst

CLEAN_MODULE_TARGETS += clean-module-zfs.mod.1

clean-module-zfs.mod-symbol.1:
	rm -f def-zfs.lst

CLEAN_MODULE_TARGETS += clean-module-zfs.mod-symbol.1
DEFSYMFILES += def-zfs.lst
mostlyclean-module-zfs.mod.1:
	rm -f zfs_mod-__GRUB_CONTRIB__zfs_zfs.d zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.d zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.d zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.d

MOSTLYCLEAN_MODULE_TARGETS += mostlyclean-module-zfs.mod.1
UNDSYMFILES += und-zfs.lst

ifeq ($(TARGET_NO_MODULES), yes)
zfs.mod: pre-zfs.o $(TARGET_OBJ2ELF)
	-rm -f $@
	$(TARGET_CC) $(zfs_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@ pre-zfs.o
	if test ! -z "$(TARGET_OBJ2ELF)"; then ./$(TARGET_OBJ2ELF) $@ || (rm -f $@; exit 1); fi
	if test x$(TARGET_NO_STRIP) != xyes ; then $(STRIP) --strip-unneeded -K grub_mod_init -K grub_mod_fini -K _grub_mod_init -K _grub_mod_fini -R .note -R .comment $@; fi
else
ifneq ($(TARGET_APPLE_CC),1)
zfs.mod: pre-zfs.o mod-zfs.o $(TARGET_OBJ2ELF)
	-rm -f $@
	$(TARGET_CC) $(zfs_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@ pre-zfs.o mod-zfs.o
	if test ! -z "$(TARGET_OBJ2ELF)"; then ./$(TARGET_OBJ2ELF) $@ || (rm -f $@; exit 1); fi
	if test x$(TARGET_NO_STRIP) != xyes ; then $(STRIP) --strip-unneeded -K grub_mod_init -K grub_mod_fini -K _grub_mod_init -K _grub_mod_fini -R .note -R .comment $@; fi
else
zfs.mod: pre-zfs.o mod-zfs.o $(TARGET_OBJ2ELF)
	-rm -f $@
	-rm -f $@.bin
	$(TARGET_CC) $(zfs_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@.bin pre-zfs.o mod-zfs.o
	$(OBJCONV) -f$(TARGET_MODULE_FORMAT) -nr:_grub_mod_init:grub_mod_init -nr:_grub_mod_fini:grub_mod_fini -wd1106 -ew2030 -ew2050 -nu -nd $@.bin $@
	-rm -f $@.bin
endif
endif

pre-zfs.o: $(zfs_mod_DEPENDENCIES) zfs_mod-__GRUB_CONTRIB__zfs_zfs.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.o
	-rm -f $@
	$(TARGET_CC) $(zfs_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@ zfs_mod-__GRUB_CONTRIB__zfs_zfs.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.o zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.o

mod-zfs.o: mod-zfs.c
	$(TARGET_CC) $(TARGET_CPPFLAGS) $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -DGRUB_FILE=\"mod-zfs.c\" -c -o $@ $<

mod-zfs.c: $(builddir)/moddep.lst $(srcdir)/genmodsrc.sh
	sh $(srcdir)/genmodsrc.sh 'zfs' $< > $@ || (rm -f $@; exit 1)

ifneq ($(TARGET_APPLE_CC),1)
def-zfs.lst: pre-zfs.o
	$(NM) -g --defined-only -P -p $< | sed 's/^\([^ ]*\).*/\1 zfs/' > $@
else
def-zfs.lst: pre-zfs.o
	$(NM) -g -P -p $< | grep -E '^[a-zA-Z0-9_]* [TDS]'  | sed 's/^\([^ ]*\).*/\1 zfs/' > $@
endif

und-zfs.lst: pre-zfs.o
	echo 'zfs' > $@
	$(NM) -u -P -p $< | cut -f1 -d' ' >> $@

zfs_mod-__GRUB_CONTRIB__zfs_zfs.o: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES)
	$(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -DGRUB_FILE=\"$(GRUB_CONTRIB)/zfs/zfs.c\" -MD -c -o $@ $<
-include zfs_mod-__GRUB_CONTRIB__zfs_zfs.d

clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs-extra.1:
	rm -f cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst video-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst

CLEAN_MODULE_TARGETS += clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs-extra.1

COMMANDFILES += cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst
FSFILES += fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst
PARTTOOLFILES += parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst
PARTMAPFILES += partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst
HANDLERFILES += handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst
TERMINALFILES += terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst
VIDEOFILES += video-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst

cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) gencmdlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/gencmdlist.sh zfs > $@ || (rm -f $@; exit 1)

fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) genfslist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genfslist.sh zfs > $@ || (rm -f $@; exit 1)

parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) genparttoollist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genparttoollist.sh zfs > $@ || (rm -f $@; exit 1)

partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) genpartmaplist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genpartmaplist.sh zfs > $@ || (rm -f $@; exit 1)

handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) genhandlerlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genhandlerlist.sh zfs > $@ || (rm -f $@; exit 1)

terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) genterminallist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genterminallist.sh zfs > $@ || (rm -f $@; exit 1)

video-zfs_mod-__GRUB_CONTRIB__zfs_zfs.lst: $(GRUB_CONTRIB)/zfs/zfs.c $($(GRUB_CONTRIB)/zfs/zfs.c_DEPENDENCIES) genvideolist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genvideolist.sh zfs > $@ || (rm -f $@; exit 1)

zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.o: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES)
	$(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -DGRUB_FILE=\"$(GRUB_CONTRIB)/zfs/zfs_lzjb.c\" -MD -c -o $@ $<
-include zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.d

clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb-extra.1:
	rm -f cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst

CLEAN_MODULE_TARGETS += clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb-extra.1

COMMANDFILES += cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst
FSFILES += fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst
PARTTOOLFILES += parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst
PARTMAPFILES += partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst
HANDLERFILES += handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst
TERMINALFILES += terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst
VIDEOFILES += video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst

cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) gencmdlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/gencmdlist.sh zfs > $@ || (rm -f $@; exit 1)

fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) genfslist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genfslist.sh zfs > $@ || (rm -f $@; exit 1)

parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) genparttoollist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genparttoollist.sh zfs > $@ || (rm -f $@; exit 1)

partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) genpartmaplist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genpartmaplist.sh zfs > $@ || (rm -f $@; exit 1)

handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) genhandlerlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genhandlerlist.sh zfs > $@ || (rm -f $@; exit 1)

terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) genterminallist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genterminallist.sh zfs > $@ || (rm -f $@; exit 1)

video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_lzjb.lst: $(GRUB_CONTRIB)/zfs/zfs_lzjb.c $($(GRUB_CONTRIB)/zfs/zfs_lzjb.c_DEPENDENCIES) genvideolist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genvideolist.sh zfs > $@ || (rm -f $@; exit 1)

zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.o: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES)
	$(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -DGRUB_FILE=\"$(GRUB_CONTRIB)/zfs/zfs_sha256.c\" -MD -c -o $@ $<
-include zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.d

clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256-extra.1:
	rm -f cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst

CLEAN_MODULE_TARGETS += clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256-extra.1

COMMANDFILES += cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst
FSFILES += fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst
PARTTOOLFILES += parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst
PARTMAPFILES += partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst
HANDLERFILES += handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst
TERMINALFILES += terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst
VIDEOFILES += video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst

cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) gencmdlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/gencmdlist.sh zfs > $@ || (rm -f $@; exit 1)

fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) genfslist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genfslist.sh zfs > $@ || (rm -f $@; exit 1)

parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) genparttoollist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genparttoollist.sh zfs > $@ || (rm -f $@; exit 1)

partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) genpartmaplist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genpartmaplist.sh zfs > $@ || (rm -f $@; exit 1)

handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) genhandlerlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genhandlerlist.sh zfs > $@ || (rm -f $@; exit 1)

terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) genterminallist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genterminallist.sh zfs > $@ || (rm -f $@; exit 1)

video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_sha256.lst: $(GRUB_CONTRIB)/zfs/zfs_sha256.c $($(GRUB_CONTRIB)/zfs/zfs_sha256.c_DEPENDENCIES) genvideolist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genvideolist.sh zfs > $@ || (rm -f $@; exit 1)

zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.o: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES)
	$(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -DGRUB_FILE=\"$(GRUB_CONTRIB)/zfs/zfs_fletcher.c\" -MD -c -o $@ $<
-include zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.d

clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher-extra.1:
	rm -f cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst

CLEAN_MODULE_TARGETS += clean-module-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher-extra.1

COMMANDFILES += cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst
FSFILES += fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst
PARTTOOLFILES += parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst
PARTMAPFILES += partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst
HANDLERFILES += handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst
TERMINALFILES += terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst
VIDEOFILES += video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst

cmd-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) gencmdlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/gencmdlist.sh zfs > $@ || (rm -f $@; exit 1)

fs-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) genfslist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genfslist.sh zfs > $@ || (rm -f $@; exit 1)

parttool-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) genparttoollist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genparttoollist.sh zfs > $@ || (rm -f $@; exit 1)

partmap-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) genpartmaplist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genpartmaplist.sh zfs > $@ || (rm -f $@; exit 1)

handler-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) genhandlerlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genhandlerlist.sh zfs > $@ || (rm -f $@; exit 1)

terminal-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) genterminallist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genterminallist.sh zfs > $@ || (rm -f $@; exit 1)

video-zfs_mod-__GRUB_CONTRIB__zfs_zfs_fletcher.lst: $(GRUB_CONTRIB)/zfs/zfs_fletcher.c $($(GRUB_CONTRIB)/zfs/zfs_fletcher.c_DEPENDENCIES) genvideolist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfs_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genvideolist.sh zfs > $@ || (rm -f $@; exit 1)

zfs_mod_CFLAGS = $(COMMON_CFLAGS) -Wno-error
zfs_mod_LDFLAGS = $(COMMON_LDFLAGS)

pkglib_MODULES += zfsinfo.mod
zfsinfo_mod_SOURCES = $(GRUB_CONTRIB)/zfs/zfsinfo.c

clean-module-zfsinfo.mod.1:
	rm -f zfsinfo.mod mod-zfsinfo.o mod-zfsinfo.c pre-zfsinfo.o zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.o und-zfsinfo.lst

CLEAN_MODULE_TARGETS += clean-module-zfsinfo.mod.1

clean-module-zfsinfo.mod-symbol.1:
	rm -f def-zfsinfo.lst

CLEAN_MODULE_TARGETS += clean-module-zfsinfo.mod-symbol.1
DEFSYMFILES += def-zfsinfo.lst
mostlyclean-module-zfsinfo.mod.1:
	rm -f zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.d

MOSTLYCLEAN_MODULE_TARGETS += mostlyclean-module-zfsinfo.mod.1
UNDSYMFILES += und-zfsinfo.lst

ifeq ($(TARGET_NO_MODULES), yes)
zfsinfo.mod: pre-zfsinfo.o $(TARGET_OBJ2ELF)
	-rm -f $@
	$(TARGET_CC) $(zfsinfo_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@ pre-zfsinfo.o
	if test ! -z "$(TARGET_OBJ2ELF)"; then ./$(TARGET_OBJ2ELF) $@ || (rm -f $@; exit 1); fi
	if test x$(TARGET_NO_STRIP) != xyes ; then $(STRIP) --strip-unneeded -K grub_mod_init -K grub_mod_fini -K _grub_mod_init -K _grub_mod_fini -R .note -R .comment $@; fi
else
ifneq ($(TARGET_APPLE_CC),1)
zfsinfo.mod: pre-zfsinfo.o mod-zfsinfo.o $(TARGET_OBJ2ELF)
	-rm -f $@
	$(TARGET_CC) $(zfsinfo_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@ pre-zfsinfo.o mod-zfsinfo.o
	if test ! -z "$(TARGET_OBJ2ELF)"; then ./$(TARGET_OBJ2ELF) $@ || (rm -f $@; exit 1); fi
	if test x$(TARGET_NO_STRIP) != xyes ; then $(STRIP) --strip-unneeded -K grub_mod_init -K grub_mod_fini -K _grub_mod_init -K _grub_mod_fini -R .note -R .comment $@; fi
else
zfsinfo.mod: pre-zfsinfo.o mod-zfsinfo.o $(TARGET_OBJ2ELF)
	-rm -f $@
	-rm -f $@.bin
	$(TARGET_CC) $(zfsinfo_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@.bin pre-zfsinfo.o mod-zfsinfo.o
	$(OBJCONV) -f$(TARGET_MODULE_FORMAT) -nr:_grub_mod_init:grub_mod_init -nr:_grub_mod_fini:grub_mod_fini -wd1106 -ew2030 -ew2050 -nu -nd $@.bin $@
	-rm -f $@.bin
endif
endif

pre-zfsinfo.o: $(zfsinfo_mod_DEPENDENCIES) zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.o
	-rm -f $@
	$(TARGET_CC) $(zfsinfo_mod_LDFLAGS) $(TARGET_LDFLAGS) -Wl,-r,-d -o $@ zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.o

mod-zfsinfo.o: mod-zfsinfo.c
	$(TARGET_CC) $(TARGET_CPPFLAGS) $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -DGRUB_FILE=\"mod-zfsinfo.c\" -c -o $@ $<

mod-zfsinfo.c: $(builddir)/moddep.lst $(srcdir)/genmodsrc.sh
	sh $(srcdir)/genmodsrc.sh 'zfsinfo' $< > $@ || (rm -f $@; exit 1)

ifneq ($(TARGET_APPLE_CC),1)
def-zfsinfo.lst: pre-zfsinfo.o
	$(NM) -g --defined-only -P -p $< | sed 's/^\([^ ]*\).*/\1 zfsinfo/' > $@
else
def-zfsinfo.lst: pre-zfsinfo.o
	$(NM) -g -P -p $< | grep -E '^[a-zA-Z0-9_]* [TDS]'  | sed 's/^\([^ ]*\).*/\1 zfsinfo/' > $@
endif

und-zfsinfo.lst: pre-zfsinfo.o
	echo 'zfsinfo' > $@
	$(NM) -u -P -p $< | cut -f1 -d' ' >> $@

zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.o: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES)
	$(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -DGRUB_FILE=\"$(GRUB_CONTRIB)/zfs/zfsinfo.c\" -MD -c -o $@ $<
-include zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.d

clean-module-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo-extra.1:
	rm -f cmd-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst fs-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst partmap-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst handler-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst parttool-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst video-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst terminal-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst

CLEAN_MODULE_TARGETS += clean-module-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo-extra.1

COMMANDFILES += cmd-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst
FSFILES += fs-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst
PARTTOOLFILES += parttool-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst
PARTMAPFILES += partmap-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst
HANDLERFILES += handler-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst
TERMINALFILES += terminal-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst
VIDEOFILES += video-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst

cmd-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) gencmdlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/gencmdlist.sh zfsinfo > $@ || (rm -f $@; exit 1)

fs-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) genfslist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genfslist.sh zfsinfo > $@ || (rm -f $@; exit 1)

parttool-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) genparttoollist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genparttoollist.sh zfsinfo > $@ || (rm -f $@; exit 1)

partmap-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) genpartmaplist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genpartmaplist.sh zfsinfo > $@ || (rm -f $@; exit 1)

handler-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) genhandlerlist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genhandlerlist.sh zfsinfo > $@ || (rm -f $@; exit 1)

terminal-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) genterminallist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genterminallist.sh zfsinfo > $@ || (rm -f $@; exit 1)

video-zfsinfo_mod-__GRUB_CONTRIB__zfs_zfsinfo.lst: $(GRUB_CONTRIB)/zfs/zfsinfo.c $($(GRUB_CONTRIB)/zfs/zfsinfo.c_DEPENDENCIES) genvideolist.sh
	set -e; 	  $(TARGET_CC) -I$(GRUB_CONTRIB)/zfs -I$(srcdir)/$(GRUB_CONTRIB)/zfs $(TARGET_CPPFLAGS)  $(TARGET_CFLAGS) $(zfsinfo_mod_CFLAGS) -E $< 	  | sh $(srcdir)/genvideolist.sh zfsinfo > $@ || (rm -f $@; exit 1)

zfsinfo_mod_CFLAGS = $(COMMON_CFLAGS) -Wno-error
zfsinfo_mod_LDFLAGS = $(COMMON_LDFLAGS)
