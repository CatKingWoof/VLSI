***** you can modify clock cycle here, remember synchronize with clock cycle in FA4.vec ****
.param period = 0.61n
.param wp=0.8u 
.param wn=0.48u 
.param wp2=0.8u 
.param wn2=0.7u 
.param wp3=0.8u
.param wn3=0.9u
.param wp4=0.8u
.param wn4=0.48u
***** Define your sub-circuit and self-defined parameter here , and only need to submmit this part ****


.subckt FA4  CLK A[3] A[2] A[1] A[0] 
+ B[3] B[2] B[1] B[0] CIN 
+ SUM[3] SUM[2] SUM[1] SUM[0] COUT


X1 A[0] B[0] CIN  S[0] C[0] FA
X2 A[1] B[1] C[0] S[1] C[1] FA
X3 A[2] B[2] C[1] S[2] C[2] FA
X4 A[3] B[3] C[2] S[3] C[3] FA
XINV5 clk clki INV
XD0 S[0] clk clki SUM[0] DD
XD1 S[1] clk clki SUM[1] DD
XD2 S[2] clk clki SUM[2] DD
XD3 S[3] clk clki SUM[3] DD

XDD C[3] clk clki COUT DD


.ends


.subckt FA A B Cin SUM1 COUT1
XOR1 A B X1 XOR
XOR2 X1 Cin SUM1 XOR
XNAND1 Cin X1 N1 NAND
XNAND2 A B N2 NAND
XNAND3 N1 N2 COUT1 NAND

.ends 

.subckt INV IN OUT
mp OUT GND VDD VDD P_18_G2  l=0.18u w=wp2
mn OUT IN GND GND N_18_G2  l=0.18u w=wn2
.ends

.subckt NAND in1 in2 out
mp1 out GND VDD VDD P_18_G2  l=0.18u w=wp3
mn1 out in1 n1 GND  N_18_G2 l=0.18u w=wn3
mn2 n1 in2 GND GND N_18_G2  l=0.18u w=wn3
.ends


.subckt XOR A B OUT
mp1 XR1 A VDD VDD P_18_G2  l=0.18u w=wp
mn1 XR1 A GND GND N_18_G2  l=0.18u w=wn
mp2 OUT B A VDD P_18_G2  l=0.18u w=wp
mn2 OUT B XR1 GND N_18_G2  l=0.18u w=wn
mp3 OUT A B VDD P_18_G2  l=0.18u w=wp
mn3 OUT XR1 B GND N_18_G2  l=0.18u w=wn
.ends

.subckt DD IN clk clki OUT
Xinv1 IN a1 INV
mp1 a2 clk a1 VDD P_18_G2 l=0.18u w=wp4
mn1 a2 clki a1 GND N_18_G2  l=0.18u w=wn4
Xinv2 a2 a3 INV

mp2 a4 clki a3 VDD P_18_G2  l=0.18u w=wp4
mn2 a4 clk a3 GND N_18_G2  l=0.18u w=wn4
Xinv3 a4 a5 INV
Xinv4 a5 OUT INV

.ends

.end
