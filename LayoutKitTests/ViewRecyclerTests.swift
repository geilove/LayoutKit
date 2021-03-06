// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import XCTest
@testable import LayoutKit

class ViewRecyclerTests: XCTestCase {

    func testNilIdNotRecycled() {
        let root = View()
        let zero = View()
        root.addSubview(zero)

        let recycler = ViewRecycler(rootView: root)

        let v: View = recycler.makeView(viewReuseId: nil)
        XCTAssertNotEqual(v, zero)

        recycler.purgeViews()
        XCTAssertNil(zero.superview)
    }

    func testNonNilIdRecycled() {
        let root = View()
        let one = View(viewReuseId: "1")
        root.addSubview(one)

        let recycler = ViewRecycler(rootView: root)

        let v: View = recycler.makeView(viewReuseId: "1")
        XCTAssertEqual(v, one)

        recycler.purgeViews()
        XCTAssertNotNil(one.superview)
    }

    func testMarkViewAsRecycled() {
        let root = View()
        let one = View(viewReuseId: "1")
        root.addSubview(one)

        let recycler = ViewRecycler(rootView: root)
        recycler.markViewAsRecycled(one)
        recycler.purgeViews()

        XCTAssertNotNil(one.superview)
    }
}

extension View {
    convenience init(viewReuseId: String) {
        self.init(frame: .zero)
        self.viewReuseId = viewReuseId
    }
}