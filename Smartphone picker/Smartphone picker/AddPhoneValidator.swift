import UIKit

@objc class PhoneValidator: NSObject {
    var reasonForFail = "Fill all fields";
    
    @objc func modelIsValid(model:String) -> (Bool){
        if(model.isEmpty){
            reasonForFail = "Model name cannot be empty."
            return false;
        }
        else if(model.characters.count < 2) {
            reasonForFail = "Model name cannot be less than 2 characters.";
            return false;
        }
        else if(model.characters.count >= 30) {
            reasonForFail = "Model name cannot be more than 30 characters."
            return false;
        }
        
        return true;
    }
    
    @objc func priceIsValid(price:Double) -> (Bool){
        if(price <= 0){
            reasonForFail = "Price cannot be negative or zero"
            return false;
        }
        else if(price > 100000) {
            reasonForFail = "So expensive phone? C'mon..."
            return false;
        }
        
        return true;
    }
    
    @objc func manufacturerNameIsValid(manufacturer:String) -> (Bool){
        if(manufacturer.isEmpty){
            reasonForFail = "Manufacturer name cannot be empty.";
            return false;
        }
        else if(manufacturer.characters.count < 2) {
            reasonForFail = "Manufacturer name cannot be less than 2 characters.";
            return false;
        }
        else if(manufacturer.characters.count >= 30) {
            reasonForFail = "Manufacturer name cannot be more than 30 characters."
            return false;
        }
        
        return true;
    }
    
    @objc func descriptionIsValid(deviceDescription:String) -> (Bool){
        if(deviceDescription.isEmpty){
            reasonForFail = "Description cannot be empty.";
            return false;
        }
        else if(deviceDescription.characters.count < 6) {
            reasonForFail = "Description cannot be less than 6 characters.";
            return false;
        }
        else if(deviceDescription.characters.count >= 250) {
            reasonForFail = "Description cannot be more than 250 characters."
            return false;
        }
        
        return true;
    }
    
}
