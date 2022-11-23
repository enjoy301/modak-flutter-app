import 'package:flutter/material.dart';
import 'package:modak_flutter_app/widgets/album/album_chip_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:provider/provider.dart';

import '../../constant/coloring.dart';
import '../../constant/font.dart';
import '../../provider/album_provider.dart';
import '../../ui/common/common_medias_screen.dart';
import '../../utils/easy_style.dart';

class AlbumThemeWidget extends StatefulWidget {
  const AlbumThemeWidget({Key? key}) : super(key: key);

  @override
  State<AlbumThemeWidget> createState() => _AlbumThemeWidgetState();
}

class _AlbumThemeWidgetState extends State<AlbumThemeWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumProvider>().addThemeScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List<Widget>.from(
                    provider.labelDataList.asMap().entries.map(
                          (entry) => GestureDetector(
                            onTap: () async {
                              provider.setSelectedLabel(entry.key);
                              provider.initLabelView(entry.value['label']);
                            },
                            child: AlbumChipWidget(
                              title: entry.value['label'],
                              isSelected: entry.key == provider.selectedLabel,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ),
            if (provider.isLabelLoading) ...[
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ] else ...[
              Expanded(
                child: Column(
                  children: [
                    if (provider.labelDataList.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: ScalableTextWidget(
                          "아직 인식된 테마가 없습니다",
                          style: EasyStyle.text(
                            Coloring.gray_20,
                            Font.size_mediumText,
                            Font.weight_medium,
                          ),
                        ),
                      ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          String label = provider
                              .labelDataList[provider.selectedLabel]['label'];
                          provider.initLabelView(label);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: GridView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: provider.themeScrollController,
                            shrinkWrap: true,
                            itemCount: provider.labelDetailFileList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder:
                                (BuildContext context, int labelIndex) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  1,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CommonMediasScreen(
                                          files: provider.labelDetailFileList,
                                          initialIndex: labelIndex,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.file(
                                    provider.labelDetailFileList[labelIndex],
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                    gaplessPlayback: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
