//
//  SuggestViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 15/03/2019.
//  Copyright © 2019 Vasily Evreinov. All rights reserved.
//

import UIKit

class SuggestViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var questionField: UITextView!
    @IBOutlet weak var answerFields: UIView!
    @IBOutlet weak var submitButton: RoundedButton!
    
    // MARK: - Properties
    var fields: [UITextField] = []
    
    // MARK: - Button taps
    
    @IBAction func submitButtonTap(_ sender: Any) {
        
        let question = questionField.text ?? ""
        var answers: [String] = []
        
        var notEmpty = 0
        
        for i in 0...fields.count-1 {
            let a = fields[i].text ?? ""
            if(a != "") {
                notEmpty = notEmpty+1
                answers.append(a)
            }
        }
        
        if(question != "" && notEmpty == fields.count) {
            submitButton.isEnabled = false
            swithNavButton("loading")
            API.suggest(question, answers, suggestSuccess, failure)
        }
        
    }
    
    func suggestSuccess(_ data: NSDictionary)
    {
        submitButton.isEnabled = true
        swithNavButton("done")
        let alert = UIAlertController(title: NSLocalizedString("suggest_trivia", comment: ""), message: NSLocalizedString("suggest_trivia_confirm", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: {(alert: UIAlertAction!) in
        }))
        self.present(alert, animated: true)
        
        // empty fields
        questionField.text = NSLocalizedString("question", comment: "")
        questionField.textColor = UIColor.lightGray
        for i in 0...fields.count-1 {
            fields[i].text = ""
        }
    }
    
    override func failure(_ status: Int, _ errors: [String]) {
        submitButton.isEnabled = true
        swithNavButton("done")
        super.failure(status, errors)
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        // translations
        submitButton.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
        self.title = NSLocalizedString("suggest_trivia", comment: "")
        
        // question field
        questionField.text = NSLocalizedString("question", comment: "")
        questionField.textColor = UIColor.lightGray
        questionField.layer.cornerRadius = 25.0
        questionField.layer.borderWidth = 1.0
        questionField.layer.borderColor = UIColor(cfgName: "colors.system.text").withAlphaComponent(0.3).cgColor
        questionField.delegate = self
        
        // submit button
        submitButton.layer.cornerRadius = submitButton.frame.size.height / 2
        submitButton.backgroundColor = UIColor(cfgName: "colors.system.button.background")
        submitButton.setTitleColor(UIColor(cfgName: "colors.system.button.text"), for: .normal)
        
        // build answers
        let answers: Int = Int(Config.shared.data["settings.answers"]!)!
        
        let space = CGFloat(16.0)
        let height = CGFloat(50.0)
        
        let width = self.answerFields.frame.width
        for i in 0...answers-1 {
            
            let view = PaddingTextField()
            view.frame = CGRect(x: 0, y: CGFloat(i)*(height + space), width: width, height: height)
            view.layer.cornerRadius = height / 2
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor(cfgName: "colors.system.text").withAlphaComponent(0.3).cgColor
            view.font = UIFont.systemFont(ofSize: 25)
            
            if(i > 0) {
            let format = NSLocalizedString("answer", comment: "")
                view.placeholder = String(format: format, i + 1)
            } else {
                view.placeholder = NSLocalizedString("correct_answer", comment: "")
            }
            
            self.answerFields.addSubview(view)
            fields.append(view)
        }
        
        let tf = UITextField()
        tf.frame = CGRect(x:20,y:CGFloat(4)*(height + space),width: width, height: height)
        self.answerFields.addSubview(tf)
        
        // add "close on tap" functionality
        let closeTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(closeTap)
        
        // show cancel button
        swithNavButton("done")
    }
    
    @objc func dismissKeyboard() {
        if(questionField.isFirstResponder) {
            view.endEditing(true)
            return
        }
        for i in 0...fields.count-1 {
            if(fields[i].isFirstResponder) {
                view.endEditing(true)
                return
            }
        }
    }
    
    @objc func closePopup()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func swithNavButton(_ to: String)
    {
        if(to == "loading")
        {
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            activityIndicator.style = .gray
            let barButton = UIBarButtonItem(customView: activityIndicator)
            navigationItem.setRightBarButton(barButton, animated: true)
            activityIndicator.startAnimating()
        } else if (to == "done") {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePopup))
        }
    }
    
    // MARK: - TextViewEditing
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NSLocalizedString("question", comment: "")
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
}
