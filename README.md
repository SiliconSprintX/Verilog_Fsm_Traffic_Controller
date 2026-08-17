# 🚦 Traffic Light Controller Using Verilog HDL

## 📌 Project Overview

This project implements a **Traffic Light Controller** using **Verilog HDL**. The design is based on a **Finite State Machine (FSM)** that controls three traffic lights: **Red, Green, and Yellow**.

The controller automatically transitions between the three states based on a clock signal and a counter. The duration of each traffic light is controlled by predefined clock-cycle values.

---

## 🎯 Objectives

* Design a traffic light controller using Verilog HDL.
* Implement an FSM-based control mechanism.
* Control Red, Green, and Yellow traffic lights.
* Use a counter to control the duration of each state.
* Implement state transitions using sequential and combinational logic.
* Verify the design using simulation and waveforms.

---

## 🧠 Working Principle

The controller consists of three states:

```text
             ┌──────────────┐
             │              │
             ▼              │
        ┌─────────┐         │
        │   RED   │         │
        └────┬────┘         │
             │              │
       5 clock cycles       │
             │              │
             ▼              │
        ┌─────────┐         │
        │  GREEN  │         │
        └────┬────┘         │
             │              │
       5 clock cycles       │
             │              │
             ▼              │
        ┌─────────┐         │
        │  YELLOW │         │
        └────┬────┘         │
             │              │
       2 clock cycles       │
             │              │
             └──────────────┘
```

The state sequence is:

```text
RED → GREEN → YELLOW → RED → ...
```

Only one traffic light is ON at a time.

---

## 🔄 FSM State Encoding

| State  | Encoding | Active Output |
| ------ | -------- | ------------- |
| RED    | `2'b00`  | `red = 1`     |
| GREEN  | `2'b01`  | `green = 1`   |
| YELLOW | `2'b10`  | `yellow = 1`  |

---

## ⏱️ Timing Configuration

The controller uses the following clock-cycle durations:

| Traffic Light |       Duration |
| ------------- | -------------: |
| 🔴 RED        | 5 clock cycles |
| 🟢 GREEN      | 5 clock cycles |
| 🟡 YELLOW     | 2 clock cycles |

The timing values can be modified using:

```verilog
localparam RED_TIME    = 5;
localparam GREEN_TIME  = 5;
localparam YELLOW_TIME = 2;
```

---

## 🏗️ Design Architecture

The RTL design is divided into three main blocks.

### 1. State Register and Counter

This is the sequential logic block:

```verilog
always @(posedge clk or posedge rst)
```

It performs:

* State register update
* Counter update
* Reset handling
* Counter reset when the FSM changes state

When reset is asserted:

```text
state = RED
count = 0
```

---

### 2. Next-State Logic

This is the combinational FSM logic:

```verilog
always @(*)
```

It determines the next state according to the current state and counter.

State transitions:

```text
RED    → GREEN    after 5 clock cycles
GREEN  → YELLOW   after 5 clock cycles
YELLOW → RED      after 2 clock cycles
```

---

### 3. Output Logic

The output logic determines which traffic light is active:

```verilog
always @(*)
```

The outputs are:

```text
RED    → red = 1
GREEN  → green = 1
YELLOW → yellow = 1
```

Therefore, only one traffic light is HIGH at any given time.

---

## 📁 Project Structure

```text
Traffic-Light-Controller/
│
├── traffic_light_controller.v
├── traffic_light_controller_tb.v
├── waveform/
│   └── traffic_light_controller.vcd
│
└── README.md
```

### File Description

| File                            | Description              |
| ------------------------------- | ------------------------ |
| `traffic_light_controller.v`    | Main Verilog RTL design  |
| `traffic_light_controller_tb.v` | Testbench for simulation |
| `traffic_light_controller.vcd`  | Generated waveform file  |
| `README.md`                     | Project documentation    |

---

## 🔌 Module Interface

### Inputs

| Signal | Width | Description                    |
| ------ | ----: | ------------------------------ |
| `clk`  | 1 bit | System clock                   |
| `rst`  | 1 bit | Active-high asynchronous reset |

### Outputs

| Signal   | Width | Description          |
| -------- | ----: | -------------------- |
| `red`    | 1 bit | Red traffic light    |
| `yellow` | 1 bit | Yellow traffic light |
| `green`  | 1 bit | Green traffic light  |

