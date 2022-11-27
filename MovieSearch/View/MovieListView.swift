//
//  MovieListView.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct MovieListView: View {
    let movies: [Movie]
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                
                NavigationLink {
                    MovieDetailView(movie: movie)
                } label: {
                    MovieRow(movie: movie)
                }
                
                
            }
        }
        .navigationTitle("Results")
        
    }
}

//struct MovieListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListView(movies: [Movie(title: "Test Movie Title")])
//    }
//}
