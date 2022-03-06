//
//  detailFicheView.swift
//  Mobile
//
//  Created by m1 on 18/02/2022.
//

import SwiftUI

struct detailFicheView: View {
        
    @ObservedObject
    var fiches : listeFichesVM
    
    var index : Int
    
    @ObservedObject
    var ingred : ingredVM = ingredVM(from: Ingredient(nom: "nn", PU: 3, unite: "KG", quantite: 22, allergene: false, typeAllergene: "", categorie: ""))

    @ObservedObject
    var listeIngreds = listeIngredsVM()
    
    var body: some View {
        ScrollView {
            Image("pic")
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(height: 70)
                 .background(LinearGradient(gradient:  Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                        
            Text(fiches.listeFichesVM[index].model.intitule)
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(.black)

            Spacer().frame(height: 25)
            
            VStack(alignment: .trailing) {
                HStack {
                    NavigationLink(destination: UpdateFicheView(liste: fiches, index: index)) {
                        Image(systemName: "pencil.circle.fill")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(50)
                    }
                    
                    Spacer().frame(width: 50)
                    
                    Button {
                            //imprimer
                        
                    } label: {
                        Image(systemName: "printer.filled.and.paper")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(50)
                    }
                    Spacer().frame(width: 50)

                    Button {
                            //supprimer
                        fiches.deleteFiche(idFiche: index)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(50)
                    }
                }
            }
                        
            VStack (alignment: .leading){
                HStack {
                    HStack {
                        Text("Responsable : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                        Text(fiches.listeFichesVM[index].model.responsable)
                    }
                    Spacer().frame(width : 25)
                    Text("Couverts : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    Text("\(fiches.listeFichesVM[index].model.couverts)")
                    
                }
                
                if !fiches.listeFichesVM[index].model.description.isEmpty {
                    Text("Etape de base : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    
                    VStack(alignment : .leading) {
                        ZStack (alignment: .trailing){
                            Text("\(fiches.listeFichesVM[index].model.tempsTotal) min").padding().background(
                                Circle()
                                    .stroke(Color.orange, lineWidth: 3)
                            ).frame(width: 100, height: 100, alignment: .center)
                        }
                        .frame(width: 40, height: 40)
                        
                        Text("Ingrédients de base :").font(.headline).foregroundColor(Color.orange).shadow(color: .black, radius: 2)
                        ForEach(fiches.listeFichesVM[index].model.ingredients, id : \.self) { ing in
                            HStack {
                                Text(ing)
                                let x = listeIngreds.getUnite(nomIngred: ing)
                                Text("            0 \(x)")
                                
                            }
                            
                        }
                        Spacer().frame(height: 20)
                        Text("Description :").font(.headline).foregroundColor(Color.orange).shadow(color: .black, radius: 2)
                        Text("\(fiches.listeFichesVM[index].model.description)")
                    }
                    .padding(12)
                    .frame(width : UIScreen.main.bounds.width-15)
                    .background(.gray)
                    .cornerRadius(20)
                }
                
                //Lister les étapes de plus
                let tabEtapes = fiches.getFiches(tabetapes: fiches.listeFichesVM[index].model.etape)
                
                if tabEtapes.count != 0 {
                    Text("Autres Etapes : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    
                    ForEach(Array(tabEtapes.enumerated()), id: \.element.model.id) { index, item in
                        VStack(alignment : .leading) {
                            HStack {
                                
                                ZStack (alignment: .trailing){
                                    HStack {
                                        Text("\(item.model.tempsTotal) min").padding().background(
                                            Circle()
                                                .stroke(Color.orange, lineWidth: 3)
                                        ).frame(width: 100, height: 100, alignment: .center)
                                        
                                    }
                                }
                                .frame(width: 40, height: 40)
                                Spacer().frame(width: 10)
                                Text("\(item.intitule)").bold().italic()
                            }

                            Text("Ingrédients :").font(.headline).foregroundColor(Color.orange).shadow(color: .black, radius: 2)
                            ForEach(item.model.ingredients, id : \.self) { ing in
                                HStack {
                                    Text(ing)
                                    let x = listeIngreds.getUnite(nomIngred: ing)
                                    Text("            0 \(x)")
                                }
                            }
                            Spacer().frame(height: 20)
                            Text("Description :").font(.headline).foregroundColor(Color.orange).shadow(color: .black, radius: 2)
                            Text("\(item.model.description)")
                        }
                        .padding(12)
                        .frame(width : UIScreen.main.bounds.width-15)
                        .background(.gray)
                        .cornerRadius(20)
                        
                        
                    }

                    
                }

                
                Spacer().frame(height : 30)
                NavigationLink(destination: EtapeCreationView(fiches: fiches, index: index)) {
                    Text("Ajouter une étape")
                }
                
                if (fiches.listeFichesVM[index].model.materielDress != "") {
                    HStack {
                        Text("Materiel de dressage : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                        Text(fiches.listeFichesVM[index].model.materielDress)
                    }
                }
                
                if (fiches.listeFichesVM[index].model.materielSpes != "") {
                   HStack {
                        Text("Matériel spécifique : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                       Text("\(fiches.listeFichesVM[index].model.materielSpes)")
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .top)


    }
}


struct detailFicheView_Previews: PreviewProvider {
    static var previews: some View {
        let liste = listeFichesVM()
        detailFicheView(fiches: liste, index: 0);
    }
}
