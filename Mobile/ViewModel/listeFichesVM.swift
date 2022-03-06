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
    
    // Récupération des fiches
    func getFiches() {
        db.collection("Fiche").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    //Update the list property in the main thread
                    DispatchQueue.main.async {
                        //initialisation de la liste de fiches VM
                        self.listeFichesVM = snapshot.documents.map{ doc in
                            return FicheVM(from : Fiche(id: doc.documentID ,intitule: doc["intitule"] as? String ?? "", responsable: doc["responsable"] as? String ?? "", couverts: doc["nbrCouverts"] as? Int ?? 0, categorie: doc["categorie"] as? String ?? "",ingredients: doc["ingredients"] as? [String] ?? [], description: doc["description"] as? String ?? "", etape: doc["etape"] as? [String] ?? [] , materielSpes: doc["materielSpes"] as? String ?? "", materielDress: doc["materielDress"] as? String ?? "", temps: doc["temps"] as? Int ?? 0))
                        }
                    }
                }
            }
            else{
                //Handeling the error
            }
        }
    }
    
    
    //Ajouter une étape à une fiche et modifier le temps total de la fiche
    func addEtapeToFiche(idFiche : Int, etapes : [String]){
        for i in 0..<etapes.count {
            self.listeFichesVM[idFiche].model.etape.append(etapes[i])
        }
        // Update le modèle dans la BD
        self.listeFichesVM[idFiche].updateFiche()
        let x = getFiches(tabetapes: etapes)
        let t = getTimes(tab: x)
        if t != 0 {
            self.listeFichesVM[idFiche].updateTemps(temps: t)
        }
    }
    
    func deleteFiche(idFiche: Int) {
        let ficheVM = self.listeFichesVM[idFiche]
        ficheVM.deleteFiche()
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
    
    // Get Fiches qui sont utilisés comme étape dans une autre fiche
    func getFiches(tabetapes : [String]) -> [FicheVM]{
        var tab : [FicheVM] = []
        for j in 0..<listeFichesVM.count {
            if tabetapes.contains(listeFichesVM[j].intitule) {
                tab.append(listeFichesVM[j])
            }
        }
        return tab
    }
    
    //Get le temps total des étapes
    func getTimes(tab : [FicheVM]) -> Int {
        var total = 0
        for j in 0..<tab.count {
            total = total + tab[j].model.tempsTotal
        }
        return total
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
