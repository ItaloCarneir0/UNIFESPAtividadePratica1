//
//  main.swift
//  AtividadePratica4
//
//  Created by Italo Carneiro on 03/09/24.
//

import Foundation

// Função para medir o tempo de execução
func measureTime(_ block: () -> Void) -> TimeInterval {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let end = CFAbsoluteTimeGetCurrent()
    return end - start
}

// Função para gerar um vetor aleatório
func generateRandomArray(size: Int) -> [Int] {
    return (0..<size).map { _ in Int.random(in: 0..<size) }
}

// Função para gerar um vetor crescente
func generateAscendingArray(size: Int) -> [Int] {
    return Array(0..<size)
}

// Função para gerar um vetor decrescente
func generateDescendingArray(size: Int) -> [Int] {
    return Array((0..<size).reversed())
}

// Implementação do Shellsort com diferentes gaps
func shellSort(_ array: inout [Int], gapSequence: String = "hibbard") {
    let n = array.count
    var gap = n / 2
    
    // Definindo os gaps de acordo com a sequência escolhida
    var gaps: [Int] = []
    if gapSequence == "hibbard" {
        var h = 1
        while h < n {
            gaps.append(h)
            h = 2 * h + 1
        }
        gaps.reverse()
    } else if gapSequence == "sedgewick" {
        var k = 0
        while true {
            let gap1 = 9 * (Int(pow(4.0, Double(k))) - Int(pow(2.0, Double(k)))) + 1
            let gap2 = Int(pow(2.0, Double(k+2))) * (Int(pow(2.0, Double(k+2))) - 3) + 1
            if gap1 < n {
                gaps.append(gap1)
            }
            if gap2 < n {
                gaps.append(gap2)
            }
            if gap1 >= n && gap2 >= n {
                break
            }
            k += 1
        }
        gaps.sort(by: >)
    } else { // Divisão por 2
        gap = n / 2
        while gap > 0 {
            gaps.append(gap)
            gap /= 2
        }
    }

    // Shell Sort usando a sequência de gaps selecionada
    for gap in gaps {
        for i in gap..<n {
            var j = i
            let temp = array[j]
            while j >= gap && array[j - gap] > temp {
                array[j] = array[j - gap]
                j -= gap
            }
            array[j] = temp
        }
    }
}

// Implementação do Heapsort
func heapSort(_ array: inout [Int]) {
    func heapify(_ array: inout [Int], n: Int, i: Int) {
        var largest = i
        let left = 2 * i + 1
        let right = 2 * i + 2
        if left < n && array[left] > array[largest] {
            largest = left
        }
        if right < n && array[right] > array[largest] {
            largest = right
        }
        if largest != i {
            array.swapAt(i, largest)
            heapify(&array, n: n, i: largest)
        }
    }

    let n = array.count
    for i in stride(from: n / 2 - 1, through: 0, by: -1) {
        heapify(&array, n: n, i: i)
    }
    for i in stride(from: n - 1, through: 0, by: -1) {
        array.swapAt(0, i)
        heapify(&array, n: i, i: 0)
    }
}

// Implementação do Quicksort
func quickSort(_ array: inout [Int], low: Int, high: Int) {
    if low < high {
        let pi = partition(&array, low: low, high: high)
        quickSort(&array, low: low, high: pi - 1)
        quickSort(&array, low: pi + 1, high: high)
    }
}

func partition(_ array: inout [Int], low: Int, high: Int) -> Int {
    let pivot = array[high]
    var i = low - 1
    for j in low..<high {
        if array[j] < pivot {
            i += 1
            array.swapAt(i, j)
        }
    }
    array.swapAt(i + 1, high)
    return i + 1
}

// Implementação do Mergesort
func mergeSort(_ array: inout [Int]) {
    func merge(_ array: inout [Int], left: Int, mid: Int, right: Int) {
        let n1 = mid - left + 1
        let n2 = right - mid

        let L = Array(array[left..<left + n1])
        let R = Array(array[mid + 1..<mid + 1 + n2])

        var i = 0, j = 0, k = left
        while i < n1 && j < n2 {
            if L[i] <= R[j] {
                array[k] = L[i]
                i += 1
            } else {
                array[k] = R[j]
                j += 1
            }
            k += 1
        }

        while i < n1 {
            array[k] = L[i]
            i += 1
            k += 1
        }

        while j < n2 {
            array[k] = R[j]
            j += 1
            k += 1
        }
    }

    func mergeSortHelper(_ array: inout [Int], left: Int, right: Int) {
        if left < right {
            let mid = left + (right - left) / 2
            mergeSortHelper(&array, left: left, right: mid)
            mergeSortHelper(&array, left: mid + 1, right: right)
            merge(&array, left: left, mid: mid, right: right)
        }
    }

    mergeSortHelper(&array, left: 0, right: array.count - 1)
}

// Teste de desempenho

let arraySize = 100000

var randomArray = generateRandomArray(size: arraySize)
var ascendingArray = generateAscendingArray(size: arraySize)
var descendingArray = generateDescendingArray(size: arraySize)


print("Random Array Sorting (diferentes gaps):")

var array = randomArray
print("Shellsort (Hibbard): \(measureTime { shellSort(&array, gapSequence: "hibbard") }) seconds")

array = randomArray
print("Shellsort (Sedgewick): \(measureTime { shellSort(&array, gapSequence: "sedgewick") }) seconds")

array = randomArray
print("Shellsort (Divisão por 2): \(measureTime { shellSort(&array, gapSequence: "default") }) seconds")

print("Random Array Sorting:")

print("Shellsort: \(measureTime { shellSort(&array) }) seconds")

array = randomArray
print("Heapsort: \(measureTime { heapSort(&array) }) seconds")

array = randomArray
print("Quicksort: \(measureTime { quickSort(&array, low: 0, high: array.count - 1) }) seconds")

array = randomArray
print("Mergesort: \(measureTime { mergeSort(&array) }) seconds")

print("\nAscending Array Sorting:")

array = ascendingArray
print("Shellsort: \(measureTime { shellSort(&array) }) seconds")

array = ascendingArray
print("Heapsort: \(measureTime { heapSort(&array) }) seconds")

// Causa estouro de memoria
//array = ascendingArray
//print("Quicksort: \(measureTime { quickSort(&array, low: 0, high: array.count - 1) }) seconds")

array = ascendingArray
print("Mergesort: \(measureTime { mergeSort(&array) }) seconds")

print("\nDescending Array Sorting:")

array = descendingArray
print("Shellsort: \(measureTime { shellSort(&array) }) seconds")

array = descendingArray
print("Heapsort: \(measureTime { heapSort(&array) }) seconds")

// Causa estouro de memoria
//array = descendingArray
//print("Quicksort: \(measureTime { quickSort(&array, low: 0, high: array.count - 1) }) seconds")

array = descendingArray
print("Mergesort: \(measureTime { mergeSort(&array) }) seconds")
