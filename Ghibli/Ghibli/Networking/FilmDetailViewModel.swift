//
//  FilmDetailViewModel.swift
//  Ghibli
//
//  Created by Hai Ng. on 25/3/26.
//

import Foundation
import Observation

class FilmDetailViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle

    let service: GhibliService

    init(service: GhibliService = DefGhibliService()) {
        self.service = service
    }

    func fetch(for film: Film) async {
        
        guard state != .loading else { return }
        
        state = .loading
        
        var loadedPeople: [Person] = []

        do {
            /// `withThrowingTaskGroup` — phiên bản có thể throw error (dùng khi fetch API có thể fail)
            /// `of: Person.self` — khai báo kiểu dữ liệu mỗi task sẽ trả về
            /// `group` — đối tượng để thêm và thu thập các task
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    /// `group.addTask {}` — tạo một task con chạy ngay lập tức và song song với các task khác
                    /// Swift tự quản lý số lượng task chạy đồng thời — không cần lo về thread management
                    group.addTask {
                        try await self.service.fetchPeople(from: personInfoURL)
                    }
                }
                
                /// Collect resoults as they complete
                /// `for try await person in group` — chờ và collect kết quả từng task khi chúng hoàn thành
                
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .loaded(loadedPeople)
            
            /// NOTE: Thứ tự collect không đảm bảo bằng thứ tự thêm vào — nếu cần giữ thứ tự phải dùng index
            /// Example:
            /* withThrowingTaskGroup(of: (Int, Person).self) { group in
             for (index, url) in film.people.enumerated() {
             group.addTask {
             let person = try await service.fetchPeople(from: url)
             return (index, person)  // trả về cả index
             }
             }

             var result: [(Int, Person)] = []
             for try await pair in group {
             result.append(pair)
             }
             return result.sorted { $0.0 < $1.0 }.map { $0.1 }  // sort lại theo index
             } */
            
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}

import Playgrounds

#Playground {
    let service = MockGhiBliService()
    let vm = FilmDetailViewModel(service: service)
    let film = service.fetchFilm()
    
    await vm.fetch(for: film)
    
    switch vm.state {
        case .loading:
            print("Loading...")
        case .idle:
            print("Idle")
        case .loaded(let people):
            for person in people {
                print(person)
            }
        case .error:
            fatalError("Should not happen")
    }
}
