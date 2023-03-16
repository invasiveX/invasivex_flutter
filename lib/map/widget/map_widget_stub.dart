import 'map_widget.dart';
import 'new_pin_listener.dart';

//the error is shown in case of wrong version loaded on wrong platform
MapWidget getMapWidget({required NewPinListener listener}) => throw UnsupportedError(
    'Cannot create a map without dart:html or google_maps_flutter');