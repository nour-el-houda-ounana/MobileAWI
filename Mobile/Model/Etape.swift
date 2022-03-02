//
//  Etape.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct EtapeFiche : Identifiable {
    
    var id : String
    var nom : String
    var description : String
    var temps : Int
    var ingreds : [Ingredient]
    var quantite : [Int]

}
