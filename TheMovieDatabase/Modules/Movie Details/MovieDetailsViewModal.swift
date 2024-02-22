//
//  MovieDetailsViewModal.swift
//  TheMovieDatabase
//
//  Created by Koushik Dutta on 18/02/24.
//

import Foundation
import NetworkUtility

enum MovieDetailsSection: Int, CaseIterable {
    case Movie = 0
    case Cast
    case Social
    
    func reuseIdentifier() -> String {
        switch self {
            case .Movie : return MovieDetailsTableViewCell.reuseIdentifier
            case .Cast  : return CastTableViewCell.reuseIdentifier
            case .Social: return SocialTableViewCell.reuseIdentifier
        }
    }
}

protocol MovieDetailsView: AnyObject {
    func reloadTableView()
}

protocol MovieDetailsViewModalProtocol {
    var movie: Movie? { get }
    var cast: [Cast]? { get }
    var latestReview: Review? { get }
    var runtimeText: String? { get }
    var numberOfSections: Int { get }
    var reviewTitle: String? { get }
    var reviewCreatedAtText: String? { get }
    var ratingString: String? { get }
    func getGenreText(fromGenres genres: [Genre]?) -> String?
    func fetchMovieDetails()
    func numberOfRows(inSection section: MovieDetailsSection) -> Int
    
}

class MovieDetailsViewModal: MovieDetailsViewModalProtocol {
    private unowned let view: MovieDetailsView
    let apiService: MovieDetailsInteractor
    let movieId : Int
    var movieDetails: Movie?
    var review: Review?
    
    init(movieId: Int, view: MovieDetailsView, apiService: MovieDetailsInteractor) {
        self.movieId = movieId
        self.view = view
        self.apiService = apiService
    }
    
    var movie: Movie? {
        return movieDetails
    }
    
    var cast: [Cast]? {
        return movieDetails?.credits?.cast
    }
    
    var latestReview: Review? {
        return review
    }
    
    func fetchMovieDetails() {
        apiService.fetchMovieDetails(forMovieWithId: movieId)
    }
    
    var runtimeText: String? {
        guard let runtime = movieDetails?.runtime else { return nil }
        return convertTimeToHoursAndMinutes(from: runtime)
    }
    
    var ratingString: String? {
        guard let ratingValue =  review?.authorDetails.rating else { return nil }
        return String(describing: ratingValue)
    }
    
    var numberOfSections: Int {
        return MovieDetailsSection.allCases.count
    }
    
    func numberOfRows(inSection section: MovieDetailsSection) -> Int {
        switch section {
            case .Movie:
                return 1
            case .Cast:
                return 1
            case .Social:
            return review != nil ? 1 : 0
        }
    }
    
    var reviewTitle: String? {
        guard let authorUsername = review?.authorDetails.username else{ return nil }
        return "A review by \(authorUsername)"
    }
    
    var reviewCreatedAtText: String? {
        guard let createdAt = review?.createdAt.stringDateFormatter(inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", outputFormat: "MMMM dd, yyyy"), let authorUsername = review?.authorDetails.username  else { return nil }
        return "Written by \(authorUsername) on \(createdAt)"
    }
    
    func getGenreText(fromGenres genres: [Genre]?) -> String? {
        guard let genres else { return nil }
        var result: [String] = []
        genres.forEach { genre in
            result.append(genre.name)
        }
        return result.map{String($0)}.joined(separator: ", ")
    }
    
    private func convertTimeToHoursAndMinutes(from minutesValue: Int) -> String {
        let timeMeasure = Measurement(value: Double(minutesValue), unit: UnitDuration.minutes)
        let hours = timeMeasure.converted(to: .hours)
        if hours.value > 1 {
            let minutes = timeMeasure.value.truncatingRemainder(dividingBy: 60)
            return String(format: "%.f%@ %.f%@", hours.value, "h", minutes, "m")
        }
        return String(format: "%.f%@", timeMeasure.value, "m")
     }
    
}

extension MovieDetailsViewModal: MovieDetailsInteractorDelegate {
    func fetchMovieDetailsSuccess(movies: Movie) {
        movieDetails = movies
        review = movies.reviews?.results.first
        view.reloadTableView()
    }
    
    func fetchMovieDetailsFailure(error: NetworkError?) {
        if let error {
            print(error.localizedDescription)
        }
    }
}
