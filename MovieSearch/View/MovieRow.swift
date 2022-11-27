//
//  MovieRow.swift
//  MovieSearch
//
//  Created by James Buckley on 27/11/2022.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.poster)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(5)
            

                
            
            Text(movie.title)
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: Movie(id: "0", title: "Test Movie", poster: "", year: "2000"))
    }
}
