class Gloals {
  static String Cin = "";
  static printInteger() {
    print(Cin);
  }

  static changeCin(String a) {
    Cin = a;
    printInteger(); // this can be replaced with any static method
  }
}
