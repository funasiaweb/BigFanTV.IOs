//
//  NewDetailpodcast.swift
//  bigfantv
//
//  Created by Ganesh on 08/01/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import SwiftAudio
import AVFoundation
import MediaPlayer

class NewDetailpodcast: UIViewController {

    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var isScrubbing: Bool = false
    private let controller = AudioController.shared
    private var lastLoadFailed: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

  
       try? controller.player.add(item: DefaultAudioItem(audioUrl: "https://d3b0pu5pa31rn8.cloudfront.net/45921/EncodedVideo/uploads/movie_stream/full_movie/592291/PODCAST_HEMANT_KUMAR_1.mp3?Expires=1610402168&Signature=YC7nUEnNU-oWdSjGI3bROhuYQfjP1swriNlxfXHMPEoJF7jQDgQy~g2AZ~4327JbtQvai4BtO-lBmFbGCKYyUbW32k4VCBI6sj3xJQ2IwfE7WV4PS1hbsdTvpz00Ha~UqsRbDcMaDpN4L3BNzyI0D~XqIVM-plp3~1sf40FK6pt8oFxbK-usvj7sGoCOaAC4~tzP5Lb1el7vfwmReWh3fHyRwJHtGzoh7jIZBjzXVgT8mq3CzrdNxspfejPQ0GPJ8omqCXpEEHOdYroOhg62UXIhDyImAH6uvF0qatsZBKxdAQ3efLuAx4RZ6M~N-jk8L8k53dBPWptDgw0OYg452Q__&Key-Pair-Id=APKAI7LE5J4L2WM2V57A", artist: "", title: "", albumTitle: "", sourceType: .stream,  artwork: nil))
        controller.player.event.stateChange.addListener(self, handleAudioPlayerStateChange)
        controller.player.event.secondElapse.addListener(self, handleAudioPlayerSecondElapsed)
        controller.player.event.seek.addListener(self, handleAudioPlayerDidSeek)
        controller.player.event.updateDuration.addListener(self, handleAudioPlayerUpdateDuration)
        controller.player.event.didRecreateAVPlayer.addListener(self, handleAVPlayerRecreated)
        controller.player.event.fail.addListener(self, handlePlayerFailure)
        updateMetaData()
        handleAudioPlayerStateChange(data: controller.player.playerState)
    }
    @IBAction func togglePlay(_ sender: Any)
    {
        if !controller.audioSessionController.audioSessionIsActive {
            try? controller.audioSessionController.activateSession()
        }
        if lastLoadFailed, let item = controller.player.currentItem {
            lastLoadFailed = false
            
            try? controller.player.load(item: item, playWhenReady: true)
        }
        else {
            controller.player.togglePlaying()
        }
    }
    
    @IBAction func startScrubbing(_ sender: UISlider) {
         isScrubbing = true
     }
     
     @IBAction func scrubbing(_ sender: UISlider) {
         controller.player.seek(to: Double(slider.value))
     }
    @IBAction func scrubbingValueChanged(_ sender: UISlider) {
        let value = Double(slider.value)
        elapsedTimeLabel.text = value.secondsToString()
        remainingTimeLabel.text = (controller.player.duration - value).secondsToString()
    }
    
    func updateTimeValues() {
        self.slider.maximumValue = Float(self.controller.player.duration)
        self.slider.setValue(Float(self.controller.player.currentTime), animated: true)
        self.elapsedTimeLabel.text = self.controller.player.currentTime.secondsToString()
        self.remainingTimeLabel.text = (self.controller.player.duration - self.controller.player.currentTime).secondsToString()
    }
    func setPlayButtonState(forAudioPlayerState state: AudioPlayerState) {
        playButton.setImage(state == .playing ? UIImage(named: "mute") : UIImage(named: "unmutea"), for: .normal)
       // playButton.setTitle(state == .playing ? "Pause" : "Play", for: .normal)
    }
    
    func setErrorMessage(_ message: String) {
        self.loadIndicator.stopAnimating()
        
       
    }
    func updateMetaData() {
        if let item = controller.player.currentItem {
            titleLabel.text = item.getTitle()
            
            item.getArtwork({ (image) in
                
            })
        }
    }
    func handleAudioPlayerStateChange(data: AudioPlayer.StateChangeEventData) {
        print(data)
        DispatchQueue.main.async {
            self.setPlayButtonState(forAudioPlayerState: data)
            switch data {
            case .loading:
                self.loadIndicator.startAnimating()
                self.updateMetaData()
                self.updateTimeValues()
            case .buffering:
                self.loadIndicator.startAnimating()
            case .ready:
                self.loadIndicator.stopAnimating()
                self.updateMetaData()
                self.updateTimeValues()
            case .playing, .paused, .idle:
                self.loadIndicator.stopAnimating()
                self.updateTimeValues()
            }
        }
    }
    
    func handleAudioPlayerSecondElapsed(data: AudioPlayer.SecondElapseEventData) {
        if !isScrubbing {
            DispatchQueue.main.async {
                self.updateTimeValues()
            }
        }
    }
    
    func handleAudioPlayerDidSeek(data: AudioPlayer.SeekEventData) {
        isScrubbing = false
    }
    
    func handleAudioPlayerUpdateDuration(data: AudioPlayer.UpdateDurationEventData) {
        DispatchQueue.main.async {
            self.updateTimeValues()
        }
    }
    
    func handleAVPlayerRecreated() {
        try? controller.audioSessionController.set(category: .playback)
    }
    
    func handlePlayerFailure(data: AudioPlayer.FailEventData) {
        if let error = data as NSError? {
            if error.code == -1009 {
                lastLoadFailed = true
                DispatchQueue.main.async {
                    self.setErrorMessage("Network disconnected. Please try again...")
                }
            }
        }
    }

   

}
extension Double {
    
    private var formatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
    
    func secondsToString() -> String {
        return formatter.string(from: self) ?? ""
    }
    
}
