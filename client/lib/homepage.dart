import 'package:flutter/material.dart';
import 'package:starxpand/starxpand.dart';


class HomePage extends StatelessWidget {
     final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  HomePage({super.key});

  // Method untuk menampilkan Snackbar
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Method untuk membuka cash register
  void openCashRegister(BuildContext context) async {
    try {
      // Temukan printer
      final printers = await StarXpand.findPrinters(
        interfaces: const [
          StarXpandInterface.usb,
          StarXpandInterface.bluetooth,
          StarXpandInterface.bluetoothLE,
          StarXpandInterface.lan
        ],
        timeout: 3000,
        callback: (foundPrinter) {
          // Callback ketika printer ditemukan
             showSnackbar(context, "Printer ditemukan: $foundPrinter");
        },
      );

      // Pastikan ada printer yang ditemukan
      if (printers.isEmpty) {
        showSnackbar(context,"Tidak ada printer yang ditemukan.");
        return;
      }

      // Pilih printer pertama yang ditemukan
      final selectedPrinter = printers[0];

      // Buka cash register
      await StarXpand.openDrawer(selectedPrinter);

      showSnackbar(context,"Cash register berhasil dibuka.");
    } catch (e) {
      // Tangani kesalahan jika terjadi
      showSnackbar(context,"Error: $e");
    }
  }

  // Method untuk mencetak struk
  void printStruk(BuildContext context) async {
    try {
      // Temukan printer
      final printers = await StarXpand.findPrinters(
        interfaces: const [
          StarXpandInterface.usb,
          StarXpandInterface.bluetooth,
          StarXpandInterface.bluetoothLE,
          StarXpandInterface.lan
        ],
        timeout: 3000,
        callback: (foundPrinter) {
          // Callback ketika printer ditemukan
             showSnackbar(context, "Printer ditemukan: $foundPrinter");
        },
      );

      // Pastikan ada printer yang ditemukan
      if (printers.isEmpty) {
        showSnackbar(context,"Tidak ada printer yang ditemukan.");
        return;
      }

      // Pilih printer pertama yang ditemukan
      final selectedPrinter = printers[0];

      // Buat dokumen struk
      final doc = StarXpandDocument();

      final printDoc = StarXpandDocumentPrint();
      printDoc.actionPrintText("Toko Bangunan\n");
      printDoc.actionPrintText("Jl. Bungur No. 123\n");
      printDoc.actionPrintText("---------------------------\n");
      printDoc.actionPrintText("Keramik\t\t\$5.00\n");
      printDoc.actionPrintText("Pasir\t\t\$15.00\n");
      printDoc.actionPrintText("---------------------------\n");
      printDoc.actionPrintText("Total:\t\t\$20.00\n");

      // Cetak struk
      await StarXpand.printDocument(selectedPrinter, doc);

      showSnackbar(context,"Struk berhasil dicetak.");
    } catch (e) {
      // Tangani kesalahan jika terjadi
      showSnackbar(context,"Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return 
   
   Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("POS"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                printStruk(context);
              }, child: Text("print")),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () { openCashRegister(context);}, child: Text("open cash register"))
            ],
          ),
        ),
      
    );
  }
  
}
