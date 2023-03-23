import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


# sine_values = [ 63, 6, 91, 79, 102, 109, 124, 7, 127, 103 ]

@cocotb.test()
async def test_bpsk(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())
    
    dut._log.info("initial")
    dut.d.value = 0
    dut.rstn.value = 0
    dut.en.value = 0
	
    dut._log.info("reset")
    await ClockCycles(dut.clk, 10)
    dut.rstn.value = 1
	
    dut._log.info("enable")
    await ClockCycles(dut.clk, 10)
    dut.en.value = 1

    dut._log.info("d = 1")
    await ClockCycles(dut.clk, 64)
    dut.d.value = 1

    dut._log.info("d = 0")
    await ClockCycles(dut.clk, 64)
    dut.d.value = 0

    dut._log.info("d = 1")
    await ClockCycles(dut.clk, 128)
    dut.d.value = 1

    dut._log.info("d = 0")
    await ClockCycles(dut.clk, 128)
    dut.d.value = 0

    dut._log.info("waiting")
    for i in range(20):
        # dut._log.info("clock {}".format(i))
        await ClockCycles(dut.clk, 10)
        # assert int(dut.out_wave.value) == sine_values[i]
		