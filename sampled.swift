//
//  ViewController.swift
//  Audio-Player
//
//  Created by mitchell hudson on 4/8/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//


// Simple Audio Player with notes

import UIKit
import AVFoundation // Import the AVFoundation

class sampled: UIViewController {
  
  // Formatting time for display
  let timeFormatter = NumberFormatter()
  
  var audioPlayer: AVAudioPlayer?     // holds an audio player instance. This is an optional!
  var audioTimer: Timer?            // holds a timer instance
  var isDraggingTimeSlider = false    // Keep track of when the time slide is being dragged
  
  var isPlaying = false {             // keep track of when the player is playing
    didSet {                        // This is a computed property. Changing the value
      setButtonState()            // invokes the didSet block
      playPauseAudio()
    }
  }
  
  
  
  // MARK: IBOutlets
  
  @IBOutlet var playButton: UIButton!
  @IBOutlet var progressBar: UIProgressView!
  @IBOutlet var timeSlider: UISlider!
  @IBOutlet var volumeSlider: UISlider!
  @IBOutlet var timeLabel: UILabel!
  
  
  // MARK: IBActions
  
  @IBAction func playButtonTapped(sender: UIButton) {
    // Set the didSet block above! Setting this value will play and pause the audio
    
    isPlaying = !isPlaying
  }
  
  // Update time when dragging the slider
  @IBAction func timeSliderChanged(sender: UISlider) {
    // Working on this
    // TODO: Implement Time Slider
    guard let audioPlayer = audioPlayer else {
      return
    }
    
    audioPlayer.currentTime = audioPlayer.duration * Double(sender.value)
  }
  
  // The time slider is tricky since we want it to update while the player is playing
  // but it can't be updated while we dragging it!
  @IBAction func timeSliderTouchDown(sender: UISlider) {
    isDraggingTimeSlider = true
  }
  
  @IBAction func timeSliderTouchUp(sender: UISlider) {
    isDraggingTimeSlider = false
  }
  
  @IBAction func timeSliderTouchUpOutside(sender: UISlider) {
    isDraggingTimeSlider = false
  }
  
  
  
  
  @IBAction func volumeSliderChanged(sender: UISlider) {
    // Use a guard statement here since audioPlayer is optional
    guard let audioPlayer = audioPlayer else {
      return
    }
    // If audioPlayer is not nil set the volume
    audioPlayer.volume = sender.value
  }
  
  
  
  
  func setButtonState() {
    // When the play button is tapped the text changes
    // TODO: Use the enum below for button and player states
    if isPlaying {
      playButton.setTitle("Pause", for: .normal)
    } else {
      playButton.setTitle("Play", for: .normal)
    }
  }
  
  func playPauseAudio() {
    // audioPlayer is optional use guard to check it before using it.
    guard let audioPlayer = audioPlayer else {
      return
    }
    
    // Check is playing then play or pause
    if isPlaying {
      audioPlayer.play()
    } else {
      audioPlayer.pause()
    }
  }
  
  
  
  func queueSound() {
    // Use this methid to load up the sound.
 
    // TODO: Use catch here and check for errors.
    let url = URL(string: "https://d3b0pu5pa31rn8.cloudfront.net/45921/EncodedVideo/uploads/movie_stream/full_movie/592296/PODCAST_HEMANT_KUMAR_2.mp3?Expires=1610073764&Signature=Jp3OhR4as9u3JOI8Eymr9UE16FC3VJUL7rN5w-CHAo2pGgOg2n26nOl~cFsVXgDgTVpR~YyMBIyn2hoLSpCSPR63SlN8N9~nX45WG3WVQmM9T31PN5kRP8wqgoFyeZ6EHTpCtDCNqVIejuKAmAvlj~NavC-gRe4-mtBLb6kKkn7vugToQKbzk13HmlF8mNAq8YIEwV537P2eg3l5rPDEv-689MApPVepmFb7iDDwprxFD3IaVEMYZu5H1ZCdFcf3A2W7Mb78pTT5AMuA98xU4zVO0nqghjoEYD3izcEneMvouHCALMeOvrQ~peZdGnaySXUVWL0T6djg8m9OXVTfgg__&Key-Pair-Id=APKAI7LE5J4L2WM2V57A")!
   
   downloadFileFromURL(url: url)
    
  }
    func downloadFileFromURL(url:URL){

        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
            self?.play(url: URL!)
        })
            
        downloadTask.resume()
        
    }
  func play(url:URL) {
      print("playing \(url)")
      
      do {
        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        audioPlayer?.volume = 1.0
        audioPlayer?.play()
      } catch let error as NSError {
          //self.player = nil
          print(error.localizedDescription)
      } catch {
          print("AVAudioPlayer init failed")
      }
      
  }
  
  func makeTimer() {
    // This function sets up the timer.
    if audioTimer != nil {
      audioTimer!.invalidate()
    }
    
    // audioTimer = Timer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.onTimer(_:)), userInfo: nil, repeats: true)
    
    audioTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer(timer:)), userInfo: nil, repeats: true)
  }
  
  @objc func onTimer(timer: Timer) {
    // Check the audioPlayer, it's optinal remember. Get the current time and duration
    guard let currentTime = audioPlayer?.currentTime, let duration = audioPlayer?.duration else {
      return
    }
    
    // Calculate minutes, seconds, and percent completed
    let mins = currentTime / 60
    // let secs = currentTime % 60
    let secs = currentTime.truncatingRemainder(dividingBy: 60)
    let percentCompleted = currentTime / duration
    
    // Use the number formatter, it might return nil so guard
    //    guard let minsStr = timeFormatter.stringFromNumber(NSNumber(mins)), let secsStr = timeFormatter.stringFromNumber(NSNumber(secs)) else {
    //      return
    //    }
    
    guard let minsStr = timeFormatter.string(from: NSNumber(value: mins)), let secsStr = timeFormatter.string(from: NSNumber(value: secs)) else {
      return
    }
    
    
    // Everything is cool so update the timeLabel and progress bar
    timeLabel.text = "\(minsStr):\(secsStr)"
     
    // Check that we aren't dragging the time slider before updating it
    if !isDraggingTimeSlider {
      timeSlider.value = Float(percentCompleted)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup a number formatter that rounds down and pads with a 0
    timeFormatter.minimumIntegerDigits = 2
    timeFormatter.minimumFractionDigits = 0
    timeFormatter.roundingMode = .down
    
    // Load the sound and set up the timer.
     queueSound()
     makeTimer()
  }
  

    
}



// TODO: Use Enum to manage play state
enum PlayState: String {
  case Play = "Play"
  case Puase = "Pause"
}

