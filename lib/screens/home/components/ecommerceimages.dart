
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:krishak_farma/screens/home/components/firestorageservices.dart';

class EcommerceImage extends StatefulWidget {
  const EcommerceImage({
    Key? key,
  }) : super(key: key);


  @override
  State<EcommerceImage> createState() => _EcommerceImageState();
}

class _EcommerceImageState extends State<EcommerceImage> {
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            // child: SectionTitle(
            //   title: "Dealers of the day",
            //   press: () {},
            // ),
          ),
          // SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenWidth(200),
                  child : FutureBuilder(
                    builder: (context,snapshots){
                      if(snapshots.connectionState == ConnectionState.done)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.width/1.2,
                          child: snapshots.data,
                        );


                      }

                      if(snapshots.connectionState == ConnectionState.waiting)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.width/1.2,
                          //child: CircularProgressIndicator(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Skeleton(
                                height: 120,
                                width: 120,
                              ),
                              const SizedBox(width: 16,),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Skeleton(width:80),
                                  const SizedBox(height: 8,),
                                  const Skeleton(),
                                  const SizedBox(height: 8,),
                                  const Skeleton(),
                                  const SizedBox(height: 8,),
                                  Row(
                                    children: const[
                                      Expanded(child: Skeleton()),
                                      SizedBox(width: 16,),
                                      Expanded(child: Skeleton()),
                                    ],
                                  )

                                ],
                              ))
                            ],
                          )
                        );
                      }

                      return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Skeleton(
                      height: 120,
                      width: 120,
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Skeleton(width:80),
                      const SizedBox(height: 8,),
                      const Skeleton(),
                      const SizedBox(height: 8,),
                      const Skeleton(),
                      const SizedBox(height: 8,),
                      Row(
                      children: const[
                      Expanded(child: Skeleton()),
                      SizedBox(width: 16,),
                      Expanded(child: Skeleton()),
                      ],
                      )

                      ],
                      ))
                      ],
                      );

                    },
                    future: _getImage(context, "Banners/Banner1.png"),
                  ),
                ),
                SizedBox(width: 20,),
                SizedBox(
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenWidth(200),
                  child : FutureBuilder(
                    builder: (context,snapshots){
                      if(snapshots.connectionState == ConnectionState.done)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.width/1.2,
                          child: snapshots.data,
                        );
                      }

                      if(snapshots.connectionState == ConnectionState.waiting)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.width/1.2,
                          //child: CircularProgressIndicator(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Skeleton(
                                  height: 120,
                                  width: 120,
                                ),
                                const SizedBox(width: 16,),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Skeleton(width:80),
                                        const SizedBox(height: 8,),
                                        const Skeleton(),
                                        const SizedBox(height: 8,),
                                        const Skeleton(),
                                        const SizedBox(height: 8,),
                                        Row(
                                          children: const[
                                            Expanded(child: Skeleton()),
                                            SizedBox(width: 16,),
                                            Expanded(child: Skeleton()),
                                          ],
                                        )

                                      ],
                                    ))
                              ],
                            )
                        );
                      }

                      return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Skeleton(
                      height: 120,
                      width: 120,
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Skeleton(width:80),
                      const SizedBox(height: 8,),
                      const Skeleton(),
                      const SizedBox(height: 8,),
                      const Skeleton(),
                      const SizedBox(height: 8,),
                      Row(
                      children: const[
                      Expanded(child: Skeleton()),
                      SizedBox(width: 16,),
                      Expanded(child: Skeleton()),
                      ],
                      )

                      ],
                      ))
                      ],
                      );

                    },
                    future: _getImage(context, "Banners/Banner2.png"),


                  ),
                ),

                // SizedBox(
                //   width: getProportionateScreenWidth(300),
                //   height: getProportionateScreenWidth(200),
                //   child: FutureBuilder(
                //     builder: (context,snapshots){
                //       if(snapshots.connectionState == ConnectionState.done)
                //       {
                //         return Container(
                //           width: MediaQuery.of(context).size.width/1.2,
                //           height: MediaQuery.of(context).size.width/1.2,
                //           child: snapshots.data,
                //         );
                //       }
                //
                //       if(snapshots.connectionState == ConnectionState.waiting)
                //       {
                //         return Container(
                //           width: MediaQuery.of(context).size.width/1.2,
                //           height: MediaQuery.of(context).size.width/1.2,
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //
                //       return Container();
                //
                //     },
                //     future: _getImage(context, "Banners/Banner3.png"),
                //
                //   ),
                // ),
                //
                // SizedBox(
                //     width: getProportionateScreenWidth(300),
                //     height: getProportionateScreenWidth(200),
                //     child: FutureBuilder(
                //
                //       builder: (context,snapshots){
                //         if(snapshots.connectionState == ConnectionState.done)
                //         {
                //           return Container(
                //             //margin: EdgeInsets.all(10.0),
                //             // decoration: BoxDecoration(
                //             //   borderRadius: BorderRadius.only(
                //             //       topRight: Radius.circular(40.0),
                //             //       bottomRight: Radius.circular(40.0),
                //             //       topLeft: Radius.circular(40.0),
                //             //       bottomLeft: Radius.circular(40.0)),
                //             // ),
                //             // decoration: BoxDecoration(
                //             //   borderRadius: BorderRadius.all(Radius.circular(20)),
                //             // ),
                //             width: MediaQuery.of(context).size.width/1.2,
                //             height: MediaQuery.of(context).size.width/1.2,
                //             child: snapshots.data,
                //           );
                //         }
                //
                //         if(snapshots.connectionState == ConnectionState.waiting)
                //         {
                //           return Container(
                //             width: MediaQuery.of(context).size.width/1.2,
                //             height: MediaQuery.of(context).size.width/1.2,
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //
                //         return Container();
                //
                //       },
                //       future: _getImage(context, "Banners/Banner4.png"),
                //
                //     )
                // )
              ],
            ),


          )

        ]

    );
  }

  Future<Widget> _getImage(BuildContext context, String ImageName) async
  {
    late Image mimage;
    await FireStorageService.loadImages(context, ImageName).then((value) {
      mimage = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return mimage;
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        //onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFFFFF).withOpacity(0.1),
                        Color(0xFFFFFFFF).withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 16.0;


class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
          const BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}