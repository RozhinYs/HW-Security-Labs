## Lab1: Logic Locking

This hands-on experiment demonstrates a simple logic locking mechanism at the gate level. In this case, a 4-bit adder is locked such that it only works correctly if the right key is supplied.

## 🎯 Objective

By "locking" the inputs of a digital design using a secret key, designers can protect their chip from:
- Unauthorized use
- Overproduction by foundries
- Reverse engineering and IP theft

---

## 🔍 Step-by-Step Instructions

1. Go to https://edaplayground.com

2. Paste Logic_Locking_Design.v into the left-hand code window

3. Paste the Logic_Locking_Testbench.v code into the right-hand testbench window

4. Choose:
  - Language: Verilog 2001
  - Simulator: Icarus Verilog

5. Click Run

6. Try to find the correct key.
  
8. ✅ Question: What is the Correct Key?

---

🧠 How Logic Locking Works Here
🔐 The Locking Logic
Inside the circuit:
"
assign A_locked = A ^ key;
assign B_locked = B ^ key;
assign SUM = A_locked + B_locked;
"

This means:

Inputs A and B are XORed with the 4-bit key before being added.

So unless the correct key is applied, the adder will compute garbage.

🎯 Goal: Make Output Match A + B
You want the adder to behave like a normal adder. That happens only if the XORed values (A ^ key and B ^ key) are internally restored back to the original A and B.

🧪 The Key Insight
Let’s suppose the actual value you want to input is:

A_real = A ^ key

B_real = B ^ key

So to undo the XOR, you must XOR again with the same key!

---


🚨 What Happens with the Wrong Key?
Let’s say:

A = 0011 (3)

B = 0101 (5)

If you use the correct key 1101, you get:

A_locked = 0011 ^ 1101 = 1110

B_locked = 0101 ^ 1101 = 1000

Internally: 1110 + 1000 = 1_0110 (decimal 16)
But because both were locked and unlocked the same way, the final observable behavior matches 3 + 5 = 8.

But if the key is wrong (say, 0000):

A_locked = 0011 ^ 0000 = 0011 (unchanged)

B_locked = 0101 ^ 0000 = 0101

Internally: 0011 + 0101 = 1000 (decimal 8)

Looks okay here — but it’s only a coincidence.

Change the inputs and try again:

With wrong keys, the XOR scrambling produces inconsistent results

The chip will fail in unpredictable ways, rendering it unusable

---

## Lab2: Detecting a Stealthy Hardware Trojan

This lab guides students through identifying a stealthy **hardware Trojan** embedded in a simple 4-bit adder. The Trojan remains dormant during normal operations and activates only under a specific trigger condition.

## 🎯 Objective

Understand how a stealthy hardware Trojan operates and how it can be detected through strategic functional testing.

---

## 🛠 Tools Required

- Web browser
- Internet access
- [EDA Playground](https://edaplayground.com) (Free, no login required)

---

## 🧰 Files

- `Hardware_Trojan_Design.v`: 4-bit adder with embedded Trojan
- `Hardware_Trojan_Testbench.v`: Testbench to simulate and expose the Trojan

---

## 🔍 Step-by-Step Instructions

### 1. Understand the Design

The module performs a 4-bit addition. However, a **Trojan is triggered only when both `A` and `B` are `4'b1010` (decimal 10)**, which alters the expected output.

---

### 2. Open EDA Playground

1. Go to [EDA Playground](https://edaplayground.com)
2. Select **Verilog 2001** as the language
3. Choose **Icarus Verilog** as the simulator
4. Paste the contents of `Hardware_Trojan_Design.v` in the left window
5. Paste `Hardware_Trojan_Testbench.v` in the right testbench window

---

### 3. Run the Simulation

Click the **Run** button to simulate. Observe the output:

```plaintext
A    B    => SUM
3 + 2 = 5
5 + 7 = 12
8 + 1 = 9
```
---

### 4. Experiment

- Analyze the design and try different inputs to activate the Trojan
- How the Trojan get activated?
- What does the Trojan do?
  
---

### 5. Reflect and Discuss

- How easy is it to miss a Trojan during standard functional testing?
- How might designers harden circuits against such threats?

---

## 📎 Extensions

- Modify the Trojan condition to activate under a different pattern
- Insert additional logging or alarms when the Trojan is triggered
- Explore formal verification tools to detect logic anomalies

Happy hacking! 🔐
