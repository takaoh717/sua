
import Glibc


class Tick {

  // Alias for millis.
  static var millisecondsSinceEpoch: Int {
    return millis
  }

  static var millis: Int {
    var ts = timespec()
    clock_gettime(CLOCK_REALTIME, &ts)
    return (ts.tv_sec * 1000) + Int(ts.tv_nsec / 1000000)
  }

}


class Stopwatch {

  var startTime: Int = 0

  var sliceTime: Int = 0

  var stopped = true

  func start() {
    startTime = Tick.millis
    sliceTime = startTime
    stopped = false
  }

  func stop() {
    doSlice()
    stopped = true
  }

  func doSlice() {
    sliceTime = Tick.millis
  }

  // Alias for millis.
  var elapsedMilliseconds: Int {
    return millis
  }

  var millis: Int {
    if (!stopped) {
      doSlice()
    }
    return sliceTime - startTime
  }

}


var sw = Stopwatch()

print("Elapsed: \(sw.millis)")

sw.start()
sleep(1)
sw.stop()
print("Elapsed: \(sw.millis)")
sw.start()
sleep(2)
print("Elapsed: \(sw.millis)")
sleep(3)
print("Elapsed: \(sw.millis)")
