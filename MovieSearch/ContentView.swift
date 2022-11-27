//
//  ContentView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = MovieSearchViewModel()
    

    
    var body: some View {
        NavigationStack() {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.errorMessage != nil {
                    //ErrorView(viewModel: viewModel)
                    
                }
                else {
                    TextField("Search", text: $viewModel.searchTerm)
                        .border(.selection, width: 1)
                        .disableAutocorrection(true)

                    
                    Button("Search", action: {
                        viewModel.fetchMovies(for: viewModel.searchTerm)
                       
                    })

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
