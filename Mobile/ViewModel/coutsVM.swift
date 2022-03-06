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
    
    init(){
        getCouts()
        
    }
    
    func getCouts(){
        db.collection("Cout").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.model = snapshot.documents.map{ doc in
                            return couts(id: doc.documentID, personnel: doc["coutPersonnel"] as? Double ?? 0, fluide: doc["coutFluide"] as? Double ?? 0, assaisonement: doc["coutAssaisonnement"] as? Bool ?? false, coeffMultip: doc["coefficient"] as? Int ?? 0)
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
        
    }

    // Modification
    func updatePersonnel(idModif : Int, cout : Double){
        if let documentId = model[idModif].id {
            db.collection("Cout").document(documentId).setData(["coutPersonnel": cout], merge: true)
        }
    }
    
    func updateFluide(idModif : Int, cout : Double){
        if let documentId = model[idModif].id {
            db.collection("Cout").document(documentId).setData(["coutFluide": cout], merge: true)
        }
    }
    
    func updateCoeff(idModif : Int, cout : Int){
        if let documentId = model[idModif].id {
            db.collection("Cout").document(documentId).setData(["coefficient": cout], merge: true)
        }
    }
    
    
    func updateAssaison(idModif : Int, cout : Bool){
        if let documentId = model[idModif].id {
            db.collection("Cout").document(documentId).setData(["coutAssaisonement": cout], merge: true)
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
