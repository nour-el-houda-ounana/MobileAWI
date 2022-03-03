//
//  IngredCatVM.swift
//  Mobile
//
//  Created by m1 on 21/02/2022.
//

import Foundation
import Firebase

class IngredCatVM : ObservableObject {
    
    // List of Categories
    @Published
    var listCatIngred = [IngredCat]()
    
    //get ref to database
    private var db =  Firestore.firestore()
    
    func getIngredCat() {
        //read from document
        db.collection("CategorieIngredient").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.listCatIngred = snapshot.documents.map{ doc in
                            return IngredCat(id: doc.documentID ,type: doc["type"] as? String ?? "")
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
        getIngredCat()
    }
    
}

enum catIngredVM : String {
    
    case Poisson = "Poisson - Crustacés"
    case Cremerie = "Crémerie"
    case viande = "Viandes - Volailles"
    case Epicerie = "Épicerie"
    case FruitLegume = "Fruits - Légumes"
    
}
