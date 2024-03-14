import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class ThermalPage extends StatefulWidget {
  const ThermalPage({super.key});

  @override
  State<ThermalPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ThermalPage> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevices;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDevices();
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
    setState(() {});
  }

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
            DropdownButton<BluetoothDevice>(
              items: devices
                  .map((e) => DropdownMenuItem(
                        child: Text(e.name!),
                        value: e,
                      ))
                  .toList(),
              onChanged: (device) {
                setState(() {
                  selectedDevices = device;
                });
              },
              value: selectedDevices,
              hint: const Text("Pilih thermal printer"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  printer.connect(selectedDevices!);
                },
                child: const Text("Connect")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  printer.disconnect();
                },
                child: const Text("Disconnect")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if ((await printer.isConnected)!) {
                    printer.printNewLine();
                    printer.printCustom("Toko Galang Bangunan", 0, 1);
                    printer.printQRcode("TEST QR", 200, 200, 1);
                    printer.printCustom("Jl. Bungur No. 123", 0, 1);
                    printer.printCustom("---------------------------", 0, 1);
                    printer.printCustom("Keramik\t\t\$5.00", 0, 1);
                    printer.printCustom("Pasir\t\t\$15.00\n", 0, 1);
                    printer.printCustom("Total:\t\t\$20.00\n", 0, 1);
                    printer.printNewLine();
                  }
                },
                child: const Text("Print thermal printer")),
          ],
        ),
      ),
    );
  }
}
