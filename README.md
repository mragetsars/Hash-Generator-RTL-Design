# Hash Generator RTL Design

> **Computer-Aided Design of Digital Systems (CAD) – University of Tehran – Department of Electrical & Computer Engineering**

![Language](https://img.shields.io/badge/Language-Verilog-orange) ![Tool](https://img.shields.io/badge/Tool-ModelSim-blue) ![Status](https://img.shields.io/badge/Status-Completed-success)

## 📌 Overview

This repository contains the Register Transfer Level (RTL) implementation of a **Hash Generator System**. This project was developed as the *First Project* of the *Computer-Aided Design of Digital Systems (CAD)* course at the University of Tehran.

The project focuses on reinforcing core RTL design concepts through the implementation of a **modular, controller–datapath based digital system**, featuring:

- Pseudo-Random Number Generation (PRNG)
- Bitwise operations and shift registers
- Handshaking mechanisms
- Huffman-inspired hash generation process
- Finite State Machine (FSM) based controllers (Moore machines)
- Full functional verification via simulation

The entire system is designed in **Verilog HDL** and simulated using **ModelSim**.

## 🎯 Project Objectives

The main goals of this project are:

- ✅ Strengthening RTL-level digital design skills
- ✅ Designing **separate datapath and controller** for each subsystem
- ✅ Applying **handshaking protocols** between modules
- ✅ Implementing **pseudo-random number generation using shift registers and XOR logic**
- ✅ Building a **hash generator** inspired by Huffman encoding principles
- ✅ Verifying correctness through simulation using provided test vectors

## 🧠 System Architecture & Features

The design strictly separates the **Datapath** and **Controller** (Moore FSM) and consists of two primary subsystems integrated at the top level:

### 1️⃣ Pseudo-Random Number Generator (RND Module)

* **Mechanism:** Shift-register based algorithm with XOR feedback.
* **Operation:** Generates 6-bit pseudo-random numbers, outputting the 2 MSBs as indices.
* **Control:** Activated via `start_rnd` with precise handshaking (`done_rnd` pulse).

### 2️⃣ Hash Generator Module

* **Mechanism:** Computes hash values using random indices, constant memory lookup, and bitwise operations (Rotate, XOR, Add).
* **Logic:** Implements a step-by-step algorithm based on the provided pseudocode.

### 🏗️ Design Methodology

* ✅ **Modular Design:** Dedicated modules for ALU, Counters, and Memories.
* ✅ **FSM Control:** All controllers implemented as **Moore Machines**.
* ✅ **Handshaking:** Robust signal exchange between Top-Level, RND, and Hash modules.
* ✅ **Synthesizable:** Fully synthesizable RTL code structure.

## 📂 Repository Structure

The project is organized as follows:

```text
Hash Generator RTL Design/
├── Description/         # Project specifications & Algorithm references
│   ├── pseudocode.txt   # Reference algorithm
│   ├── constant.mem     # Memory initialization
│   └── example.txt      # Test input vectors
├── Source/              # Synthesizable RTL Source files
│   ├── RND/             # Random Generator Subsystem
│   ├── controller.v     # Main FSM Controller
│   ├── datapath.v       # Main Datapath
│   ├── F_logic_ALU.v    # Arithmetic Logic Unit
│   ├── const_mem.v      # Constant Memory
│   └── top_module.v     # System Top-Level
├── Project/             # ModelSim Simulation files
│   └── work/            # Compiled libraries
├── Report/              # Final Documentation
│   └── doc.pdf
└── README.md
```

## 🛠️ Tools & Verification

* **HDL Language:** Verilog (IEEE 1364)
* **Simulation Tool:** Mentor Graphics ModelSim
* **Verification:** Validated against `example.txt` with correct handshaking and reset behavior.

## 👥 Contributors

This project was developed as a team effort for the **CAD** course at the **University of Tehran**.

* **[Sadra Salehi](https://github.com/im-w)**
* **[Meraj Rastegar](https://github.com/mragetsars)**
