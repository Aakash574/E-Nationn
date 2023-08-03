import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../data/repos/remote/jobRepository/job_repository.dart';
import '../candidate_section.dart';

class ExperianceSection extends StatefulWidget {
  const ExperianceSection({
    super.key,
  });

  @override
  State<ExperianceSection> createState() => _ExperianceSectionState();
}

class _ExperianceSectionState extends State<ExperianceSection> {
  int count = 0;
  List jobsData = [];

  void getData() async {
    jobsData = await JobRepository().getJobsData();
    for (var i = 0; i < jobsData.length; i++) {
      if (jobsData[i]['type_of_job'] == 'experiance' &&
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
      child: Column(
        children: [
          RefreshIndicator(
            onRefresh: () => JobRepository().getJobsData(),
            child: FutureBuilder(
              future: JobRepository().getJobsData(),
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
                  return count != 0
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: jobsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (jobsData[index]['type_of_job'] ==
                                    'experience' &&
                                jobsData[index]['apply_status'] == 'Active') {
                              return ListTile(
                                  title: ExperianceData(
                                index: index,
                                jobsData: jobsData,
                              ));
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

class ExperianceData extends StatefulWidget {
  const ExperianceData({
    super.key,
    required this.index,
    required this.jobsData,
  });
  final int index;
  final List jobsData;

  @override
  State<ExperianceData> createState() => _ExperianceDataState();
}

class _ExperianceDataState extends State<ExperianceData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CandidateSection(
                index: widget.index,
                jobData: widget.jobsData,
              ),
            ),
          );
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
      ).animate(delay: 10.ms).fadeIn().moveX(begin: 100),
    );
  }

  void _scaleDialog(index, jobData) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: CandidateSection(
            index: index,
            jobData: jobData,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}