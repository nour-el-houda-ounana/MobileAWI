//
//  ingredient.swift
//  Mobile
//  Created by m1 on 17/02/2022.
//

import Foundation

protocol IngredDelegate : AnyObject {
    func changed(name: String)
    func changed(pu: Double)
    func changed(unite : String)
    func changed(quantite: Double)
    func changed(allergene: Bool)
    func changed(typeAllergene : String)
}

class Ingredient : Identifiable {
    
    var id: String = UUID().uuidString
    
    var nom : String {
        didSet{
           guard nom != oldValue else { return }
           for d in delegates{ d.changed(name: nom) }
        }
     }

    var PU : Double {
        didSet{
           guard PU != oldValue else { return }
           for d in delegates{ d.changed(pu: PU) }
        }
     }

    var unite : String { //Unite.type
        didSet{
           guard unite != oldValue else { return }
           for d in delegates{ d.changed(unite: unite) }
        }
    }
    
    var quantite : Double {
        didSet{
           guard quantite != oldValue else { return }
           for d in delegates{ d.changed(quantite: quantite) }
        }
     }
    var allergene : Bool {
        didSet{
           guard allergene != oldValue else { return }
           for d in delegates{ d.changed(allergene: allergene) }
        }
     }

    var typeAllergene : String {  //type{
        didSet{
           guard typeAllergene != oldValue else { return }
           for d in delegates{ d.changed(typeAllergene: typeAllergene) }
        }
     }

    init(nom : String, PU : Double, unite: String, quantite:Double,allergene:Bool,typeAllergene : String){
        self.nom = nom
        self.PU = PU
        self.unite = unite
        self.quantite = quantite
        self.allergene = allergene
        self.typeAllergene = typeAllergene
    }
    
    
    // Delegation
    private var delegates = [IngredDelegate]()
    
    func add(delegate: IngredDelegate) {
       self.delegates.append(delegate)
       print("add delegate : \(self.delegates.count) delagates now")
    }
    
    func remove(delegate: IngredDelegate) {
       self.delegates.removeAll{ $0 === delegate}
    }

    func nameChanged(value: String){
       for d in delegates{ d.changed(name: value) }
    }
    
    
}
