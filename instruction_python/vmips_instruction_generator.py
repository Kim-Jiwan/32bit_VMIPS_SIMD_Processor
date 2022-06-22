# 6bit for MIPS SIMD Architecture
MSA = "011110"

# df : 00 -> Byte
# df : 01 -> Half-word
# df : 10 -> Word
# df : 11 -> Double-word
df = "10"

################## below are opcode ##################
# 3R : 3 register operations, opcode : 25 ~ 23(bit)
addv_3R = "001110"
subv_3R = "001110"
mulv_3R = "010010"
dotp_3R = "010011"

# I5 : instruction with 5bit immediate
addvi_I5 = "000110"
subvi_I5 = "000110"

# MI10 : 2 register operation with 10bit immediate
ld_MI10 = "1000"        # opcode for memory load
st_MI10 = "1001"        # opcode for memory store

# I10 : instruction with 10bit immediate
ld_I10 = "000111"
st_I10 = "000110"
######################################################

print("w : make new instruction set")
print("a+ : continue enter")
input_mode = input("Enter input mode : ")

instruction_file = open("instructionfile.txt", input_mode)

while True:
    instruction = input("assembly input : ").split()

    if instruction[0] == "exit":
        # stop get instruction
        break

    else:
        if instruction[0] == "addv":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            wt = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}000{df}{wt}{ws}{wd}{addv_3R}\n")
            
        elif instruction[0] == "addvi":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            u5 = f"{int(instruction[3]):05b}"

            if len(u5) <= 5:
                instruction_file.write(f"{MSA}000{df}{u5}{ws}{wd}{addvi_I5}\n")
            else:
                print("Please enter again(less than 5bit immediate)")

        elif instruction[0] == "subv":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            wt = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}001{df}{wt}{ws}{wd}{subv_3R}\n")

        elif instruction[0] == "subvi":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            u5 = f"{int(instruction[3]):05b}"

            if len(u5) <= 5:
                instruction_file.write(f"{MSA}001{df}{u5}{ws}{wd}{subvi_I5}\n")
            else:
                print("Please enter again(less than 5bit immediate)")

        elif instruction[0] == "mulv":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            wt = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}000{df}{wt}{ws}{wd}{mulv_3R}\n")

        elif instruction[0] == "maddv":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            wt = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}001{df}{wt}{ws}{wd}{mulv_3R}\n")

        elif instruction[0] == "dotp_s":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            wt = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}000{df}{wt}{ws}{wd}{dotp_3R}\n")

        elif instruction[0] == "dotp_u":
            wd = f"{int(instruction[1]):05b}"
            ws = f"{int(instruction[2]):05b}"
            wt = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}001{df}{wt}{ws}{wd}{dotp_3R}\n")

        elif instruction[0] == "ld":
            s10 = f"{int(instruction[1]):010b}"
            rs = f"{int(instruction[2]):05b}"
            wd = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}{s10}{rs}{wd}{ld_MI10}{df}\n")

        elif instruction[0] == "ldi":
            wd = f"{int(instruction[1]):05b}"
            s10 = f"{int(instruction[2]):010b}"

            if len(s10) <= 10:
                instruction_file.write(f"{MSA}110{df}{s10}{wd}{ld_I10}\n")
            else:
                print("Please enter again(less than 10bit immediate)")
            
        elif instruction[0] == "st":
            s10 = f"{int(instruction[1]):010b}"
            rs = f"{int(instruction[2]):05b}"
            wd = f"{int(instruction[3]):05b}"

            instruction_file.write(f"{MSA}{s10}{rs}{wd}{st_MI10}{df}\n")

        elif instruction[0] == "sti":
            wd = f"{int(instruction[1]):05b}"
            s10 = f"{int(instruction[2]):010b}"

            if len(s10) <= 10:
                instruction_file.write(f"{MSA}110{df}{s10}{wd}{ld_I10}\n")
            else:
                print("Please enter again(less than 10bit immediate)")

instruction_file.close()