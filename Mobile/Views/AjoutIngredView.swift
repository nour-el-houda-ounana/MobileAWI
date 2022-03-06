//
//  AjoutIngredView.swift
//  Mobile
//
//  Created by m1 on 20/02/2022.
//

import SwiftUI

struct AjoutIngredView: View {
    
    @ObservedObject
    var listIngred = listeIngredsVM()
    
    @ObservedObject
    var ingVM = ingredVM(from: Ingredient(id: "", nom: "", PU: 2, unite: "", quantite: 3, allergene: false, typeAllergene: "", categorie: ""))
    
    @State
    var catIngre = IngredCatVM()
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    @State var ingredient : String = ""
    @State var prixUnitaire : Int = 0
    @State var unite : String = Unite.g.rawValue
    @State var quantite : Double = 0
    @State var isAllergene : Bool = false
    @State var typeAllergene : String = ""
    @State var categorie : String = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Catégorie de l'ingrédient")) {
                    Picker("Catégories", selection: $categorie){
                        Text("Épicerie").tag(catIngredVM.Epicerie.rawValue)
                        Text("Poisson - Crustacés").tag(catIngredVM.Poisson.rawValue)
                        Text("Crémerie").tag(catIngredVM.Cremerie.rawValue)
                        Text("Viandes - Volailles").tag(catIngredVM.viande.rawValue)
                        Text("Fruits - Légumes").tag(catIngredVM.FruitLegume.rawValue)
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Nom ingrédient")) {
                    TextField("Nom de l'ingrédient", text: $ingredient)
                }
                
                Section(header: Text("Prix unitaire")) {
                    TextField("Prix de l'ingrédient",value: $prixUnitaire, formatter: formatter).textFieldStyle(RoundedBorderTextFieldStyle());
                }
                
                Section(header: Text("Quantité")) {
                    TextField("Quantité ajoutée", value: $quantite, formatter: formatter).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("unité")) {
                    Picker("Unité", selection: $unite){
                        Text("g").tag(Unite.g.rawValue)
                        Text("L").tag(Unite.L.rawValue)
                        Text("Kg").tag(Unite.Kg.rawValue)
                        Text("U").tag(Unite.U.rawValue)
                        Text("Botte").tag(Unite.botte.rawValue)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Allergene")) {
                    Toggle(isOn: $isAllergene) {
                        Text(" ")
                    }
                }
                
                if isAllergene {
                    Section(header: Text("type allergene")) {
                        Picker("Catégories", selection: $typeAllergene){
                            Text("Crustacés").tag(catAllergene.Crustasés.rawValue)
                            Text("Arachide").tag(catAllergene.Arachide.rawValue)
                            Text("Céleri").tag(catAllergene.Céleri.rawValue)
                            Text("Lait").tag(catAllergene.Lait.rawValue)
                            Text("Lupin").tag(catAllergene.Lupin.rawValue)
                        }
                        .pickerStyle(.menu)
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
                ToolbarItem {
                    Button {
                        ingVM.add(nom: ingredient, PU: Double(prixUnitaire), unite: unite.description, quantite: quantite, allergene: isAllergene, typeAllergene: typeAllergene, categorie: categorie)
                        
                        dismiss()
                        
                    } label: {
                        Label("Valider", systemImage: "checkmark")
                            .labelStyle(.iconOnly)
                    }
                    .disabled(ingredient.isEmpty)
                }
            }
            .navigationTitle("Ajouter au stock")
            .padding()
        }
    }
     
}


struct AjoutIngredView_Previews: PreviewProvider {
    static var previews: some View {
        AjoutIngredView()
    }
}
