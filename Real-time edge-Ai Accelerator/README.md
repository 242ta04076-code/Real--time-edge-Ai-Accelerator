# Real-Time Edge-AI Accelerator using Verilog HDL

## 📌 Project Overview

This project implements a simplified **Real-Time Edge-AI Accelerator** using Verilog HDL.

The accelerator performs a small neural-network-style inference operation directly in hardware.

Instead of sending sensor data to a cloud server, the Edge-AI accelerator processes data locally, providing:

- Low latency
- Reduced communication
- Hardware-based computation
- Real-time decision making

The design uses 8-bit integer arithmetic and performs:

```text
Input Data
    ↓
Multiply
    ↓
Accumulate
    ↓
Add Bias
    ↓
ReLU Activation
    ↓
Classification
```

---

## 🎯 Objective

The objective is to design a hardware accelerator capable of performing a small AI inference operation using:

- INT8 inputs
- INT8 weights
- Multiply-Accumulate operations
- Bias addition
- ReLU activation
- Classification output

---

## 🧠 AI Hardware Architecture

```text
             Input Features
             X0 X1 X2 X3
                  │
                  ▼
          +---------------+
          | INT8 MAC Unit |
          +---------------+
                  │
                  ▼
          Accumulated Sum
                  │
                  ▼
             Bias Add
                  │
                  ▼
             ReLU Unit
                  │
                  ▼
          AI Classification
                  │
                  ▼
             Result
```

---

## ⚙️ Processing Equation

The accelerator performs:

```text
Y = ReLU(X0×W0 + X1×W1 + X2×W2 + X3×W3 + Bias)
```

where:

- X = input features
- W = trained weights
- Bias = neural-network bias
- ReLU = Rectified Linear Unit

ReLU is defined as:

```text
ReLU(x) = x       if x > 0
          0       otherwise
```

---

## 🔢 Example

Consider:

```text
Inputs:

X0 = 2
X1 = 3
X2 = 1
X3 = 2

Weights:

W0 = 2
W1 = 1
W2 = 3
W3 = 1

Bias = 1
```

Calculation:

```text
Y = (2×2) + (3×1) + (1×3) + (2×1) + 1

Y = 4 + 3 + 3 + 2 + 1

Y = 13
```

After ReLU:

```text
ReLU(13) = 13
```

The accelerator produces:

```text
Result = 13
Valid  = 1
```

---

## 🧩 Main Components

### 1. Input Interface

Receives feature data.

### 2. MAC Unit

Performs multiplication and accumulation.

### 3. Bias Unit

Adds the trained neural-network bias.

### 4. ReLU Unit

Removes negative values.

### 5. Control FSM

Controls the processing sequence.

### 6. Output Interface

Provides the inference result and completion signal.

---

## 📌 Inputs

| Signal | Width | Description |
|---|---:|---|
| clk | 1 | System clock |
| reset | 1 | Reset |
| start | 1 | Starts inference |
| x0-x3 | 8 | Input features |
| w0-w3 | 8 | Neural-network weights |
| bias | 16 | Bias value |

---

## 📌 Outputs

| Signal | Width | Description |
|---|---:|---|
| result | 16 | AI inference result |
| valid | 1 | Result valid signal |
| busy | 1 | Accelerator processing status |

---

## 🔄 FSM

The accelerator uses the following states:

```text
IDLE
  │
  │ start
  ▼
MAC
  │
  ▼
BIAS
  │
  ▼
RELU
  │
  ▼
DONE
  │
  ▼
IDLE
```

---

## 📊 Processing Steps

### Step 1

Receive input features and weights.

### Step 2

Calculate:

```text
X0×W0
X1×W1
X2×W2
X3×W3
```

### Step 3

Accumulate the products.

### Step 4

Add bias.

### Step 5

Apply ReLU.

### Step 6

Generate the output result.

---

## 🧪 Verification

The testbench verifies:

- Reset operation
- Accelerator start
- MAC calculation
- Bias addition
- ReLU operation
- Output validity
- Busy signal

---

## 🛠️ Tools

- Verilog HDL
- Icarus Verilog
- GTKWave
- ModelSim
- Vivado

---

## 📈 Applications

This type of architecture can be extended for:

- Smart cameras
- IoT devices
- Wearable devices
- Industrial monitoring
- Autonomous systems
- Predictive maintenance
- Sensor-based AI
- Robotics

---

## 🚀 Future Improvements

Possible extensions include:

- Multiple MAC units
- CNN accelerator
- Convolution engine
- INT4/INT8 quantization
- AXI interface
- SRAM-based weight memory
- Pipelined processing
- FPGA implementation
- Hardware/software co-design

---

## 👩‍💻 Author

Harshitha Gangireddy