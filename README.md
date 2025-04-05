Lab1: Logic Locking

1. Go to https://edaplayground.com

2. Paste locked_adder.v into the left-hand code window

3. Paste the testbench code into the right-hand testbench window

4. Choose:
  - Language: Verilog 2001
  - Simulator: Icarus Verilog

5. Click Run


Purpose of the Experiment
This hands-on experiment demonstrates a simple logic locking mechanism at the gate level. By "locking" the inputs of a digital design using a secret key, designers can protect their chip from:
- Unauthorized use
- Overproduction by foundries
- Reverse engineering and IP theft

In this case, a 4-bit adder is locked such that it only works correctly if the right key is supplied.

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

So to undo the XOR, you must XOR again with the same key:

nginx
Copy
Edit
A_real ^ key = (A ^ key) ^ key = A
This works because of a basic XOR property:
(X ^ K) ^ K = X for any bitstring X and key K.

✅ Question: What is the Correct Key?

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

🧪 Summary
Key Used	A + B Output	Behavior
1101	Correct sum	✅ Expected behavior
Anything else	Incorrect sum	❌ Locked / Obfuscated
Let me know if you'd like this explanation turned into a slide for your workshop, or included in the PDF instructions!

EDA Playground Hands-On Lab: Detecting a Stealthy Hardware Trojan
In this lab, you'll explore how a stealthy hardware Trojan can be inserted into a simple circuit and remain dormant under normal conditions. You'll use EDA Playground to simulate a 4-bit adder that has been compromised with a Trojan triggered by a very specific input pattern.
Objective
Understand how a stealthy hardware Trojan operates and how it can be detected through strategic functional testing.
Tools Required
• EDA Playground (https://edaplayground.com)
• Web browser and internet access
Step-by-Step Instructions
Step 1: Understand the Design
The circuit is a 4-bit adder. A Trojan has been inserted to produce an incorrect sum only when both inputs are exactly 4'b1010 (decimal 10).
Step 2: Open EDA Playground and Load the Design
Paste the Verilog design and testbench code (provided separately) into EDA Playground. Use Verilog 2001 and Icarus Verilog simulator.
Step 3: Run the Testbench
Simulate the design and observe the output values. The design should behave like a normal adder for all cases except when A and B are both 10.
Step 4: Analyze the Trojan Behavior
Look for the anomaly when A and B are 10. This is the only case where the sum is intentionally wrong. This demonstrates how hardware Trojans can stay hidden unless specifically triggered.
Step 5: Reflect and Discuss
• How easy is it to miss a Trojan during standard testing?
• What methods could detect such stealthy triggers?
• How can hardware design be hardened against such threats?
![image](https://github.com/user-attachments/assets/4bd2998b-0385-4443-aeea-9d77f9b281f2)

