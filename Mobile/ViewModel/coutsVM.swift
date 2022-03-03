//
//  coutsVM.swift
//  Mobile
//
//  Created by m1 on 03/03/2022.
//

import Foundation
import Firebase

class coutsVM : ObservableObject, coutDelegate {
    
    @Published
    var model = [couts]()
    
    //get ref to database
    private var db =  Firestore.firestore()
    
    
    init() {
        db.collection("Cout").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.model = snapshot.documents.map{ doc in
                            return couts(personnel: doc["coutPersonnel"] as? Double ?? 0, fluide: doc["coutFluide"] as? Double ?? 0, assaisonement: doc["coutAssaisonnement"] as? Bool ?? false, coeffMultip: doc["coefficient"] as? Int ?? 0)
                            
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
        
    }
    
    
    
    
    func changed(personnel: Double) {
        return
    }
    
    func changed(fluide: Double) {
        return
    }
    
    func changed(assaisonement: Bool) {
        return
    }
    
    func changed(coeffMultip: Int) {
        return
    }
    
    
    
    
}
