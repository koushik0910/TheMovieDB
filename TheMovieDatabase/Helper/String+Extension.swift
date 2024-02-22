//
//  DateFormatter.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 21/02/24.
//

import Foundation

extension String {
    func stringDateFormatter(inputFormat: String, outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        let date = inputFormatter.date(from: self)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        guard let date else { return nil }
        return outputFormatter.string(from: date)
    }
}

