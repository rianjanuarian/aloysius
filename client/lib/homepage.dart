// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:pos/ThermalPage.dart';

import 'package:starxpand/starxpand.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // void openCashRegister(BuildContext context) async {
  //   try {
  //     final bluetooth = FlutterBlue.instance;

  //     if (!await bluetooth.isAvailable) {
  //       showSnackbar(context, "Bluetooth tidak tersedia.");
  //       return;
  //     }

  //     if (!await bluetooth.isOn) {
  //       showSnackbar(context,
  //           "Bluetooth tidak diaktifkan. Aktifkan bluetooth terlebih dahulu dan hubungkan printer");
  //       return;
  //     }
  //     final printers = await StarXpand.findPrinters(
  //       interfaces: const [
  //         StarXpandInterface.usb,
  //         StarXpandInterface.bluetooth,
  //         StarXpandInterface.bluetoothLE,
  //         StarXpandInterface.lan
  //       ],
  //       timeout: 3000,
  //       callback: (foundPrinter) {
  //         showSnackbar(context, "Printer ditemukan: $foundPrinter");
  //       },
  //     );

  //     if (printers.isEmpty) {
  //       showSnackbar(context, "Tidak ada printer yang ditemukan.");
  //       return;
  //     }

  //     final selectedPrinter = printers[0];

  //     await StarXpand.openDrawer(selectedPrinter);

  //     showSnackbar(context, "Cash register berhasil dibuka.");
  //   } catch (e) {
  //     showSnackbar(context, "Error: $e");
  //   }
  // }

  // void printStruk(BuildContext context) async {
  //   try {
  //     final bluetooth = FlutterBlue.instance;

  //     if (!await bluetooth.isAvailable) {
  //       showSnackbar(context, "Bluetooth tidak tersedia.");
  //       return;
  //     }

  //     if (!await bluetooth.isOn) {
  //       showSnackbar(context,
  //           "Bluetooth tidak diaktifkan. Aktifkan bluetooth terlebih dahulu dan hubungkan printer");
  //       return;
  //     }

  //     final printers = await StarXpand.findPrinters(
  //       interfaces: const [
  //         StarXpandInterface.usb,
  //         StarXpandInterface.bluetooth,
  //         StarXpandInterface.bluetoothLE,
  //         StarXpandInterface.lan
  //       ],
  //       timeout: 3000,
  //       callback: (foundPrinter) {
  //         showSnackbar(context, "Printer ditemukan: $foundPrinter");
  //       },
  //     );

  //     if (printers.isEmpty) {
  //       showSnackbar(context, "Tidak ada printer yang ditemukan.");
  //       return;
  //     }

  //     final selectedPrinter = printers[0];

  //     final doc = StarXpandDocument();

  //     final printDoc = StarXpandDocumentPrint();
  //     printDoc.actionPrintText("Toko Bangunan\n");
  //     printDoc.actionPrintText("Jl. Bungur No. 123\n");
  //     printDoc.actionPrintText("---------------------------\n");
  //     printDoc.actionPrintText("Keramik\t\t\$5.00\n");
  //     printDoc.actionPrintText("Pasir\t\t\$15.00\n");
  //     printDoc.actionPrintText("---------------------------\n");
  //     printDoc.actionPrintText("Total:\t\t\$20.00\n");

  //     doc.addPrint(printDoc);
  //     await StarXpand.printDocument(selectedPrinter, doc);

  //     showSnackbar(context, "Struk berhasil dicetak.");
  //   } catch (e) {
  //     showSnackbar(context, "Error: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "POS",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  //     printStruk(context);
                },
                child: const Text("Print Struk")),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  //  openCashRegister(context);
                },
                child: const Text("Buka Cash Register")),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ThermalPage(),
                    ),
                  );
                },
                child: const Text("Thermal Printer Page"))
          ],
        ),
      ),
    );
  }
}
