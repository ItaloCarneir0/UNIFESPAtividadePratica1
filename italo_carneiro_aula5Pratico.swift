//
//  main.swift
//  AtividadePratica5
//
//  Created by Italo Carneiro on 03/09/24.
//

import Foundation

// Definindo a estrutura Data, conformando ao protocolo Equatable
struct Data: Equatable {
    var dia: Int
    var mes: Int
    var ano: Int
    
    // Implementação de '==' para comparar duas instâncias de Data
    static func ==(lhs: Data, rhs: Data) -> Bool {
        return lhs.dia == rhs.dia && lhs.mes == rhs.mes && lhs.ano == rhs.ano
    }
}

// Função para gerar 1000 datas aleatórias
func gerarDatasAleatorias() -> [Data] {
    var datas = [Data]()
    
    for _ in 0..<1000 {
        let dia = Int.random(in: 1...31)
        let mes = Int.random(in: 1...12)
        let ano = Int.random(in: 2000...2024)
        datas.append(Data(dia: dia, mes: mes, ano: ano))
    }
    
    return datas
}

// Função de radix sort com contagem e um método estável
func radixSortEstavel(_ datas: inout [Data]) {
    func countingSortEstavel(_ datas: inout [Data], by key: (Data) -> Int) {
        let maxElement = datas.map(key).max() ?? 0
        var count = Array(repeating: 0, count: maxElement + 1)
        var output = Array(repeating: Data(dia: 0, mes: 0, ano: 0), count: datas.count)
        
        // Contando as ocorrências
        for data in datas {
            count[key(data)] += 1
        }
        
        // Ajustando as posições
        for i in 1..<count.count {
            count[i] += count[i - 1]
        }
        
        // Construindo o array de saída
        for i in stride(from: datas.count - 1, through: 0, by: -1) {
            let data = datas[i]
            output[count[key(data)] - 1] = data
            count[key(data)] -= 1
        }
        
        datas = output
    }
    
    // Ordena por dia, depois mês e por último ano
    countingSortEstavel(&datas, by: { $0.dia })
    countingSortEstavel(&datas, by: { $0.mes })
    countingSortEstavel(&datas, by: { $0.ano })
}

// Função de radix sort com contagem e um método não estável
func radixSortNaoEstavel(_ datas: inout [Data]) {
    func countingSortNaoEstavel(_ datas: inout [Data], by key: (Data) -> Int) {
        let maxElement = datas.map(key).max() ?? 0
        var count = Array(repeating: 0, count: maxElement + 1)
        
        // Contando as ocorrências
        for data in datas {
            count[key(data)] += 1
        }
        
        // Colocando os elementos na ordem
        var index = 0
        for i in 0..<count.count {
            for data in datas where key(data) == i {
                datas[index] = data
                index += 1
            }
        }
    }
    
    // Ordena por dia, depois mês e por último ano
    countingSortNaoEstavel(&datas, by: { $0.dia })
    countingSortNaoEstavel(&datas, by: { $0.mes })
    countingSortNaoEstavel(&datas, by: { $0.ano })
}

// Função para medir o tempo de execução
func medirTempo(_ function: (inout [Data]) -> Void, _ datas: inout [Data]) -> TimeInterval {
    let start = Date()
    function(&datas)
    let end = Date()
    return end.timeIntervalSince(start)
}

// Exemplo de uso
var datasAleatorias = gerarDatasAleatorias()

var datasEstavel = datasAleatorias
let tempoEstavel = medirTempo(radixSortEstavel, &datasEstavel)
print("Tempo de execução com método estável: \(tempoEstavel) segundos")

var datasNaoEstavel = datasAleatorias
let tempoNaoEstavel = medirTempo(radixSortNaoEstavel, &datasNaoEstavel)
print("Tempo de execução com método não estável: \(tempoNaoEstavel) segundos")

// Explicação do motivo do erro no método não estável
if datasEstavel != datasNaoEstavel {
    print("A ordenação não funcionou corretamente com o método não estável.")
}
