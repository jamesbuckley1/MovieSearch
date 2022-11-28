//
//  MovieListView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct MovieListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: MovieListViewModel
    
    init(searchTerm: String) {
        _viewModel = StateObject(wrappedValue: MovieListViewModel(searchTerm: searchTerm))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailView(movie: movie)
                } label: {
                    MovieRow(movie: movie)
                }
            }
            ProgressView()
                .frame(height: 50)
                .onAppear {
                    viewModel.fetchMore()
                }
        }
        .navigationTitle("Results")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK"), action: { dismiss() }))
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(searchTerm: "Star Wars")
    }
}
