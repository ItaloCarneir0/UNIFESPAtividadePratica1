//
//  main.swift
//  AtividadePratica1
//
//  Created by Italo Carneiro on 10/08/24.
//

import Foundation

func gerarVetorAleatorio(tamanho: Int, intervalo: Range<Int>) -> [Int] {
    return (0..<tamanho).map { _ in Int.random(in: intervalo) }
}

// Função de busca sequencial
func buscaSequencial(vetor: [Int], valor: Int) -> Int? { // Complexidade O(n)
    for (indice, elemento) in vetor.enumerated() {
        if elemento == valor {
            return indice
        }
    }
    return nil
}

// Função de busca binária
func buscaBinaria(vetor: [Int], valor: Int) -> Int? { // Complexidade O(log n)
    var inicio = 0
    var fim = vetor.count - 1
    
    while inicio <= fim {
        let meio = (inicio + fim) / 2
        if vetor[meio] == valor {
            return meio
        } else if vetor[meio] < valor {
            inicio = meio + 1
        } else {
            fim = meio - 1
        }
    }
    return nil
}

let vetorAleatorio = gerarVetorAleatorio(tamanho: 100_000, intervalo: 1..<100_001)

// ---- Busca Sequencial ----
let inicioSequencial = Date()

// Busca sequencial pelo número 9
if let indice9Seq = buscaSequencial(vetor: vetorAleatorio, valor: 9) {
    print("Busca Sequencial: Número 9 encontrado na posição \(indice9Seq).")
} else {
    print("Busca Sequencial: Número 9 não encontrado.")
}

// Busca sequencial pelo número 99.999
if let indice99999Seq = buscaSequencial(vetor: vetorAleatorio, valor: 99_999) {
    print("Busca Sequencial: Número 99.999 encontrado na posição \(indice99999Seq).")
} else {
    print("Busca Sequencial: Número 99.999 não encontrado.")
}

let fimSequencial = Date()
let tempoExecucaoSequencial = fimSequencial.timeIntervalSince(inicioSequencial)
print("Tempo de execução da busca sequencial: \(tempoExecucaoSequencial) segundos.")



// ---- Busca Binária ----
var vetorOrdenado = vetorAleatorio.sorted() // Ordena o vetor para a busca binária

let inicioBinaria = Date()

// Busca binária pelo número 9
if let indice9Bin = buscaBinaria(vetor: vetorOrdenado, valor: 9) {
    print("Busca Binária: Número 9 encontrado na posição \(indice9Bin).")
} else {
    print("Busca Binária: Número 9 não encontrado.")
}

// Busca binária pelo número 99.999
if let indice99999Bin = buscaBinaria(vetor: vetorOrdenado, valor: 99_999) {
    print("Busca Binária: Número 99.999 encontrado na posição \(indice99999Bin).")
} else {
    print("Busca Binária: Número 99.999 não encontrado.")
}

let fimBinaria = Date()
let tempoExecucaoBinaria = fimBinaria.timeIntervalSince(inicioBinaria)
print("Tempo de execução da busca binária: \(tempoExecucaoBinaria) segundos.")
