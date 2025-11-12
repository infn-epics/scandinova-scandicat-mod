##epicsEnvSet("RFMOD_ID",         "1")
##epicsEnvSet("RFMOD_SLAVE_ADDR", "1")
##epicsEnvSet("RFMOD_TCP_IP",     "10.5.2.131")
##epicsEnvSet("RFMOD_TCP_PORT",   "502")

epicsEnvSet("RFMOD_ASYNPORT", "RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_MSGS", "SCN_RFMod_$(RFMOD_ID)")
epicsEnvSet("RFMOD_POLLING", "2000")
epicsEnvSet("RFMOD_WD_POLLING", "1000")

## Use the following commands for TCP/IP
## drvAsynIPPortConfigure(const char *portName,
##                       const char *hostInfo,
##                       unsigned int priority,
##                       int noAutoConnect,
##                       int noProcessEos);
drvAsynIPPortConfigure("$(RFMOD_ASYNPORT)","$(RFMOD_TCP_IP):$(RFMOD_TCP_PORT)",0,0,1)

## modbusInterposeConfig(const char *portName,
##                      modbusLinkType linkType,
##                      int timeoutMsec, 
##                      int writeDelayMsec)
modbusInterposeConfig("$(RFMOD_ASYNPORT)", 0, 2000, 0)

## ModBus function types
## 16-bit word access 	Read Input Registers 4
## 16-bit word access 	Read Holding Registers 	3
## 16-bit word access 	Write Single Register 	6

## ModBus types
## 0 	UINT16 	
## 1 	INT16SM 	
## 2 	BCD_UNSIGNED 
## 3 	BCD_SIGNED 	
## 4 	INT16
## 5 	INT32_LE
## 6 	INT32_BE
## 7 	FLOAT32_LE
## 8 	FLOAT32_BE
## 9 	FLOAT64_LE
## 10 	FLOAT64_LE

## drvModbusAsynConfigure(portName, 
##                       tcpPortName,
##                       slaveAddress, 
##                       modbusFunction, 
##                       modbusStartAddress, 
##                       modbusLength,
##                       dataType,
##                       pollMsec, 
##                       plcType);

################################################################################
## OPTIMIZED BLOCK READS - Consolidate consecutive registers
################################################################################

## ============================================================================
## BLOCK 1: Protocol Status & State (Offsets 0-9)
## Reads: Protocol ID, Rev, Watchdog Prev, State, Status, Access Level, 
##        Delay Remaining, Pulse Rep Rate
## Total: 10 registers (0-9)
## ============================================================================
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATUS_BLOCK", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 0, 10, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Watchdog readback needs faster polling
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TCP_WD_PREV", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 2, 1, 0, $(RFMOD_WD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 2a: Setpoint Readbacks Group 1 (Offsets 20-23)
## Contains: State Target RB, CCPS Voltage SP RB
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SETPOINT_RB_A", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 20, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 2b: Setpoint Readbacks Group 2 (Offsets 24-26)
## Contains: Filament Current SP RB, Pulse Width SP RB
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SETPOINT_RB_B", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 24, 3, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 3: CCPS Voltages (Offsets 100-105)
## Reads: CCPS1, CCPS2, CCPS3 voltages
## Total: 6 registers (100-105)
## ============================================================================
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLTS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 100, 6, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 4: CCPS Interlocks (Offsets 120-122)
## Reads: CCPS1, CCPS2, CCPS3 interlock status
## Total: 3 registers (120-122)
## ============================================================================
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_ILCKS", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 120, 3, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 5a: Filament Current (Offsets 200-201)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 200, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 5b: Filament Voltage (Offsets 202-203)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 202, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 6: Ion Pump (Offset 300-301)
## Reads: Ion Pump Current
## Total: 2 registers (300-301)
## ============================================================================
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_IONPS_R", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 300, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 7a: Solenoid Current (Offsets 400-401)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPS_CURR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 400, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 7b: Solenoid Voltage (Offsets 402-403)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_SOLPS_VOLT", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 402, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 8a: Pulse Current/Voltage (Offsets 500-503)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PULSE_A", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 500, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 8b: Pulse Width (Offsets 504-505)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PULSE_B", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 504, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 9a: Oil Temperature (Offsets 600-601)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TANK_TEMP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 600, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 9b: Oil Level (Offsets 602-603)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TANK_LEVEL", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 602, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 10a: Temps Group 1 (Offsets 700-703)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TEMP_A", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 700, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 10b: Temps Group 2 (Offsets 704-707)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_TEMP_B", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 704, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 11: RF Measurements (split to avoid VSWR exceptions)
## 11a: RF Forward, RF Reflected (Offsets 820-823)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_RF_A", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 820, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## 11b: RF Pulse Length (Offsets 826-827)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_RF_B", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 826, 2, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## 11c: RF VSWR (Offset 824) - optional/sparse, isolate to prevent block failures
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_RF_VSWR", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 824, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## ============================================================================
## BLOCK 12a: Flow Group 1 (Offsets 900-905) CCPS Flow 1-3
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FLOW_A", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 900, 6, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 12b: Flow Group 2 (Offsets 906-909) CCPS Flow 4, Body Flow
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FLOW_B", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 906, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))
## BLOCK 12c: Flow Group 3 (Offsets 910-913) Collector Flow, Solenoid Flow
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FLOW_C", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 4, 910, 4, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))


################################################################################
## HOLDING REGISTERS (OUTPUTS)
################################################################################

## Offset:0  ModbusTcpWatchdog  Uint16
## Increment this value at least every second, used by the
## modulator to monitor this communication
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_WD_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 0, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:1  StateTarget  Int 
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_STATE_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 1, 1, 4, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:2  CommandBits  Uint16 A word containing 16 command bit's
## Bit0: Reset  (* 0=Idle/ready, 1=Clear interlocks and return to 0 *)
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CMD_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 6, 2, 1, 0, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:100  Ccps.VoltSet  Single  V  Set value of all CCPS which defines the pulse amplitude
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_CCPS_VOLT_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 100, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:200  SR_FastCall.IFB_FastKly.IFB_FastFilPS.IFB_CurrSet.ati_rSet1Rem  Single  A  Filaments current set value
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_FILPS_CURR_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 200, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Offset:300  Su.PlswthSet  Single  us  Pulse width set value
drvModbusAsynConfigure("$(RFMOD_ASYNPORT)_PLS_WDTH_SP", "$(RFMOD_ASYNPORT)", $(RFMOD_SLAVE_ADDR), 16, 300, 2, 7, $(RFMOD_POLLING), $(RFMOD_MSGS))

## Enable ASYN_TRACEIO_HEX on octet server
asynSetTraceIOMask("$(RFMOD_ASYNPORT)", 0, 4)

## Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
#asynSetTraceMask("$(RFMOD_ASYNPORT)", 0, 11)

## Enable ASYN_TRACEIO_HEX on modbus server
#asynSetTraceIOMask("$(RFMOD_ASYNPORT)_STATUS_BLOCK", 0, 4)

## Enable ASYN_TRACE_ERROR, ASYN_TRACEIO_DEVICE, and ASYN_TRACEIO_DRIVER on modbus server
#asynSetTraceMask("$(RFMOD_ASYNPORT)_STATUS_BLOCK", 0, 11)
