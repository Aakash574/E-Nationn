import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PopScreens/subscribe_Pop_Up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../../ApiMap/APIs/JobEndPoints/job_api.dart';
import '../candidate_section.dart';

class InternSection extends StatefulWidget {
  const InternSection({
    super.key,
  });

  @override
  State<InternSection> createState() => _InternSectionState();
}

class _InternSectionState extends State<InternSection> {
  int count = 0;
  List jobsData = [];

  void getData() async {
    jobsData = await JobsApiClient().getJobsData();
    for (var i = 0; i < jobsData.length; i++) {
      if (jobsData[i]['type_of_job'] == 'intern' &&
          jobsData[i]['apply_status'] == 'Active') {
        count += 1;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          RefreshIndicator(
            onRefresh: () => JobsApiClient().getJobsData(),
            child: FutureBuilder(
              future: JobsApiClient().getJobsData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyColors.tealGreenColor,
                      semanticsLabel: "Loading...",
                      semanticsValue: "Loading...",
                      backgroundColor: MyColors.primaryColor,
                      strokeWidth: 4.0,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  Future.delayed(const Duration(seconds: 2));
                  return count != 0
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: count == 0 ? 1 : jobsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (jobsData[index]['type_of_job'] == 'intern' &&
                                jobsData[index]['apply_status'] == 'Active') {
                              return ListTile(
                                title: InternData(
                                  index: index,
                                  jobsData: jobsData,
                                ),
                              );
                            }
                            return null;
                          },
                        )
                      : Center(
                          heightFactor: 20,
                          child: MyFont().fontSize16Bold(
                            "No Jobs",
                            MyColors.darkGreyColor,
                          ),
                        );
                } else {
                  return Center(
                    heightFactor: 20,
                    child: MyFont().fontSize16Bold(
                      "No Jobs",
                      MyColors.darkGreyColor,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InternData extends StatefulWidget {
  const InternData({
    super.key,
    required this.index,
    required this.jobsData,
  });
  final int index;
  final List jobsData;

  @override
  State<InternData> createState() => _InternDataState();
}

class _InternDataState extends State<InternData> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          _scaleDialog(widget.index, widget.jobsData, userProvider);
        },
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.jobsData[widget.index]['image'],
                            ),
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          MyFont().fontSize16Bold(
                            widget.jobsData[widget.index]['title'],
                            Colors.black,
                          ),
                          const SizedBox(height: 5),
                          MyFont().fontSize12Bold(
                            widget.jobsData[widget.index]['company_name'],
                            Colors.black,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  MyFont().fontSize12Bold(
                    (widget.jobsData[widget.index]['desc']).toString().length <
                            200
                        ? widget.jobsData[widget.index]['desc']
                        : "${(widget.jobsData[widget.index]['desc']).toString().substring(0, 200)}... See More",
                    Colors.grey,
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            maxRadius: 15,
                            backgroundColor: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          MyFont().fontSize14Bold(
                            "+${widget.jobsData.length.toString()}",
                            MyColors.tealGreenColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      MyFont().fontSize12Bold(
                        widget.jobsData[widget.index]['last_date_to_apply'],
                        Colors.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate(delay: 150.ms).fadeIn().moveX(begin: 100),
    );
  }

  void _scaleDialog(index, jobData, UserProvider userProvider) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: userProvider.planStatus == 'premium' ||
                  userProvider.planStatus == 'basic'
              ? CandidateSection(
                  index: index,
                  jobData: jobData,
                )
              : const SubscribePopUp(),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
