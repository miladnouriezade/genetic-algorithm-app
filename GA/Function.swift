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
//Create first population
func createPopulation(count:Int, size:Int, population:inout [Chromosome]){
    for _ in 0..<count{
        let sample = Chromosome(with:size)
        population.append(sample)
    }
}


func calcFitness(for generation:inout [Chromosome],with queenNum:Int){
    var totalFotness = 0
    let maxFitness = ((queenNum - 1)*(queenNum)) / 2
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
        totalFotness += generation[k].fitness
    }
    generation.sort(by: {$0.fitness > $1.fitness})
    
}


func fitnessAvg(generation:[Chromosome])->Int{
    var totalFitness = 0
    for i in 0 ..< generation.count{
        let fitness = generation[i].fitness
        totalFitness += fitness
    }
    return totalFitness/(generation.count)
    
}
func bestChromosome(generation:inout [Chromosome])->Chromosome{
    generation.sort(by: {$0.fitness > $1.fitness})
    return generation[0]
}

//Elitism in GA: transfer a specific percents of best chromosomes of generation directly to new generation
func enableElitism(from generation:[Chromosome], to newGen:inout [Chromosome], with percent:Double, newGenCount:inout Int){
    let count = percent/100 * Double(generation.count)
    for i in 0..<Int(count){
        var sample = Chromosome()
        sample.fitness = generation[i].fitness
        sample.genes = generation[i].genes
        
        newGen.append(sample)
        newGenCount += 1
    }
}

//TournomentSelect: select 2 best parent from percents of chromosomes
func tournomentSel(from generation:[Chromosome], with percent:Double)-> [Chromosome]{
    let count = percent/100 * Double(generation.count)
    var randomChromosomes = [Chromosome]()
    var selectedChromosome = [Chromosome]()
    var sample = Chromosome()
    randomChromosomes = Array(repeating: sample, count:Int(count))
   
    for i in 0 ..< Int(count){
        let randomSel = Int(arc4random_uniform(UInt32(generation.count)))
        sample.genes = generation[randomSel].genes
        sample.fitness = generation[randomSel].fitness
        randomChromosomes[i] = sample
    }
    randomChromosomes.sort(by: {$0.fitness > $1.fitness})
    selectedChromosome.append(randomChromosomes[0])
    selectedChromosome.append(randomChromosomes[1])
    return selectedChromosome
}
//SingleCrossover: select randomPoint in genes of parent and swap every gene from randomPoint in two parent
func singleCrossover(for chromosomes:inout [Chromosome])->[Chromosome]{
  let randomPoint = Int(arc4random_uniform(UInt32(chromosomes[1].genes.count)))
    
    for i in randomPoint ..< chromosomes[1].genes.count{
        
        let temp = chromosomes[0].genes[i]
        
        chromosomes[0].genes[i] = chromosomes[1].genes[i]
        
        chromosomes[1].genes[i] = temp
        
    }
    
    return chromosomes
    
}

//Mutation:select randomGene in every parent and set random num to it
func mutation(for chromosomes:inout [Chromosome])->[Chromosome]{
    let genes = chromosomes[0].genes
    
    for i in 0 ..< chromosomes.count{
    
    let randomGene = Int(arc4random_uniform(UInt32(genes.count)))
    let mutatedGene = Int(arc4random_uniform(UInt32(genes.count)))
        
    chromosomes[i].genes[randomGene] = mutatedGene
    }
    return chromosomes

}


    
