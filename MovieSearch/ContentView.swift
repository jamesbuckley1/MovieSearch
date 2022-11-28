//
//  ContentView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var searchTerm: String = ""
    @State private var searchButtonSelected: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack() {
            ZStack {
                LinearGradient(colors: [Color.blue, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                VStack {
                    Text("🍿")
                        .font(.system(size: 120))
                    ZStack(alignment: .leading) {
                        if searchTerm.isEmpty {
                            Text("Enter a movie or show")
                                .padding(20)
                        }
                        TextField("", text: $searchTerm)
                            .frame(height: 50)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .disableAutocorrection(true)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                            .accentColor(.primary)
                            .onAppear {
                                searchTerm = ""
                            }
                            .accessibilityIdentifier("SearchTextField")
                    }
                    .padding(20)
                    
                    Button("Search") {
                        if searchTerm.count > 0 {
                            searchButtonSelected = true
                        } else {
                            showAlert = true
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.primary)
                    .cornerRadius(10)
                    .font(.title)
                    .accessibilityIdentifier("SearchButton")
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Textfield cannot be empty"), dismissButton: .default(Text("OK")))
                    }
                }
                .navigationTitle("Search Movies")
                .navigationDestination(isPresented: $searchButtonSelected, destination: {
                    MovieListView(searchTerm: searchTerm)
                })
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
