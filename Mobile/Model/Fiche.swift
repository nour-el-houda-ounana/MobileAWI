//
//  Fiche.swift
//  Mobile
//
//  Created by m1 on 16/02/2022.
//

import Foundation

struct Fiche : Identifiable {
    
    var id : String = UUID().uuidString
    var intitule : String
    var responsable : String
    var couverts : Int
    var categorie : String
    //var etape : [{description, [ingredients], [qtt]}]
    var materielSpes : String
    var materielDress : String
    
}
