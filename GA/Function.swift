//
//  Function.swift
//  GA
//
//  Created by Milad Nourizade on 5/21/18.
//  Copyright © 2018 Milad Nourizade. All rights reserved.
//

import Foundation

func random(for input:Int)-> Int{
    let randomNum = arc4random_uniform(UInt32(input))
    
    return Int(randomNum)
}

func createPopulation(count:Int, size:Int, population:inout [Chromosome]){
    for _ in 0..<count{
        let sample = Chromosome(with:size)
        population.append(sample)
    }
}

func calcFitness(for generation:inout [Chromosome],with queenNum:Int){
    let maxFitness = ((queenNum - 1)*(queenNum)) / 2
    var totalFitness = 0
    var clashes = 0
    
    for k in 0 ..< generation.count{
        let chromosome = generation[k].genes
        let unique = Array(Set(chromosome))
        let columnClashes = abs(chromosome.count - unique.count)
        clashes += columnClashes
        for i in 0 ..< chromosome.count{
            for j in i+1 ..< chromosome.count{
                let gen1 = generation[k].genes[i]
                let gen2 = generation[k].genes[j]
                if abs(i-j) == abs(gen1 - gen2){
                    clashes = clashes + 1
                }
            }
        }
        generation[k].fitness = (maxFitness - clashes)
        totalFitness += generation[k].fitness
    }
    print("Average Fitness is = ")
    print(totalFitness / generation.count)

}

    

