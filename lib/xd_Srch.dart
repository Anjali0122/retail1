import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class xd_Srch extends StatelessWidget {
  xd_Srch({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 298.5),
            child: Container(
              width: 412.0,
              height: 371.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(73.0),
                color: const Color(0xff0d82e8),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(90.4, 272.8),
            child: Container(
              width: 224.0,
              height: 98.0,
              decoration: BoxDecoration(
                color: const Color(0x00ffffff),
                border: Border.all(width: 1.0, color: const Color(0x00707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 398.9),
            child: Container(
              width: 262.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xffbce0fd)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 398.9),
            child: Container(
              width: 105.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xff2699fb),
                border: Border.all(width: 1.0, color: const Color(0xff2699fb)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 421.5),
            child: Text(
              'PRODUCT NAME',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 10,
                color: const Color(0xff0d0000),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(162.8, 417.4),
            child: Text(
              'John Doe',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: const Color(0xff01060a),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 476.9),
            child: SvgPicture.string(
              _svg_sd12o8,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 476.9),
            child: Container(
              width: 106.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xff2699fb),
                border: Border.all(width: 1.0, color: const Color(0x2b2699fb)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(25.0, 496.5),
            child: Text(
              'NET WEIGHT',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 10,
                color: const Color(0xff0f0202),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(162.8, 494.5),
            child: Text(
              'John Doe',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: const Color(0xff020d16),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 553.6),
            child: SvgPicture.string(
              _svg_dkb2rz,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 553.7),
            child: Container(
              width: 105.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xff2699fb),
                border: Border.all(width: 1.0, color: const Color(0x782699fb)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(41.0, 572.8),
            child: Text(
              'PRICE',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 10,
                color: const Color(0xff070000),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(162.8, 569.9),
            child: Text(
              'John Doe',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: const Color(0xff020910),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(92.9, 631.4),
            child: SvgPicture.string(
              _svg_anv1s8,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(110.5, 582.4),
            child:
                // Adobe XD layer: 'shopping_cart-24px' (group)
                SizedBox(
              width: 104.0,
              height: 86.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(80.0, 0.0, 24.0, 24.0),
                    size: Size(104.0, 86.1),
                    pinRight: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: SvgPicture.string(
                      _svg_c5ribp,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 56.0, 31.5, 30.1),
                    size: Size(104.0, 86.1),
                    pinLeft: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: SvgPicture.string(
                      _svg_t06ttx,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(168.6, 645.2),
            child: Text(
              'Add To Cart',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 20,
                color: const Color(0xff00060c),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_sd12o8 =
    '<svg viewBox="4.0 476.9 262.0 50.0" ><path transform="translate(4.0, 476.89)" d="M 0 0 L 262 0 L 262 50 L 0 50 L 0 0 Z" fill="#ffffff" stroke="#bce0fd" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dkb2rz =
    '<svg viewBox="4.0 553.6 262.0 50.0" ><path transform="translate(4.0, 553.63)" d="M 0 0 L 262 0 L 262 50 L 0 50 L 0 0 Z" fill="#ffffff" stroke="#bce0fd" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_c5ribp =
    '<svg viewBox="80.0 0.0 24.0 24.0" ><path transform="translate(80.0, 0.0)" d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_t06ttx =
    '<svg viewBox="0.0 56.0 31.5 30.1" ><path transform="translate(-1.0, 54.0)" d="M 10.44913959503174 26.04838943481445 C 8.716797828674316 26.04838943481445 7.315175533294678 27.4011116027832 7.315175533294678 29.0544376373291 C 7.315175533294678 30.70776557922363 8.716797828674316 32.06048583984375 10.44913959503174 32.06048583984375 C 12.18148231506348 32.06048583984375 13.59885311126709 30.70776557922363 13.59885311126709 29.0544376373291 C 13.59885311126709 27.4011116027832 12.18148231506348 26.04838943481445 10.44913959503174 26.04838943481445 Z M 0.9999998807907104 2 L 0.9999998807907104 5.006049156188965 L 4.149713516235352 5.006049156188965 L 9.819196701049805 16.41400337219238 L 7.693141460418701 20.09641075134277 C 7.441164016723633 20.51725769042969 7.299427509307861 21.01325798034668 7.299427509307861 21.53931617736816 C 7.299427509307861 23.1926441192627 8.716797828674316 24.54536437988281 10.44913959503174 24.54536437988281 L 29.34741401672363 24.54536437988281 L 29.34741401672363 21.53931617736816 L 11.11058044433594 21.53931617736816 C 10.89009952545166 21.53931617736816 10.71686553955078 21.37398338317871 10.71686553955078 21.16356086730957 L 10.76411151885986 20.98319625854492 L 12.18148231506348 18.53326797485352 L 23.91416168212891 18.53326797485352 C 25.09530448913574 18.53326797485352 26.13471221923828 17.91702651977539 26.6701602935791 16.98515319824219 L 32.30815124511719 7.230525016784668 C 32.43413543701172 7.020102024078369 32.49713134765625 6.76458740234375 32.49713134765625 6.509073734283447 C 32.49713134765625 5.68241024017334 31.78844451904297 5.006049633026123 30.92227363586426 5.006049633026123 L 7.630146980285645 5.006049633026123 L 6.149781703948975 2.000000953674316 L 0.9999998807907104 2.000000953674316 Z M 26.19770431518555 26.04838943481445 C 24.46536064147949 26.04838943481445 23.06373977661133 27.4011116027832 23.06373977661133 29.0544376373291 C 23.06373977661133 30.70776557922363 24.46536254882812 32.06048583984375 26.19770431518555 32.06048583984375 C 27.9300422668457 32.06048583984375 29.34741401672363 30.70776557922363 29.34741401672363 29.0544376373291 C 29.34741401672363 27.4011116027832 27.93004608154297 26.04838943481445 26.19770431518555 26.04838943481445 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_anv1s8 =
    '<svg viewBox="92.9 631.4 212.5 54.9" ><path transform="translate(92.9, 631.4)" d="M 27.24042892456055 0 L 185.2349090576172 0 C 200.2793884277344 0 212.4753570556641 12.30002212524414 212.4753570556641 27.47286987304688 C 212.4753570556641 42.64571762084961 200.2793884277344 54.94573974609375 185.2349090576172 54.94573974609375 L 27.24042892456055 54.94573974609375 C 12.19595527648926 54.94573974609375 0 42.64571762084961 0 27.47286987304688 C 0 12.30002212524414 12.19595527648926 0 27.24042892456055 0 Z" fill="#2699fb" stroke="#4f227d" stroke-width="1" stroke-opacity="0.09" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
