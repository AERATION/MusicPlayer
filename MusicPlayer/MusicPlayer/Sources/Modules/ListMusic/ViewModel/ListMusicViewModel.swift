
import Foundation

protocol ListMusicVMProtocol {
    func loadListMusics()
    func getListMusicsCount() -> Int
    func getTracks() -> [Track]
}

final class ListMusicViewModel: ListMusicVMProtocol {
    
    //MARK: Functions
    func loadListMusics() {
        MusicService.shared.loadMusic()
    }
    
    func getListMusicsCount() -> Int {
        MusicService.shared.newTracks.count
    }
    
    func getTracks() -> [Track] {
        MusicService.shared.newTracks
    }
}
