//
//  ContentView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = MovieSearchViewModel()
    
    //@State var showAlert = false
    
    var body: some View {
        NavigationStack() {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                else {
                    TextField("Search", text: $viewModel.searchTerm)
                        .frame(height: 50)
                        .border(.selection, width: 1)
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                        .padding()

                    Button("Search", action: {
                        viewModel.fetchMovies(for: viewModel.searchTerm)
                       
                    })
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                                        }
                    
   

                }
                
                
                

            }
            
            .navigationTitle("Search Movies")
            .navigationDestination(isPresented: $viewModel.searchSuccessful, destination: {
                MovieListView(movies: viewModel.movies)
            })
            
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
