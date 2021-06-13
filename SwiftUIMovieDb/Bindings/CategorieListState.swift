//
//  CategorieListState.swift
//  SwiftUIMovieDb
//
//  Created by  on 13/06/2021.
//  Copyright © 2021 Alfian Losari. All rights reserved.
//

import SwiftUI

class CategorieListState: ObservableObject {
    
    @Published var categories: [MovieGenre]?
    @Published var error: NSError?

    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadCategories(with endpoint: CategorieListEndpoint) {
        self.categories = nil
        
        self.movieService.fetchCategories(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.categories = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}


