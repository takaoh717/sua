
import Glibc


public typealias CTime = tm

public struct TimeBuffer: CustomStringConvertible {

  public var buffer: CTime

  public init(secondsSinceEpoch: Int) {
    var n = secondsSinceEpoch
    var b = tm()
    gmtime_r(&n, &b)
    buffer = b
  }

  public init() {
    var n = time(nil)
    var b = tm()
    gmtime_r(&n, &b)
    buffer = b
  }

  public init(buffer: CTime) {
    self.buffer = buffer
  }

  public var isDst: Bool { return buffer.tm_isdst == 1 }

  public var yearday: Int32 { return buffer.tm_yday }

  public var weekday: Int32 { return buffer.tm_wday }

  public var year: Int32 { return buffer.tm_year }

  public var month: Int32 { return buffer.tm_mon }

  public var day: Int32 { return buffer.tm_mday }

  public var hour: Int32 { return buffer.tm_hour }

  public var minute: Int32 { return buffer.tm_min }

  public var second: Int32 { return buffer.tm_sec }

  public var secondsSinceEpoch: Int {
    var r = Int(second)
    r += Int(minute) * 60
    r += Int(hour) * 3600
    r += Int(yearday) * 86400
    let y = Int(year)
    r += (y - 70) * 31536000
    r += ((y - 69) / 4) * 86400
    //r += ((y - 1) / 100) * 86400
    //r += ((y + 299) / 400) * 86400
    return r
  }

  public var description: String {
    return "TimeBuffer(year: \(year), month: \(month), day: \(day), " +
        "hour: \(hour), minute: \(minute), second: \(second), " +
        "weekday: \(weekday), yearday: \(yearday), isDst: \(isDst))"
  }

}


public struct TimeMath {

  var _secondsSinceEpoch = 0
  var _buffer: TimeBuffer

  public init() {
    self.init(secondsSinceEpoch: time(nil))
  }

  public init(secondsSinceEpoch: Int) {
    _secondsSinceEpoch = secondsSinceEpoch
    _buffer = TimeBuffer(secondsSinceEpoch: secondsSinceEpoch)
  }

  public init(buffer: CTime) {
    _buffer = TimeBuffer(buffer: buffer)
    _secondsSinceEpoch = _buffer.secondsSinceEpoch
  }

  public var day: Int {
    get { return Int(_buffer.day) }
    set {
      secondsSinceEpoch += (newValue - Int(_buffer.day)) * 86400
    }
  }

  public var hour: Int {
    get { return Int(_buffer.hour) }
    set {
      secondsSinceEpoch += (newValue - Int(_buffer.hour)) * 3600
    }
  }

  public var minute: Int {
    get { return Int(_buffer.minute) }
    set {
      secondsSinceEpoch += (newValue - Int(_buffer.minute)) * 60
    }
  }

  public var second: Int {
    get { return Int(_buffer.second) }
    set {
      secondsSinceEpoch += newValue - Int(_buffer.second)
    }
  }

  public var secondsSinceEpoch: Int {
    get { return _secondsSinceEpoch }
    set {
      _secondsSinceEpoch = newValue
      _buffer = TimeBuffer(secondsSinceEpoch: newValue)
    }
  }

  public var buffer: TimeBuffer {
    return _buffer
  }

}


public struct Time {

  public init() {

  }

}
