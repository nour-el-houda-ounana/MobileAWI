//
//  CatFicheVM.swift
//  Mobile
//
//  Created by m1 on 15/02/2022.
//

import Foundation
import Firebase

class CatFicheVM : ObservableObject {
    
    // List of Categories
    @Published var listCat = [FicheCat]()
    
    //get ref to database
    private var db =  Firestore.firestore()
    
    func getFicheCat() {
        //read from document
        db.collection("CategorieFiche").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.listCat = snapshot.documents.map{ doc in
                            return FicheCat(id: doc.documentID , emoji: doc["emoji"] as? String ?? "", type: doc["type"] as? String ?? "", image: doc["image"] as? String ?? "")
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
        
    }
    
    init() {
        getFicheCat()
    }
}

enum FicheCatVM : String {
    
    case Dessert = "Dessert"
    case Accompagnement = "Accompagnement"
    case Entrée = "Entrée"
    case Plat = "Plat"
    
}
