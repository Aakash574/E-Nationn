import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../data/repos/remote/jobRepository/job_repository.dart';
import '../candidate_section.dart';

class FrasherSection extends StatefulWidget {
  const FrasherSection({
    super.key,
  });

  @override
  State<FrasherSection> createState() => _FrasherSectionState();
}

class _FrasherSectionState extends State<FrasherSection> {
  List<String> typeOfJob = [];
  List jobsData = [];
  int count = 0;

  void getData() async {
    jobsData = await JobRepository().getJobsData();
    for (var i = 0; i < jobsData.length; i++) {
      if (jobsData[i]['type_of_job'] == 'fresher' &&
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
            onRefresh: () async {
              await JobRepository().getJobsData();
            },
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
                            if (jobsData[index]['type_of_job'] == 'fresher' &&
                                jobsData[index]['apply_status'] == 'Active') {
                              return ListTile(
                                title: FresherData(
                                  index: index,
                                  jobsData: jobsData,
                                ),
                              ).animate(delay: 150.ms).moveX(begin: 100);
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

class FresherData extends StatefulWidget {
  const FresherData({
    super.key,
    required this.index,
    required this.jobsData,
  });
  final int index;
  final List jobsData;

  @override
  State<FresherData> createState() => _FresherDataState();
}

class _FresherDataState extends State<FresherData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: Colors.black12,
            ),
            color: MyColors.primaryColor.withAlpha(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.jobsData[widget.index]['image'].toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: MyFont().fontSize16Bold(
                          widget.jobsData[widget.index]['title'],
                          Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      MyFont().fontSize12Bold(
                        widget.jobsData[widget.index]['company_name'],
                        Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "${widget.jobsData[widget.index]['desc']}See more...",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: MyColors.lightBlueColor),
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

        // child:
      ).animate(delay: 100.ms).fadeIn().moveX(begin: 100),
    );
  }

  void _scaleDialog(index, jobData) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeIn.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: CandidateSection(
            index: index,
            jobData: jobData,
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }
}
