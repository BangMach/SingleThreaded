//
//  ConcurrencyComparison.swift
//  SingleThreaded
//
//  Created by Rodney Cocker on 07/09/19.
//  Copyright © 2019 RMIT. All rights reserved.
//

import Foundation

class MovieRegular
{
    private var movies:[Movie] = []
    
    init()
    {
        // This must complete before the movie gets created
        print("Performing some tasks ...")
        
        // The call to create movie must complete before the assignment takes place
        // The assignment must take place before the movie can be appended to the array
        let movie = createMovie(title: "The Lion King", actor: "Matthew Broderick")
        
        // Finally the movie is added to the array
        movies.append(movie)
    }
    
    func createMovie(title:String, actor:String) -> Movie
    {
        // The movie must be created before it can be returned
        let lionKing = Movie(title: title, actor: actor)
        return lionKing
    }
}
