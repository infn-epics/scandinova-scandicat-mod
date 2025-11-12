##epicsEnvSet("RFMOD_ID",         "1")
##epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
##epicsEnvSet("RFMOD_TCP_IP",     "10.5.2.131")
##epicsEnvSet("RFMOD_TCP_PORT",   "502")

epicsEnvSet("RFMOD_ASYNPORT", "RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_MSGS", "SCN_RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_POLLING", "4000")
epicsEnvSet("RFMOD_WD_POLLING", "2000")
epicsEnvSet("RFMOD_WD_WRITE_POLLING", "800")

## TCP/IP port
drvAsynIPPortConfigure("$(RFMOD_ASYNPORT)","$(RFMOD_TCP_IP):$(RFMOD_TCP_PORT)",0,0,1)
modbusInterposeConfig("$(RFMOD_ASYNPORT)", 0, 0, 1)

## Per-PV split ports (Function 4 Read Input Registers)
## Use FLOAT32_LE (7) for all unless noted

## Core TCP/Status registers needed by tcp/wd/specific templates
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_PROT_ID",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 0,  1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_PROT_REV", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 1,  1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_WD_PREV",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 2,  1, 0, $(RFMOD_WD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_RB",     "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 3,  1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATUS_RB",    "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 4,  1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_ACC_LVL_RB",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 5,  1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TIME_REMAINING","$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 6,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Status / Protocol derived PVs
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_PLS_REPR_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 8,   2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Setpoint readbacks
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_SR",          "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 20, 1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS_VOLT_SET_RB",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 21,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FILPS_CURR_SET_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 23,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_PLS_WDTH_SET_RB",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 25,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
## Optional discrete ports mirroring readbacks, if templates expect specific names
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT_SR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 21,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR_SR","$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 23,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_WDTH_SR",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 25,  2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## CCPS voltages
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS1_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 100, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS2_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 102, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS3_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 104, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Filament PS
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FILPS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 200, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FILPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 202, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Ion pump
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_IONPS_R",    "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 300, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Solenoid PS
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_SOLPS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 400, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_SOLPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 402, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Pulse measurements
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_PLS_CURR",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 500, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_PLS_VOLT",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 502, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_PLS_WDTH",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 504, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Tank oil
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_TANK_TEMP",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 600, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_TANK_LEVEL", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 602, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Temperatures
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CLL_IN_TEMP",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 700, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CLL_OUT_TEMP",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 702, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_SOLPS_TEMP",    "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 704, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_KLY_OUT_TEMP",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 706, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## RF measurements (disabled polling; registers appear unsupported on this unit)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_RF_FWD",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 820, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_RF_REFL",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 822, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_RF_VSWR",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 824, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_RF_PLEN",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 826, 2, 7, 0, $(RFMOD_MSGS))

## Flows (disabled polling; registers appear unsupported on this unit)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_CCPS1", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 900, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_CCPS2", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 902, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_CCPS3", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 904, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_CCPS4", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 906, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_BODY",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 908, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_CLL",   "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 910, 2, 7, 0, $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_FLOW_SOLPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 912, 2, 7, 0, $(RFMOD_MSGS))

## CCPS interlocks combined block for optimized template (disabled; device rejects len>1)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 120, 3, 0, 0, $(RFMOD_MSGS))

## CCPS interlocks (split per register to avoid exception=3 on length>1)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS1_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 120, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS2_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 121, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_READ_CCPS3_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 122, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

################################################################################
## Outputs unchanged (holding registers)
################################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_WD_SP",        "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 0,   1, 0, $(RFMOD_WD_WRITE_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_SP",     "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 1,   1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CMD_SP",       "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 2,   1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 100, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 200, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_WDTH_SP",  "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 300, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Optional: enable device-level trace
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)
#asynSetTraceMask(   "$(RFMOD_ASYNPORT)", 0, 0x11)
