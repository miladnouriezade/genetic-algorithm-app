//
//  ViewController.swift
//  GA
//
//  Created by Milad Nourizade on 5/21/18.
//  Copyright © 2018 Milad Nourizade. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var populationField: UITextField!
    @IBOutlet weak var TournomentSizeField: UITextField!
    @IBOutlet weak var crossoverField: UITextField!
    @IBOutlet weak var mutationField: UITextField!
    @IBOutlet weak var genCountField: UITextField!
    
    var previousGen:[Chromosome] = []
    var selectedChromosomes:[Chromosome] = []
    var newGen = [Chromosome]()
    var fitnessAvgArray:[Int] = []
    var bestChromosomes :[Chromosome] = []
    var newGenCount = 0
    var nQueen = 0
    var populationCount = 0
    var tournomentSize:Double = 0
    var crossoverRate = 0
    var mutationRate = 0
    var generationCount = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func saveCliked(_ sender: Any) {
        if let size = sizeField.text, let population = populationField.text,
            let percent = TournomentSizeField.text,let crossover = crossoverField.text,
            let mutation = mutationField.text, let genCount = genCountField.text  {
            
            nQueen = Int(size)!
            populationCount = Int(population)!
            tournomentSize = Double(percent)!
            crossoverRate = Int(crossover)!
            mutationRate = Int(mutation)!
            generationCount = Int(genCount)!
            
            createPopulation(count: populationCount, size:nQueen , population: &previousGen)
            calcFitness(for: &previousGen,with:nQueen)
            for _ in 0 ..< generationCount{
            generateGen(populationCount: populationCount)
            }
//            print("NEWGeneration:\(newGen)")
//            print("previousGen:\(previousGen)")
            print("FitnessAVG:\(fitnessAvgArray)\n")
            print("BestChromosomes:\(bestChromosomes)\n")
            
            
        }
    }
    func willCrossover(rate:Int){
        //let random = arc4random_uniform(UInt32(100))
        
        if 1 == rate{
            selectedChromosomes = singleCrossover(for:&selectedChromosomes)
            calcFitness(for: &selectedChromosomes, with: nQueen)
            print("CROSOVERED:\(selectedChromosomes)\n")
        }
    }
    
    func willmutating(rate:Int){
        //let random = arc4random_uniform(UInt32(100))
        
        if 1 == rate {
            selectedChromosomes = mutation(for: &selectedChromosomes)
            calcFitness(for: &selectedChromosomes, with: nQueen)
            print("Mutated:\(selectedChromosomes)\n")
        }
    }
    func addToNewGen(){
        willCrossover(rate: crossoverRate)
        willmutating(rate: mutationRate)
        for chromosome in selectedChromosomes{
            newGen.append(chromosome)
            newGenCount += 1
        }
    }
    func generateGen(populationCount:Int){
        var fitness:Int = 0
        var chromosome = Chromosome()
//        fitness = fitnessAvg(generation: previousGen)
//        fitnessAvgArray.append(fitness)
        
       
        while newGenCount < populationCount {
            selectedChromosomes = tournomentSel(from: previousGen, with: tournomentSize)
            addToNewGen()
        }
        previousGen = newGen
        chromosome = bestChromosome(generation: &previousGen)
        bestChromosomes.append(chromosome)
        
        
        fitness = fitnessAvg(generation: previousGen)
        fitnessAvgArray.append(fitness)
        
        newGen.removeAll()
        newGenCount = 0
        
    }
        
}
extension MainViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




    



