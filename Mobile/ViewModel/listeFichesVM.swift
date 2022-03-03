//
//  listeFichesVM.swift
//  Mobile
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import Firebase


class listeFichesVM : ObservableObject, FicheDelegate {
  
    @Published
    var listeFichesVM = [FicheVM]()
    
    private var db =  Firestore.firestore()
    
    init() {
        getFiches()
    }
    
    func push(fiche : FicheVM) {
        fiche.model.add(delegate:self)
        fiche.addFiche(fiche)
        self.listeFichesVM.append(fiche)
    }
    
    
    // Chercher la liste par Intitulé, responsable ou catégorie
    func searchFicheByName(nom : String) -> [FicheVM] {
        var tabFiches : [FicheVM] = []
        for i in 0..<self.listeFichesVM.count {
            if(self.listeFichesVM[i].model.intitule.contains(nom) || self.listeFichesVM[i].model.responsable.contains(nom) || self.listeFichesVM[i].model.categorie.contains(nom)){
                tabFiches.append(self.listeFichesVM[i])
            }
        }
        return tabFiches
    }
    
    // Récupérer liste de Fiche correspondants à la catégorie choisie
    func searchFicheByCategorie(categorie : String) -> [FicheVM] {
        var tabFiches : [FicheVM] = []
        for i in 0..<self.listeFichesVM.count {
            if (self.listeFichesVM[i].model.categorie.contains(categorie)) {
                tabFiches.append(self.listeFichesVM[i])
            }
        }
        return tabFiches
    }
    
    
    // Récupération des fiches
    func getFiches() {
        db.collection("Fiche").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        //initialisation de la liste de fiches VM
                        self.listeFichesVM = snapshot.documents.map{ doc in
                            return FicheVM(from : Fiche(intitule: doc["intitule"] as? String ?? "", responsable: doc["responsable"] as? String ?? "", couverts: doc["nbrCouverts"] as? Int ?? 0, categorie: doc["categorie"] as? String ?? "" , materielSpes: doc["materielSpes"] as? String ?? "", materielDress: doc["materielDress"] as? String ?? ""))
                        }
                        
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
    }
    
    
    //Delegate
    func changed(intitule: String) {
        return
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
