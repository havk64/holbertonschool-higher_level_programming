//
//  TechCompaniesHelper.swift
//  SiliconValleyCompanies
//
//  Created by Alexandro on 5/29/16.
//  Copyright © 2016 Holberton School. All rights reserved.
//

import Foundation

class TechCompaniesHelper {
    static var companies: [String] = ["Holberton", "Linkedin", "Docker", "Google", "Yahoo", "Apple"]
    static func getTechCompanies() -> [String] {
        return companies
    }
}