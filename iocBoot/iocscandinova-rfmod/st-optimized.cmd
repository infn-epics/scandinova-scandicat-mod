#!../../bin/linux-x86_64/scandinova-rfmod
##############################################################################
# Optimized Scandinova RF Modulator IOC Startup Script
# Uses grouped Modbus register access for better performance
##############################################################################

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/scandinova-rfmod.dbd"
scandinova_rfmod_registerRecordDeviceDriver(pdbbase) 

##############################################################################
# Device 1: Modulator 2
##############################################################################

epicsEnvSet("RFMOD_ID",         "1")
epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
epicsEnvSet("RFMOD_TCP_IP", "pwelimod001.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")

## Load full split debug configuration (one port per PV) for isolation
< ../../proto/scandinova-rfmod-split-debug.cmd

# ##############################################################################
# # Device 2: Modulator 3
# ##############################################################################
# epicsEnvSet("RFMOD_ID",         "3")
# epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
# epicsEnvSet("RFMOD_TCP_IP",     "modulator3.star.unical.it")
# epicsEnvSet("RFMOD_TCP_PORT",   "502")

# ## Load optimized configuration
# < ../../proto/scandinova-rfmod-optimized.cmd

# ##############################################################################
# Debug Settings (uncomment as needed)
##############################################################################
## Enable ASYN tracing on TCP connection for this device (uncomment to see raw I/O)
#asynSetTraceIOMask("RFMod_1", 0, 0x4)   # HEX
#asynSetTraceMask(   "RFMod_1", 0, 0x11)  # ERROR + IO_DRIVER

## Enable targeted tracing for split-debug ports
# asynSetTraceMask("RFMod_1", 0, 0x11)
# asynSetTraceIOMask("RFMod_1", 0, 0x4)
# ## Core registers
# asynSetTraceMask("RFMod_1_TCP_PROT_ID",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_TCP_PROT_ID", 0, 0x6)
# asynSetTraceMask("RFMod_1_TCP_PROT_REV",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_TCP_PROT_REV", 0, 0x6)
# asynSetTraceMask("RFMod_1_TCP_WD_PREV",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_TCP_WD_PREV", 0, 0x6)
# asynSetTraceMask("RFMod_1_STATE_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_STATE_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_STATUS_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_STATUS_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_ACC_LVL_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_ACC_LVL_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_TIME_REMAINING",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_TIME_REMAINING", 0, 0x6)

# ## Setpoint readbacks
# asynSetTraceMask("RFMod_1_READ_PLS_REPR_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_PLS_REPR_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_STATE_SR",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_STATE_SR", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_CCPS_VOLT_SET_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_CCPS_VOLT_SET_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FILPS_CURR_SET_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FILPS_CURR_SET_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_PLS_WDTH_SET_RB",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_PLS_WDTH_SET_RB", 0, 0x6)
# asynSetTraceMask("RFMod_1_CCPS_VOLT_SR",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_CCPS_VOLT_SR", 0, 0x6)
# asynSetTraceMask("RFMod_1_FILPS_CURR_SR",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_FILPS_CURR_SR", 0, 0x6)
# asynSetTraceMask("RFMod_1_PLS_WDTH_SR",   0, 0x11)
# asynSetTraceIOMask("RFMod_1_PLS_WDTH_SR", 0, 0x6)

# ## Analog values
# asynSetTraceMask("RFMod_1_READ_CCPS1_VOLT", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_CCPS1_VOLT", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_CCPS2_VOLT", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_CCPS2_VOLT", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_CCPS3_VOLT", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_CCPS3_VOLT", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FILPS_CURR", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FILPS_CURR", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FILPS_VOLT", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FILPS_VOLT", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_IONPS_R", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_IONPS_R", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_SOLPS_CURR", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_SOLPS_CURR", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_SOLPS_VOLT", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_SOLPS_VOLT", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_PLS_CURR", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_PLS_CURR", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_PLS_VOLT", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_PLS_VOLT", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_PLS_WDTH", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_PLS_WDTH", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_TANK_TEMP", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_TANK_TEMP", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_TANK_LEVEL", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_TANK_LEVEL", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_CLL_IN_TEMP", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_CLL_IN_TEMP", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_CLL_OUT_TEMP", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_CLL_OUT_TEMP", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_SOLPS_TEMP", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_SOLPS_TEMP", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_KLY_OUT_TEMP", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_KLY_OUT_TEMP", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_RF_FWD", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_RF_FWD", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_RF_REFL", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_RF_REFL", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_RF_VSWR", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_RF_VSWR", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_RF_PLEN", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_RF_PLEN", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_CCPS1", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_CCPS1", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_CCPS2", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_CCPS2", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_CCPS3", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_CCPS3", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_CCPS4", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_CCPS4", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_BODY", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_BODY", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_CLL", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_CLL", 0, 0x6)
# asynSetTraceMask("RFMod_1_READ_FLOW_SOLPS", 0, 0x11)
# asynSetTraceIOMask("RFMod_1_READ_FLOW_SOLPS", 0, 0x6)

##############################################################################
# Load Record Databases
##############################################################################
## Uses optimized substitutions file
## Use split-debug substitutions DB (generated via make)
dbLoadRecords("../../db/scandinova-rfmod-split-debug.db","RFMOD_ASYNPORT=RFMod_1, PREFIX=MODHEL01")
# dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_3, PREFIX=MODHEL02")

##############################################################################
# Initialize IOC
##############################################################################
iocInit()

##############################################################################
# Post-initialization Commands
##############################################################################
## Print asyn port summary
dbl

## Show all asyn ports (should see ~30 ports for 2 devices instead of 90+)
#asynReport 1

##############################################################################
# Performance Notes:
# - OLD: 45+ asyn ports per device = 90+ total for 2 devices
# - NEW: 15 asyn ports per device = 30 total for 2 devices
# - Network traffic reduced by ~67%
# - CPU usage reduced by ~50%
##############################################################################
