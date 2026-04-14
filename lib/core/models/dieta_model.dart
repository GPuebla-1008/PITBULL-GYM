class ProductoCompra {
  final String id;
  final String categoria;
  final String nombre;
  final String cantidadMensual;

  ProductoCompra({
    required this.id,
    required this.categoria,
    required this.nombre,
    required this.cantidadMensual,
  });
}

class ComidaCronograma {
  final String horario;
  final String titulo;
  final String menu;
  final String porciones;

  ComidaCronograma({
    required this.horario,
    required this.titulo,
    required this.menu,
    required this.porciones,
  });
}

class DietaModel {
  final String id;
  final String titulo;
  final int calorias;
  final String proteinas;
  final String carbohidratos;
  final String grasas;
  final List<ComidaCronograma> cronograma;
  final List<ProductoCompra> listaCompraMensual;

  DietaModel({
    required this.id,
    required this.titulo,
    required this.calorias,
    required this.proteinas,
    required this.carbohidratos,
    required this.grasas,
    required this.cronograma,
    required this.listaCompraMensual,
  });
}

// BÁSICOS GENÉRICOS PARA TODAS LAS DIETAS
List<ProductoCompra> getBasicosMensuales(String prefix) {
  return [
    ProductoCompra(
      id: '${prefix}_b1',
      categoria: 'Básicos Alacena',
      nombre: 'Sal Marina y Pimienta Negra',
      cantidadMensual: '1 envase c/u',
    ),
    ProductoCompra(
      id: '${prefix}_b2',
      categoria: 'Básicos Alacena',
      nombre: 'Especias (Orégano, Pimentón, Cúrcuma)',
      cantidadMensual: '1 pack de cada una',
    ),
    ProductoCompra(
      id: '${prefix}_b3',
      categoria: 'Básicos Alacena',
      nombre: 'Aceite de Oliva Extra Virgen',
      cantidadMensual: '1 Botella (500ml)',
    ),
    ProductoCompra(
      id: '${prefix}_b4',
      categoria: 'Infusiones',
      nombre: 'Café molido o Té a elección',
      cantidadMensual: '1 pack de 250g / 30 saquitos',
    ),
    ProductoCompra(
      id: '${prefix}_b5',
      categoria: 'Endulzantes',
      nombre: 'Edulcorante Stevia o Sucralosa',
      cantidadMensual: '1 frasco pequeño',
    ),
  ];
}

