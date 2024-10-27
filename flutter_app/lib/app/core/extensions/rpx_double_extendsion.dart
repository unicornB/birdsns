import '../utils/size_fit/size_fit.dart';

extension RpxDoubleFit on double {
  double get px {
    return SizeFit.setPx(this);
  }

  double get rpx {
    return SizeFit.setRpx(this);
  }
}
