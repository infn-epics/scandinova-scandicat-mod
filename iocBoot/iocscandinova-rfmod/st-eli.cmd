#!../../bin/linux-x86_64/scandinova-rfmod

#- You may have to change scandinova-rfmod to something else
#- everywhere it appears in this file

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/scandinova-rfmod.dbd"
scandinova_rfmod_registerRecordDeviceDriver(pdbbase) 

epicsEnvSet("RFMOD_ID",         "1")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP", "pwelimod001.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod.cmd

epicsEnvSet("RFMOD_ID",         "2")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP", "pwelimod002.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod.cmd

epicsEnvSet("RFMOD_ID",         "3")
epicsEnvSet("RFMOD_SLAVE_ADDR", "0")
epicsEnvSet("RFMOD_TCP_IP", "pwelimod003.int.eli-np.ro")
epicsEnvSet("RFMOD_TCP_PORT",   "502")
< ../../proto/scandinova-rfmod.cmd


## Enable ASYN_TRACEIO_HEX on octet server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

## Enable ASYN_TRACEIO_HEX on modbus server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 4)

## Enable ASYN_TRACE_ERROR, ASYN_TRACEIO_DEVICE, and ASYN_TRACEIO_DRIVER on modbus server
#asynSetTraceMask("$(RFMOD_ASYNPORT)_TCP_PROT_ID", 0, 11)

## Load record instances
## You can override default macros per device:
##   HOPR macros: CCPS_V_SP_HOPR (default=1500), PLS_WDTH_SP_HOPR (default=10), FILPS_CURR_SP_HOPR (default=30)
##   Alarm macros: IONPMP_HIGH (default=8000), IONPMP_HIHI (default=9000)
dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_1, PREFIX=MODHEL01, IONPMP_HIGH=7500, IONPMP_HIHI=8500, CCPS_V_SP_HOPR=1270")
dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_2, PREFIX=MODHEL02, IONPMP_HIGH=7500, IONPMP_HIHI=8500, CCPS_V_SP_HOPR=1270")
dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_3, PREFIX=MODHEL03, IONPMP_HIGH=7500, IONPMP_HIHI=8500, CCPS_V_SP_HOPR=1270")

## Example with custom values for a specific device:
#dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_1, PREFIX=MODHEL01, IONPMP_HIGH=7500, IONPMP_HIHI=8500, CCPS_V_SP_HOPR=2000")

# dbLoadRecords("../../db/scandinova-rfmod.db","RFMOD_ASYNPORT=RFMod_3, PREFIX=MODHEL02")

iocInit()

