//
//  FicheVM.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//
import Foundation
import Firebase

enum FicheVMIntent : CustomStringConvertible{
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


class FicheVM : ObservableObject, FicheDelegate {
  
    
    var model : Fiche
    
    private var db =  Firestore.firestore()
    
    @Published private(set) var intent : FicheVMIntent = .ready   {
           didSet{
             switch self.intent{
    //            case let .nameChanging(name):
    //               self.name = name
                default:
                   return
             }
          }
                                                                    
       }
    
    @Published var intitule : String {
        didSet {
            switch self.intent {
            case .nameChanging(let nvNom):
                if model.intitule != nvNom {
                    model.intitule = nvNom
                }
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
    
    func addFiche(_ ficheVm : FicheVM) {
        db.collection("Fiche").addDocument(data: ["intitule": ficheVm.model.intitule, "responsable" : ficheVm.model.responsable,
                                                      "nbrCouverts": ficheVm.model.couverts ,"categorie" : ficheVm.model.categorie, "materielSpes": ficheVm.model.materielSpes,
                                                      "materielDress": ficheVm.model.materielDress])
            
    }
    
    
    //update Fiche
    
    //delete Fiche
    
    
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
