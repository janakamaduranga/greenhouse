import 'package:flutter/material.dart';
import 'package:green_house/services/storage_service.dart';

class NavigationDrawer extends StatelessWidget {
  final String userName;
  final String deviceId;
  final StorageService _storageService = StorageService.getInstance();

  NavigationDrawer(this.userName, this.deviceId);

  void selectedItem(BuildContext buildContext, String selectedItem) {
    Navigator.of(buildContext).pushNamed(selectedItem);
  }

  void logout(BuildContext buildContext, String page) async {
    await _storageService.delete();
    await Navigator.of(buildContext).pushNamed(page);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 48,
              ),
              _builItem(
                  Icons.people, 'People', () => selectedItem(context, '/')),
              _builItem(
                  Icons.people, 'Contact', () => selectedItem(context, '/')),
              _builItem(
                  Icons.logout, 'Logout', () => logout(context, '/loginPage')),
              SizedBox(
                height: 24,
              ),
              Divider(
                color: Colors.white70,
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builItem(IconData icon, String menuText, VoidCallback? voidCallback) {
    final color = Colors.white;
    final hoColor = Colors.white70;
    return ListTile(
      title: Text(menuText),
      leading: Icon(
        icon,
        color: color,
      ),
      hoverColor: hoColor,
      onTap: voidCallback,
    );
  }
}
