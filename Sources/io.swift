
import Glibc


func nativeSleep(n: Int) {
  if (n >= 0) {
    sleep(UInt32(n))
  }
}

public class IO {

  public static func sleep(f: Double) {
    let sec = Int(f)
    let nsec = sec > 0 ? Int((f % Double(sec)) * 1e9) : Int(f * 1e9)
    var ts: timespec = timespec(tv_sec: sec, tv_nsec: nsec)
    var rem: timespec = timespec()
    nanosleep(&ts, &rem)
  }

  public static func sleep(n: Int) {
    nativeSleep(n)
  }

  public static func flush() {
    fflush(UnsafeMutablePointer<FILE>(bitPattern: 0))
  }

}