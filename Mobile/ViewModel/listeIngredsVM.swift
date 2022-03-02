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
   
   var description: String{
      switch self {
         case .ready                   : return "ready"
         case .listUpdated             : return "ingredient list updated"
         case .valueUpdated(let index) : return "ingredient element at \(index) updated"
         case .valuePushing( _)        : return "ingredient to be pushed"
         case .valuePushed( _)         : return "ingredient pushed"
         case .valueAppending( _)      : return "ingredient to be appended"
         case .valueAppended( _)       : return "ingredient appended"
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
                self.push(igVm: ingredient)
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
    
    
    init() {
        //self.liste = [ingredVM]()
        //getIngreds()
        
        db.collection("ingredients").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.liste = snapshot.documents.map{ doc in
                            return ingredVM(from :Ingredient(nom: doc["nom"] as? String ?? "", PU: doc["PU"] as? Double ?? 0, unite:  doc["unite"] as? String ?? "", quantite: doc["quantite"] as? Double ?? 0, allergene: doc["allergene"] as? Bool ?? false, typeAllergene: doc["CatAllergene"] as? String ?? ""))
                            
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
        
    }
    
    // Lire données de Document
    func getIngreds() {
        db.collection("ingredients").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.liste = snapshot.documents.map{ doc in
                            return ingredVM(from :Ingredient(nom: doc["nom"] as? String ?? "", PU: doc["PU"] as? Double ?? 0, unite:  doc["unite"] as? String ?? "", quantite: doc["quantite"] as? Double ?? 0, allergene: doc["allergene"] as? Bool ?? false, typeAllergene: doc["CatAllergene"] as? String ?? ""))
                            
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
    }
    
    
    
    func push(igVm : ingredVM) {
        print("ADDINNG")
        igVm.model.add(delegate: self)
        igVm.add(igVm)
        self.liste.append(igVm)
        print("INDERTED")
        self.intent = .valuePushed(igVm)

        //print("GET METHOOD")
        //getIngreds()
        print("FINIIIISH")
    }
    
    //Delete
    func delete(igVm : ingredVM) {
        
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

}
