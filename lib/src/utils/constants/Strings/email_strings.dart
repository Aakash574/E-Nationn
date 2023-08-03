import 'package:enationn/src/presentation/provider/user_provider.dart';

class Emails {
  static String singupEmails(UserProvider userProvider) {
    return """
Dear ${userProvider.fullName}\n\n
    
Welcome to eNationn! We're thrilled to have you as a registered student. Get
ready to explore a world of endless opportunities in your educational journey with
us.\n\n

At eNationn, we believe in providing holistic learning experiences. In addition to
our diverse course offerings, we offer a range of exciting opportunities to
enhance your skills and propel your career forward. Here's what you can look
forward to:\n\n

      ●     Internship Programs: Gain valuable real-world experience through our
              internship programs. We partner with leading companies to offer
              internships that align with your interests and career aspirations.\n
      ●     Hackathons: Put your problem-solving skills to the test by participating in
              our exhilarating hackathons. Collaborate with like-minded individuals,
              unleash your creativity, and showcase your innovative solutions.\n
      ●     Events and Workshops: Attend our dynamic events and workshops
              conducted by industry experts. Stay updated with the latest trends, learn
              new techniques, and expand your professional network.\n
      ●     Job Opportunities: Our extensive network of partner organizations
              provides exclusive job opportunities for eNationn students. Take
              advantage of our connections to jumpstart your career and land your
              dream job.\n\n

We're committed to supporting your growth and success. Should you have any
questions, require guidance, or need assistance in exploring these opportunities,
our dedicated support team is here to help.\n\n

Thank you for choosing eNationn as your preferred learning platform. We're
excited to see you thrive academically and professionally. Let's unlock a world of
opportunities together!\n\n

Best regards, Enationn Team""";
  }
}
