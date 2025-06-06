import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:the_unwind_blog/core/config/theme/app_colors.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
import 'package:the_unwind_blog/presentation/ui/blog_detail_screen/pages/blog_detail_screen.dart';
import 'package:the_unwind_blog/presentation/ui/home_screen/bloc/blog_cubit.dart';
import 'package:the_unwind_blog/presentation/ui/home_screen/pages/home_screen.dart';
import 'package:the_unwind_blog/presentation/ui/mark_screen/pages/bookmark_screen.dart';
import 'package:the_unwind_blog/presentation/ui/post_screen/pages/post_screen.dart';
import 'package:the_unwind_blog/presentation/ui/profile_screen/pages/profile_screen.dart';
import 'package:the_unwind_blog/presentation/ui/search_screen/pages/search_screen.dart';
import 'package:the_unwind_blog/service_locator.dart';

import 'common/bloc/blog_provider.dart';
import 'common/bloc/theme_cubit.dart';
import 'core/config/theme/app_theme.dart';
import 'domain/entities/user_entity.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/blog/:id',
      name: 'blogDetail',
      builder: (context, state) {
        final blogId = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return BlogDetailScreen(blogId: blogId);
      },
    ),
  ],
);


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await initializeDependencies();
  runApp(MyApp());
}

enum _SelectedTab { home, favorite, add, search, person }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        BlocProvider<BlogCubit>(create: (_) => sl<BlogCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder:
            (context, mode) => MaterialApp.router(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedTab = _SelectedTab.home;

  // List of screens corresponding to each tab
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    PostScreen(),
    BookmarksScreen(),
    ProfileScreen(),
  ];

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedTab.index,
        children: _screens,
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        height: 10,
        itemPadding: EdgeInsets.all(10),
        marginR: EdgeInsets.all(20),
        unselectedItemColor: Colors.white70,
        borderWidth: 1,
        outlineBorderColor: Colors.white,
        backgroundColor: AppColors.background_black.withOpacity(0.45),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
        onTap: _handleIndexChanged,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: Colors.white,
            badge: Badge(
              label: Text("9+", style: TextStyle(color: Colors.white)),
            ),
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.search,
            unselectedIcon: IconlyLight.search,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            unselectedIcon: IconlyLight.plus,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.bookmark,
            unselectedIcon: IconlyLight.bookmark,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.user_2,
            unselectedIcon: IconlyLight.user,
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
