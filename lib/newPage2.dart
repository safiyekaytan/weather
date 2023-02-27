import 'package:flutter/material.dart';

class newPage2 extends StatefulWidget {
  //  newPage2(a,b,c,d,e,f,g,h, {super.key});
  var a, b, c, d, e, f, g, h, i;
  newPage2(
      this.a, this.b, this.c, this.d, this.e, this.f, this.g, this.h, this.i);
  @override
  State<newPage2> createState() => _newPage2State();
}

class _newPage2State extends State<newPage2> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;
    String windKm = (((widget.i) * 18) / 5).toString();
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              child: SizedBox(
                  height: deviceHeight,
                  width: deviceWidth,
                  child: Image.asset("images/mavi.jpg")),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      Text("${widget.b.toString()}° ",
                          style: const TextStyle(
                              fontSize: 50,
                              fontFamily: "PlayfairDisplay",
                              color: Colors.white)),
                      Text(widget.a.toString(),
                          style: const TextStyle(
                              fontSize: 50,
                              fontFamily: "PlayfairDisplay",
                              color: Colors.white)),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 420,
                        child: Card(
                          color: const Color.fromARGB(180, 255, 255, 255),
                          child: Text(
                            widget.c.toString(),
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: SizedBox(
                    height: 403,
                    width: 400,
                    child: GridView.count(
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      children: [
                        Container(
                          color: const Color.fromARGB(180, 214, 216, 223),
                          child: Column(
                            children: [
                              const Text("Hissedilen Sıcaklık",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              Text(widget.e.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 34, 53, 70),
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(180, 214, 216, 223),
                          child: Column(
                            children: [
                              const Text("Ülke",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              Text(widget.d.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(180, 34, 53, 70),
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(180, 214, 216, 223),
                          child: Column(
                            children: [
                              const Text("Minimum Sıcaklık",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              Text(widget.f.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 34, 53, 70),
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(180, 214, 216, 223),
                          child: Column(
                            children: [
                              const Text("Maximum Sıcaklık",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              Text(widget.g.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 34, 53, 70),
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(180, 214, 216, 223),
                          child: Column(
                            children: [
                              const Text("Nem",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              Text(widget.h.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 34, 53, 70),
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(180, 214, 216, 223),
                          child: Column(
                            children: [
                              const Text("Rüzgar Hızı",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("${windKm} km/h",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 34, 53, 70),
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
