class UserAction {
  final String device;
  final String action;

  UserAction(this.device, this.action);

  Map toJson() => {'device': device, 'action': action};
}
