import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hoteladmin/src/models/order.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/pages/admin/list/listhotel_controller.dart';
import 'package:hoteladmin/src/utils/my_colors.dart';
import 'package:hoteladmin/src/widgets/no_data_widget.dart';



class ListaHotelPage extends StatefulWidget {
  const ListaHotelPage({Key key}) : super(key: key);

  @override
  State<ListaHotelPage> createState() => _ListaHotelPageState();
}

class _ListaHotelPageState extends State<ListaHotelPage> {
  ListHotelController _con = new ListHotelController();
  //final RestaurantOrdersListController _con = RestaurantOrdersListController();

  //Address get address => null;

  Order order;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(title: Text('Lista de Hoteles'),),
        drawer: _drawer(),
        body: _con.listHOTEL.isNotEmpty
          ? ListView(
              children: _con.listHOTEL.map((Product user) {
             return Card(
               elevation: 0,
               color: Colors.grey[200],
               child: ListTile(
                
                title: Text( user.name ?? '',),
                //subtitle: Text(user.price ?? ''),
                trailing: 
                Container(
                  //color: Colors.red,
                  width: 100,
                  child: Row(children: [
                            Container(
                  child: IconButton(
                      onPressed: () {
                        _con.editar(user);
                      // _con.deleteItem(id);
                        print('eliminaddo.......... $user');
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      )),
                ),
                   // botonEditar(user.id),
                  botonDelete(user.id),
                  ],),
                )
            ),
             );
            }).toList())
          : const Center(
            child: NoDataWidget(),
          ),
        
    
    );
   
  
  }


Widget botonEditar(Product id) {
    return Container(
      child: IconButton(
          onPressed: () {
            _con.editar(id);
           // _con.deleteItem(id);
            print('eliminaddo.......... $id');
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.blue,
          )),
    );
  }
Widget botonDelete(String id) {
    return Container(
      child: IconButton(
          onPressed: () {
            _con.deleteItem(id);
            print('eliminaddo.......... $id');
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }


  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () {
       // _con.openBottomSheet(order);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 155,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      color: MyColors.primarycolor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                          'Orden #${order.id}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'NimbusSans'
                        ),
                      ),
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Cliente: ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}',
                        //'Pedido: ${RelativeTimeUtil.getRelativeTime(_con.order?.timestamp ?? 0)}' ,
                        style: const TextStyle(
                            fontSize: 13
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        //'Cliente: ${order.address.description }',
                        'Correo: ${order.client.email}',
                        style: const TextStyle(
                            fontSize: 13
                        ),
                        maxLines: 1,
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   margin: EdgeInsets.symmetric(vertical: 5),
                    //   child: Text(
                    //     'Direccion: ${order.formulario.description}',
                    //     style: TextStyle(
                    //         fontSize: 13
                    //     ),
                    //   ),
                    // ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        'Pedido: 2022-08-17',
                        style: TextStyle(
                            fontSize: 13
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

 

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: MyColors.primarycolor
              ) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : const AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('assets/img/no-image.png'),
                    ),
                  )

                ],
              )
          ),
          
          ListTile(
            onTap: _con.goToProductCreate,
            title: const Text('Crear Hotel'),
            trailing: const Icon(Icons.local_hotel_sharp),
          ),

         /*  ListTile(
            onTap: _con.listaHabitacion,
            title: const Text('Lista de Habitación'),
            trailing: const Icon(Icons.home),
          ), 
          ListTile(
            onTap: _con.irPdf,
            title: const Text('Reporte'),
            trailing: const Icon(Icons.home),
          ),*/
          _con.user != null ?
          _con.user.roles.length > 1?
          ListTile(
            onTap:_con.goToRoles,
            title: const Text('Seleccionar rol'),
            trailing: const Icon(Icons.person_outline),
          ) : Container() : Container(),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar sesión'),
            trailing: const Icon(Icons.power_settings_new),
          )


        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}
