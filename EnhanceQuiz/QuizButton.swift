//
//  QuizButton.swift
//  EnhanceQuiz
//
//  Created by Erik Carlson on 9/14/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

/// A UIButton styled for the Quiz.
class QuizButton: UIButton {
    /**
     Initialize the button with a given title.
     
     - Parameter title: The title of the button.
    */
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        
        setTitle(title, for: .normal)
    }
    
    /**
     Initialize the button with the quiz style.
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        tintColor = UIColor.white
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
