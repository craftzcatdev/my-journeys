//
//  FilmImageView.swift
//  Ghibli
//
//  Created by Hai Ng. on 6/4/26.
//

import SwiftUI

struct FilmImageView: View {
    
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL?){
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) {phase in
            switch phase {
                case .empty:
                    Color(white: 0.8)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
            }
        }
    }
}

#Preview("poster image") {
    
    
    FilmImageView(url: URL.convertAssetImage(named: "posterImage"))
        .frame(height: 200)
}

#Preview("banner image") {
    
    FilmImageView(url: URL.convertAssetImage(named: "bannerImage"))
        .frame(height: 300)
}

/// TODO: decide where this shoud live
/// check: https://gist.github.com/fahied/d4a99e12914eb3edb074663828240907
class AssetExtractor {
    /// Retrieves (or creates should it be necessary) a temporary image's local URL on cache directory for testing purposes
    /// - Parameter name: image name retrieved from asset catalog
    /// - Parameter imageExtension: Image type. Defaults to `.jpg` kind
    /// - Returns: Resulting URL for named image
    func createLocalUrl(forImageNamed name: String, imageExtension: String = "jpg") -> URL? {
        let fileManager = FileManager.default

        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            print("Unable to access cache directory")
            return nil
        }

        let url = cacheDirectory.appendingPathComponent(
            "\(name).\(imageExtension)"
        )

        // If file doesn't exist, creates it
        guard fileManager.fileExists(atPath: url.path) else {
            // Bundle(for: Self.self) is used here instead of .main in order to work on test target as well
            guard let image = UIImage(
                named: name,
                in: Bundle(for: Self.self),
                with: nil
            ),
                  let data = image.jpegData(compressionQuality: 1) else {
                print("Impossible to convert to jpg data")
                return nil
            }

            fileManager
                .createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }

        return url
    }
}
