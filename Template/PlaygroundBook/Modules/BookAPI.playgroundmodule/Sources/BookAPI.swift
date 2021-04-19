//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Contains classes/structs/enums/functions which are part of a module that is
//  automatically imported into user-editable code.
//

import BookCore
import PlaygroundSupport
// Implement any classes/structs/enums/functions in the BookAPI module which you
// want to be automatically imported and visible for users on playground pages
// and in user modules.
//
// This is controlled via the book-level `UserAutoImportedAuxiliaryModules`
// Manifest.plist key.

public func checkUserInput(_ check_String:String,pass_message:String,fail_hint:[String],nextPageName:String?){
    let page = PlaygroundPage.current
    if page.text.contains(check_String){
        if let next = nextPageName{
            page.assessmentStatus = .pass(message: pass_message+"Go: [\(next)](@next)")
        }else{
            page.assessmentStatus = .pass(message: pass_message)
        }
    }else{
        page.assessmentStatus = .fail(hints: fail_hint, solution: nil)
    }
    
}
