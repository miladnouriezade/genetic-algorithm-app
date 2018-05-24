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
    
    var populationArray:[Chromosome] = []
    var nQueen = 0
    var populationCount = 0
    var tournomentSize = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func saveCliked(_ sender: Any) {
        if let size = sizeField.text, let population = populationField.text, let percent = TournomentSizeField.text{
            nQueen = Int(size)!
            populationCount = Int(population)!
            tournomentSize = Int(percent)!
            
            createPopulation(count: populationCount, size:nQueen , population: &populationArray)
            calcFitness(for: &populationArray,with:nQueen)
//            print(populationArray)
            let tournomentSelected = tournomentSel(from: populationArray, with:Float(tournomentSize))
            print("***\(tournomentSelected)")
        }
    }
}


extension MainViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




    



