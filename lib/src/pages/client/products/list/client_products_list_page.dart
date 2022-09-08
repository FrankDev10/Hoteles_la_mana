import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoteladmin/src/models/category.dart';
import 'package:hoteladmin/src/models/product.dart';
import 'package:hoteladmin/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:hoteladmin/src/utils/my_colors.dart';
import 'package:hoteladmin/src/widgets/no_data_widget.dart';

const itemsize = 150.0;

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  final ClientProductsListController _con = ClientProductsListController();

  final scrollController = ScrollController();

  Product producto;

  void onlisten() {
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.removeListener(onlisten);
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(onlisten);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        drawer: _drawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300),
          child: Container(
            child: Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  
                  Image.asset(
                    'assets/img/manafond.jpg',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.05,
                      child: _menuDrawer()),
                     
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
           
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                  child: ListView.builder(
                      itemCount: _con?.listHOTEL.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 110,
                            child: GestureDetector(
                              onTap: (){
                                      _con.detalle(_con.listHOTEL[index]);
                                    },
                              child: Card(
                                
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                      radius: 40,
                                      backgroundImage: _con?.listHOTEL[index].image1 != null
                                          ? NetworkImage(_con?.listHOTEL[index].image1)
                                          : const AssetImage('assets/img/user_profile_2.png'),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                  
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 10),
                                       child: Container(
                                        
                                        width: MediaQuery.of(context).size.width* 0.38,
                                         child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${_con?.listHOTEL[index].name}',style: TextStyle(fontSize: 20),),
                                            SizedBox(height: 5,),
                                            Text('${_con?.listHOTEL[index].telefono}'),
                                             SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],)
                                              ],
                                            )
                                          ],
                                    ),
                                       ),
                                     ) 
                                    ],
                                  ),
                                )
                                
                                 /* ListTile(
                                  title: Text('${_con?.listHOTEL[index].name}',style: TextStyle(fontSize: 20),),
                                  subtitle: Column(children: [
                                    Text('${_con?.listHOTEL[index].telefono}'),
                                    Row(
                                      children: [
                                        Row(
                                           children: [
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],),
                              Icon(Icons.star_outline,color: Colors.yellow[800],)
                                           ],
                                         ),
                                      ],
                                    )
                                  ]),
                                  leading: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: _con?.listHOTEL[index].image1 != null
                                        ? NetworkImage(_con?.listHOTEL[index].image1)
                                        : const AssetImage('assets/img/user_profile_2.png'),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                ),
                              */
                              ),
                            ),
                          ),
                        );
                      })),
            ),
          
            Container(
              width: double.infinity,
              height: 40,
             // color: Colors.red,
              child: Align(
                alignment: Alignment.center,
                child: Text('Hoteles',style: TextStyle(fontSize: 35),)),),
          ],
        ));
    /*   
      Stack(children: [
        Container(
          //height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
        Container(
          height: 290,
          color: Colors.red,
          
        ),
        SingleChildScrollView(
          child: Container(
          height: double.infinity,
           //height: MediaQuery.of(context).size.height,
            color: Colors.blue,
            child: Container(
              
              child: ListView.builder(
              itemCount: _con?.listHOTEL.length,
              itemBuilder: (BuildContext context, int index ){
                  return ListTile(
                    title: Text('${_con?.listHOTEL[index].name}'),
                  );
              }
              
              )),
          ),
        )
            
            ],
          ),
        )
        
      ],)
       */
    /*   Stack(
        children: [
        /*   Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/img/manafond.jpg',
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.05,
                    child: _menuDrawer())
              ],
            ),
          ), */
       /*    SizedBox(height: 500,),
          Container(
            child: Text(
              'Hoteles',
              style: TextStyle(fontSize: 23),
            ),
          ), */

          
        ],
      ),
 */
    /*   Stack(
        children: [
          Container(
            //color: Colors.red,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            
            height: 370,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/img/manafond.jpg',fit: BoxFit.cover,),
           
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: _menuDrawer())
              ],
            ),
          ),

    
           Positioned(
             bottom: 0,
             child: Container(
              height: MediaQuery.of(context).size.height * 0.62,
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  
                  controller: scrollController,
                    slivers: [
                    
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          
                          (context, index){
                           
                            final lista = _con?.listHOTEL[index];
                            final itemPositionOFFset  = index * itemsize;
                            final difference = scrollController.offset - itemPositionOFFset;
                            final porcent = 1 - (difference / itemsize);
                            double opacity = porcent;
                            double scale = porcent;
                            if(opacity > 1.0) opacity = 1.0;
                            if(opacity < 0.0) opacity = 0.0;
                            if(porcent > 1.0) scale = 1.0;
                
                            return Opacity(
                              opacity: opacity,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..scale(scale, 1.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: (){
                                      _con.detalle(_con.listHOTEL[index]);
                                    },
                                    child: Container(
                                     
                                      child: Card(
                                         elevation: 2,
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(20.0),
                                           ),
                                         child: ListTile(
                                           title: Text('${lista.name}'),
                                           leading: CircleAvatar(
                                               backgroundImage:  lista?.image1 != null
                                                   ? NetworkImage(lista?.image1)
                                                    : const AssetImage('assets/img/user_profile_2.png'),
                                              radius: 60,
                                              backgroundColor: Colors.grey[200],
                                               ),
                                             
                                             )
                                         /* Stack(
                                           alignment: Alignment.center,
                                           children: [
                                            
                                         Container(
                                       
                                           width: MediaQuery.of(context).size.width,
                                           //height: MediaQuery.of(context).size.height,
                                           
                                           child:  ClipRRect(
                                             borderRadius: BorderRadius.circular(20),
                                             child: Container(
                                                color: Colors.black,
                                               child: Opacity(
                                                 opacity: 0.7,
                                                 child: FadeInImage(
                                                 image: lista?.image1 != null
                                                     ? NetworkImage(lista?.image1)
                                                     : const AssetImage('assets/img/no-image.png'),
                                                 fit: BoxFit.cover,
                                                 // el fit cover me ayuda a que se posiscione en todo el container es mejor este
                                                 fadeInDuration: const Duration(milliseconds: 70),
                                                 placeholder:  const AssetImage('assets/img/PYBr.gif'),
                                                                                 ),
                                               ),
                                             ),
                                           ),
                                             
                                              
                                         ),
                                         
                                         Container(
                                           decoration: BoxDecoration(
                                             color: Colors.transparent,
                                                 borderRadius: BorderRadius.circular(40),
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.white,
                                                     spreadRadius: 3,
                                                     blurRadius: 8,
                                                     offset: Offset(0, 0), // Shadow position
                                                   ),
                                                 ],
                                           ),
                                           child: Padding(
                                             padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                                             child: Text('${lista.name}',
                                             style: GoogleFonts.acme(color: Colors.black, fontSize: 30,),),
                                           ),
                                         ) 
                                                                    ],
                                         ),
                                         */
                                         ),
                                          
                                       ),
                                    ),
                                  ),
                                ),
                              
                            );
                          },
                          childCount: _con.listHOTEL.length
                        ) 
                        
                        )
                    ],
                 /*  child: ListView.builder(
                          itemCount: _con.listHOTEL.length,
                  itemBuilder: (_, index){
                    return GestureDetector(
                        onTap: (){
                    //_con.opendetalle(_con.categorias[index]);
                      },
                      child: Card(
                        child: Text(_con.listHOTEL[index].name)),
                    );
                  },
                    
                  ),
                 */
                
                ),
              ),
           ),
           )

          
        ],
      ),
       */
  }

  Widget lista() {
    return ListView.builder(
        itemCount: _con?.listHOTEL.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${_con?.listHOTEL[index].name}'),
          );
        });
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(18)),
          margin: const EdgeInsets.only(left: 6),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
          )),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primarycolor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _con.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
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
              )),
          /* ListTile(
            onTap: _con.goToUpdatePage,
            title: const Text('Editar perfil'),
            trailing: const Icon(Icons.edit_outlined),
          ), */
          /* ListTile(
            onTap: _con.goToOrderCreatePage,
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ), */
          _con.user != null
              ? _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: const Text('Seleccionar rol'),
                      trailing: const Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
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
    setState(() {
      // CTRL+ S
    });
  }
}
