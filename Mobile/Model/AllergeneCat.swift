//
//  AllergeneCat.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//

import Foundation


struct Allergene : Identifiable {
    
    var id : String
    var nomAllergene : String

}

enum catAllergene : String {
    
    case Crustasés = "Crustasés"
    case Arachide = "Arachide"
    case Céleri = "Céleri"
    case CéréalesGluten = "Céréales contenant du Gluten"
    case Lait = "Lait"
    case FruitsCoque = "Fruits à coque"
    case Lupin = "Lupin"
    case Œuf = "Œuf"
    case Poisson = "Poisson"
    case Mollusques = "Mollusques"
    case Moutarde = "Moutarde"
    case Sésame = "Sésame"
    case Soja = "Soja"
    case Sulfites = "Sulfites"
    
}
