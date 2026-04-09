import 'package:flutter/material.dart';

enum FilterItemType { list, button }

class FilterItem {
  String id;
  String name;
  int isSelected;
  List<FilterItem> subitems;

  FilterItem({
    required this.id,
    required this.name,
    this.isSelected = 0,
    this.subitems = const [],
  });
}

class FilterGroup {
  String name;
  bool multiSelect;
  FilterItemType type;
  List<FilterItem> items;

  FilterGroup({
    required this.name,
    this.multiSelect = false,
    this.type = FilterItemType.list,
    required this.items,
  });
}

class FilterList extends StatefulWidget {
  const FilterList({super.key});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> with TickerProviderStateMixin {
  List<FilterGroup> filterGroups = [];
  int activeGroudIndex = -1;
  bool isShow = false;
  bool showMask = false;

  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 400,
    ).animate(_animationController!);

    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        isShow = false;
        setState(() {});
      }
    });
    _intitData();
  }

  void _intitData() {
    filterGroups = [
      FilterGroup(
        name: '全城',
        items: [
          FilterItem(id: '1', name: '全部', isSelected: 0),
          FilterItem(id: '2', name: 'Fruits', isSelected: 0),
          FilterItem(id: '3', name: 'Vegetables', isSelected: 0),
        ],
      ),
      FilterGroup(
        name: '品牌',
        multiSelect: true,
        items: [
          FilterItem(id: '1', name: '全部', isSelected: 0),
          FilterItem(id: '2', name: '华为', isSelected: 0),
          FilterItem(id: '3', name: '小米', isSelected: 0),
          FilterItem(id: '4', name: 'OPPO', isSelected: 0),
          FilterItem(id: '5', name: 'Vivo', isSelected: 0),
        ],
      ),
      FilterGroup(
        name: '排序',
        items: [
          FilterItem(id: '1', name: '距离近', isSelected: 0),
          FilterItem(id: '2', name: '价格高', isSelected: 0),
          FilterItem(id: '3', name: '价格低', isSelected: 0),
        ],
      ),
      FilterGroup(
        name: '筛选',
        multiSelect: true,
        items: [
          FilterItem(id: '1', name: '全部', isSelected: 0),
          FilterItem(id: '2', name: '品牌', isSelected: 0),
          FilterItem(id: '3', name: '价格', isSelected: 0),
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 40,
                color: Colors.grey[200],
                child: Row(
                  children: filterGroups
                      .map(
                        (group) => _buildDropdownHeader(
                          group,
                          filterGroups.indexOf(group),
                        ),
                      )
                      .toList(),
                ),
              ),
              _buildList(),
            ],
          ),
          // _buildMask(),
          _buildDropdownPanel(),
        ],
      ),
    );
  }

  Widget _buildDropdownHeader(FilterGroup group, int index) {
    bool isCurrent = activeGroudIndex == index && isShow;
    final Color fontColor = isCurrent ? Colors.blue : Colors.black;
    final IconData arrowIcon = isCurrent
        ? Icons.arrow_drop_up
        : Icons.arrow_drop_down;

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isCurrent) {
              _animationController!.reverse();
            } else {
              if (isShow) {
                _animationController!.value = 0;
              }
              activeGroudIndex = index;
              isShow = true;
              _animationController!.forward();
            }
          });
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    group.name,
                    style: TextStyle(fontSize: 16, color: fontColor),
                  ),
                  Icon(arrowIcon, color: fontColor),
                ],
              ),
            ),
            Container(width: 1, height: 25, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownPanel() {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Positioned(
          top: 40,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              Container(
                height: _animation != null ? _animation!.value : 0,
                color: Colors.white,
              ),
              _buildMask(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMask() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShow = false;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black38,
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
    );
  }

  _open() {}

  _hide() {}
}
