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
    var ingred : ingredVM = ingredVM(from: Ingredient(id: "",nom: "nn", PU: 3, unite: "KG", quantite: 22, allergene: false, typeAllergene: "", categorie: ""))

    @ObservedObject
    var listeIngreds = listeIngredsVM()
    
    @State var showingAlert = false
    
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
                        showingAlert = true
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(50)
                    }.alert("Voulez-vous vraiment supprimer cette fiche ?", isPresented: $showingAlert) {
                                Button("Supprimer") {
                                    fiches.deleteFiche(idFiche: index)
                                }
                                Button("Annuler", role: .cancel) { }
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
                
                HStack {
                    Text("Temps pr??paration : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    Text("\(fiches.listeFichesVM[index].model.tempsTotal) min")
                }
                
                if !fiches.listeFichesVM[index].model.description.isEmpty {
                    Text("Etape de base : ")
                            .fontWeight(.medium)
                            .padding(.vertical,8)
                            .font(.title3)
                    
                    VStack(alignment : .leading) {
                        Text("Ingr??dients de base :").font(.headline).foregroundColor(Color.orange).shadow(color: .black, radius: 2)
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
                
                //Lister les ??tapes de plus
                let tabEtapes = fiches.getFiches(tabetapes: fiches.listeFichesVM[index].model.etape)
                
                if tabEtapes.count != 0 {
                    
                    Divider()
                    
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

                            Text("Ingr??dients :").font(.headline).foregroundColor(Color.orange).shadow(color: .black, radius: 2)
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
                    Text("Ajouter une ??tape")
                }
                
                if (fiches.listeFichesVM[index].model.materielDress != "") {
                    Divider()
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
                        Text("Mat??riel sp??cifique : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                       Text("\(fiches.listeFichesVM[index].model.materielSpes)")
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Co??t de personnel : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                        let c = fiches.listeFichesVM[index].calculCoutPersonnel()
                        Text("\(c,specifier: "%.2f") ???")
                        
                    }
                    
                    HStack {
                        Text("Co??t Fluide : ")
                                .fontWeight(.medium)
                                .padding(.vertical,8)
                                .font(.title3)
                        let y = fiches.listeFichesVM[index].calculCoutFluide()
                        Text("\(y,specifier: "%.2f") ???")
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