// --- DEFINICIÓN MUJER ---
final List<DietaModel> dietasDefinicionMujer = [
  DietaModel(
    id: 'def_mujer_estandar',
    titulo: 'Dieta Estándar',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Infusión + Huevos revueltos con avena y manzana',
        porciones: '2 huevos, 40g avena, 1 manzana',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Frutos secos + Fruta cítrica',
        porciones: '15g nueces, 1 naranja',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Pollo a la plancha + Arroz integral + Brócoli',
        porciones: '150g pollo, 50g arroz crudo, 200g brócoli',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Yogur descremado + Almendras',
        porciones: '200g yogur, 15g almendras',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Ensalada verde + Atún al natural',
        porciones: '1 lata atún, lechuga, 1 tomate, 1 cdita aceite oliva',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dm_std_1',
        categoria: 'Proteínas',
        nombre: 'Pechuga de Pollo Fresca',
        cantidadMensual: '4.5 kg (30 porciones de 150g)',
      ),
      ProductoCompra(
        id: 'dm_std_2',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina Grandes',
        cantidadMensual: '2 Maples (60 unidades)',
      ),
      ProductoCompra(
        id: 'dm_std_3',
        categoria: 'Proteínas',
        nombre: 'Atún al Natural (latas 120g)',
        cantidadMensual: '30 Latas',
      ),
      ProductoCompra(
        id: 'dm_std_4',
        categoria: 'Carbohidratos',
        nombre: 'Arroz Integral y Avena Tradicional',
        cantidadMensual: '1.5 kg Arroz, 1.2 kg Avena',
      ),
      ProductoCompra(
        id: 'dm_std_5',
        categoria: 'Lácteos',
        nombre: 'Yogur Descremado (potes 200g)',
        cantidadMensual: '30 Potes',
      ),
      ProductoCompra(
        id: 'dm_std_6',
        categoria: 'Grasas',
        nombre: 'Mix de Nueces y Almendras',
        cantidadMensual: '900g (30g diarios)',
      ),
      ProductoCompra(
        id: 'dm_std_7',
        categoria: 'Verdulería',
        nombre: 'Manzanas, Naranjas y Brócoli',
        cantidadMensual: '30 Manzanas, 30 Naranjas, 6 kg Brócoli',
      ),
      ...getBasicosMensuales('dm_std'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_pesc',
    titulo: 'Dieta Pescatariana',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Pancakes de claras y avena',
        porciones: '4 claras, 40g avena',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Yogur proteico + Frutos rojos',
        porciones: '150g yogur, 50g frutos rojos',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Pescado blanco + Lentejas + Vegetales',
        porciones: '150g merluza, 60g lentejas crudas',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Yogur Skyr + Mix semillas',
        porciones: '150g skyr, 10g semillas',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Tacos de lechuga con atún y palta',
        porciones: '1 lata atún, 1/4 palta, 2 fajitas integrales',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dm_pesc_1',
        categoria: 'Proteínas',
        nombre: 'Pescado Blanco (Merluza/Tilapia)',
        cantidadMensual: '4.5 kg',
      ),
      ProductoCompra(
        id: 'dm_pesc_2',
        categoria: 'Proteínas',
        nombre: 'Atún al Natural (latas 120g)',
        cantidadMensual: '30 Latas',
      ),
      ProductoCompra(
        id: 'dm_pesc_3',
        categoria: 'Proteínas',
        nombre: 'Claras de Huevo Pasteurizadas',
        cantidadMensual: '4 Litros',
      ),
      ProductoCompra(
        id: 'dm_pesc_4',
        categoria: 'Lácteos',
        nombre: 'Yogur Proteico / Skyr',
        cantidadMensual: '60 Potes pequeños',
      ),
      ProductoCompra(
        id: 'dm_pesc_5',
        categoria: 'Carbohidratos',
        nombre: 'Lentejas Secas y Tortillas Integrales',
        cantidadMensual: '1.8 kg Lentejas, 8 packs Tortillas',
      ),
      ProductoCompra(
        id: 'dm_pesc_6',
        categoria: 'Grasas',
        nombre: 'Paltas y Semillas (Chía/Lino)',
        cantidadMensual: '8 Paltas, 300g Semillas',
      ),
      ProductoCompra(
        id: 'dm_pesc_7',
        categoria: 'Frutas',
        nombre: 'Frutos Rojos (congelados)',
        cantidadMensual: '1.5 kg',
      ),
      ...getBasicosMensuales('dm_pesc'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_sinlac',
    titulo: 'Sin Lácteos',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Batido proteína + Leche almendras + Pera',
        porciones: '1 scoop proteína, 200ml leche veg, 1 pera',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Frutos secos + Choco amargo',
        porciones: '20g almendras, 15g chocolate 70%',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Solomillo cerdo + Papa + Vegetales wok',
        porciones: '150g cerdo, 150g papa',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Tofu salteado + Galletas arroz',
        porciones: '100g tofu, 3 galletas arroz',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Wok pollo y morrones + Maní',
        porciones: '150g pollo, 20g maní',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dm_slac_1',
        categoria: 'Proteínas',
        nombre: 'Pollo y Solomillo de Cerdo Magro',
        cantidadMensual: '4.5 kg Pollo, 4.5 kg Cerdo',
      ),
      ProductoCompra(
        id: 'dm_slac_2',
        categoria: 'Proteínas',
        nombre: 'Tofu Firme y Proteína Isolate Soya/Beef',
        cantidadMensual: '3 kg Tofu, 1 Tarro Isolate (900g)',
      ),
      ProductoCompra(
        id: 'dm_slac_3',
        categoria: 'Lácteos Veg',
        nombre: 'Bebida de Almendras / Coco (sin azúcar)',
        cantidadMensual: '8 Litros (TetraBrik)',
      ),
      ProductoCompra(
        id: 'dm_slac_4',
        categoria: 'Carbohidratos',
        nombre: 'Papas y Galletas de Arroz soplado',
        cantidadMensual: '5 kg Papa, 6 paquetes Galletas',
      ),
      ProductoCompra(
        id: 'dm_slac_5',
        categoria: 'Grasas',
        nombre: 'Almendras, Maní y Chocolate 70%+',
        cantidadMensual: '600g Almendras, 600g Maní, 450g Choco',
      ),
      ...getBasicosMensuales('dm_slac'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_eco',
    titulo: 'Económica',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Avena cocida con leche y banana',
        porciones: '40g avena, 150ml leche, 1 banana',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Maní + Fruta de estación',
        porciones: '15g maní, 1 manzana',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Carne picada + Fideos + Tomate',
        porciones: '150g carne, 60g fideos',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Huevos duros + Fruta',
        porciones: '2 huevos, 1 naranja',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Guiso ligero pollo y lentejas',
        porciones: '150g pollo, 60g lentejas',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dm_eco_1',
        categoria: 'Proteínas',
        nombre: 'Carne Molida Magra y Pata-Muslo',
        cantidadMensual: '4.5 kg Carne, 5 kg Pollo',
      ),
      ProductoCompra(
        id: 'dm_eco_2',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina',
        cantidadMensual: '2 Maples (60 unidades)',
      ),
      ProductoCompra(
        id: 'dm_eco_3',
        categoria: 'Lácteos',
        nombre: 'Leche Larga Vida',
        cantidadMensual: '6 Litros',
      ),
      ProductoCompra(
        id: 'dm_eco_4',
        categoria: 'Carbohidratos',
        nombre: 'Avena Saco, Fideos Secos y Lentejas',
        cantidadMensual: '1.5 kg Avena, 2 kg Fideos, 2 kg Lentejas',
      ),
      ProductoCompra(
        id: 'dm_eco_5',
        categoria: 'Grasas/Frutas',
        nombre: 'Maní pelado, Bananas y Naranjas',
        cantidadMensual: '500g Maní, 30 Bananas, 45 Naranjas',
      ),
      ...getBasicosMensuales('dm_eco'),
    ],
  ),
  DietaModel(
    id: 'def_mujer_fibra',
    titulo: 'Alta Fibras',
    calorias: 1500,
    proteinas: '35%',
    carbohidratos: '35%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Pudding chía y avena + Frutos rojos',
        porciones: '15g chía, 30g avena, 50g frutos rojos',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Bastones vegetales + Hummus',
        porciones: 'Vegetales libres, 40g hummus',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Ensalada garbanzos + Atún',
        porciones: '60g garbanzos crudos, 1 lata atún',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Pan integral + Ricota + Semillas girasol',
        porciones: '2 rodajas pan, 40g ricota, 10g semillas',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Filete magro + Colchón de espinaca',
        porciones: '150g carne, 250g espinaca',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dm_fib_1',
        categoria: 'Proteínas',
        nombre: 'Vacuno Magro (Lomo), Pechuga y Atún',
        cantidadMensual: '4.5 kg Carnes, 30 latas Atún',
      ),
      ProductoCompra(
        id: 'dm_fib_2',
        categoria: 'Legumbres',
        nombre: 'Garbanzos Secos ( Hummus y Ensalada)',
        cantidadMensual: '3 kg',
      ),
      ProductoCompra(
        id: 'dm_fib_3',
        categoria: 'Carbohidratos',
        nombre: 'Pan Integral de Semilla y Avena',
        cantidadMensual: '5 packs Pan, 1 kg Avena',
      ),
      ProductoCompra(
        id: 'dm_fib_4',
        categoria: 'Semillas/Lácteos',
        nombre: 'Chía, Girasol y Ricota Descremada',
        cantidadMensual: '500g Chía, 300g Girasol, 1.5kg Ricota',
      ),
      ProductoCompra(
        id: 'dm_fib_5',
        categoria: 'Verdulería',
        nombre: 'Espinaca, Zanahoria, Apio y Frutos Rojos',
        cantidadMensual:
            '12 atados Espinaca, 4 kg Vegetales, 1.5kg Frutos Rojos',
      ),
      ...getBasicosMensuales('dm_fib'),
    ],
  ),
];

