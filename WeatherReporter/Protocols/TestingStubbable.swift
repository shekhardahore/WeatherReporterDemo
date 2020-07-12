//
//  TestingStubbable.swift
//  WeatherReporter
//
//  Created by Shekhar Dahore on 12/07/20.
//  Copyright © 2020 Shekkhar. All rights reserved.
//

import Foundation

//Allows to retrieve testing stubs easily
protocol TestingStubbable {
    func getTestingStubFor(file: String) -> Data
}

extension TestingStubbable {
    
    func getTestingStubFor(file: String) -> Data {
        let path = Bundle.main.path(forResource: file, ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            return Data()
        }
        return data
    }
    
    func getWeatherModelFrom(file: String) -> Weather? {
        let contactsData = getTestingStubFor(file: file)
        let decoder = JSONDecoder()
        guard let weather = try? decoder.decode(Weather.self, from: contactsData) else {
            return nil
        }
        return weather
    }
}
