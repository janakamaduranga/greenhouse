import 'package:green_house/models/UserAction.dart';

class Command {
  final String deviceId;
  final List<UserAction> actions;

  Command(this.deviceId, this.actions);

  Map toJson() => {
        'deviceId': deviceId,
        'actions': actions,
      };
}