// --- DEFINICIÓN HOMBRE ---
final List<DietaModel> dietasDefinicionHombre = [
  DietaModel(
    id: 'def_hombre_estandar',
    titulo: 'Estándar Masculina',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Huevos revueltos + Avena + Manzana',
        porciones: '3 huevos, 80g avena, 1 manzana',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Mix frutos secos + Naranjas',
        porciones: '30g frutos secos, 2 naranjas',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Pechuga / Res + Arroz integral + Brócoli',
        porciones: '200g carne, 80g arroz crudo, 300g brócoli',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Yogur natural + Nueces',
        porciones: '300g yogur, 30g nueces',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Doble Atún + Ensalada mixta + Oliva',
        porciones: '2 latas atún, Ensalada libre, 1 cda oliva',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dh_std_1',
        categoria: 'Proteínas',
        nombre: 'Pechuga de Pollo y Res Magra',
        cantidadMensual: '6 kg Pollo, 6 kg Carne roja',
      ),
      ProductoCompra(
        id: 'dh_std_2',
        categoria: 'Proteínas',
        nombre: 'Huevos XL y Atún al natural',
        cantidadMensual: '3 Maples (90 huevos), 60 Latas atún',
      ),
      ProductoCompra(
        id: 'dh_std_3',
        categoria: 'Lácteos',
        nombre: 'Yogur Natural / Descremado',
        cantidadMensual: '45 potes grandes (o 10L)',
      ),
      ProductoCompra(
        id: 'dh_std_4',
        categoria: 'Carbohidratos',
        nombre: 'Arroz Integral y Avena Rolada',
        cantidadMensual: '2.5 kg Arroz, 2.5 kg Avena',
      ),
      ProductoCompra(
        id: 'dh_std_5',
        categoria: 'Grasas',
        nombre: 'Nueces y Almendras peladas',
        cantidadMensual: '1.8 kg (60g diarios)',
      ),
      ProductoCompra(
        id: 'dh_std_6',
        categoria: 'Verdulería',
        nombre: 'Manzanas, Naranjas y Brócoli',
        cantidadMensual: '30 Manzanas, 60 Naranjas, 10 kg Brócoli',
      ),
      ...getBasicosMensuales('dh_std'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_pesc',
    titulo: 'Pescatariana High-Protein',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Pancakes de claras y avena',
        porciones: '8 claras (o 250ml), 80g avena',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Yogur griego + Frutos rojos',
        porciones: '250g yogur, 100g frutos rojos',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Filete pescado + Quinoa + Zapallo',
        porciones: '250g pescado, 80g quinoa cruda',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Bowl Skyr + Semillas chía',
        porciones: '250g skyr, 20g chía',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Wraps de lechuga con atún y palta',
        porciones: '2 latas atún, 1/2 palta, 3 wraps',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dh_pesc_1',
        categoria: 'Proteínas',
        nombre: 'Pescado Blanco y Atún al natural',
        cantidadMensual: '7.5 kg Pescado, 60 Latas atún',
      ),
      ProductoCompra(
        id: 'dh_pesc_2',
        categoria: 'Proteínas',
        nombre: 'Claras de Huevo Pasteurizadas',
        cantidadMensual: '8 Litros',
      ),
      ProductoCompra(
        id: 'dh_pesc_3',
        categoria: 'Lácteos',
        nombre: 'Yogur Griego / Skyr Proteico',
        cantidadMensual: '15 kg (Potes o Sachets)',
      ),
      ProductoCompra(
        id: 'dh_pesc_4',
        categoria: 'Carbohidratos',
        nombre: 'Quinoa andina y Avena Fina',
        cantidadMensual: '2.5 kg Quinoa, 2.5 kg Avena',
      ),
      ProductoCompra(
        id: 'dh_pesc_5',
        categoria: 'Grasas',
        nombre: 'Paltas y Semillas Chía/Lino',
        cantidadMensual: '15 Paltas, 600g Semillas',
      ),
      ProductoCompra(
        id: 'dh_pesc_6',
        categoria: 'Frutas',
        nombre: 'Frutos Rojos / Arándanos (congelados)',
        cantidadMensual: '3 kg',
      ),
      ...getBasicosMensuales('dh_pesc'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_sinlac',
    titulo: 'Sin Lácteos / Keto-Friendly',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Batido proteína veg + Leche almendras + Maní',
        porciones: '2 scoops prot, 350ml leche veg, 1 cda maní',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Frutos secos + Choco 80%',
        porciones: '40g frutos secos, 20g chocolate',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Lomo cerdo + Papas asadas + Wok hojas',
        porciones: '200g cerdo, 250g papa',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Tofu bloque + Galletas arroz',
        porciones: '150g tofu, 5 galletas arroz',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Pollo en dados + Vegetales wok + Maní',
        porciones: '200g pollo, 40g maní',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dh_slac_1',
        categoria: 'Proteínas',
        nombre: 'Cerdo Magro, Pollo y Proteína Isolate Soya/Beef',
        cantidadMensual: '6 kg Cerdo, 6 kg Pollo, 2 kg Proteína',
      ),
      ProductoCompra(
        id: 'dh_slac_2',
        categoria: 'Proteínas',
        nombre: 'Tofu Duro Firme en Bloque',
        cantidadMensual: '4.5 kg',
      ),
      ProductoCompra(
        id: 'dh_slac_3',
        categoria: 'Lácteos Veg',
        nombre: 'Bebida Almendras / Coco (sin azúcar)',
        cantidadMensual: '12 Litros',
      ),
      ProductoCompra(
        id: 'dh_slac_4',
        categoria: 'Carbohidratos',
        nombre: 'Papas y Galletas de Arroz soplado',
        cantidadMensual: '8 kg Papa, 8 paquetes Galletas',
      ),
      ProductoCompra(
        id: 'dh_slac_5',
        categoria: 'Grasas',
        nombre: 'Maní, Almendras y Chocolate 80%+',
        cantidadMensual: '1.5 kg Maní, 1 kg Almendras, 600g Choco',
      ),
      ...getBasicosMensuales('dh_slac'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_eco',
    titulo: 'Económica Masculina',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Mazamorra de avena con banana y leche',
        porciones: '80g avena, 1 banana, 200ml leche',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Maní + Naranjas',
        porciones: '30g maní, 2 naranjas',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Fideos con carne molida y tomate',
        porciones: '200g carne, 80g fideos crudos',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Infusión + 3 Huevos duros',
        porciones: '3 huevos gigantes',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Pollo (pata muslo) con lentejas',
        porciones: '200g pollo, 80g lentejas crudas',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dh_eco_1',
        categoria: 'Proteínas',
        nombre: 'Carne Molida Magra y Pollo Pata-Muslo',
        cantidadMensual: '6 kg Carne, 8 kg Pollo',
      ),
      ProductoCompra(
        id: 'dh_eco_2',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina',
        cantidadMensual: '3 Maples (90 unidades)',
      ),
      ProductoCompra(
        id: 'dh_eco_3',
        categoria: 'Lácteos',
        nombre: 'Leche Tradicional',
        cantidadMensual: '8 Litros',
      ),
      ProductoCompra(
        id: 'dh_eco_4',
        categoria: 'Almidones',
        nombre: 'Fideos Guiseros, Avena y Lentejas',
        cantidadMensual: '2.5 kg Fideos, 2.5 kg Avena, 2.5 kg Lentejas',
      ),
      ProductoCompra(
        id: 'dh_eco_5',
        categoria: 'Grasas/Frutas',
        nombre: 'Maní pelado, Bananas y Naranjas',
        cantidadMensual: '1 kg Maní, 30 Bananas, 60 Naranjas',
      ),
      ...getBasicosMensuales('dh_eco'),
    ],
  ),
  DietaModel(
    id: 'def_hombre_fibra',
    titulo: 'Alta Fibras Masculina',
    calorias: 2200,
    proteinas: '30%',
    carbohidratos: '40%',
    grasas: '30%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Pudding chía y avena + Bayas',
        porciones: '25g chía, 60g avena, 100g bayas',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Bastones pepino/api + Hummus',
        porciones: 'Vegetales libres, 60g hummus',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Bol garbanzos + 2 latas Atún + Espinaca',
        porciones: '100g garbanzos crudos, 2 latas atún',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Pan integral + Ricota + Girasol',
        porciones: '4 rodajas pan, 80g ricota, 15g girasol',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Filete magro + Espinaca al ajo',
        porciones: '200g carne, 300g espinaca',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'dh_fib_1',
        categoria: 'Proteínas',
        nombre: 'Carne Magra Vacuna (Lomo) y Atún',
        cantidadMensual: '6 kg Carne, 60 latas Atún',
      ),
      ProductoCompra(
        id: 'dh_fib_2',
        categoria: 'Legumbres',
        nombre: 'Garbanzos Secos ( Hummus y Fibra)',
        cantidadMensual: '4 kg',
      ),
      ProductoCompra(
        id: 'dh_fib_3',
        categoria: 'Carbohidratos',
        nombre: 'Pan Integral Molde Oscuro y Avena',
        cantidadMensual: '12 packs Pan, 2 kg Avena',
      ),
      ProductoCompra(
        id: 'dh_fib_4',
        categoria: 'Semillas/Lácteos',
        nombre: 'Chía, Girasol y Ricota Proteica',
        cantidadMensual: '750g Chía, 500g Girasol, 3 kg Ricota',
      ),
      ProductoCompra(
        id: 'dh_fib_5',
        categoria: 'Verdulería',
        nombre: 'Espinaca, Apio, Pepino y Frutos Rojos',
        cantidadMensual:
            '15 atados Espinaca, 15 atados Apio, 3 kg Frutos Rojos',
      ),
      ...getBasicosMensuales('dh_fib'),
    ],
  ),
];

