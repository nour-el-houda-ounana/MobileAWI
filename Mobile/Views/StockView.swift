//
//  StockView.swift
//  Mobile
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI

struct StockView: View {
    
    @ObservedObject
    var ingreds = listeIngredsVM()

    @State
    private var showAddIngred = false
    
    @State
    private var update = false
    
    @State
    var chercher = ""
    
    
   let NbrFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    
    var body: some View {
        ScrollView {
           Image("stock")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .background(LinearGradient(gradient:  Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                .overlay(alignment: .center) {
                    Text("Stock").bold()
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                        .padding()
                }
                .overlay(alignment: .bottom) {
                    Button(action: {
                        showAddIngred = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Ajouter un ingrédient")
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            
            Spacer().frame(height: 10)

            VStack(alignment : .leading){
                HStack {
                    Text("Search")
                    TextField("Search bar", text: $chercher)
                }
                
            }
            Spacer().frame(height: 10)
            
            ForEach(Array(ingreds.liste.enumerated()), id: \.element.model.id){ index, item in
                VStack {
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading){
                            HStack {
                                    Button {
                                        //déclencher modification
                                        update = true
                                            
                                    } label: {
                                        Image(systemName: "pencil")
                                            .padding(10)
                                            .foregroundColor(.white)
                                            .background(.black)
                                            .cornerRadius(50)
                                    }
                                    Button {
                                        ingreds.delete(igVm :item)
                                    } label: {
                                        Image(systemName: "x.circle.fill")
                                            .padding(10)
                                            .foregroundColor(.white)
                                            .background(.black)
                                            .cornerRadius(50)
                                    }
                                Spacer().frame(width : 20)
                                Text("\(item.model.categorie)").bold()
                                    
                            }
                            VStack(alignment : .leading) {
                                Text("\(item.model.nom)").font(.title)
                                Spacer().frame(width:10)
                                Text("Quantité : \(item.model.quantite) \(item.model.unite)")
                                Text("PU : \(item.model.PU) euros")
                                if(item.model.allergene.description == "true"){
                                    Text("Allergene : \(item.model.allergene.description)")
                                    Text("Type Allergene : \(item.model.typeAllergene)")
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 125))
                            
                            }
                            Spacer()

                        }
                        .padding(12)
                        .frame(width : UIScreen.main.bounds.width-15)
                        .background(.gray)
                        .cornerRadius(20)
                    }
                    .sheet(isPresented: $update) {
                        modifIngredView(ingreds: ingreds, index: index)
                    }
            }
            .onAppear() {
                self.ingreds.getIngreds()
            }
            
        }
        .ignoresSafeArea(.container, edges: .top)
        .sheet(isPresented: $showAddIngred) {
          AjoutIngredView()
        }

    }
    
    
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
