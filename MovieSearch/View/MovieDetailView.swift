//
//  MovieDetailView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: MovieDetailViewModel
    
    let imageSize: CGFloat = 250
    
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
       
    }
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.movie.poster)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: imageSize, height: imageSize)
            .cornerRadius(5)
            Text(viewModel.movie.title)
                .font(.title)
                .multilineTextAlignment(.center)
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if let movieDetail = viewModel.movieDetail {
                        List {
                            Section(header: Text("Released")) {
                                Text(movieDetail.released)
                            }
                            Section(header: Text("Runtime")) {
                                Text(movieDetail.runtime)
                            }
                            Section(header: Text("Plot")) {
                                Text(movieDetail.plot)
                            }
                            Section(header: Text("Cast")) {
                                Text(movieDetail.actors)
                            }
                            Section(header: Text("IMDB Score")) {
                                Text(movieDetail.imdbRating)
                            }
                        }
                        
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK"), action: { dismiss() }))
                            }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(id: "0", title: "Test Movie", poster: "", year: "2000"))
    }
}

