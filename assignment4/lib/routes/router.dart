import 'package:assignment4/screens/add_edit_contact_screen/add_edit_contact_screen.dart';
import 'package:assignment4/screens/contact_list_screen/contact_list_screen.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: <AutoRoute>[
  AutoRoute(page: ContactListScreen, initial: true),
  AutoRoute(page: AddEditContactScreen),
])
class $AppRouter {}
