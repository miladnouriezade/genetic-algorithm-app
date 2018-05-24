//
//  Chromosome.swift
//  GA
//
//  Created by Milad Nourizade on 5/21/18.
//  Copyright © 2018 Milad Nourizade. All rights reserved.
//

import Foundation

struct Chromosome{
    var genes = [Int]()
    var fitness:Int = 0
    
    init() {}
    
    init(with number:Int) {
        genes = Array(repeating: 0, count: number)
        for i in 0 ..< genes.count{
            genes[i] = random(for: number)
            
        }
    }
}