---

## 🔁 State Transition

The controller follows this sequence:

```text
             RED
              │
              │ 5 cycles
              ▼
            GREEN
              │
              │ 5 cycles
              ▼
           YELLOW
              │
              │ 2 cycles
              ▼
             RED
              │
              └──────────────►
```

---

## 🧪 Verification

The design can be verified using a Verilog testbench.

The testbench should:

1. Generate the clock.
2. Apply reset.
3. Release reset.
4. Monitor the traffic light outputs.
5. Verify the state transitions.
6. Check that only one light is active at a time.
7. Generate and inspect simulation waveforms.

Example clock generation:

```verilog
always #5 clk = ~clk;
```

This produces a clock with a **10 ns period**.

---

## 📈 Expected Simulation Behavior

After reset:

```text
red    = 1
yellow = 0
green  = 0
```

After the RED duration:

```text
red    = 0
yellow = 0
green  = 1
```

After the GREEN duration:

```text
red    = 0
yellow = 1
green  = 0
```

After the YELLOW duration:

```text
red    = 1
yellow = 0
green  = 0
```

The sequence repeats continuously:

```text
RED → GREEN → YELLOW → RED → ...
```

---

## 🛠️ Tools Used

This project can be simulated using:

* **Icarus Verilog**
* **GTKWave**
* **ModelSim**
* **QuestaSim**
* **Vivado**
* **EDA Playground**

---

## ▶️ Running the Simulation Using Icarus Verilog

### Step 1: Compile the design and testbench

```bash
iverilog -o traffic_light_sim traffic_light_controller.v traffic_light_controller_tb.v
```

### Step 2: Run the simulation

```bash
vvp traffic_light_sim
```

### Step 3: Open the waveform

If the testbench generates a VCD file:

```bash
gtkwave traffic_light.vcd
```

---

## 💡 Verilog Concepts Used

This project demonstrates:

* Verilog modules
* Input and output ports
* `reg` and `wire`
* `always` blocks
* Sequential logic
* Combinational logic
* Finite State Machines
* State encoding
* `localparam`
* `case` statements
* Non-blocking assignments (`<=`)
* Blocking assignments (`=`)
* Asynchronous reset
* Counters
* State transitions
* RTL simulation
* Waveform analysis

---

## 🧩 FSM Design Approach

The project follows a standard FSM architecture:

```text
              ┌─────────────────┐
              │  Current State  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Next-State Logic│
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ State Register  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  Output Logic   │
              └─────────────────┘
```

This structure provides a foundation for designing more complex FSM-based RTL systems.

---

## 🚀 Possible Improvements

The project can be extended with:

* 🚗 Vehicle detection
* 🚶 Pedestrian crossing control
* ⏱️ Configurable traffic-light timing
* 🚨 Emergency vehicle priority
* 🔢 Seven-segment countdown display
* 🔘 Manual control mode
* 🚦 Four-way intersection support
* 🌙 Night/low-traffic mode
* 📡 Sensor-based traffic control
* 🧪 SystemVerilog assertions
* 🔍 Functional coverage
* 🧰 UVM-based verification

---

## 🎓 Learning Outcomes

Through this project, I learned how to:

* Design an FSM using Verilog HDL.
* Implement state transitions.
* Use counters for timing control.
* Separate sequential and combinational logic.
* Implement asynchronous reset.
* Control multiple outputs based on FSM states.
* Verify RTL behavior using simulation.
* Analyze digital design behavior using waveforms.

---

## 🔮 Future Scope

A more advanced version of this project can implement a **four-way intelligent traffic signal controller** with vehicle sensors, pedestrian signals, emergency vehicle detection, and dynamic timing.

The controller could automatically adjust the green-light duration based on real-time traffic density.

---

## 👩‍💻 Author

**Saakshi**

**Aspiring VLSI / RTL Design Engineer**

### Skills

`Verilog HDL` | `Digital Electronics` | `RTL Design` | `SystemVerilog`

---

## ⭐ Conclusion

The **Traffic Light Controller** is a beginner-friendly RTL project that demonstrates how **Finite State Machines and counters** can be combined to implement a practical digital control system.

This project provides a strong foundation for understanding **FSM-based RTL design, state transitions, counters, combinational logic, sequential logic, and simulation-based verification**.

---

⭐ **If you found this project useful, consider giving the repository a star!**
