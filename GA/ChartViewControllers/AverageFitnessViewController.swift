//
//  LineChartViewController.swift
//  GA
//
//  Created by Milad Nourizade on 5/28/18.
//  Copyright © 2018 Milad Nourizade. All rights reserved.
//

import UIKit
import Charts

class AverageFitnessViewController: UIViewController {
    @IBOutlet weak var lineChart: LineChartView!
    var fitnessArray : [Int] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChart()

    }
    func updateChart(){
        var lineChartEnty = [ChartDataEntry]()
        for i in 0..<fitnessArray.count{
            let value = ChartDataEntry(x: Double(i), y: Double(fitnessArray[i]))
            lineChartEnty.append(value)
            
        }
        let line = LineChartDataSet(values:lineChartEnty , label: "FitnessAVG")
        line.colors = [NSUIColor.red]
        line.circleRadius = CGFloat(3)
        line.circleColors = [NSUIColor.black]
        line.circleHoleRadius = CGFloat(0)
        
        
        let data = LineChartData()
        data.addDataSet(line)
        
        lineChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        lineChart.data = data
        
    }
    
   
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
