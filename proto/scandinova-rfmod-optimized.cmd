##############################################################################
# Optimized Scandinova RF Modulator Modbus Configuration
# This version groups registers into logical blocks and uses offsets
# Reduces number of asyn ports from 45+ to ~10
##############################################################################

##epicsEnvSet("RFMOD_ID",         "1")
##epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
##epicsEnvSet("RFMOD_TCP_IP",     "10.5.2.131")
##epicsEnvSet("RFMOD_TCP_PORT",   "502")

epicsEnvSet("RFMOD_ASYNPORT", "RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_MSGS", "SCN_RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_POLLING", "900")
epicsEnvSet("RFMOD_WD_POLLING", "250")

##############################################################################
# TCP/IP Port Configuration
##############################################################################
## drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
drvAsynIPPortConfigure("$(RFMOD_ASYNPORT)","$(RFMOD_TCP_IP):$(RFMOD_TCP_PORT)",0,0,1)

## modbusInterposeConfig(portName, linkType, timeoutMsec, writeDelayMsec)
modbusInterposeConfig("$(RFMOD_ASYNPORT)", 0, 2000, 0)

##############################################################################
# GROUPED INPUT REGISTERS (Function Code 4: Read Input Registers)
##############################################################################
## Modbus Data Types:
##  0=UINT16, 1=INT16SM, 4=INT16, 5=INT32_LE, 6=INT32_BE
##  7=FLOAT32_LE, 8=FLOAT32_BE, 9=FLOAT64_LE, 10=FLOAT64_BE
##
## drvModbusAsynConfigure(portName, tcpPortName, slaveAddr, modbusFunction, 
##                        startAddr, length, dataType, pollMsec, plcType)

##############################################################################
# GROUP 1A: System Status Block Part 1 (Offsets 0-9)
# Contains: Protocol ID, revision, watchdog, state, status, access level, 
#           delay timer, pulse rate (mixed types, read as UINT16)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SYS_STATUS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 0, 10, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 1B: Setpoint Readbacks (Offsets 20-26)
# Contains: State, CCPS voltage, filament current, pulse width setpoints RBV
#           (mixed types, read as UINT16)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SP_RBV", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 20, 7, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Watchdog needs faster polling (separate port for different scan rate)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_WD_RB", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 2, 1, 0, $(RFMOD_WD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 2: CCPS Voltages Block (Offsets 100-106)
# Contains: CCPS1, CCPS2, CCPS3 voltage readbacks (3 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 100, 3, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 3: CCPS Interlock Status (Offsets 120-123)
# Contains: CCPS1, CCPS2, CCPS3 interlock bits
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_ILCK", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 120, 3, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 4: Filament Power Supply (Offsets 200-203)
# Contains: Current and voltage readbacks (2 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 200, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 5: Ion Pump (Offsets 300-301)
# Contains: Recorder readback (1 FLOAT32 value)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_IONPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 300, 1, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 6: Solenoid Power Supply (Offsets 400-403)
# Contains: Current and voltage readbacks (2 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 400, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 7: Pulse Digitizer (Offsets 500-505)
# Contains: Current, voltage, pulse width readbacks (3 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PULSE", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 500, 3, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 8: Tank Monitoring (Offsets 600-603)
# Contains: Oil temperature and level (2 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TANK", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 600, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 9: Cooling System Temperatures (Offsets 700-707)
# Contains: Inlet, outlet, solenoid, and klystron body temperatures 
#           (4 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_COOL_TEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 700, 4, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 10: Klystron RF Monitoring (Offsets 820-827)
# Contains: Forward power, reflected power, VSWR, pulse length 
#           (4 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_KLY_RF", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 820, 4, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 11: Cooling System Flows (Offsets 900-913)
# Contains: All cooling water flow measurements (7 FLOAT32 values)
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_COOL_FLOW", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 900, 7, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# HOLDING REGISTERS (Function Codes 3/6/16: Read/Write Holding Registers)
##############################################################################

##############################################################################
# GROUP 12: Control Registers Block (Offsets 0-2)
# Contains: Watchdog setpoint, state target, command bits
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CTRL", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 0, 3, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 13: CCPS Voltage Setpoint (Offset 100-101)
# Write using Function 16 (Write Multiple Registers) for FLOAT32
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_V_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 100, 1, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 14: Filament Current Setpoint (Offset 200-201)
# Write using Function 16 (Write Multiple Registers) for FLOAT32
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FIL_I_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 200, 1, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# GROUP 15: Pulse Width Setpoint (Offset 300-301)
# Write using Function 16 (Write Multiple Registers) for FLOAT32
##############################################################################
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PW_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 300, 1, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

##############################################################################
# Debug Settings (commented out by default)
##############################################################################
## Enable ASYN_TRACEIO_HEX on octet server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

##############################################################################
# Summary of Optimization:
# OLD: 45+ individual asyn ports (one per register)
# NEW: 15 grouped asyn ports covering all registers
# 
# Benefits:
# - Reduced network traffic (fewer Modbus transactions)
# - Clearer organization by functional groups
# - Easier maintenance and debugging
# - Better performance (fewer context switches)
##############################################################################