// --- GANANCIA MUJER ---
final List<DietaModel> dietasGananciaMujer = [
  DietaModel(
    id: 'gan_mujer_estandar',
    titulo: 'Estándar Ganancia',
    calorias: 2000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Huevos + Avena + Batata asada',
        porciones: '3 huevos, 60g avena, 100g batata',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Yogur + Frutos secos + Pan',
        porciones: '200g yogur, 30g mix, 1 rodaja pan',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Pollo / Cuadril + Arroz integral',
        porciones: '150g carne, 100g arroz crudo',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Tostadas pan oscuro + Ricota + Mermelada',
        porciones: '3 tostadas, 60g ricota',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Pollo desmenuzado + Fideos + Espinaca',
        porciones: '150g pollo, 80g fideos crudos',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gm_std_1',
        categoria: 'Proteínas',
        nombre: 'Pechuga de Pollo y Vacuno (Lomo/Cuadril)',
        cantidadMensual: '4.5 kg Pollo, 4.5 kg Carne roja',
      ),
      ProductoCompra(
        id: 'gm_std_2',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina Grandes',
        cantidadMensual: '3 Maples (90 unidades)',
      ),
      ProductoCompra(
        id: 'gm_std_3',
        categoria: 'Lácteos',
        nombre: 'Yogures y Ricota Magra',
        cantidadMensual: '30 potes Yogur, 2 kg Ricota',
      ),
      ProductoCompra(
        id: 'gm_std_4',
        categoria: 'Carbohidratos',
        nombre: 'Arroz Integral, Avena, Fideos y Pan',
        cantidadMensual: '3 kg Arroz, 2 kg Avena, 2.5 kg Fideos, 4 packs Pan',
      ),
      ProductoCompra(
        id: 'gm_std_5',
        categoria: 'Verdulería',
        nombre: 'Batatas Gordas y Espinaca Fina',
        cantidadMensual: '4 kg Batata, 15 atados Espinaca',
      ),
      ProductoCompra(
        id: 'gm_std_6',
        categoria: 'Extras',
        nombre: 'Frutos Secos y Mermelada Natural',
        cantidadMensual: '900g Frutos, 2 frascos Mermelada',
      ),
      ...getBasicosMensuales('gm_std'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_pesc',
    titulo: 'Power-Veggie (Pescatariana)',
    calorias: 2000,
    proteinas: '30%',
    carbohidratos: '45%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Pancakes de 1 huevo, claras y avena',
        porciones: '1 huevo + 100ml claras, 60g avena',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Licuado yogur + Chía + Frutos rojos',
        porciones: '200g yogur, 15g chía, 100g bayas',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Salmón / Merluza + Quinoa + Garbanzos',
        porciones: '150g pescado, 70g quinoa cruda, 50g garbanzos',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Yogur Skyr + Granola',
        porciones: '200g skyr, 40g granola',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Fajitas de atún y lentejas',
        porciones: '2 fajitas, 1 lata atún (170g), 40g lentejas',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gm_pesc_1',
        categoria: 'Proteínas',
        nombre: 'Pescado Azul / blanco y Atún natural',
        cantidadMensual: '5 kg Pescado, 45 latas Atún grandes',
      ),
      ProductoCompra(
        id: 'gm_pesc_2',
        categoria: 'Proteínas',
        nombre: 'Claras de Huevo y Huevos enteros',
        cantidadMensual: '4 Litros Claras, 1 Maple (30 unidades)',
      ),
      ProductoCompra(
        id: 'gm_pesc_3',
        categoria: 'Lácteos',
        nombre: 'Yogur Skyr densito',
        cantidadMensual: '30 Potes grandes',
      ),
      ProductoCompra(
        id: 'gm_pesc_4',
        categoria: 'Carbohidratos',
        nombre: 'Quinoa, Avena fina y Fajitas integrales',
        cantidadMensual: '2 kg Quinoa, 2 kg Avena, 8 packs Fajitas',
      ),
      ProductoCompra(
        id: 'gm_pesc_5',
        categoria: 'Legumbres',
        nombre: 'Lentejas andinas y Garbanzos secos',
        cantidadMensual: '1.5 kg Lentejas, 1.5 kg Garbanzos',
      ),
      ProductoCompra(
        id: 'gm_pesc_6',
        categoria: 'Extras',
        nombre: 'Granola artesana y Frutos rojos',
        cantidadMensual: '1.2 kg Granola, 3 kg Frutos rojos',
      ),
      ...getBasicosMensuales('gm_pesc'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_sinlac',
    titulo: 'Sin Lácteos',
    calorias: 2000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Smoothie veg + Proteína + Galletas arroz',
        porciones: '300ml leche veg, 1 scoop prot, 3 galletas',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Cítricos + Maní crudo',
        porciones: '2 frutas (naranja), 30g maní',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Bloque tofu dorado + Palta + Espinaca',
        porciones: '150g tofu, 1/2 palta, espinaca libre',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Pan negro + Hummus casero',
        porciones: '3 rodajas pan, 60g hummus',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Pechuga de pollo + Batatas asadas',
        porciones: '150g pollo, 200g batata',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gm_slac_1',
        categoria: 'Proteínas',
        nombre: 'Pechugas de Pollo y Tofu Duro',
        cantidadMensual: '5 kg Pollo, 5 kg Tofu',
      ),
      ProductoCompra(
        id: 'gm_slac_2',
        categoria: 'Proteínas',
        nombre: 'Proteína aislada (Soya/Beef)',
        cantidadMensual: '1 kg (1 Tarro)',
      ),
      ProductoCompra(
        id: 'gm_slac_3',
        categoria: 'Lácteos Veg',
        nombre: 'Bebida Vegetal (Almendra/Coco)',
        cantidadMensual: '10 Litros',
      ),
      ProductoCompra(
        id: 'gm_slac_4',
        categoria: 'Carbohidratos',
        nombre: 'Batatas, Pan Negro y Galletas Arroz',
        cantidadMensual: '6 kg Batatas, 4 packs Pan, 4 tubos Galletas',
      ),
      ProductoCompra(
        id: 'gm_slac_5',
        categoria: 'Grasas',
        nombre: 'Paltas, Maní y Hummus',
        cantidadMensual: '15 Paltas, 1 kg Maní, 2 kg Hummus',
      ),
      ...getBasicosMensuales('gm_slac'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_eco',
    titulo: 'Económica Voluminizadora',
    calorias: 2000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Mazamorra avena + Leche + Banana',
        porciones: '80g avena, 200ml leche, 1 banana',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Manzana + Puñado maní',
        porciones: '1 fruta, 30g maní',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Pastas tirabuzón con carne molida',
        porciones: '120g fideos crudos, 100g carne',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Infusión + 3 Huevos duros',
        porciones: '3 huevos enteros',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Cazuela pollo pata-muslo con lentejas',
        porciones: '200g pollo, 100g lentejas crudas',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gm_eco_1',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina',
        cantidadMensual: '3 Maples (90 unidades)',
      ),
      ProductoCompra(
        id: 'gm_eco_2',
        categoria: 'Proteínas',
        nombre: 'Carne Molida y Pollo Pata-Muslo',
        cantidadMensual: '3 kg Carne, 6 kg Pollo',
      ),
      ProductoCompra(
        id: 'gm_eco_3',
        categoria: 'Carbohidratos',
        nombre: 'Fideos Guiseros, Avena y Lentejas',
        cantidadMensual: '4 kg Fideos, 2.5 kg Avena, 3 kg Lentejas',
      ),
      ProductoCompra(
        id: 'gm_eco_4',
        categoria: 'Verdulería',
        nombre: 'Bananas, Manzanas y Naranjas',
        cantidadMensual: '30 Bananas, 60 Frutas variadas',
      ),
      ProductoCompra(
        id: 'gm_eco_5',
        categoria: 'Grasas',
        nombre: 'Maní pelado económico',
        cantidadMensual: '1 kg',
      ),
      ...getBasicosMensuales('gm_eco'),
    ],
  ),
  DietaModel(
    id: 'gan_mujer_fibra',
    titulo: 'Densidad Nutritiva',
    calorias: 2000,
    proteinas: '30%',
    carbohidratos: '45%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Smoothie verde: avena, chía, espinaca, bayas',
        porciones: '50g avena, 10g chía, 100g bayas',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Crackers integrales + Manteca maní',
        porciones: '4 galletas, 30g manteca maní',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Lomo asado + Quinoa + Verdes',
        porciones: '150g lomo, 80g quinoa cruda',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Pudding yogur + Banana + Polvo avena',
        porciones: '200g yogur, 1 banana, 20g avena',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Pechuga pollo + Papas asadas + Wok veg',
        porciones: '150g pollo, 200g papa',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gm_fib_1',
        categoria: 'Proteínas',
        nombre: 'Lomo Vacuno, Pechuga Pollo y Atún',
        cantidadMensual: '5 kg Lomo, 5 kg Pollo, 20 latas Atún',
      ),
      ProductoCompra(
        id: 'gm_fib_2',
        categoria: 'Lácteos/Grasas',
        nombre: 'Yogur Griego y Manteca de Maní Natural',
        cantidadMensual: '30 Potes grandes, 1 kg Manteca maní',
      ),
      ProductoCompra(
        id: 'gm_fib_3',
        categoria: 'Carbohidratos',
        nombre: 'Quinoa, Avena, Papas y Crackers Fibra',
        cantidadMensual:
            '2.5 kg Quinoa, 3 kg Avena, 6 kg Papa, 6 packs Crackers',
      ),
      ProductoCompra(
        id: 'gm_fib_4',
        categoria: 'Verdulería',
        nombre: 'Espinaca, Frutos Rojos y Bananas',
        cantidadMensual: '20 atados Espinaca, 2 kg Bayas, 30 Bananas',
      ),
      ProductoCompra(
        id: 'gm_fib_5',
        categoria: 'Semillas',
        nombre: 'Chía y Semillas de Girasol',
        cantidadMensual: '500g Chía, 300g Girasol',
      ),
      ...getBasicosMensuales('gm_fib'),
    ],
  ),
];

