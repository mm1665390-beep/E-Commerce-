import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce/features/data/repository/repositeryimpl.dart';
import 'package:ecommerce/features/data/service/apimethod.dart';
import 'package:ecommerce/features/data/service/localdatabase.dart';
import 'package:ecommerce/features/domian/usecase/add_products_usecase.dart';
import 'package:ecommerce/features/domian/usecase/get_all_product_usecase.dart';
import 'package:ecommerce/features/presentation/bloc/cart/cubit/cart_item_cubit.dart';
import 'package:ecommerce/features/presentation/bloc/product/cubit/products_cubit.dart';
import 'package:ecommerce/features/presentation/pages/homescreen.dart';
import 'package:ecommerce/core/networks/networkinfo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Cubits معمولين globally عشان MyApp تفضل const و tests متكسرش
late ProductsCubit _productsCubit;
late CartItemCubit _cartItemCubit;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final repository = ProductRepositoryImpl(
    remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()),
    localDataSource: ProductLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
    ),
    networkInfo: NetworkInfoImpl(Connectivity()),
  );

  _productsCubit = ProductsCubit(
    getAllProductUsecase: GetAllProductUsecase(productRepository: repository),
    addProducts: AddProductsUsecase(productRepository: repository),
  );
  _cartItemCubit = CartItemCubit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>.value(value: _productsCubit),
        BlocProvider<CartItemCubit>.value(value: _cartItemCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6C63FF),
              ),
              useMaterial3: true,
            ),
            initialRoute: 'home',
            routes: {'home': (_) => const HomeScreen()},
          );
        },
      ),
    );
  }
}
