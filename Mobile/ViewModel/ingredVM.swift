//
//  ingredVM.swift
//  Mobile
//
//  Created by m1 on 24/02/2022.
//

import Foundation
import Firebase

enum IngredVNIntent : CustomStringConvertible{
   case ready
   case nameChanging(String)
   case nameChanged(String)

   var description: String{
      switch self {
         case .ready                 : return "ready"
         case .nameChanging(let name): return "name to be changed to \(name)"
         case .nameChanged(let name) : return "name changed to: \(name)"
      }
   }

   // MARK: -
   // MARK: Intents
   
   mutating func endOfIntent(){
      self = .ready
   }

   mutating func intentToChange(name: String){
         self = .nameChanging(name)
   }

}


class ingredVM : ObservableObject, IngredDelegate {
    
    var model : Ingredient
    
    private var db =  Firestore.firestore()
    
    @Published private(set) var intent : IngredVNIntent = .ready   {
           didSet{
             switch self.intent{
    //            case let .nameChanging(name):
    //               self.name = name
                default:
                   return
             }
          }
                                                                    
       }
    
    init(from ingred : Ingredient) {
        self.model = ingred
        self.name = ingred.nom
        ingred.add(delegate: self)
    }
    
    @Published var name : String {
        didSet {
            switch self.intent {
            case .nameChanging(let nvNom):
                if model.nom != nvNom {
                    model.nom = nvNom
                }
            default:
                self.name = oldValue
            }
        }
    }
    
    var pu : Double { return model.PU }
    var unite : String { return model.unite }
    var quantite : Double { return model.quantite }
    var allergene : Bool { return model.allergene }
    var typeAllergene : String { return model.typeAllergene }

    
    func add(nom : String, PU : Double, unite: String, quantite:Double,allergene:Bool,typeAllergene : String, categorie : String) {
        // Ajouter à la Collection
        db.collection("ingredients").addDocument(data: ["nom": nom, "PU": PU,
                                                        "unite": unite, "quantite": quantite,
                                                        "allergene" : allergene, "CatAllergene": typeAllergene, "categorie": categorie ])
    }
    
    func delete() {
        if let docId = model.id {
            db.collection("ingredients").document(docId).delete{ error in
                if error == nil {
                    print("Deletee")
                }
            }
        }
    }
    
    
    // : IngredDelegate
    func changed(name: String) {
        guard name != self.name else { return }
        self.name = name
    }
    
    func changed(pu: Double) {
        return
    }
    
    func changed(unite: String) {
        return
    }
    
    func changed(quantite: Double) {
        return
    }
    
    func changed(allergene: Bool) {
        return
    }
    
    func changed(typeAllergene: String) {
        return
    }
    
    func changed(categorie : String) {
        return
    }
    
    
}
