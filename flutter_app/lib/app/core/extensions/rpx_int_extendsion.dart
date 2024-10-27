import '../utils/size_fit/size_fit.dart';

extension RpxIntFit on int {
  double get px {
    return SizeFit.setPx(toDouble());
  }

  double get rpx {
    return SizeFit.setRpx(toDouble());
  }
}
