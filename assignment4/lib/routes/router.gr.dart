// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:contacts_service/contacts_service.dart' as _i5;
import 'package:flutter/material.dart' as _i4;

import '../screens/add_edit_contact_screen/add_edit_contact_screen.dart' as _i2;
import '../screens/contact_list_screen/contact_list_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ContactListRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ContactListScreen());
    },
    AddEditContactRoute.name: (routeData) {
      final args = routeData.argsAs<AddEditContactRouteArgs>(
          orElse: () => const AddEditContactRouteArgs());
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i2.AddEditContactScreen(key: args.key, contact: args.contact));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(ContactListRoute.name, path: '/'),
        _i3.RouteConfig(AddEditContactRoute.name,
            path: '/add-edit-contact-screen')
      ];
}

/// generated route for [_i1.ContactListScreen]
class ContactListRoute extends _i3.PageRouteInfo<void> {
  const ContactListRoute() : super(name, path: '/');

  static const String name = 'ContactListRoute';
}

/// generated route for [_i2.AddEditContactScreen]
class AddEditContactRoute extends _i3.PageRouteInfo<AddEditContactRouteArgs> {
  AddEditContactRoute({_i4.Key? key, _i5.Contact? contact})
      : super(name,
            path: '/add-edit-contact-screen',
            args: AddEditContactRouteArgs(key: key, contact: contact));

  static const String name = 'AddEditContactRoute';
}

class AddEditContactRouteArgs {
  const AddEditContactRouteArgs({this.key, this.contact});

  final _i4.Key? key;

  final _i5.Contact? contact;
}
