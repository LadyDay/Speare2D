//
//  Extensions.swift
//  tcc_kelle
//
//  Created by Dayane Kelly Rodrigues da Silva on 21/11/15.
//  Copyright © 2015 LadyDay. All rights reserved.
//

import Foundation

extension Dictionary {
    static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>? {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
            do {
                let data = try NSData(contentsOfFile: path, options: NSDataReadingOptions())
                    do {
                        let dictionary: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data,
                        options: NSJSONReadingOptions())
                        if let dictionary = dictionary as? Dictionary<String, AnyObject> {
                            return dictionary
                        } else {
                            print("Level file '\(filename)' is not valid JSON")
                            return nil
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        return nil
                    }
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("Could not find level file: \(filename)")
            return nil
        }
    }
    
    static func writeInfoJSONToBundle(filename: String, string: String, object: AnyObject){
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
            do {
                let currentData = try! NSData(contentsOfFile: path, options: NSDataReadingOptions())
                do {
                    let dictionaryRead: AnyObject? = try! NSJSONSerialization.JSONObjectWithData(currentData,
                        options: NSJSONReadingOptions())
                    if let dictionaryRead = dictionaryRead as? Dictionary<String, AnyObject> {
                        do {
                            let data = try! NSJSONSerialization.dataWithJSONObject(Dictionary<String, AnyObject>.init(dictionaryLiteral: (string, object)), options: NSJSONWritingOptions())

                            if dictionaryRead[string] != nil{
                                do {
                                    try! data.writeToFile(path, options: NSDataWritingOptions.DataWritingWithoutOverwriting)
                                }
                            }else{
                                do {
                                    try! data.writeToFile(path, options: NSDataWritingOptions.DataWritingAtomic)
                                }
                            }
                        }
                    } else {
                        print("Level file '\(filename)' is not valid JSON")
                    }
                }
            }
        }
    }
    
}
