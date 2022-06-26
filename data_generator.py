print("w : make new instruction set")
print("a+ : continue enter")
input_mode = input("Enter input mode : ")

print("\nEnter 4 element for 1 vector (ex: 100 100 100 100)")

with open("datafile.txt", input_mode) as data_file:

    while True:
        data = input("4 data input : ").split()

        if data[0] == "exit":
            break

        else:
            element_x = f"{int(data[0]):032b}"
            element_y = f"{int(data[1]):032b}"
            element_z = f"{int(data[2]):032b}"
            element_w = f"{int(data[3]):032b}"

            data_file.write(f"{element_x}\n{element_y}\n{element_z}\n{element_w}\n")