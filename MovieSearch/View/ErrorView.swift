//
//  ErrorView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: MovieSearchViewModel
    
    var body: some View {
        Text("Oops")
            .font(.system(size:80))
        Text(viewModel.errorMessage ?? "")
        Button {
            viewModel.fetchMovies(for: viewModel.searchTerm)
        } label: {
            Text("Try again")
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewModel: MovieSearchViewModel())
    }
}
