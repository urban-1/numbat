#
# OMNeT++/OMNEST Makefile for numbat
#
# This file was generated with the command:
#  opp_makemake -f --deep --nolink -O out -d src -X. -L../Vlans/out/$(CONFIGNAME)/src -L/media/data/Linux/omnet/inetmanet-inetmanet-00f64c2/out/$(CONFIGNAME)/src -L../PON/out/$(CONFIGNAME)/src -L../PON/out/$(CONFIGNAME) -L./out/$(CONFIGNAME)/src -lVlans -linet -lPON -lPON -KVLANS_PROJ=../Vlans -KINETMANET_PROJ=/media/data/Linux/omnet/inetmanet-inetmanet-00f64c2 -KPON_PROJ=../PON
#

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Other makefile variables (-K)
VLANS_PROJ=../Vlans
INETMANET_PROJ=/media/data/Linux/omnet/inetmanet-inetmanet-00f64c2
PON_PROJ=../PON

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target

all:  submakedirs Makefile
	@# Do nothing

submakedirs:  src_dir

.PHONY: src
src: src_dir

src_dir:
	cd src && $(MAKE)

msgheaders:
	cd src && $(MAKE) msgheaders

clean:
	-rm -rf $O
	-rm -f numbat numbat.exe libnumbat.so libnumbat.a libnumbat.dll libnumbat.dylib

	-cd src && $(MAKE) clean

cleanall: clean
	-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	-cd src && if [ -f Makefile ]; then $(MAKE) depend; fi

