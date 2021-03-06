func foo() {
    bar() {
        var abc = 1
        let a: String = {
          let b = "asdf"
          return b
        }()
    }
}

class C {
  private static let durationTimeFormatter: NSDateComponentsFormatter = {
		return timeFormatter
}()
}

func foo1(a: Int, handler : () -> ()) {}
func foo2(handler : () -> ()) {}

func foo3() {
  foo1(1)
    {
  }
}

// RUN: %sourcekitd-test -req=format -line=3 -length=1 %s >%t.response
// RUN: %sourcekitd-test -req=format -line=4 -length=1 %s >>%t.response
// RUN: %sourcekitd-test -req=format -line=5 -length=1 %s >>%t.response
// RUN: %sourcekitd-test -req=format -line=6 -length=1 %s >>%t.response
// RUN: %sourcekitd-test -req=format -line=7 -length=1 %s >>%t.response
// RUN: %sourcekitd-test -req=format -line=8 -length=1 %s >>%t.response
// RUN: %sourcekitd-test -req=format -line=14 -length=1 %s >>%t.response
// RUN: %sourcekitd-test -req=format -line=22 -length=1 %s >>%t.response
// RUN: FileCheck --strict-whitespace %s <%t.response

// CHECK: key.sourcetext: "        var abc = 1"
// CHECK: key.sourcetext: "        let a: String = {"
// CHECK: key.sourcetext: "            let b = \"asdf\""
// CHECK: key.sourcetext: "            return b"
// CHECK: key.sourcetext: "        }()"
// CHECK: key.sourcetext: "    }"

//                        "  private static let durationTimeFormatter: NSDateComponentsFormatter = {"
// CHECK: key.sourcetext: "  }()"
//                        "  foo1(1)"
// CHECK: key.sourcetext: "  {"
