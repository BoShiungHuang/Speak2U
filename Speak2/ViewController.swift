
import UIKit
import AVFoundation
class ViewController: UIViewController  {
    
    
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var speakwords: UITextField!
    
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var speedSlider: UISlider!
    

    @IBOutlet weak var pitchValueIndicator: UILabel!
    
    @IBOutlet weak var speedValueIdencator: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        pitchValueIndicator.text = String(format: "%.1f", pitchSlider.value)
        speedValueIdencator.text = String(format:"%.1f", speedSlider.value)
        
        
        
    }
    
    
    @IBAction func speak(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: speakwords.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        utterance.rate = speedSlider.value
        utterance.pitchMultiplier = pitchSlider.value
        synthesizer.speak(utterance)
        
    }
    
    @IBAction func sliderAdjust(_ sender: UISlider) {
        let adjustment = AVSpeechUtterance()
        adjustment.pitchMultiplier = pitchSlider.value
        pitchValueIndicator.text = String(format: "%.1f", pitchSlider.value)
        adjustment.rate = speedSlider.value
        speedValueIdencator.text = String(format:"%.1f", speedSlider.value)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    
}
