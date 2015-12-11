//
//  User.swift
//  AutoLayout
//
//  Created by Bozidar on 11.12.2015..
//  Copyright © 2015. Bozidar. All rights reserved.
//

import Foundation

//Model class
struct User
{
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        //get user model with entered username
        if let user = database[login] {
            //compare password of this user with entered password
            if user.password == password {
                //if username and password are correct return user model, else return nil (because of that return value of func is optional String)
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "John Appleseed", company: "Apple", login: "japple", password: "foo"),
            User(name: "Madison Bumgarner", company: "World Champion San Francisco Giants", login: "madbum", password: "foo"),
            User(name: "John Hennessy", company: "Stanford", login: "hennessy", password: "foo"),
            User(name: "Bad Guy", company: "Criminals, Inc.", login: "baddie", password: "foo")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
        }()
}