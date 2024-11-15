//
//  PasswordValidatorTests.swift
//  PasswordValidatorTests
//
//  Created by Andy Brown on 06/11/2024.
//
import Foundation
import Testing
@testable import PasswordValidator

struct PasswordValidatorTests {
    
    @Test
    func passwordLessThanEightCharacters_returnsCorrectError()  {
        let sut = PasswordValidator()
        
        let errors = sut.validate("abcdefg")
        
        #expect(errors.contains(.passwordLessThanEightCharacters))
    }
    
    @Test
    func passwordAllLowercase_returnsCorrectError() {
        let sut = PasswordValidator()
        
        let errors = sut.validate("abcdefgh")
        
        #expect(errors.contains(.passwordDoesNotContainUppercaseCharacters))
    }
    
    @Test
    func passwordAllUppercase_returnsCorrectError() {
        let sut = PasswordValidator()
        
        let errors = sut.validate("ABCDEFGH")
        
        #expect(errors.contains(.passwordDoesNotContainLowercaseCharacters))
    }
    
    @Test
    func passwordWithNoDigits_returnsCorrectError() {
        let sut = PasswordValidator()
        
        let errors = sut.validate("ABCDEFGH")
        
        #expect(errors.contains(.passwordDoesNotContainDigits))
    }
    
    @Test
    func passwordWithNoSpecialCharacters_returnsCorrectError() {
        let sut = PasswordValidator()
        
        let errors = sut.validate("ABCDEFGH")
        
        #expect(errors.contains(.passwordDoesNotContainSpecialCharacter))
    }
    
    @Test(arguments: ["!", "@", "#", "$", "%", "^", "&", "*"])
    func specialCharacterIncludesSpecifiedCharacters(specialCharacter: String) {
        let sut = PasswordValidator()
        
        let errors = sut.validate("mypassword\(specialCharacter)")
        
        #expect(errors.doesNotContain(.passwordDoesNotContainSpecialCharacter))
    }
    
    @Test
    func validPassword_returnsNoErrors() {
        let sut = PasswordValidator()
        
        let errors = sut.validate("aBcd1f@m")
        
        #expect(errors.isEmpty)
    }
}

private extension Array where Element == PasswordValidator.ValidationError {
    func contains(_ error: PasswordValidator.ValidationError) -> Bool {
        contains(where: { $0 == error })
    }
    
    func doesNotContain(_ error: PasswordValidator.ValidationError) -> Bool {
        contains(error) == false
    }
}

struct PasswordValidator {
    enum ValidationError {
        case passwordLessThanEightCharacters
        case passwordDoesNotContainUppercaseCharacters
        case passwordDoesNotContainLowercaseCharacters
        case passwordDoesNotContainDigits
        case passwordDoesNotContainSpecialCharacter
    }
            
    func validate(_ password: String) -> [ValidationError] {
        var validationErrors = [ValidationError]()
        
        if password.count < 8 {
            validationErrors.append(.passwordLessThanEightCharacters)
        }
        
        if password.rangeOfCharacter(from: .uppercaseLetters) == nil {
            validationErrors.append(.passwordDoesNotContainUppercaseCharacters)
        }
        
        if password.rangeOfCharacter(from: .lowercaseLetters) == nil {
            validationErrors.append(.passwordDoesNotContainLowercaseCharacters)
        }
        
        if password.rangeOfCharacter(from: .decimalDigits) == nil {
            validationErrors.append(.passwordDoesNotContainDigits)
        }
        
        let specialCharacters: CharacterSet = ["!", "@", "#", "$", "%", "^", "&", "*"]
        if password.rangeOfCharacter(from: specialCharacters) == nil {
            validationErrors.append(.passwordDoesNotContainSpecialCharacter)
        }
        
        return validationErrors
    }
}

//Length Requirement: Password must be at least 8 characters. ✅
//Uppercase Requirement: Password must contain at least one uppercase letter. ✅
//Lowercase Requirement: Password must contain at least one lowercase letter. ✅
//Digit Requirement: Password must contain at least one digit. ✅
//Special Character Requirement: Password must contain at least one special character (e.g., !@#$%^&*). ✅