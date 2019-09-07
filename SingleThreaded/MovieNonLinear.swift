//
//  MovieNonLinear.swift
//  SingleThreaded
//
//  Created by Rodney Cocker on 07/09/19.
//  Copyright © 2019 RMIT. All rights reserved.
//

import Foundation
/*
 Note: this code does not work it is being used to demonstrate the concept only.
 */
class MovieNonLinear
{
    private var movies:[Movie] = []
    private var movie:Movie?
    
    init()
    {
        
//        print("List your favourite cartoons")
//        var first:String = "Hello"
        let time = DispatchTime.now() + .seconds(5)
//        DispatchQueue.main.asyncAfter(deadline: time)
//        {
//            first = "Alladin"
//            print("Alladin")
//        }
//        
//        print("The Lion King")
//        print("First: \(first)")

        
        // This must complete before the movie gets created
        print("Performing some tasks before creating movie ...")
        
        DispatchQueue.main.asyncAfter(deadline: time)
        {
            self.createMovieNonLinear(title: "The Lion King", actor: "Mathew Broderrick")
        }
        // The call to create begins execution, but the next statement executes before this one completes
        
        // The previous statement begins executing, but this statement executes before the movie is created.  This cannot work because the movie we want to append has not yet been created
        // This must complete before the movie gets created
        print("User continues using the app ...")
    }
    
    
    func createMovieNonLinear(title:String, actor:String)
    {
        print("Long running Task/operations")
        let newMovie = Movie(title: title, actor: actor)
        
        appendMovie(movie: newMovie)
    }
    
    func appendMovie(movie:Movie){
        movies.append(movie)
        print("Movie appended - \(movie.title)")
    }
}
