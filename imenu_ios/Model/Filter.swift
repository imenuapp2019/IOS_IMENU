//
//  Filter.swift
//  imenu_ios
//
//  Created by Miguel Jaimes on 05/03/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import Foundation

class SearchFilter {
    
    //Hola Edu
    var typeFoodSelected:String? = nil
    var averagePerson:String? = nil
    var averageDistance:String? = nil
    
    init(TypeFood typeFood:String?, AveragePerson averagePerson:String?,AverageDistace averageDistance:String?) {
        self.typeFoodSelected = typeFood
        self.averagePerson = averagePerson
        self.averageDistance = averageDistance
    }
    
    init(TypeFood typeFood:String?, AveragePerson averagePerson:String?) {
        self.typeFoodSelected = typeFood
        self.averagePerson = averagePerson
    }
    
    init(AverageDistace averageDistance:String?,AveragePerson averagePerson:String?) {
        self.averagePerson = averagePerson
        self.averageDistance = averageDistance
    }
}
