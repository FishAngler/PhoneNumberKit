//
//  PhoneNumber.swift
//  PhoneNumberKit
//
//  Created by Roy Marmelstein on 26/09/2015.
//  Copyright © 2015 Roy Marmelstein. All rights reserved.
//

import Foundation

/**
Parsed phone number object
 
- numberString: String used to generate phone number struct
- countryCode: Country dialing code as an unsigned. Int.
- leadingZero: Some countries (e.g. Italy) require leading zeros. Bool.
- nationalNumber: National number as an unsigned. Int.
- numberExtension: Extension if available. String. Optional
- type: Computed phone number type on access. Returns from an enumeration - PNPhoneNumberType.
*/
@objc(PhoneNumber)
public class PhoneNumber : NSObject {
    @objc public let numberString: String
    @objc public let countryCode: UInt64
    @objc public let leadingZero: Bool
    @objc public let nationalNumber: UInt64
    @objc public let numberExtension: String?
    @objc public let type: PhoneNumberType
    
    init(numberString: String, countryCode: UInt64, leadingZero: Bool, nationalNumber: UInt64, numberExtension: String?, type: PhoneNumberType) {
        self.numberString = numberString
        self.countryCode = countryCode
        self.leadingZero = leadingZero
        self.nationalNumber = nationalNumber
        self.numberExtension = numberExtension
        self.type = type
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? PhoneNumber else { return false }
        
        return (self.countryCode == rhs.countryCode)
            && (self.leadingZero == rhs.leadingZero)
            && (self.nationalNumber == rhs.nationalNumber)
            && (self.numberExtension == rhs.numberExtension)
    }
    
    override public var hash : Int {
        return countryCode.hashValue ^ nationalNumber.hashValue ^ leadingZero.hashValue ^ (numberExtension?.hashValue ?? 0)
    }
}

extension PhoneNumber{
    
    public static func notPhoneNumber() -> PhoneNumber{
        return PhoneNumber(numberString: "", countryCode: 0, leadingZero: false, nationalNumber: 0, numberExtension: nil, type: .notParsed)
    }
    
    public func notParsed() -> Bool{
        return type == .notParsed
    }
}

/// In past versions of PhoneNumebrKit you were able to initialize a PhoneNumber object to parse a String. Please use a PhoneNumberKit object's methods.
public extension PhoneNumber {
    /**
    DEPRECATED. 
    Parse a string into a phone number object using default region. Can throw.
    - Parameter rawNumber: String to be parsed to phone number struct.
    */
    @available(*, unavailable, message: "use PhoneNumberKit instead to produce PhoneNumbers")
    public convenience init(rawNumber: String) throws {
        assertionFailure(PhoneNumberError.deprecated.localizedDescription)
        throw PhoneNumberError.deprecated
    }
    
    /**
    DEPRECATED.
    Parse a string into a phone number object using custom region. Can throw.
    - Parameter rawNumber: String to be parsed to phone number struct.
    - Parameter region: ISO 639 compliant region code.
    */
    @available(*, unavailable, message: "use PhoneNumberKit instead to produce PhoneNumbers")
    public convenience init(rawNumber: String, region: String) throws {
        throw PhoneNumberError.deprecated
    }

}


