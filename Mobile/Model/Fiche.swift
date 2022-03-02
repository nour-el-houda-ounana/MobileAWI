//
//  Fiche.swift
//  Mobile
//
//  Created by m1 on 16/02/2022.
//

import Foundation

protocol FicheDelegate : AnyObject {
    func changed(intitule: String)
    func changed(responsable: String)
    func changed(couverts : Int)
    func changed(categorie: String)
    func changed(materielSpes: String)
    func changed(materielDress : String)
}

class Fiche : Identifiable {
    

    var id : String = UUID().uuidString
    
    var intitule : String {
        didSet{
           guard intitule != oldValue else { return }
           for d in delegates{ d.changed(intitule: intitule) }
        }
     }
    
    var responsable : String  {
        didSet{
           guard responsable != oldValue else { return }
           for d in delegates{ d.changed(responsable: responsable) }
        }
     }

    var couverts : Int  {
        didSet{
           guard couverts != oldValue else { return }
           for d in delegates{ d.changed(couverts: couverts) }
        }
     }

    var categorie : String  {
        didSet{
           guard categorie != oldValue else { return }
           for d in delegates{ d.changed(categorie: categorie) }
        }
     }
    
    
    //var etape : [{description, [ingredients], [qtt]}]
    
    var materielSpes : String  {
        didSet{
           guard materielSpes != oldValue else { return }
           for d in delegates{ d.changed(materielSpes: materielSpes) }
        }
     }

    var materielDress : String  {
        didSet{
           guard materielDress != oldValue else { return }
           for d in delegates{ d.changed(materielDress: materielDress) }
        }
     }
    
    init(intitule : String, responsable : String, couverts: Int, categorie: String, materielSpes: String, materielDress : String){
        self.intitule = intitule
        self.responsable = responsable
        self.couverts = couverts
        self.categorie = categorie
        self.materielSpes = materielSpes
        self.materielDress = materielDress
    }
    
    //Delegate
    private var delegates = [FicheDelegate]()

    func add(delegate: FicheDelegate) {
       self.delegates.append(delegate)
       print("add delegate : \(self.delegates.count) delagates now")
    }
    
    func remove(delegate: FicheDelegate) {
       self.delegates.removeAll{ $0 === delegate}
    }

    func nameChanged(value: String){
       for d in delegates{ d.changed(intitule: value) }
    }
    
}
