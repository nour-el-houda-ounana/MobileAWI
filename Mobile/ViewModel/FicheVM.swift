//
//  FicheVM.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//
import Foundation
import Firebase


class FicheVM : ObservableObject {
    
    var model : Fiche
    
    private var db =  Firestore.firestore()
    
    init(from fiche : Fiche) {
        self.model = fiche
    }
    
    func addFiche(ficheVm : FicheVM) {
        db.collection("Fiche").addDocument(data: ["intitule": ficheVm.model.intitule, "responsable" : ficheVm.model.responsable,
                                                      "nbrCouverts": ficheVm.model.couverts ,"categorie" : ficheVm.model.categorie, "materielSpes": ficheVm.model.materielSpes,
                                                      "materielDress": ficheVm.model.materielDress])
            
    }
    
    
    //update Fiche
    
    //delete Fiche
    
    
    
}
