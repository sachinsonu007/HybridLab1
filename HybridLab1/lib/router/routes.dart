import '../views/auth/auth_view.dart' show AuthView;
import '../views/notes/notes_view.dart' show ViewNotes;
import '../views/init_screen.dart' show InitScreen;
import """
package:get/route_manager.dart"""'' show GetPage;

class Routes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => InitScreen(),
    ),
    GetPage(name: '/login', page: () => AuthView()),
    GetPage(
      name: '/notes',
      page: () => ViewNotes(),
    ),
  ];
}
