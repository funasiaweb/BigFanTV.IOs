//
//  AudioController.swift
//  SwiftAudio_Example
//
//  Created by Jørgen Henrichsen on 25/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftAudio
import AVFoundation

class AudioController {
    
    static let shared = AudioController()
    let player: QueuedAudioPlayer
    let audioSessionController = AudioSessionController.shared
    
    
    init() {
        let controller = RemoteCommandController()
        player = QueuedAudioPlayer(remoteCommandController: controller)
        player.remoteCommands = [
            .stop,
            .play,
            .pause,
            .togglePlayPause,
            .next,
            .previous,
            .changePlaybackPosition
        ]
        try? audioSessionController.set(category: .playback)
       // try? player.add(items: sources , playWhenReady: false)
    }
    
}
