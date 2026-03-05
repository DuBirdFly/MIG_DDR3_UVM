TB_TOP ?= Top
TESTNAME ?= Test

RUN_DIR = run_case.$(TESTNAME)

.PHONY: base vcs simv verdi all clean

######################################################
base:
	mkdir -p $(RUN_DIR)
	mkdir -p $(RUN_DIR)/log
	mkdir -p $(RUN_DIR)/output
	mkdir -p $(RUN_DIR)/output/wave
	cd $(RUN_DIR) && ln -sf ../base
	cd $(RUN_DIR) && ln -sf ../../../dut
	cd $(RUN_DIR) && ln -sf ../../../sim
	cd $(RUN_DIR) && ln -sf ../../../memory

######################################################
# note: 指定 -o 包括了 simv 和 simv.daidir
# note: 指定 -Mdir 包括了 csrc 和 vc_hdrs.h

# VCS  = vcs -full64 -LDFLAGS -Wl,--no-as-needed
VCS  = vcs -full64
VCS += -file ./base/option/compile_base.f
VCS += -file ./base/option/compile_define.f
VCS += -file ./base/option/compile_uvm.f
VCS += -file ./base/option/compile_filelist.f
VCS += +optconfigfile+./base/option/vcs.cfg
VCS += -l ./log/vcs.log
VCS += -o ./output/simv
VCS += -Mdir=./output/csrc
VCS += -top $(TB_TOP)

vcs:
	cd $(RUN_DIR) && $(VCS)

######################################################
SIMV  = ./output/simv +UVM_TESTNAME=$(TESTNAME)
SIMV += -f ./base/option/simulate_base.f
SIMV += -l ./log/simv.log
SIMV += -k ./output/ucli.key

simv:
	cd $(RUN_DIR) && $(SIMV) && rm -rf novas_dump.log

######################################################
clean:
	cd $(RUN_DIR) && find . -maxdepth 1 -type l -delete

######################################################
all:
	$(MAKE) base
	$(MAKE) vcs
	$(MAKE) simv
	$(MAKE) clean

######################################################
VERDI  = verdi
VERDI += -ssf ./output/wave/novas.vf
VERDI += -dbdir ./output/simv.daidir
VERDI += -logdir ./log/verdiLog
VERDI += -rcFile ../base/novas/novas.rc
VERDI += -guiConf ../base/novas/novas.conf

verdi:
	cd $(RUN_DIR) && $(VERDI) &
