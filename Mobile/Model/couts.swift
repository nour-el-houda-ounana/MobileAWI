//
//  couts.swift
//  Mobile
//
//  Created by m1 on 03/03/2022.
//

import Foundation

protocol coutDelegate : AnyObject {
    func changed(personnel: Double)
    func changed(fluide: Double)
    func changed(assaisonement : Bool)
    func changed(coeffMultip : Int)
    
}

class couts : Identifiable {
    
    private var delegates = [coutDelegate]()

    var id = UUID().uuidString
    
    var personnel : Double = 0.0 {
        didSet{
           guard personnel != oldValue else { return }
           for d in delegates{ d.changed(personnel: personnel) }
        }
    }
    
    var fluide : Double {
        didSet {
            guard fluide != oldValue else { return }
            for d in delegates { d.changed(fluide: fluide) }
        }
    }
    
    var assaisonement : Bool {
        didSet {
            guard assaisonement != oldValue else { return }
            for d in delegates { d.changed(assaisonement: assaisonement) }
        }
        
    }
    
    var coeffMultip : Int {
        didSet {
            guard coeffMultip != oldValue else { return }
            for d in delegates { d.changed(coeffMultip : coeffMultip) }
        }
        
    }
    
    init(personnel: Double, fluide: Double, assaisonement: Bool, coeffMultip : Int){
        self.personnel = personnel
        self.fluide = fluide
        self.assaisonement = assaisonement
        self.coeffMultip = coeffMultip
    }
    
    
    // Delegation
   /* func add(delegate: coutDelegate) {
       self.delegates.append(delegate)
       print("add delegate : \(self.delegates.count) delagates now")
    }
    
    func remove(delegate: coutDelegate) {
       self.delegates.removeAll{ $0 === delegate}
    }*/
    
}
