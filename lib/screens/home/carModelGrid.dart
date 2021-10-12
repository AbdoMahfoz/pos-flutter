import 'package:flutter/material.dart';

class CarModelGrid extends StatelessWidget {
  final void Function(int) onItemClicked;

  const CarModelGrid({
    Key? key,
    required this.onItemClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 5,
                        color: Colors.grey[400]!,
                        offset: Offset(0, 5))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => this.onItemClicked(index),
                  child: Center(
                      child: Icon(
                        Icons.car_rental,
                        size: 75,
                      )),
                ),
              ),
            ),
          ),
        ));
  }
}