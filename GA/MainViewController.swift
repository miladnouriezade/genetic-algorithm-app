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
    @IBOutlet weak var bestAnsLabel: UILabel!
    @IBOutlet weak var elitismSwitch: UISwitch!
    @IBOutlet weak var elitismField: UITextField!
    
    
    var currentGen:[Chromosome] = []
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
    var elitismPercent:Int?
    

    
    
    override func viewDidLoad() {

    }
    
    //Getting data from user and run algorithm
    @IBAction func runClicked(_ sender: Any) {
        if let size = sizeField.text, let population = populationField.text,
            let percent = TournomentSizeField.text,let crossover = crossoverField.text,
            let mutation = mutationField.text, let genCount = genCountField.text, let elitism = elitismField.text  {
            
            nQueen = Int(size)!
            populationCount = Int(population)!
            tournomentSize = Double(percent)!
            crossoverRate = Int(crossover)!
            mutationRate = Int(mutation)!
            generationCount = Int(genCount)!
            elitismPercent = Int(elitism)
            
            createPopulation(count: populationCount, size:nQueen , population: &currentGen) //generate first population
            calcFitness(for: &currentGen,with:nQueen)
    
            
            for _ in 0 ..< generationCount{
            generateGen(populationCount: populationCount)
            }
            
            bestAnsLabel.text = String(format: "%@, %@", String(describing: bestChromosomes.last!.genes), String(bestChromosomes.last!.fitness))
        }
    }
    // send fitnessAverage and bestFitness for every generation in new viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AverageFitness"{
            let controller = segue.destination as! AverageFitnessViewController
            controller.fitnessArray = fitnessAvgArray
        }
        else if segue.identifier == "BestFitness"{
            let controller = segue.destination as! BestFitnessViewController
            for i in 0 ..< bestChromosomes.count{
                controller.bestFitness.append(bestChromosomes[i].fitness)
            }
        }
    }
    
    
    //Crossover will happen with specific expectance
    func willCrossover(rate:Int){
        let random = arc4random_uniform(UInt32(100))
        
        if random < rate{
            selectedChromosomes = singleCrossover(for:&selectedChromosomes)
            calcFitness(for: &selectedChromosomes, with: nQueen)
        }
    }
    //Mutation will happen with specific expectance
    func willmutating(rate:Int){
        let random = arc4random_uniform(UInt32(100))
        
        if random < rate {
            selectedChromosomes = mutation(for: &selectedChromosomes)
            calcFitness(for: &selectedChromosomes, with: nQueen)
        }
    }
    //Add chromosomes to new generation
    func addToNewGen(){
        willCrossover(rate: crossoverRate)
        willmutating(rate: mutationRate)
        for chromosome in selectedChromosomes{
            newGen.append(chromosome)
            newGenCount += 1
        }
    }
    
    func generateGen(populationCount:Int){
        
        if elitismSwitch.isOn && elitismPercent != nil{
            enableElitism(from: currentGen, to: &newGen, with: Double(elitismPercent!), newGenCount: &newGenCount)
        }
        var fitness:Int = 0
        var chromosome = Chromosome()

       
        while newGenCount < populationCount {
            selectedChromosomes = tournomentSel(from: currentGen, with: tournomentSize)
            addToNewGen()
        }
        
        currentGen = newGen //Copy newGen to currentGen for generating new generation from currentGen
        chromosome = bestChromosome(generation: &currentGen)
        bestChromosomes.append(chromosome)
        
        
        fitness = fitnessAvg(generation: currentGen)
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




    



