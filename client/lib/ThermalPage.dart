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
                    //size
                    //0: normal
                    //1: normal - bold
                    //2: medium - bold
                    //3: large - bold
                    //align
                    //0: left
                    //1: center
                    //2: right
                    printer.printCustom("INVOICE", 1, 1);
                    printer.printNewLine();
                    printer.printCustom("Payment Due 24 Januari 2025}", 0, 1);
                    printer.printNewLine();
                    printer.printCustom("Invoice Number\tINV123", 0, 0);
                    printer.printCustom("Customer\t\tBudi", 0, 0);
                    printer.printCustom("Order Id\t\tORDER123", 0, 0);
                    printer.printCustom("Collected by\tAdmin raisa", 0, 0);

                    printer.printCustom("---------------------------", 0, 1);
                    printer.printCustom("*Moms Recipe*", 1, 1);
                    printer.printCustom("Alamat : jl papango", 0, 0);
                    printer.printCustom("Jam Pengambilan : 11:17", 0, 0);
                    printer.printCustom("Alamat : Sunter mediterania", 0, 0);
                    printer.printCustom("Nama Penerima : Frans", 0, 0);
                    printer.printCustom(
                        "No Telp Penerima : +628871346754", 0, 0);
                    printer.printNewLine();
                    printer.printCustom("1x Boba Milk\t\Rp.5.000", 1, 1);

                    printer.printCustom("1x Fla\t\t Rp.500", 0, 0);

                    printer.printCustom("1x Kopi\t\tRp.15.000", 1, 1);
                    printer.printCustom("---------------------------", 0, 1);
                    printer.printCustom("SubTotal:\t\tRp.20.500", 0, 1);
                    printer.printCustom("---------------------------", 0, 1);
                    printer.printCustom("Total:\t\tRp.20.500", 0, 1);
                    printer.printCustom("---------------------------", 0, 1);
                    printer.printCustom("Invoice:\t\tRp.20.500", 0, 1);
                    printer.printCustom("---------------------------", 0, 1);
                    printer.printCustom("@ momsrecipe12", 0, 0);
                    printer.printNewLine();
                    printer.printCustom("---------------------------", 0, 1);
                    printer.printNewLine();
                    printer.printCustom(
                        "Sedia Pudding Tart | Snack Box | Aneka Kue | Kue Mampan | Roti Goreng",
                        0,
                        1);
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
