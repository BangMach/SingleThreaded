//
//  MovieNonLinearProblem.swift
//  SingleThreaded
//
//  Created by Rodney Cocker on 07/09/19.
//  Copyright © 2019 RMIT. All rights reserved.
//

import Foundation
/*
 Note: this code does not work it is being used to demonstrate the concept only.
 */
class MovieNonLinearProblem
{
    private var movies:[Movie] = []
    
    init()
    {
        // This must complete before the movie gets created
        print("Performing some tasks ...")
        
        // The call to create begins execution, but the next statement executes before this one completes
        let movie = createMovieNonLinear(title: "The Lion King", actor: "Matthew Broderick")
        
        // The previous statement begins executing, but this statement executes before the movie is created.  This cannot work because the movie we want to append has not yet been created
        movies.append(movie)
    }
    
    func createMovieNonLinear(title:String, actor:String) -> Movie
    {
        // The movie must be created before it can be returned
        let lionKing = Movie(title: title, actor: actor)
        return lionKing
    }
}
