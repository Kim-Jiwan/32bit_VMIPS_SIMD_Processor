from unicodedata import decimal


data_file = open("datafile.txt", "a+")

while True:
    data = input("4 data input : ").split()

    if data[0] == "exit":
        break

    else:
        element_x = f"{int(data[0]):032b}"
        element_y = f"{int(data[1]):032b}"
        element_z = f"{int(data[2]):032b}"
        element_w = f"{int(data[3]):032b}"

        data_file.write(f"{element_x}{element_y}{element_z}{element_w}\n")

data_file.close()