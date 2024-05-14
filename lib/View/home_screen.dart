import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:khabar/View%20Model/news_view_model.dart';
import '../Models/news_channel_headline_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd, yyyy');
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              "images/category_icon.png",
              height: height * .03,
            ),
          ),
          title: Center(
              child: Text(
            "KHABAR",
            style: GoogleFonts.acme(color: Colors.black, fontSize: 25),
          )),
        ),
        body: ListView(
          children: [
            SizedBox(
              width: width,
              height: height * .5,
              child: FutureBuilder<NewsChannelHeadlineModel>(
                future: newsViewModel.fetchNewsChannelHeadlineApi(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                            size: 50, color: Colors.indigoAccent));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                         
                          return Container(
                            color: Colors.amber,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * .5,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * .02,
                                      vertical: height * .01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (BuildContext, url) =>
                                          spinkit2,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error,
                                              color: Colors.amber),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        height: height * .22,
                                        width: width * .7,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * .8,
                                              child: Text(
                                                snapshot
                                                    .data!.articles![index].title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.acme(
                                                  color: Colors.black,
                                                  letterSpacing: .6,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: width * .8,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot.data!.articles![index].source!.name.toString(),style: GoogleFonts.acme(
                                                    color: Colors.black,
                                                    letterSpacing: .6,
                                                  ),),
                                                  Text(format.format(dateTime),style: GoogleFonts.acme(
                                                    color: Colors.black,
                                                    letterSpacing: .6,
                                                  ),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            )
          ],
        ));
  }
}

const spinkit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.amber,
);
