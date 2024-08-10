//
//  main.swift
//  AtividadePratica1
//
//  Created by Italo Carneiro on 10/08/24.
//

import Foundation

// Função para verificar se um número é primo
func isPrime(_ number: Int) -> Bool {
    if number <= 1 { return false } // Complexidade constante O(1)
    if number <= 3 { return true } // Complexidade constante O(1)
    if number % 2 == 0 || number % 3 == 0 { return false } // Complexidade constante O(1)
    var i = 5
    while i * i <= number { // Complexidade O(√m) onde m é o número a ser validado
        if number % i == 0 || number % (i + 2) == 0 { // Complexidade constante O(1)
            return false
        }
        i += 6
    }
    return true
}

// Função para encontrar o último número primo em um array
func findLastPrime(in array: [Int]) -> Int? {
    var lastPrime: Int? = nil
    
    for number in array { // Complexidade O(n * √m) sendo n o número de elementos no array
        if isPrime(number) {
            lastPrime = number
        }
    }
    
    return lastPrime
}

let array = Array(1...100_000)

// Marca o início do tempo
let startTime = Date()

// Executa a função para encontrar o último número primo
if let lastPrime = findLastPrime(in: array) {
    print("O último número primo encontrado é \(lastPrime)")
} else {
    print("Nenhum número primo encontrado.")
}

// Marca o fim do tempo
let endTime = Date()

// Calcula a duração da execução
let executionTime = endTime.timeIntervalSince(startTime)
print("Tempo de execução: \(executionTime) segundos")
