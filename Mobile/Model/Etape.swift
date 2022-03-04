//
//  Etape.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct EtapeFiche : Identifiable {
    
    var id : String = UUID().uuidString
    var nom : String
    var description : String
    var temps : Int
    var ingreds : [Ingredient]
    //var quantite : [Int]
    
    init(nom : String, temps : Int, description: String, ingredients: [Ingredient] = []) {
        self.nom = nom
        self.temps = temps
        self.description = description
        self.ingreds = ingredients
    }

}
