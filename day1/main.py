from input import input

def parseInput(inputString):
    column1 = []
    column2 = []
    for line in inputString.split('\n'):
        if line:
            c1, c2 = line.split()
            column1.append(int(c1))
            column2.append(int(c2)) 
        
    return column1, column2

def day1(inputString):
    print("part 1", str(part1(input)))
    print("part 2", str(part2(input)))
    

def part1(input):
    column1, column2 = parseInput(input)
    
    column1.sort()
    column2.sort()

    sub_array = []
    for i in range(len(column1)):
        sub_array.append(abs(column2[i] - column1[i]))
    
    return sum(sub_array)

def part2(input):
    # How often does the N appear in the second column?
    column1, column2 = parseInput(input)
    scores_array = []
    for i in range(len(column1)):
        scores_array.append(column1[i] * column2.count(column1[i]))
    
    return sum(scores_array)


day1(input)