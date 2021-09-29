//
//  CustomParseableFormatStyleDemoTests.swift
//  CustomParseableFormatStyleDemoTests
//
//  Created by Yang Xu on 2021/9/30.
//

import XCTest

class CustomParseableFormatStyleDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    let count = 1000

    // Tuesday, September 28, 2021, 02:54:46 PM China Standard Time
    // 0.121
    func testDateFormatterLong() throws {
        measure {
            for _ in 0..<count {
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .full
                formatter.timeStyle = .full
                _ = formatter.string(from: date)
            }
        }
    }

    // 0.005
    func testDateFormatterLongCreateOnce() throws {
        let formatter = DateFormatter()
        measure {
            for _ in 0..<count {
                let date = Date()
                formatter.dateStyle = .full
                formatter.timeStyle = .full
                _ = formatter.string(from: date)
            }
        }
    }

    // 0.085 sec
    func testDateFormatStyleLong() throws {
        measure {
            for _ in 0..<count {
                _ = Date().formatted(.dateTime.year().month(.wide).day().weekday(.wide).hour(.conversationalTwoDigits(amPM: .wide)).minute(.defaultDigits).second(.twoDigits).timeZone(.genericName(.long)))
            }
        }
    }

    // 0.071
    func testDateFormatStyleLongCreateOnce() throws {
        measure {
            let dateFormatter = Date.FormatStyle(date: .complete, time: .complete, locale: .current, calendar: .current, timeZone: .current, capitalizationContext: .listItem)//.timeZone(.genericName(.long))
            for _ in 0..<count {
                _ = dateFormatter.format(Date.now)
            }
        }
    }


    // 2021/9/28
    // 0.084 sec
    func testDateFormatterShort() throws {
        let date = Date.now
        measure {
            for _ in 0..<count {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                _ = formatter.string(from: date)
            }
        }
    }

    // 0.003
    func testDateFormatterShortCreateOnce() throws {
        let date = Date.now
        let formatter = DateFormatter()
        measure {
            for _ in 0..<count {
                formatter.dateStyle = .short
                _ = formatter.string(from: date)
            }
        }
    }

    // 0.031 sec
    func testDateFormatStyleShort() throws {
        let date = Date.now
        measure {
            for _ in 0..<count {
                _ = date.formatted(.dateTime.year(.defaultDigits).month(.defaultDigits).day(.twoDigits))
            }
        }
    }

    // 35 353,343
    // 0.024
    func testNumberFormatter() throws {
        measure {
            for _ in 0..<count {
                let formatter = NumberFormatter()
                formatter.locale = Locale(identifier: "fr")
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 3
                _ = formatter.string(from: 35353.343234)!
            }
        }
    }

    // 0.003
    func testNumberFormatterCreateOnce() throws {
        measure {
            let formatter = NumberFormatter()
            for _ in 0..<count {
                formatter.locale = Locale(identifier: "fr")
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 3
                _ = formatter.string(for: 35353.343234)!
            }
        }
    }

    // 0.008
    func testNumberFormatStyle() throws {
        measure {
            for _ in 0..<count {
                _ = 35353.343234.formatted(.number.precision(.fractionLength(3)).locale(Locale(identifier: "fr")))
            }
        }
    }
}
