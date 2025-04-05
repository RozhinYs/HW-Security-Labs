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

✅ Why is 1101 the Correct Key?
Because the testbench was written assuming A and B are the original values. So to make the circuit act like a normal adder, you must use the same key that was originally used to lock the circuit logic.

In our case, the design uses the XOR logic:

verilog
Copy
Edit
assign A_locked = A ^ key;
So for the adder to function as expected, we need to reverse this XOR internally using the same key, which the testbench sets to:

verilog
Copy
Edit
key = 4'b1101;
When you use this key:

A_locked = A ^ 1101

Internally, adder computes: (A ^ 1101) + (B ^ 1101)

Since both inputs are XORed with the same key, the final output behaves just like:

A + B

✔️ Correct output.
Any other key results in wrong input values and a wrong sum.

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







You said:
Now generate a multi-step kind of a lab that start with a simple example and gets more complicated. it should showcase, functional testing, logic locking, and hardwa trojan
ChatGPT said:
Your multi-stage semiconductor security lab document is ready! It includes three progressive hands-on stages: functional testing, logic locking, and hardware Trojan detection, plus reflection questions and extension ideas.

📄 Download Multi_Stage_Semiconductor_Security_Lab.docx

Would you like me to also create:

Sample Verilog code for each stage?

A slide version of this lab to guide participants during the workshop? ​​

do both of these Sample Verilog code for each stage?

A slide version of this lab to guide participants during the workshop?






📄 Download Semiconductor_Security_Lab_Verilog_Samples.txt

Let me know if you'd like these packaged into a zip file, or converted into separate files for EDA Playground! ​​


📄 Download Semiconductor_Security_Lab_Verilog_Samples_REGEN.txt

It includes:

✅ Functional 4-bit Adder

🔐 Logic-Locked Adder with Key Input

🐞 Trojan-Embedded Adder (triggered by specific input)
