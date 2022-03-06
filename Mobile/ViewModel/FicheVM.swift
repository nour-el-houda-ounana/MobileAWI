//
//  FicheVM.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//
import Foundation
import Firebase
import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift


enum FicheVMIntent : CustomStringConvertible, Equatable {
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

}

class FicheVM : ObservableObject, FicheDelegate {
  
    var model : Fiche
    
    private var db =  Firestore.firestore()
    
    @Published private(set) var intent : FicheVMIntent = .ready   {
           didSet{
             switch self.intent{
               // case let .nameChanging(name):
                 //  self.intitule = name
                default:
                   return
             }
          }
       }
    
    @DocumentID var id : String?
        
    @Published var intitule : String {
        didSet {
            switch self.intent {
                //case .nameChanging(let nvNom):
                  //  if model.intitule != nvNom {
                    //    model.intitule = nvNom
                    //}
                default:
                    self.intitule = oldValue
            }
        }
    }
    
    var responsable : String { return model.responsable }
    var couverts : Int { return model.couverts }
    var categorie : String { return model.categorie }
    var materielSpes : String { return model.materielSpes }
    var materielDress : String { return model.materielDress }
    
    
    init(from fiche : Fiche) {
        self.model = fiche
        self.intitule = model.intitule
        fiche.add(delegate: self)
    }
    
    
    func addFicheV2(intitule : String, responsable : String, couverts: Int, categorie: String,ingredients: [String], description : String, etape: [String] = [], materielSpes: String, materielDress : String, temps : Int) {
        db.collection("Fiche").addDocument(data: ["intitule": intitule, "responsable" : responsable,
                                                  "nbrCouverts": couverts ,"categorie" : categorie,"ingredients" :ingredients,"description": description, "etape": [] , "materielSpes": materielSpes, "materielDress": materielDress, "temps" : temps])
    }
    
    
    func addFiche(_ ficheVm : FicheVM) {
        db.collection("Fiche").addDocument(data: ["intitule": ficheVm.model.intitule, "responsable" : ficheVm.model.responsable,
                                                  "nbrCouverts": ficheVm.model.couverts ,"categorie" : ficheVm.model.categorie,"ingredients" : ficheVm.model.ingredients,"description": ficheVm.model.description, "etape": [] , "materielSpes": ficheVm.model.materielSpes,
                                                  "materielDress": ficheVm.model.materielDress, "temps" : ficheVm.model.tempsTotal])
    }
    
    func updateFiche() {
        if let documentId = model.id {
            db.collection("Fiche").document(documentId).setData(["etape": model.etape], merge: true)
        }
    }
    
    
    //update Fiche
    func updateName(name : String){
        if let documentId = model.id {
            db.collection("Fiche").document(documentId).setData(["intitule": name], merge: true)
            
        }
    }
    
    //delete Fiche
    func deleteFiche() {
        if let documentId = model.id {
            db.collection("Fiche").document(documentId).delete()
        }
    }
    
    // Delegate
    func changed(intitule: String) {
        guard intitule != self.intitule else { return }
        self.intitule = intitule
        
    }
    
    func changed(responsable: String) {
        return
    }
    
    func changed(couverts: Int) {
        return
    }
    
    func changed(categorie: String) {
        return
    }
    
    func changed(materielSpes: String) {
        return
    }
    
    func changed(materielDress: String) {
        return
    }
    
}
