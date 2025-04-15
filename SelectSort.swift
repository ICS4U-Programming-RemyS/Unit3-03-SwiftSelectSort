import Foundation

// Define array size
let ARRAY_SIZE = 10

// Welcome message
print("Welcome to the Selection Sort program!")
print("This program reads a random array from input.txt, sorts it,", terminator: " ")
print("and writes the result to output.txt.")

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do-catch block to catch any errors
do {
    // Initialize output string
    var outputStr = ""

    // Define the file paths
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split input into lines
    let lines = inputStr.components(separatedBy: "\n")

    // Loop through each line
    for line in lines {

        // Skip empty lines
        if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            continue
        }

        // Split line into numbers
        let numsLineArr = line.components(separatedBy: " ")
        // Initialize an array to hold integers
        var unsortedArray: [Int] = []

        // Loop through each component and try to convert to Int
        for str in numsLineArr {
            // Check if the string can be converted to an Int
            if let number = Int(str) {
                // If it can, append to the unsorted array
                unsortedArray.append(number)
            }
        }
        // Close the input file
        input.closeFile()

        // Sort the array
        let sortedArray = selectionSort(unsortedArray: unsortedArray)

        // Add to the output line
        outputStr += "Sorted array: "
        // Loop through the sorted array and add to output string
        for num in sortedArray {
            // Add each number to the output string
            outputStr += "\(num) "
        }
        // Skip to the next line
        outputStr += "\n"
    }

    // Write to output.txt
    try outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print the output string
    print("Sorted arrays written to output.txt.")

} catch {
    // Print error message if unable to read from the input file or write to the output file
    print("Error: \(error)")
}

// Function to perform selection sort
func selectionSort(unsortedArray: [Int]) -> [Int] {
    // Set array to the unsorted array
    var sortedArray = unsortedArray

    // For each index in the array
    for currentIndex in 0..<sortedArray.count - 1 {
        // Create minIndex variable and set it to the current index
        var minIndex = currentIndex
        // For each index after the current index
        for comparisonIndex in currentIndex+1..<sortedArray.count {
            // Compare the current index with the comparison index
            if sortedArray[comparisonIndex] < sortedArray[minIndex] {
                // If the comparison index is less than the current index,
                minIndex = comparisonIndex
            }
        }

        // Swap elements
        let temp = sortedArray[currentIndex]
        sortedArray[currentIndex] = sortedArray[minIndex]
        sortedArray[minIndex] = temp
    }

    // Return the sorted array
    return sortedArray
}
