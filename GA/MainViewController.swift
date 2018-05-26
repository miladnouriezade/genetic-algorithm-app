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
    
    var populationArray:[Chromosome] = []
    var selectedChromosomes:[Chromosome] = []
    var nQueen = 0
    var populationCount = 0
    var tournomentSize = 0
    var crossoverRate = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func saveCliked(_ sender: Any) {
        if let size = sizeField.text, let population = populationField.text,
            let percent = TournomentSizeField.text,let crossover = crossoverField.text{
            nQueen = Int(size)!
            populationCount = Int(population)!
            tournomentSize = Int(percent)!
            crossoverRate = Int(crossover)!
            
            createPopulation(count: populationCount, size:nQueen , population: &populationArray)
            calcFitness(for: &populationArray,with:nQueen)
            selectedChromosomes = tournomentSel(from: populationArray, with:Float(tournomentSize))
            print("***Parent:\(selectedChromosomes)\n")
            willCrossover(rate:crossoverRate)
            print("CROSOVERED:\(selectedChromosomes)\n")
            
            
        }
    }
    func willCrossover(rate:Int)->Bool{
        
        //let random = arc4random_uniform(UInt32(100))
        
        if 1 == rate{
            selectedChromosomes = singleCrossover(for:&selectedChromosomes)
            calcFitness(for: &selectedChromosomes, with: nQueen)
            return true
            
        }else{
            return false
        }
    }
    
    
    
}


extension MainViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




    



