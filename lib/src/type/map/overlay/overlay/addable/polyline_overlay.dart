part of flutter_naver_map;

class NPolylineOverlay extends NAddableOverlay<NPolylineOverlay> {
  List<NLatLng> get coords => _coords;
  List<NLatLng> _coords;

  Color get color => _color;
  Color _color;

  double get width => _width;
  double _width;

  NLineCap get lineCap => _lineCap;
  NLineCap _lineCap;

  NLineJoin get lineJoin => _lineJoin;
  NLineJoin _lineJoin;

  List<int> get pattern => _pattern;
  List<int> _pattern; // dp(pt)이므로, Android 는 px로 변환 과정에서 오차가 발생할 수 있음.

  NPolylineOverlay({
    required String id,
    required List<NLatLng> coords,
    Color color = Colors.white,
    double width = 2,
    NLineCap lineCap = NLineCap.butt,
    NLineJoin lineJoin = NLineJoin.miter,
    List<int> pattern = const [],
  })  : _coords = coords,
        _color = color,
        _width = width,
        _lineCap = lineCap,
        _lineJoin = lineJoin,
        _pattern = pattern,
        super(id: id, type: NOverlayType.polylineOverlay);

  void setCoords(List<NLatLng> coords) {
    _coords = coords;
    _set(_coordsName, coords);
  }

  void setColor(Color color) {
    _color = color;
    _set(_colorName, color);
  }

  void setWidth(double width) {
    _width = width;
    _set(_widthName, width);
  }

  void setLineCap(NLineCap lineCap) {
    _lineCap = lineCap;
    _set(_lineCapName, lineCap);
  }

  void setLineJoin(NLineJoin lineJoin) {
    _lineJoin = lineJoin;
    _set(_lineJoinName, lineJoin);
  }

  void setPattern(List<int> pattern) {
    _pattern = pattern;
    _set(_patternName, pattern);
  }

  Future<NLatLngBounds> getBounds() {
    return _getAsyncWithCast(_boundsName, NLatLngBounds._fromMessageable);
  }

  /* ----- Factory Constructor ----- */

  factory NPolylineOverlay._fromMessageable(dynamic m) => NPolylineOverlay(
        id: NOverlayInfo._fromMessageable(m[_infoName]!).id,
        coords: (m[_coordsName] as List)
            .map((e) => NLatLng._fromMessageable(e))
            .toList(),
        color: Color(m[_colorName] as int),
        width: m[_widthName] as double,
        lineCap: NLineCap._fromMessageable(m[_lineCapName]!),
        lineJoin: NLineJoin._fromMessageable(m[_lineJoinName]!),
        pattern: (m[_patternName] as List).cast<int>(),
      );

  @override
  NPayload toNPayload() => NPayload.make({
        _infoName: info,
        _coordsName: coords,
        _colorName: color,
        _widthName: width,
        _lineCapName: lineCap,
        _lineJoinName: lineJoin,
        _patternName: pattern,
      });

  /*
    --- Messaging Name Define ---
  */

  static const _infoName = "info";
  static const _coordsName = "coords";
  static const _colorName = "color";
  static const _widthName = "width";
  static const _lineCapName = "lineCap";
  static const _lineJoinName = "lineJoin";
  static const _patternName = "pattern";
  static const _boundsName = "bounds";
}
