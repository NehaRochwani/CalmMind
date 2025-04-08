import 'package:flutter/material.dart';
import 'blog_screen.dart'; // Import BlogScreen

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Insights")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildBlogButton(
              context,
              "Mental Health",
              "assets/images/mental_health.jpg",
              "**Mental Health: The Foundation of Well-Being** Mental health is the cornerstone of a fulfilling life, encompassing our emotional, psychological, and social well-being. It influences how we handle stress, relate to others, and make choices. Prioritizing mental health is not a sign of weakness but a testament to self-awareness. Regular self-care, including exercise, balanced nutrition, and sufficient sleep, supports mental resilience. Seeking professional help is crucial when facing challenges, ensuring long-term mental stability. Creating a supportive environment fosters open conversations about mental health, reducing stigma and promoting understanding. Building healthy relationships and practicing mindfulness further contribute to overall mental wellness. **Watch the video below for more insights.**",
              "assets/videos/mental_health.mp4",
            ),
            buildBlogButton(
              context,
              "Depression",
              "assets/images/depression.jpg",
              "**Depression: Understanding the Silent Struggle** Depression is a common yet severe mood disorder that negatively affects how you feel, the way you think, and how you act. It causes feelings of sadness and a loss of interest in activities once enjoyed. Beyond sadness, it can lead to physical symptoms like fatigue and changes in sleep or appetite. Recognizing depression is the first step towards recovery. Treatment often involves therapy, medication, or a combination. Building a support system is vital; talking to friends, family, or support groups can provide comfort. Lifestyle changes, such as regular exercise and a balanced diet, can also alleviate symptoms. With proper care, individuals can manage depression and regain a sense of normalcy. **Watch the video below for more insights.**",
              "assets/videos/depression.mp4",
            ),
            buildBlogButton(
              context,
              "Anger",
              "assets/images/anger.jpg",
              "Anger is a natural human emotion, but its uncontrolled expression can be destructive. Understanding triggers is crucial for managing anger effectively. Techniques like deep breathing, meditation, and physical exercise can help calm the mind and body. Expressing anger constructively involves using 'I' statements to communicate feelings without blaming others. Setting boundaries and practicing assertiveness prevent resentment from building. Seeking professional help can provide strategies for long-term anger management. Healthy coping mechanisms, such as journaling or engaging in hobbies, offer outlets for emotional release. Developing empathy and practicing patience further enhance emotional control, fostering healthier relationships and personal well-being. **Watch the video below for more insights.**",
              "assets/videos/anger.mp4",
            ),
            buildBlogButton(
              context,
              "Emotional Intelligence",
              "assets/images/emotional_intelligence.jpg",
              "Emotional intelligence (EQ) is the ability to recognize, understand, and manage our own emotions and those of others. It enhances communication and strengthens relationships. Self-awareness, the foundation of EQ, involves recognizing one's emotions and their impact. Self-regulation allows for controlling disruptive impulses and adapting to change. Motivation, another key component, drives achievement and commitment. Empathy, the ability to understand others' feelings, fosters trust and collaboration. Social skills, like building rapport and managing relationships, are essential for effective teamwork. Developing EQ requires practice and self-reflection. It leads to better decision-making, reduced stress, and improved overall well-being. **Watch the video below for more insights.**",
              "assets/videos/Emotional_Intelligence.mp4",
            ),
            buildBlogButton(
              context,
              "Sleep Habits",
              "assets/images/sleep_habits.jpg",
              "Quality sleep is vital for both physical and mental health. Establishing consistent sleep habits can significantly improve overall well-being. A regular sleep schedule, even on weekends, helps regulate the body's natural sleep-wake cycle. Creating a relaxing bedtime routine, such as reading or taking a warm bath, prepares the mind for sleep. Optimizing the sleep environment by keeping it dark, quiet, and cool enhances sleep quality. Avoiding caffeine and alcohol before bed is essential for uninterrupted sleep. Regular physical activity during the day promotes better sleep at night. Prioritizing sleep leads to improved mood, increased energy levels, and enhanced cognitive function. **Watch the video below for more insights.**",
              "assets/videos/sleep_habits.mp4",
            ),
            buildBlogButton(
              context,
              "Self Disclosure",
              "assets/images/self_disclosure.jpg",
              "Self-disclosure, the act of revealing personal information to others, plays a crucial role in building trust and intimacy. It fosters deeper connections and mutual understanding. However, it requires careful consideration and balance. Sharing too much too soon can overwhelm others, while sharing too little can hinder connection. Choosing the right context and timing is essential. Practicing vulnerability and authenticity encourages reciprocal disclosure. Setting boundaries ensures personal comfort and safety. Reflecting on the impact of shared information helps maintain healthy relationships. Self-disclosure strengthens bonds by creating a sense of shared experience and mutual respect, enhancing overall relationship quality. **Watch the video below for more insights.**",
              "assets/videos/Self_Disclosure_ Explained.mp4",
            ),
            buildBlogButton(
              context,
              "Social Anxiety",
              "assets/images/social_anxiety.jpg",
              "Social anxiety disorder is characterized by an intense fear of social situations, leading to avoidance and distress. It impacts daily life, affecting relationships and work performance. Understanding the root causes, such as past experiences or genetics, is crucial for management. Cognitive-behavioral therapy (CBT) helps individuals challenge negative thoughts and develop coping strategies. Gradual exposure to feared situations reduces anxiety over time. Practicing relaxation techniques, like deep breathing and mindfulness, calms the body and mind. Building a support network provides emotional comfort and encouragement. Self-compassion and patience are vital for overcoming social anxiety. With proper treatment and support, individuals can lead fulfilling social lives. **Watch the video below for more insights.**",
              "assets/videos/Social_Anxiety_Disorder.mp4",
            ),
            buildBlogButton(
              context,
              "Emotional Stability",
              "assets/images/emotional_stability.jpg",
              "Emotional stability is the ability to remain calm and composed in the face of stress or adversity. It fosters resilience and enhances overall well-being. Developing emotional stability involves practicing self-awareness and self-regulation. Recognizing emotional triggers and responding constructively prevents impulsive reactions. Mindfulness and meditation techniques help cultivate inner peace. Building a strong support system provides emotional security during challenging times. Practicing gratitude and focusing on positive aspects enhances emotional balance. Engaging in hobbies and activities that bring joy promotes emotional well-being. Emotional stability leads to healthier relationships, improved decision-making, and a greater sense of control over life. **Watch the video below for more insights.**",
              "assets/videos/emotional_stabilty.mp4",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlogButton(BuildContext context, String title, String imagePath, String content, String videoPath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogScreen(
              blogTitle: title,
              imagePath: imagePath,
              content: content,
              videoPath: videoPath,
              showControls: true, // Only pass showControls
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2)],
        ),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}