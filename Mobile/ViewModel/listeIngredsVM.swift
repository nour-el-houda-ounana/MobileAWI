//
//  listeIngredsVM.swift
//  Mobile
//
//  Created by m1 on 24/02/2022.
//

import Foundation
import Firebase

// ListIngredIntent VM
enum IngredListViewModelIntent : CustomStringConvertible{
   case ready
   case listUpdated
   case valueUpdated(Int)
   case valuePushing(ingredVM)
   case valuePushed(ingredVM)
   case valueAppending(ingredVM)
   case valueAppended(ingredVM)
   case valueDeleted(ingredVM)
   
   var description: String{
      switch self {
         case .ready                   : return "ready"
         case .listUpdated             : return "ingredient list updated"
         case .valueUpdated(let index) : return "ingredient element at \(index) updated"
         case .valuePushing( _)        : return "ingredient to be pushed"
         case .valuePushed( _)         : return "ingredient pushed"
         case .valueAppending( _)      : return "ingredient to be appended"
         case .valueAppended( _)       : return "ingredient appended"
         case .valueDeleted( _)        : return "ingredient supprimé"
      }
   }
   
   // MARK: -
   // MARK: Intents
   
   mutating func endOfIntent(){
      self = .ready
   }
   mutating func intentToPush(_ ingredient: ingredVM){
      self = .valuePushing(ingredient)
   }
   mutating func intentToAppend(_ ingredient: ingredVM){
      self = .valueAppending(ingredient)
   }

   
}

class listeIngredsVM : ObservableObject,IngredDelegate {
  
    @Published
    var liste = [ingredVM]()
    
    @Published var intent : IngredListViewModelIntent = .ready{
       didSet{
          switch self.intent{
             case .valuePushing(let ingredient):
                //self.push(igVm: ingredient)
                self.intent = .valuePushed(ingredient)
             /*case .valueAppending(let ingredient):
                self.append(track)
                self.intent = .valueAppended(track)*/
             default:
                return
          }
       }
    }
    
    //get ref to database
    private var db =  Firestore.firestore()
    
    private var listener : ListenerRegistration?
    
    
    init() {
        getIngreds()
    }
    
    func getIngreds(){
        db.collection("ingredients").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.liste = snapshot.documents.map{ doc in
                            return ingredVM(from :Ingredient(id: doc.documentID, nom: doc["nom"] as? String ?? "", PU: doc["PU"] as? Double ?? 0, unite:  doc["unite"] as? String ?? "", quantite: doc["quantite"] as? Double ?? 0, allergene: doc["allergene"] as? Bool ?? false, typeAllergene: doc["CatAllergene"] as? String ?? "", categorie: doc["categorie"] as? String ?? ""))
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
    }
    
    func fetchData(){
        if listener == nil {
            listener = db.collection("ingredients").addSnapshotListener({ (querySnapshot, error) in
                guard let doc = querySnapshot?.documents else {
                    return
                }
                self.liste = doc.map{ (document) -> ingredVM in
                    return ingredVM(from :Ingredient(id: document.documentID, nom: document["nom"] as? String ?? "", PU : document["PU"] as? Double ?? 0, unite:  document["unite"] as? String ?? "", quantite: document["quantite"] as? Double ?? 0, allergene: document["allergene"] as? Bool ?? false, typeAllergene: document["CatAllergene"] as? String ?? "", categorie: document["categorie"] as? String ?? ""))
                }
            })
        }
    }
    
    func getUnite(nomIngred : String) -> String{
        for ing in liste {
            if ing.name == nomIngred {
                return ing.unite
            }
        }
        return "none"
    }
    
    
   func delete(igVm : ingredVM) {
        igVm.model.remove(delegate: self)
        igVm.delete()
        self.liste = self.liste.filter { $0 !== igVm }
        self.intent = .valueDeleted(igVm)
    }
    
    /*func deleteIngredient(idIngredient : String) {
        db.collection("ingredients").document(idIngredient).delete(){ error in
            if error == nil {
                DispatchQueue.main.async {
                    self.liste.removeAll { ingred in
                        return ingred.model.id == idIngredient
                    }
                }
            }
        }
    }*/
    
    
    /*func push(igVm : ingredVM) {
        igVm.model.add(delegate: self)
        igVm.add(igVm)
        self.liste.append(igVm)
        self.intent = .valuePushed(igVm)

    }*/
    
    func searchIngredientByName(nom : String) -> [ingredVM] {
        var tabFiches : [ingredVM] = []
        for i in 0..<self.liste.count {
            if(self.liste[i].model.nom.contains(nom)){
                tabFiches.append(self.liste[i])
            }
        }
        return tabFiches
    }
    
    // Delegate
    func changed(name: String) {
        self.intent = .listUpdated
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
    
    func changed(categorie: String) {
        return
    }

}
