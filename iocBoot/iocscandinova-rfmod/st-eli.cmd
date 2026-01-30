#!../../bin/linux-x86_64/scandinova-rfmod

#- Scandinova Scandicat Modulator IOC Configuration
#- IOC Prefix: LEL:MOD:SCAT
#- Device Type: PPT Modulator
#- Device Group: modulator

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/scandinova-rfmod.dbd"
scandinova_rfmod_registerRecordDeviceDriver(pdbbase) 

## Get IOC version from git tag
epicsEnvSet("IOC_VERSION", "1.0.0")
## Global Configuration
epicsEnvSet("IOC_PREFIX",           "LEL:MOD:SCAT")
epicsEnvSet("PLS_WDTH_SP_HOPR",     "5")      # Pulse width max
epicsEnvSet("FILPS_CURR_SP_HOPR",   "30")     # Filament current max
epicsEnvSet("IONPMP_HIGH",          "8000")   # Ion pump pressure warning
epicsEnvSet("IONPMP_HIHI",          "9000")   # Ion pump pressure alarm

#=============================================================================
# Device: MOD01
# Server: pwelimod001.int.eli-np.ro:502
# V_max: 1200V
#=============================================================================
epicsEnvSet("RFMOD_ID",         "1")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP",     "pwelimod001.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod-lite.cmd

#=============================================================================
# Device: MOD02
# Server: pwelimod002.int.eli-np.ro:502
# V_max: 1200V
#=============================================================================
epicsEnvSet("RFMOD_ID",         "2")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP",     "pwelimod002.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod-lite.cmd

#=============================================================================
# Device: MOD03
# Server: pwelimod003.int.eli-np.ro:502
# V_max: 1200V
#=============================================================================
epicsEnvSet("RFMOD_ID",         "3")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP",     "pwelimod003.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod-lite.cmd

#=============================================================================
# Device: MOD04
# Server: pwelimod004.int.eli-np.ro:502
# V_max: 1270V
#=============================================================================
epicsEnvSet("RFMOD_ID",         "4")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP",     "pwelimod004.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod-lite.cmd


## Enable ASYN_TRACEIO_HEX on octet server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

## Enable ASYN_TRACEIO_HEX on modbus server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 4)

## Enable ASYN_TRACE_ERROR, ASYN_TRACEIO_DEVICE, and ASYN_TRACEIO_DRIVER on modbus server
#asynSetTraceMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 11)

## Load record instances with device-specific configurations (lite version - no optional registers)
dbLoadRecords("../../db/scandinova-rfmod-lite.db","RFMOD_ASYNPORT=RFMod_1, PREFIX=$(IOC_PREFIX):MOD01, CCPS_V_SP_HOPR=1200, PLS_WDTH_SP_HOPR=$(PLS_WDTH_SP_HOPR), FILPS_CURR_SP_HOPR=$(FILPS_CURR_SP_HOPR), IONPMP_HIGH=$(IONPMP_HIGH), IONPMP_HIHI=$(IONPMP_HIHI)")
dbLoadRecords("../../db/scandinova-rfmod-lite.db","RFMOD_ASYNPORT=RFMod_2, PREFIX=$(IOC_PREFIX):MOD02, CCPS_V_SP_HOPR=1200, PLS_WDTH_SP_HOPR=$(PLS_WDTH_SP_HOPR), FILPS_CURR_SP_HOPR=$(FILPS_CURR_SP_HOPR), IONPMP_HIGH=$(IONPMP_HIGH), IONPMP_HIHI=$(IONPMP_HIHI)")
dbLoadRecords("../../db/scandinova-rfmod-lite.db","RFMOD_ASYNPORT=RFMod_3, PREFIX=$(IOC_PREFIX):MOD03, CCPS_V_SP_HOPR=1200, PLS_WDTH_SP_HOPR=$(PLS_WDTH_SP_HOPR), FILPS_CURR_SP_HOPR=$(FILPS_CURR_SP_HOPR), IONPMP_HIGH=$(IONPMP_HIGH), IONPMP_HIHI=$(IONPMP_HIHI)")
dbLoadRecords("../../db/scandinova-rfmod-lite.db","RFMOD_ASYNPORT=RFMod_4, PREFIX=$(IOC_PREFIX):MOD04, CCPS_V_SP_HOPR=1270, PLS_WDTH_SP_HOPR=$(PLS_WDTH_SP_HOPR), FILPS_CURR_SP_HOPR=$(FILPS_CURR_SP_HOPR), IONPMP_HIGH=$(IONPMP_HIGH), IONPMP_HIHI=$(IONPMP_HIHI)")

## Load IOC version information
dbLoadRecords("../../db/ioc-version.db","PREFIX=$(IOC_PREFIX),VERSION=$(IOC_VERSION)")

iocInit()

#=============================================================================
# Post-IOC Initialization - Set Initial Setpoints
#=============================================================================

# MOD01 Initial Values
dbpf $(IOC_PREFIX):MOD01:FILPS:CURR_SP 30
dbpf $(IOC_PREFIX):MOD01:PLS:WDTH_SP 2.5

# MOD02 Initial Values
dbpf $(IOC_PREFIX):MOD02:FILPS:CURR_SP 30
dbpf $(IOC_PREFIX):MOD02:PLS:WDTH_SP 2.5

# MOD03 Initial Values
dbpf $(IOC_PREFIX):MOD03:FILPS:CURR_SP 31
dbpf $(IOC_PREFIX):MOD03:PLS:WDTH_SP 2.5

# MOD04 Initial Values
dbpf $(IOC_PREFIX):MOD04:FILPS:CURR_SP 19.50
dbpf $(IOC_PREFIX):MOD04:PLS:WDTH_SP 2.4

## Display initialization status
echo "=========================================="
echo "Scandinova Scandicat Modulator IOC Initialized"
echo "=========================================="
echo "IOC Prefix:  $(IOC_PREFIX)"
echo "IOC Version: $(IOC_VERSION)"
echo "Devices configured:"
echo "  $(IOC_PREFIX):MOD01 -> pwelimod001.int.eli-np.ro:502 (Vmax: 1200V)"
echo "  $(IOC_PREFIX):MOD02 -> pwelimod002.int.eli-np.ro:502 (Vmax: 1200V)"
echo "  $(IOC_PREFIX):MOD03 -> pwelimod003.int.eli-np.ro:502 (Vmax: 1200V)"
echo "  $(IOC_PREFIX):MOD04 -> pwelimod004.int.eli-np.ro:502 (Vmax: 1270V)"
echo "Global limits:"
echo "  Pulse width max:       $(PLS_WDTH_SP_HOPR) us"
echo "  Filament current max:  $(FILPS_CURR_SP_HOPR) A"
echo "  Ion pump warning:      $(IONPMP_HIGH) nA"
echo "  Ion pump alarm:        $(IONPMP_HIHI) nA"
echo "=========================================="

