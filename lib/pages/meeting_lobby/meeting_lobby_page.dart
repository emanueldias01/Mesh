import 'package:flutter/material.dart';
import 'package:mesh/pages/room/room_page_arguments.dart';
import 'package:mesh/pages/meeting_lobby/meeting_lobby_page_viewmodel.dart';
import 'package:mesh/ui/colors.dart';
import 'package:mesh/ui/text_styles.dart';
import 'package:mesh/widgets/address.dart';
import 'package:mesh/widgets/principal_button.dart';
import 'package:mesh/widgets/secondary_button.dart';

class MeetingLobbyPage extends StatefulWidget {
  const MeetingLobbyPage({super.key});

  @override
  State<MeetingLobbyPage> createState() => _MeetingLobbyPageState();
}

class _MeetingLobbyPageState extends State<MeetingLobbyPage> {

  final viewmodel = MeetingLobbyPageViewmodel();

  @override
  void initState() {
    super.initState();
    viewmodel.addListener(() {
      setState(() {});
    });

  }
  
  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (viewmodel.addressSignalServer.text.isNotEmpty)
                          Address(address: viewmodel.addressSignalServer.text)
                        else
                          Text(
                            "Add Server signal address",
                            style: AppTextStyles.mediumText.copyWith(fontSize: 16)
                          ),
                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SecondaryButton(text: "Add Address", icon: Icons.add, onTap: () {}),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 800;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32 : 24,
                    vertical: 24,
                  ),
                  child: ListView(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: isDesktop ? 140 : 100,
                      ),

                      const SizedBox(height: 24),

                      Text(
                        "Meeting Lobby",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bigText,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Create a new room or join an existing one.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.mediumText.copyWith(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text(
                        "Personal ID",
                        style: AppTextStyles.mediumText,
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: viewmodel.callerIdController,
                        decoration: InputDecoration(
                          hintText: "Your caller ID",
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Meeting ID",
                        style: AppTextStyles.mediumText,
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: viewmodel.roomCodeController,
                        decoration: InputDecoration(
                          hintText: "Enter meeting code",
                          filled: true,
                          fillColor: AppColors.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: PrincipalButton(
                          text: "Join a Meeting",
                          onTap: () async {
                            final foundMeeting =
                                await viewmodel.joinRoom();

                            if (foundMeeting) {
                              Navigator.pushNamed(
                                context,
                                "/room",
                                arguments: RoomPageArguments(
                                  roomId:
                                      viewmodel.roomCodeController.text,
                                  userId:
                                      viewmodel.callerIdController.text,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    viewmodel.errorMessage,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      if (viewmodel.isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              "OR",
                              style: AppTextStyles.mediumText,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      SecondaryButton(
                        text: "Create Room",
                        icon: Icons.video_call,
                        onTap: () async {
                          final createRoom = await viewmodel.createRoom();

                          if (createRoom) {
                            Navigator.pushNamed(
                              context,
                              "/room",
                              arguments: RoomPageArguments(
                                roomId: viewmodel.roomCodeController.text,
                                userId: viewmodel.callerIdController.text,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed to create room"),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}