TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#=============================
# Build the IOC application

PROD_IOC = scandinova-rfmod

# scandinova-rfmod.dbd will be created and installed
DBD += scandinova-rfmod.dbd

# scandinova-rfmod.dbd will be made up from base.dbd and module dbds listed below:
scandinova-rfmod_DBD += base.dbd
scandinova-rfmod_DBD += asyn.dbd
scandinova-rfmod_DBD += modbusSupport.dbd
scandinova-rfmod_DBD += drvAsynIPPort.dbd



# scandinova-rfmod_registerRecordDeviceDriver.cpp derives from scandinova-rfmod.dbd
scandinova-rfmod_SRCS += scandinova-rfmod_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
scandinova-rfmod_SRCS_DEFAULT += scandinova-rfmodMain.cpp
scandinova-rfmod_SRCS_vxWorks += -nil-

#=============================
# Add support for the following uncommented modules:

# # AUTOSAVE
#scandinova-rfmod_DBD += asSupport.dbd
#scandinova-rfmod_LIBS += autosave

# # IOC Monitor
#scandinova-rfmod_DBD += iocmon.dbd
#scandinova-rfmod_LIBS += iocmon

# # System Monitor
#scandinova-rfmod_DBD += sysmon.dbd
#scandinova-rfmod_LIBS += sysmon

# # STD
#scandinova-rfmod_DBD += std.dbd
#scandinova-rfmod_LIBS += std

# # ASYN
scandinova-rfmod_LIBS += asyn
scandinova-rfmod_LIBS += modbus

-include ../*.snlprog
#=============================

# Finally link to the EPICS Base libraries
scandinova-rfmod_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

