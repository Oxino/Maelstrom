// // import '';

// import 'package:flutter/material.dart';

// import 'package:maelstrom/config.dart';

// import 'package:maelstrom/bloc/bloc_provider.dart';
// import 'package:maelstrom/bloc/application_bloc.dart';

// import 'package:maelstrom/widgets/home/home_app_bar.dart';
// import 'package:maelstrom/widgets/base_navigation_bar.dart';

// import 'package:maelstrom/pages/home.dart';
// import 'package:maelstrom/pages/list.dart';
// import 'package:maelstrom/pages/map.dart';

// import 'package:maelstrom/widgets/base_app_bar.dart';
// import 'package:maelstrom/widgets/base_app_bar.dart';



// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
//     final test =
//     return Scaffold(
//       backgroundColor: ThemeColors.backgroundColor,
//       appBar:  StreamBuilder<PageType>(
//         stream: pageBloc.streamPage,
//         initialData: PageType.home,
//         builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
//           return _buildPages(snapshot.requireData);
//         }),
//       body:  StreamBuilder<PageType>(
//         stream: pageBloc.streamPage,
//         initialData: PageType.home,
//         builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
//           return _buildPages(snapshot.requireData);
//         }),
//     );
//   }

//   _buildPages(PageType type) {
//     switch (type) {
//       case PageType.home:
//         {
//           return HomePage();
//         }

//       case PageType.map:
//         {
//           return MapPage();
//         }

//       case PageType.list:
//         {
//           return ListPage();
//         }

//       default:
//         {
//           return HomePage();
//         }
//     }
//   }
// }


// // _buildPages(PageType type) {
// //     switch (type) {
// //       case PageType.home:
// //         {
// //           return [HomeAppBar(), HomePage()];
// //         }

// //       case PageType.list:
// //         {
// //           return [BaseAppBar('List'), ListPage()];
// //         }
        
// //       case PageType.map:
// //         {
// //           return [BaseAppBar('Map'), MapPage()];
// //         }

// //       default:
// //         {
// //           return [HomeAppBar(), HomePage()];
// //         }
// //     }
// //   }