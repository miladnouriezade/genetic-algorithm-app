//
//  SeccondViewController.swift
//  GA
//
//  Created by Milad Nourizade on 5/29/18.
//  Copyright © 2018 Milad Nourizade. All rights reserved.
//

import UIKit
import Charts

class BestFitnessViewController: UIViewController {
    
    @IBOutlet weak var lineChart: LineChartView!
    var bestFitness : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update_fitness()

        // Do any additional setup after loading the view.
    }

    func update_fitness(){
        var lineChartEnty1 = [ChartDataEntry]()
        for i in 0..<bestFitness.count{
            let value = ChartDataEntry(x: Double(i), y: Double(bestFitness[i]))
            lineChartEnty1.append(value)
        }
        let line = LineChartDataSet(values: lineChartEnty1, label: "BestFitness")
        line.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.addDataSet(line)
        lineChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        lineChart.data = data
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
