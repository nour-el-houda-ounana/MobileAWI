//
//  modifIngredView.swift
//  Mobile
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct modifIngredView: View {
    
    @ObservedObject
    var ingreds = listeIngredsVM()
    
    var index : Int = 0
    
    
    @State
    var nom : String = "";
    
    
    @Environment(\.dismiss) var dismiss
    
    let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
       formatter.numberStyle = .decimal
       return formatter
     }()
    
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Nom ingrédient")) {
                        //Text("\(ingreds.liste[index].name)")
                        TextField("nom", text: $nom)
                            .onSubmit {
                                ingreds.liste[index].name = nom
                                
                            }
                    }
                    
                    Section(header: Text("type allergene")) {
                        /*Picker("Catégories", selection: $typeAllergene){
                            ForEach(catIngre.listCatIngred) { category in
                                Text("\(category.type.description)")
                            }
                        }
                        .pickerStyle(.menu)*/
                    }
                                      
                    
                    Section(header: Text("Prix unitaire")) {
                        Text("");
                        
                    }
                    
                    Section(header: Text("Quantité")) {
                        Text("Quantité ajoutée")
                    }
                    
                    Section(header: Text("unité")) {
                        Text("\(ingreds.liste[index].unite)")
                    }
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Annuler", systemImage: "xmark")
                        .labelStyle(.iconOnly)
                }
            }
            
        }
        .padding()
        .navigationTitle("Modification")
        
    }
}

struct modifIngredView_Previews: PreviewProvider {
    static var previews: some View {
        modifIngredView()
    }
}
