package main

import (
	"bufio"
	"log"
	"os"
	"strconv"
	"strings"
)

func textToNumbers(text string) []int {
	numbers := strings.Split(text, " ")
	output := []int{}

	for i := 0; i < len(numbers); i++ {
		number, _ := strconv.Atoi(numbers[i])
		output = append(output, number)
	}

	return output
}

func isSafe(numbers []int) bool {
	increasing := false
	decreasing := false

	for i := 0; i < len(numbers)-1; i++ {
		difference := numbers[i+1] - numbers[i]

		if difference > 3 || difference < -3 || difference == 0 {
			return false
		}

		if difference > 0 {
			if decreasing {
				return false
			}
			increasing = true
		}

		if difference < 0 {
			if increasing {
				return false
			}
			decreasing = true
		}
	}

	return true
}

func main() {
	file, err := os.Open("../Inputs/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	counter := 0

	for scanner.Scan() {
		text := scanner.Text()
		numbers := textToNumbers(text)
		for i := 0; i < len(numbers); i++ {
			toleranceNumbers := append([]int{}, numbers[:i]...)
			toleranceNumbers = append(toleranceNumbers, numbers[i+1:]...)
			if isSafe(toleranceNumbers) {
				counter++
				break
			}
		}
	}

	print(counter)
}
