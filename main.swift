//
//  main.swift
//  AtividadePratica1
//
//  Created by Italo Carneiro on 10/08/24.
//

import Foundation

// Gera um array aleatório de 100.000 números
let array = (0..<100_000).map { _ in Int.random(in: 1...1_000_000) }

// Função para verificar se um número é primo (iterativa)
func isPrimeIterativo(_ number: Int) -> Bool {
    if number <= 1 { return false } // Complexidade constante O(1)
    if number <= 3 { return true } // Complexidade constante O(1)
    if number % 2 == 0 || number % 3 == 0 { return false } // Complexidade constante O(1)
    var i = 5
    while i * i <= number { // Complexidade O(√m) onde m é o número a ser validado
        if number % i == 0 || number % (i + 2) == 0 { return false } // Complexidade constante O(1)
        i += 6
    }
    return true
}

// Função para verificar se um número é primo (recursiva)
func isPrimeRecursivo(_ number: Int, _ i: Int = 5) -> Bool {
    if number <= 1 { return false }
    if number <= 3 { return true }
    if number % 2 == 0 || number % 3 == 0 { return false }
    if i * i > number { return true }
    if number % i == 0 || number % (i + 2) == 0 { return false }
    return isPrimeRecursivo(number, i + 6)
}

// Função para encontrar o último número primo em um array (usando a função iterativa)
func findLastPrimeIterativo(in array: [Int]) -> Int? {
    var lastPrime: Int? = nil
    
    for number in array {
        if isPrimeIterativo(number) {
            lastPrime = number
        }
    }
    
    return lastPrime
}

// Função para encontrar o último número primo em um array (usando a função recursiva)
func findLastPrimeRecursivo(in array: [Int]) -> Int? {
    var lastPrime: Int? = nil
    
    for number in array {
        if isPrimeRecursivo(number) {
            lastPrime = number
        }
    }
    
    return lastPrime
}

// Marca o início do tempo para o algoritmo iterativo
let startTimeIterativo = Date()

// Executa a função para encontrar o último número primo usando o algoritmo iterativo
if let lastPrimeIterativo = findLastPrimeIterativo(in: array) {
    print("O último número primo encontrado (iterativo) é \(lastPrimeIterativo)")
} else {
    print("Nenhum número primo encontrado (iterativo).")
}

// Marca o fim do tempo para o algoritmo iterativo
let endTimeIterativo = Date()

// Calcula a duração da execução do algoritmo iterativo
let executionTimeIterativo = endTimeIterativo.timeIntervalSince(startTimeIterativo)
print("Tempo de execução do algoritmo iterativo: \(executionTimeIterativo) segundos")

// Marca o início do tempo para o algoritmo recursivo
let startTimeRecursivo = Date()

// Executa a função para encontrar o último número primo usando o algoritmo recursivo
if let lastPrimeRecursivo = findLastPrimeRecursivo(in: array) {
    print("O último número primo encontrado (recursivo) é \(lastPrimeRecursivo)")
} else {
    print("Nenhum número primo encontrado (recursivo).")
}

// Marca o fim do tempo para o algoritmo recursivo
let endTimeRecursivo = Date()

// Calcula a duração da execução do algoritmo recursivo
let executionTimeRecursivo = endTimeRecursivo.timeIntervalSince(startTimeRecursivo)
print("Tempo de execução do algoritmo recursivo: \(executionTimeRecursivo) segundos")