// --- GANANCIA HOMBRE ---
final List<DietaModel> dietasGananciaHombre = [
  DietaModel(
    id: 'gan_hombre_estandar',
    titulo: 'Estándar Volumen',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Avena con miel + 4 Huevos + Tostadas',
        porciones: '120g avena, 4 huevos, 2 tostadas',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Licuado: Proteína, Bananas y Maní',
        porciones: '1 scoop prot, 2 bananas, 2 cdas maní',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo Masivo',
        menu: 'Pechuga / Res + 150g Arroz (crudo)',
        porciones: '250g carne, 150g arroz crudo',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Sándwich pollo cuádruple + Palta',
        porciones: '4 rodajas pan, 150g pollo, 1 palta',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Bife ancho + Puré papa y batata',
        porciones: '200g bife, 300g tubérculos',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gh_std_1',
        categoria: 'Proteínas',
        nombre: 'Pollo y Res (Bife Ancho/Cuadril)',
        cantidadMensual: '12 kg Pollo, 6 kg Carne roja',
      ),
      ProductoCompra(
        id: 'gh_std_2',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina XL',
        cantidadMensual: '10 Maples (300 unidades)',
      ),
      ProductoCompra(
        id: 'gh_std_3',
        categoria: 'Carbohidratos',
        nombre: 'Arroz, Fideos, Papa y Batata',
        cantidadMensual: '6 kg Arroz, 6 kg Fideos, 10 kg Tubérculos',
      ),
      ProductoCompra(
        id: 'gh_std_4',
        categoria: 'Carbohidratos',
        nombre: 'Avena, Pan Molde XL y Miel',
        cantidadMensual: '5 kg Avena, 8 packs Pan, 1 kg Miel',
      ),
      ProductoCompra(
        id: 'gh_std_5',
        categoria: 'Grasas',
        nombre: 'Pasta de Maní Natural y Paltas',
        cantidadMensual: '2 kg Pasta maní, 20 Paltas',
      ),
      ProductoCompra(
        id: 'gh_std_6',
        categoria: 'Lácteos',
        nombre: 'Leche Entera o Proteica',
        cantidadMensual: '15 Litros',
      ),
      ...getBasicosMensuales('gh_std'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_pesc',
    titulo: 'Pescatariana Volumen',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Pancakes avena y 6 claras + Yogur griego',
        porciones: '150g avena, 6 claras, 200g yogur',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Hummus + Pan árabe integral + Oliva',
        porciones: '60g hummus, 2 panes pita',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo Rústico',
        menu: 'Salmón/Atún asado + Quinoa y Lentejas',
        porciones: '250g pescado, 100g quinoa, 80g lenteja',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Bowl Skyr + Bananas + Chía + Maní',
        porciones: '300g skyr, 2 bananas, 20g chía',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Wraps de Atún (3 latas) + Palta + Fideos',
        porciones: '3 latas atún, 1 palta, 80g fideos',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gh_pesc_1',
        categoria: 'Proteínas',
        nombre: 'Pescado Merluza/Salmón y Atún Natural',
        cantidadMensual: '10 kg Pescado, 40 latas Atún grandes',
      ),
      ProductoCompra(
        id: 'gh_pesc_2',
        categoria: 'Proteínas',
        nombre: 'Claras de Huevo Pasteurizadas',
        cantidadMensual: '8 Litros',
      ),
      ProductoCompra(
        id: 'gh_pesc_3',
        categoria: 'Lácteos',
        nombre: 'Yogur Griego / Skyr Proteico',
        cantidadMensual: '30 potes XL (o 15 kg)',
      ),
      ProductoCompra(
        id: 'gh_pesc_4',
        categoria: 'Carbohidratos',
        nombre: 'Quinoa, Lenteja, Avena y Pan Pita',
        cantidadMensual: '4 kg Quinoa, 5 kg Lenteja, 5 kg Avena, 10 packs Pan',
      ),
      ProductoCompra(
        id: 'gh_pesc_5',
        categoria: 'Grasas',
        nombre: 'Paltas, Chía y Pasta de Maní',
        cantidadMensual: '20 Paltas, 1 kg Chía, 2 kg Pasta maní',
      ),
      ...getBasicosMensuales('gh_pesc'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_sinlac',
    titulo: 'Crecimiento Masivo No-Lacteo',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Smoothie colosal: avena, isolate, coco',
        porciones: '120g avena, 2 scoops prot, 1 cda coco',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Bloque tofu revuelto + Galletas + Palta',
        porciones: '250g tofu, 6 galletotas, 1 palta',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo',
        menu: 'Pollo al maní + Montaña de batata',
        porciones: '250g pollo, 300g batata',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: '4 Huevos duros o Ensalada Atún/Lenteja',
        porciones: '4 huevos o 2 latas atún + 100g lenteja',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Bistec res + Puré arvejas + Pan negro',
        porciones: '250g res, 100g arveja cruda, 3 pan',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gh_slac_1',
        categoria: 'Proteínas',
        nombre: 'Res Magra, Pollo y Tofu Duro',
        cantidadMensual: '8 kg Res, 8 kg Pollo, 7 kg Tofu',
      ),
      ProductoCompra(
        id: 'gh_slac_2',
        categoria: 'Proteínas',
        nombre: 'Proteína Isolate (Beef/Soya)',
        cantidadMensual: '2 kg (2 Tarros)',
      ),
      ProductoCompra(
        id: 'gh_slac_3',
        categoria: 'Lácteos Veg',
        nombre: 'Bebida Vegetal (Almendra/Coco)',
        cantidadMensual: '20 Litros',
      ),
      ProductoCompra(
        id: 'gh_slac_4',
        categoria: 'Carbohidratos',
        nombre: 'Avena, Batata y Arveja Partida Seca',
        cantidadMensual: '5 kg Avena, 12 kg Batata, 5 kg Arveja',
      ),
      ProductoCompra(
        id: 'gh_slac_5',
        categoria: 'Grasas',
        nombre: 'Aceite Coco, Maní y Paltas',
        cantidadMensual: '1 Litro Coco, 2 kg Maní, 20 Paltas',
      ),
      ...getBasicosMensuales('gh_slac'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_eco',
    titulo: 'Económica Bestial',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Tazón mazamorra + Banana + Pan maní',
        porciones: '150g avena, 2 bananas, 3 panes',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: '4 Huevos duros + Fruta',
        porciones: '4 huevos XL, 4 naranjas',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo Rudo',
        menu: 'Arroz blanco con carne molida gorda',
        porciones: '150g arroz crudo, 200g carne',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda',
        menu: 'Pan molde + Puré lentejas o maní',
        porciones: '4 rodajas pan, 100g lenteja o maní',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Pata-Muslo con fideos tirabuzón',
        porciones: '300g pollo, 100g fideos crudos',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gh_eco_1',
        categoria: 'Proteínas',
        nombre: 'Huevos de Gallina XL',
        cantidadMensual: '10 Maples (300 unidades)',
      ),
      ProductoCompra(
        id: 'gh_eco_2',
        categoria: 'Proteínas',
        nombre: 'Pollo Pata-Muslo y Picada Especial',
        cantidadMensual: '12 kg Pollo, 10 kg Carne molida',
      ),
      ProductoCompra(
        id: 'gh_eco_3',
        categoria: 'Carbohidratos',
        nombre: 'Arroz, Avena, Fideos y Lentejas',
        cantidadMensual: '10 kg Arroz, 8 kg Avena, 8 kg Fideos, 6 kg Lentejas',
      ),
      ProductoCompra(
        id: 'gh_eco_4',
        categoria: 'Verdulería',
        nombre: 'Bananas y Cítricos varios',
        cantidadMensual: '60 Bananas, 60 Cítricos',
      ),
      ProductoCompra(
        id: 'gh_eco_5',
        categoria: 'Grasas',
        nombre: 'Pasta de Maní (Cacahuate) suelto',
        cantidadMensual: '4 kg',
      ),
      ...getBasicosMensuales('gh_eco'),
    ],
  ),
  DietaModel(
    id: 'gan_hombre_fibra',
    titulo: 'Atletas / Densidad Nutritiva',
    calorias: 3000,
    proteinas: '25%',
    carbohidratos: '50%',
    grasas: '25%',
    cronograma: [
      ComidaCronograma(
        horario: '08:00 AM',
        titulo: 'Desayuno',
        menu: 'Smoothie blender masivo + Miel',
        porciones: '120g avena, 1 scoop prot, 2 bananas, miel',
      ),
      ComidaCronograma(
        horario: '11:00 AM',
        titulo: 'Media Mañana',
        menu: 'Pudding Chía + Dátiles + Nueces',
        porciones: '30g chía, 5 dátiles, manojo nueces',
      ),
      ComidaCronograma(
        horario: '01:00 PM',
        titulo: 'Almuerzo Bloque',
        menu: 'Bife Lomo 3cm + Fideos oscuros o Papa',
        porciones: '250g res, 200g fideos/papa',
      ),
      ComidaCronograma(
        horario: '05:00 PM',
        titulo: 'Merienda Sandwich',
        menu: 'Sandwich pan negro + Atún/Pollo + Palta',
        porciones: '4 rodajas pan, 1 lata atún, 1 palta',
      ),
      ComidaCronograma(
        horario: '09:00 PM',
        titulo: 'Cena',
        menu: 'Cazuela legumbres + 4 claras + Pollo',
        porciones: '150g pollo, 120g lentejas crudas',
      ),
    ],
    listaCompraMensual: [
      ProductoCompra(
        id: 'gh_fib_1',
        categoria: 'Proteínas',
        nombre: 'Bifes Cuadril, Pechuga Pollo y Atún',
        cantidadMensual: '8 kg Res, 8 kg Pollo, 30 latas Atún',
      ),
      ProductoCompra(
        id: 'gh_fib_2',
        categoria: 'Carbohidratos',
        nombre: 'Avena, Quinoa y Pan Negro Masivo',
        cantidadMensual: '8 kg Avena, 3 kg Quinoa, 10 packs Pan',
      ),
      ProductoCompra(
        id: 'gh_fib_3',
        categoria: 'Frutos/Semillas',
        nombre: 'Dátiles, Chía, Nueces y Paltas',
        cantidadMensual: '1 kg Dátiles, 1 kg Chía, 1 kg Nueces, 20 Paltas',
      ),
      ProductoCompra(
        id: 'gh_fib_4',
        categoria: 'Proteínas Extras',
        nombre: 'Claras de Huevo Pasteurizadas',
        cantidadMensual: '6 Litros',
      ),
      ProductoCompra(
        id: 'gh_fib_5',
        categoria: 'Infusiones',
        nombre: 'Té Verde / Matcha especial',
        cantidadMensual: '2 packs (500g)',
      ),
      ...getBasicosMensuales('gh_fib'),
    ],
  ),
];
