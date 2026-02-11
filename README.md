# FPGA Implementation of Van der Pol Oscillator

This project implements a **Van der Pol nonlinear oscillator** on FPGA using
a **multi-cycle RTL architecture**.  
The system numerically solves the differential equation using the **Euler method**
and outputs the oscillator waveform.

---

## Mathematical Model

The Van der Pol oscillator is defined by:

d²x/dt² − μ(1 − x²) dx/dt + x = 0

Converted to first-order form:

dx/dt = u  
du/dt = μ(1 − x²)u − x

---

## Numerical Method

- Euler discretization
- Fixed-point arithmetic (Q16.16)
- Multi-cycle datapath with FSM control

---

## Architecture

- 2 multipliers
- 1 adder/subtractor
- 1 comparator
- FSM-based control
- One iteration per 5–6 clock cycles

---

## File Structure
- rtl/ → Verilog RTL design
- tb/ → Testbench (CSV output)


---

## Simulation

- Run behavioral simulation in Vivado / ModelSim
- Output waveform saved as CSV
- CSV can be plotted using MATLAB or Python

---

## How to Run

1. Add rtl/
2. Add tb/
3. Run behavioral simulation
4. Observe CSV output

---

## Applications

- Nonlinear dynamics
- Oscillator modeling
- FPGA-based numerical solvers
- Control systems research

---


