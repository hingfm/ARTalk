//
//  ViewController.swift
//  ARTalk
//
//  Created by Hing Chung on 18/1/2024.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController {
    private var _engine: Engine?
    private var _model: Whisper?
    private var _audioCapture: AudioCaptureController?
    private let _chatGPT = ChatGPT()

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var textView: UITextView!
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        guard let audioCapture = _audioCapture else {
            return
    }
        if audioCapture.captureInProgress {
            // Stop existing capture-in-progress
            self.recordButton.isHidden = true
            audioCapture.stopCapture { (modelAudioInputBuffer: AVAudioPCMBuffer?) in
                if let modelAudioInputBuffer = modelAudioInputBuffer {
                    // Run model on audio queue
                    audioCapture.queue.async {
                        if let segments = self._model?.infer(buffer: modelAudioInputBuffer) {
                            let completeText = segments.joined(separator: " ")
                            print("[ViewController] Transcription: \(completeText)")

                            // Update UI on main thread
                            DispatchQueue.main.async {
                                // Update text view with captured spoken text and make it flow from bottom to top
                                self.textView.text = completeText
                                var inset = UIEdgeInsets.zero
                                inset.top = self.textView.bounds.size.height - self.textView.contentSize.height
                                self.textView.contentInset = inset

                                // Toggle record button state
                                self.recordButton.setTitle("Record", for: .normal)
                                self.recordButton.setTitleColor(UIColor.systemBlue, for: .normal)
                                self.recordButton.tintColor = UIColor.systemBlue
                                self.recordButton.isHidden = false

                                // Send user's command to ChatGPT
                                self._chatGPT.send(command: completeText, completion: self.onCodeReceived)
                            }
                        }
                    }
                }
            }
        } else {
            // Start a new capture
            self.recordButton.isHidden = true
            _audioCapture?.startCapture() {
                // Toggle record button state
                self.recordButton.setTitle("Stop", for: .normal)
                self.recordButton.setTitleColor(UIColor.systemRed, for: .normal)
                self.recordButton.tintColor = UIColor.systemRed
                self.recordButton.isHidden = false
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _engine = Engine(sceneView: sceneView)

        // Initialize Whisper model
        guard let modelPath = Bundle.main.path(forResource: "ggml-base.en", ofType: "bin") else {
            fatalError("Model path invalid")
        }
        _model = Whisper(modelPath: modelPath)

        // Set up audio capture
        _audioCapture = AudioCaptureController(outputFormat: _model!.format)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Start AR experience
        _engine?.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _engine?.pause()
    }

    private func onCodeReceived(_ code: String) {
        // Run the code received from ChatGPT
        _engine?.runCode(code: code)
    }
}

