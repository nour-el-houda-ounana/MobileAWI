//
//  modifIngredView.swift
//  Mobile
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct UpdateIngredView: View {
    
    @ObservedObject
    var ingreds : listeIngredsVM
    
    var index : Int
    
   /* @ObservedObject
    var ingVm : ingredVM*/
    
    @State
    var nom : String = ""
    
    
    let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
       formatter.numberStyle = .decimal
       return formatter
     }()
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Nom ingrédient")) {
                        TextField("nom", text: $ingreds.liste[index].name)
                        //TextField("nom", text: $ingVm.name)
                            /*.onSubmit {
                                ingreds.liste[index].name = nom
                            }*/
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
                        //TextField("Prix Unitaire", value: $ingVm.PU, formatter :formatter)
                    }
                    
                    Section(header: Text("Quantité")) {
                        //TextField("Quantité ajoutée", value: $ingreds.liste[index].quantite, formatter: formatter)
                    }
                    
                    Section(header: Text("unité")) {
                        //Text("\(ingVm.unite)")
                    }
                }
        }
        /*.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Annuler", systemImage: "xmark")
                        .labelStyle(.iconOnly)
                }
            }
            
        }*/
        .padding()
        .navigationTitle("Modification")
        
    }
}

struct modifIngredView_Previews: PreviewProvider {
    static var previews: some View {
       //let liste = listeIngredsVM()
        //modifIngredView(ingreds: liste, index: 0)
        Text("")
    }
}
