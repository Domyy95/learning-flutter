import 'package:flutter/material.dart';

const kHintStyle = TextStyle(
  fontSize: 13,
  letterSpacing: 1.2,
);

// border

var kOutlikeBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(color: Colors.transparent),
);

var kOutlineErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(color: Colors.redAccent),
);

const kLoaderBtn = SizedBox(
  height: 20,
  width: 20,
  child: CircularProgressIndicator(
    strokeWidth: 1.5,
    valueColor: AlwaysStoppedAnimation(Colors.white),
  ),
);

const kHeadingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
