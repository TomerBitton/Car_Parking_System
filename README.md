# Car_Parking_System

1. Introduction

The VHDL Car Parking System is designed to manage vehicle access to a parking area using front and back sensors. The system employs a Finite State Machine (FSM) to control the gates and ensure safe and orderly vehicle entry and exit.

2. Prerequisites

Before working with this VHDL Car Parking System project, ensure you have the following:
- VHDL Simulator: You will need a VHDL simulator for simulating and testing the car parking system with FSM. Common choices include ModelSim and Xilinx Vivado.
- Familiarity with VHDL: Basic knowledge of VHDL and digital logic design principles will be beneficial.

3. Project Structure

The project structure is organized as follows:
- Car_Parking_System.vhd, the main VHDL file for the car parking system design.
- Car_Parking_System.do, a DO file for simulating the car parking system.
- FSM of the Car_Parking_System.jpg, image of the FSM.
- Illustration of the Car_Parking_System.jpg.

4. Car Parking System Logic

- IDLE: Waits for a vehicle.
- WAIT_PASSWORD: Awaits password input.
- WRONG_PASS: Remains if wrong password.
- RIGHT_PASS: Opens gate with correct password.
- STOP: Gate stays closed and checks next car's password.

LED Indications:
- GREEN_LED: Gate open for vehicles.
- RED_LED: Gate closed, no entry.

5. Simulation

To simulate the system:
- Copy the Car_Parking_System.vhd and Car_Parking_System.do files into your project directory.
- Modify the DO file (Car_Parking_System.do) to include the system instantiation and test cases with sensor input variations.
- Use your VHDL simulator (ModelSim or Xilinx Vivado) to compile and simulate.
- Analyze the simulation results to ensure the car parking system with FSM operates correctly for your use case.







