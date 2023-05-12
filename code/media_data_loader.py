

def read_media_data():

    lines = []

    with open("medias.csv", "r") as f:

        lines = f.readlines()[1:]

    for i in range(len(lines)):
        lines[i] = lines[i].replace("\n", "")
        lines[i] = lines[i].split(";")

    return lines
