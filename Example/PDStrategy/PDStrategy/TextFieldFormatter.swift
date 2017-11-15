//
//  TextFieldFormatter.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 07/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TextFieldFormatter:NSObject, UITextFieldDelegate {
    
    var format = "((xx-xx))"
    var dynamicSymbol = "x"
    var characterSet: CharacterSet?
    var staticAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor:UIColor.gray]
    var dynamicAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor:UIColor.black]
    
    var valueChangedBlock = {}
    
    func applyText(text: String, textField: UITextField) {

        let range = NSRange(location: 0, length: textField.text != nil ? textField.text!.count : 0)
        format(textField, shouldChangeCharactersIn: range, replacementString: text)
    }
    
    func rawFromText(text:String?) -> String? {
        
        var raw = ""
        for index in format.indices {
            let char = format[index]
            if String(char) == dynamicSymbol {
                
                if let text = text, index.encodedOffset < text.count
                {
                    let textChar = text[index]
                    if  textChar != char {
                        raw.append(textChar)
                    }
                }
            }
        }
        return raw
    }
    
    func rawRangeFrom(text: String?, range: Range<String.Index>, string: String) -> Range<String.Index>?{
        var rawRange: Range<String.Index>?
        let raw = rawFromText(text: text)
        var rawFirstIndex = raw?.startIndex
        for index in format.indices {
            
            if index < range.lowerBound {
                let char = format[index]
                if String(char) == dynamicSymbol {
                    
                    if let textChar = text?[index], textChar != char {
                        rawFirstIndex = raw?.index(rawFirstIndex!, offsetBy: 1)
                        if string.count == 0 {
                            //delete
                        } else {
                            
                        }
                        
                    } else {
                        
                        break
                    }
                }
            } else {
                let char = format[index]
                if String(char) == dynamicSymbol {
                     break
                }
            }
            
        }
        
        let offset = range.upperBound.encodedOffset - range.lowerBound.encodedOffset
        //print(rawFirstIndex?.encodedOffset)
        //print(offset)
        var end: String.Index
        
        if rawFirstIndex!.encodedOffset + offset <= raw!.count {
            end = raw!.index(rawFirstIndex!, offsetBy: offset)
            
        } else {
            end = raw!.endIndex
        }
        rawRange = rawFirstIndex!..<end
        
        return rawRange
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var replacementString = string
        if characterSet != nil {
            replacementString = replacementString.trimmingCharacters(in: characterSet!.inverted)
        }
        let originalText = textField.text != nil ? textField.text! : ""
        
        let raw = rawFromText(text: originalText)
        //print(raw as Any)
        let startIndex = originalText.index(originalText.startIndex, offsetBy: range.location)
        let endIndex = originalText.index(originalText.startIndex, offsetBy: range.location + range.length)
        //print(startIndex.encodedOffset)
        //print(endIndex.encodedOffset)
        
        let swiftRange = startIndex..<endIndex
        
        //print(swiftRange.lowerBound.encodedOffset)
        //print(swiftRange.upperBound.encodedOffset)
        
        let rawRange = rawRangeFrom(text: originalText, range: swiftRange, string: replacementString)
        //print(rawRange?.lowerBound.encodedOffset)
        //print(rawRange?.upperBound.encodedOffset)
        let newRaw = raw?.replacingCharacters(in: rawRange!, with: replacementString)
        //print(raw)
        
        var text = ""
        var rawIndex = newRaw?.indices.first
        var textPositionIndex: String.Index?
        var firstPositionIndex: String.Index?
        for index in format.indices {
            let char = format[index]
            if String(char) == dynamicSymbol {
                if rawIndex != nil, rawIndex!.encodedOffset < newRaw!.indices.count {
                    let textChar = newRaw![rawIndex!]
                    
                    text.append(textChar)
                    rawIndex = newRaw?.index(after: rawIndex!)
                    textPositionIndex = format.index(index, offsetBy: 1)
                    
                } else {
                    
                    text.append(char)
                }
                
                if firstPositionIndex == nil {
                    firstPositionIndex = index
                }
                
            } else {
                text.append(char)
            }
        }
        
        let attributedString = NSMutableAttributedString()
        
        
        for index in format.indices {
            let char = format[index]
            let textChar = text[index]
            if String(char) == dynamicSymbol, textChar != char {
                let str = NSMutableAttributedString(string: String(textChar), attributes: dynamicAttributes);
                attributedString.append(str)
                
            } else {
                let str = NSMutableAttributedString(string: String(char), attributes: staticAttributes);
                attributedString.append(str)
            }
        }
        
        textField.attributedText = attributedString
        
        if textPositionIndex == nil {
            textPositionIndex = firstPositionIndex
        }
        
        //print(textPositionIndex?.encodedOffset)
        if textPositionIndex != nil, let newPosition = textField.position(from: textField.beginningOfDocument, offset: textPositionIndex!.encodedOffset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        if raw != newRaw {
            valueChangedBlock()
        }
        
        return false
    }
    
    func format(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        var replacementString = string
        if characterSet != nil {
            replacementString = replacementString.trimmingCharacters(in: characterSet!.inverted)
        }
        let originalText = textField.text != nil ? textField.text! : ""
        
        let raw = rawFromText(text: originalText)
        //print(raw as Any)
        let startIndex = originalText.index(originalText.startIndex, offsetBy: range.location)
        let endIndex = originalText.index(originalText.startIndex, offsetBy: range.location + range.length)
        //print(startIndex.encodedOffset)
        //print(endIndex.encodedOffset)
        
        let swiftRange = startIndex..<endIndex
        
        //print(swiftRange.lowerBound.encodedOffset)
        //print(swiftRange.upperBound.encodedOffset)
        
        let rawRange = rawRangeFrom(text: originalText, range: swiftRange, string: replacementString)
        //print(rawRange?.lowerBound.encodedOffset)
        //print(rawRange?.upperBound.encodedOffset)
        let newRaw = raw?.replacingCharacters(in: rawRange!, with: replacementString)
        //print(raw)
        
        var text = ""
        var rawIndex = newRaw?.indices.first
        var textPositionIndex: String.Index?
        var firstPositionIndex: String.Index?
        for index in format.indices {
            let char = format[index]
            if String(char) == dynamicSymbol {
                if rawIndex != nil, rawIndex!.encodedOffset < newRaw!.indices.count {
                    let textChar = newRaw![rawIndex!]
                    
                    text.append(textChar)
                    rawIndex = newRaw?.index(after: rawIndex!)
                    textPositionIndex = format.index(index, offsetBy: 1)
                    
                } else {
                    
                    text.append(char)
                }
                
                if firstPositionIndex == nil {
                    firstPositionIndex = index
                }
                
            } else {
                text.append(char)
            }
        }
        
        let attributedString = NSMutableAttributedString()
        
        
        for index in format.indices {
            let char = format[index]
            let textChar = text[index]
            if String(char) == dynamicSymbol, textChar != char {
                let str = NSMutableAttributedString(string: String(textChar), attributes: dynamicAttributes);
                attributedString.append(str)
                
            } else {
                let str = NSMutableAttributedString(string: String(char), attributes: staticAttributes);
                attributedString.append(str)
            }
        }
        
        textField.attributedText = attributedString
        
        if textPositionIndex == nil {
            textPositionIndex = firstPositionIndex
        }
        
        //print(textPositionIndex?.encodedOffset)
        if textPositionIndex != nil, let newPosition = textField.position(from: textField.beginningOfDocument, offset: textPositionIndex!.encodedOffset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
}
