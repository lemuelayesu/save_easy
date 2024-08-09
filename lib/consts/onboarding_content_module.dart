class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent(
      {required this.image, required this.title, required this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: "Save Money",
    image: "assets/illustrations/Currency Crush Mobile Money.png",
    discription:
        "Start building your financial future with small, consistent steps.",
  ),
  OnboardingContent(
    title: "Track Savings",
    image: "assets/illustrations/Currency Crush Graphs.png",
    discription:
        "Stay on top of your savings journey with clear progress tracking.",
  ),
  OnboardingContent(
    title: "Safe and Secure",
    image: "assets/illustrations/Currency Crush Password.png",
    discription:
        "Your savings are safe and secure, so you can focus on achieving your goals.",
  ),
];
