import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.dart';
import '../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/input_form_button.dart';
import '../../../widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();
  int _currentIndex = 0;

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;
    if (currentScroll > (maxScroll * scrollPercentage)) {
      if (context.read<ProductBloc>().state is ProductLoaded) {
        context.read<ProductBloc>().add(const GetMoreProducts());
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).padding.top + 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                    if (state is UserLogged) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.userProfile);
                              },
                              child: Text(
                                "${state.user.firstName} ${state.user.lastName}",
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.userProfile);
                              },
                              child: state.user.image != null
                                  ? CachedNetworkImage(
                                      imageUrl: state.user.image!,
                                      imageBuilder: (context, image) =>
                                          CircleAvatar(
                                        radius: 18.sp,
                                        backgroundImage: image,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 18.sp,
                                      backgroundImage: AssetImage(kUserAvatar),
                                      backgroundColor: Colors.transparent,
                                    ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Welcome,",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 36),
                              ),
                              Text(
                                "SoundSage Music Store",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal, fontSize: 22),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRouter.signIn);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0,
                                backgroundImage: AssetImage(kUserAvatar),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 1.h,
                    left: 6.w,
                    right: 6.w,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<FilterCubit, FilterProductParams>(
                          builder: (context, state) {
                            return TextField(
                              autofocus: false,
                              controller:
                                  context.read<FilterCubit>().searchController,
                              onChanged: (val) => setState(() {}),
                              onSubmitted: (val) => context.read<ProductBloc>().add(
                                  GetProducts(FilterProductParams(keyword: val))),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 16.sp,
                                    bottom: 16.sp,
                                    top: 18.sp,
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(Icons.search),
                                  ),
                                  suffixIcon: context
                                      .read<FilterCubit>()
                                      .searchController
                                      .text
                                      .isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<FilterCubit>()
                                                  .searchController
                                                  .clear();
                                              context
                                                  .read<FilterCubit>()
                                                  .update(keyword: '');
                                            },
                                            icon: const Icon(Icons.clear)),
                                      )
                                      : null,
                                  border: const OutlineInputBorder(),
                                  hintText: "Search Product",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 3.0),
                                      borderRadius: BorderRadius.circular(16.sp)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.sp),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 1.h,)
              ],
            ),
          ),
Container(
  padding: EdgeInsets.symmetric(vertical: 8),
  margin: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.0), // Rounded corners
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8.0,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: CarouselSlider.builder(
      itemCount: 3, // Updated to 3 images
      itemBuilder: (context, index, realIdx) {
        return Image.asset(
          index == 0
              ? 'assets/images/coverphoto.jpg'
              : index == 1
                  ? 'assets/images/coverimage3.jpg' 
                  : 'assets/images/coverimage2.jpg', 
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200.0,
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    ),
  ),
)
,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded && state.products.isEmpty) {
                    return const AlertCard(
                      image: kEmpty,
                      message: "Products not found!",
                    );
                  }
                  if (state is ProductError && state.products.isEmpty) {
                    if (state.failure is NetworkFailure) {
                      return AlertCard(
                        image: kNoConnection,
                        message: "Network failure\nTry again!",
                        onClick: () {
                          context.read<ProductBloc>().add(GetProducts(
                              FilterProductParams(
                                  keyword: context
                                      .read<FilterCubit>()
                                      .searchController
                                      .text)));
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (state.failure is ServerFailure)
                            Image.asset(
                              'assets/status_image/internal-server-error.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          if (state.failure is CacheFailure)
                            Image.asset(
                              'assets/status_image/no-connection.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          Text(
                            "Products not found!",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          IconButton(
                              color: Colors.grey.shade600,
                              onPressed: () {
                                context.read<ProductBloc>().add(GetProducts(
                                    FilterProductParams(
                                        keyword: context
                                            .read<FilterCubit>()
                                            .searchController
                                            .text)));
                              },
                              icon: const Icon(Icons.refresh)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ProductBloc>()
                          .add(const GetProducts(FilterProductParams()));
                    },
                    child: GridView.builder(
                      itemCount: state.products.length +
                          ((state is ProductLoading) ? 10 : 0),
                      controller: scrollController,
                      padding: EdgeInsets.only(
                          top: 18,
                          left: 20,
                          right: 20,
                          bottom: (80 + MediaQuery.of(context).padding.bottom)),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 20,
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (state.products.length > index) {
                          return ProductCard(
                            product: state.products[index],
                          );
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.white,
                            child: const ProductCard(),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
